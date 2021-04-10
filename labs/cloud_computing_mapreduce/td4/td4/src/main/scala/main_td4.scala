import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SparkSession

object main_td4 extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val directory = "/home/romain/Documents/upem/m2_sia/cloud_computing_mapreduce/td/td4/"
  val propFile = "univProps.txt"
  val conFile = "univConcepts.txt"
  val tripleFile = "univ1.nt"
  val conc = sc.textFile(directory + conFile).map(x => x.split(" ")).map(x => (x(1), x(0).toLong))
  val prop = sc.textFile(directory + propFile).map(x => x.split(" ")).map(x => (x(1), x(0).toLong))
  val trip = sc.textFile(directory + tripleFile).map(x => x.split(" ")).map(x => (x(1), (x(0), x(2))))
  //println(conc.count)
  //println(prop.count)
  //println(trip.count)

  val trip1 = trip.join(prop).map{case(p, ((s, o), pid)) => (s, pid, o)}.setName("trip1").persist
  val pCount = trip1.map(x => (x._2, 1)).reduceByKey(_+_)
  //println(pCount.count)
  //pCount.foreach(println)
  val c = trip1.map(x => x._2).distinct
  //println(c.count)
  //c.foreach(println)

  val cCount = trip1.filter(x => x._2 == 0).map(x => x._3).distinct
  //println(cCount.count)

  val ind = trip1.filter(x => x._2 != 0).map(x => (x._1, x._3)).flatMap{case(s, o) => Array(s, o)}.distinct.zipWithUniqueId.setName("ind").persist
  //println(ind.count)

  val trip2 = trip1.map{case(s, pid, o) => (o, (s, pid))}.setName("trip2").persist
  //println(trip2.count)
  trip1.unpersist _
  val trip3 = trip2.join(conc).map{case(o, ((s, pid), oid)) => (s, (pid, oid.toLong))}.union(trip2.join(ind).map{case(o, ((s, pid), oid)) => (s, (pid, oid.toLong))}).setName("trip3").persist
  //println(trip3.count)

  val tripEncoded = trip3.join(ind).map{case(s, ((pid, oid), sid)) => (sid, pid, oid)}.setName("tripEncoded").persist
  //println(tripEncoded.count)

  val spark = SparkSession.builder.config(sc.getConf).getOrCreate()
  import spark.implicits._

  val tripDF = tripEncoded.toDF("s", "p", "o")
  tripDF.createOrReplaceTempView("triple")
  val res = spark.sql("SELECT t1.s, t2.s, t3.s FROM triple t1, triple t2, triple t3 WHERE t1.p=1233125376 AND t2.p=1136656384 AND t3.p=1224736768 AND t1.o=t2.s AND t2.o=t3.s")
  //println(res.count)
  //res.show()

  val propDist = spark.sql("SELECT t.p, count(*) FROM triple t GROUP BY t.p ORDER BY count(*) desc")
  //println(propDist.count)
  //propDist.collect.foreach(println)
}