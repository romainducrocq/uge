import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._

object main_td5 extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val spark = SparkSession.builder.config(sc.getConf).getOrCreate()
  import spark.implicits._

  def printDF(df: org.apache.spark.sql.DataFrame): Unit = {
    df.collect.foreach(println)
  }

  def showDF(df: org.apache.spark.sql.DataFrame): Unit = {
    df.show
  }

  def writeCSV(dir: String, df: org.apache.spark.sql.DataFrame): Unit = {
    df.write.format("csv").option("header", "true").mode("overwrite").option("sep", ",").save(directory + dir)
  }

  def readCSV(file: String): org.apache.spark.sql.DataFrame = {
    return spark.read.format("csv").option("header", "true").option("sep", ",").load(directory + file)
  }

  val directory = "/home/romain/Documents/upem/m2_sia/cloud_computing_mapreduce/td/td5/"
  val db = "drugbankExt.nt"

  /*
  val triples = sc.textFile(directory + db).map(x => x.split(" ")).map(t => (t(0), t(1), t(2))).setName("triples").persist

  val tripDF = triples.toDF("s", "p", "o")
  tripDF.createOrReplaceTempView("triple")
  printDF(tripDF)

  writeCSV("tripDF", tripDF)
   */

  val tripDF = readCSV("tripDF.csv")
  //printDF(tripDF)
  //showDF(tripDF)

  tripDF.createOrReplaceTempView("triple")

  //val res1 = spark.sql("SELECT o FROM triple WHERE p LIKE '%/brandName>'")
  //showDF(res1)

  val brDes = spark.sql("SELECT t.o FROM triple t WHERE t.p='<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/brandName>'")
  val brDsl = tripDF.where(col("p") === "<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/brandName>").select("o")
  //showDF(brDes)
  //showDF(brDsl)

  val disSql = spark.sql("SELECT t2.o FROM triple t1, triple t2 WHERE t1.p='<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/possibleDiseaseTarget>' AND t1.s=t2.s AND t2.p='<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/brandName>'")
  val disDsl1 = tripDF.where(col("p") === "<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/brandName>").select("s", "o")
  val disDsl2 = tripDF.where(col("p") === "<http://www4.wiwiss.fu-berlin.de/drugbank/resource/drugbank/possibleDiseaseTarget>").select("s")
  val disDsl3 = disDsl1.join(disDsl2, Seq("s")).select("o")
  //showDF(disSql)
  //showDF(disDsl3)

  val triples = sc.textFile(directory + db).map(x => x.split(" ")).map(t => (t(0), t(1), t(2)))
  val sa = triples.filter(x => x._2 == "<http://www.w3.org/2002/07/owl#sameAs>").map(x => (x._1, x._3))
  val sar = sa.map(x => (x._2, x._1))
  var sau = sa.union(sar)
  var old = sau.count
  var next = old
  do{
    old = sau.count
    sau = sau.union(sau.join(sau).filter(x => (x._2._1 != x._2._2)).map(x => List(x._2._1, x._2._2).sorted).map(x => (x(0), x(1)))).distinct
    next = sau.count
  }while(next != old)
  val sau2 = sau.map(x => List(x._1, x._2).sorted).map(x => (x(0), x(1))).distinct
  val sau3 = sau2.union(sau2.map(x => (x._2, x._1)).distinct)

  val materializedTriples = sau3.join(triples.map(x => (x._1, (x._2, x._3)))).map{case(k, (n, (p, o))) => (n, p, o)}
  materializedTriples.sortBy(x => (x._1, x._2, x._3), ascending = true).collect.foreach(println)
}
