import org.apache.spark.{SparkConf, SparkContext}

object main_td3 extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val directory = "/home/romain/Documents/upem/m2_sia/cloud_computing_mapreduce/td/td3/"
  val db = "drugbankExt.nt"

  val triples = sc.textFile(directory + db).map(x => x.split(" ")).map(t => (t(0), t(1), t(2)))
  //triples.foreach(println)

  val properties = sc.textFile(directory + "properties.dct").map(x => x.split(" "))
  val propertiesURI2ID = properties.map(x => ("<" + x(0) + ">", x(1).toLong))
  val individuals = sc.textFile(directory + "individuals.txt").map(x => x.split(" ")).map(x => (x(0).toLong, x(1)))
  val individualsURI2ID = individuals.map(x => (x._2.replace("\"", ""), x._1)).persist
  //println(individualsURI2ID.count)
  //individualsURI2ID.foreach(println)

  val abox1 = triples.map{case(s, p, o) => (p, (s, o))}.join(propertiesURI2ID).map{case(p, ((s, o), idp)) => (s, (idp, o.replace("\"", "")))}
  val abox2 = abox1.join(individualsURI2ID).map{case(s, ((p, o), ids)) => (ids, (o, p))}
  val abox3 = abox2.map{case(s, (o, p)) => (o, (s, p))}.join(individualsURI2ID).map{case(uri0, ((s, p), o)) => (s, p, o)}
  //abox3.sortBy(x => (x._1, x._2, x._3), ascending = true).take(20).foreach(println)

  val sa = abox3.filter(x => x._2 == 1).map(x => (x._1, x._3))
  val sar = sa.map(x => (x._2, x._1))
  var sau = sa.union(sar)
  var old = sau.count
  var next = old
  do{
    old = sau.count
    sau = sau.union(sau.join(sau).filter(x => x._2._1 != x._2._2).map(x => List(x._2._1, x._2._2).sorted).map(x => (x(0), x(1)))).distinct
    next = sau.count
  }while(next != old)
  val sau2 = sau.map(x => List(x._1, x._2).sorted).map(x => (x(0), x(1))).distinct
  val sau3 = sau2.union(sau2.map(x => (x._2, x._1))).distinct

  val materializedTriples = sau3.join(abox3.map(x => (x._1, (x._2, x._3)))).map{case(k, (n, (p, o))) => (n, p, o)}
  materializedTriples.sortBy(x => (x._1, x._2, x._3), ascending = true).collect.foreach(println)
}