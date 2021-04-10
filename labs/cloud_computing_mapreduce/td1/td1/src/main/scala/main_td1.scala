import org.apache.spark.{SparkConf, SparkContext}

object main_td1 extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val moby = sc.textFile("/home/romain/Documents/upem/m2_sia/cloud_computing_mapreduce/td/td1/mobyDick.txt")

  val chap = moby.filter(x => x.contains("CHAPTER"))
  println(chap.count)

  val moby2 = moby.filter(x => x.length() > 0)
  println(moby2.count)

  val wc = moby2.flatMap(x => x.split(" ")).map(x => (x, 1)).reduceByKey(_+_)
  println(wc.count)

  val cap = wc.filter(x => x._1.contains("captain"))
  println(cap.count)
  cap.take(10).foreach(println)

  val tmp = wc.map{case(m, c) => (c, m)}.top(10)
  val tmp2 = wc.map(x => (x._2, x._1)).top(10)
  tmp.foreach(println)
  tmp2.foreach(println)
}
