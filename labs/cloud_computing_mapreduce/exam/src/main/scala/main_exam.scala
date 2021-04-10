import org.apache.spark.{SparkConf, SparkContext}

object main_exam extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val stations = sc.parallelize(Array(1, 2, 3, 4)).map(x => (((x+1).toDouble, (x+2).toDouble), x*2, x*x, (x*10).toString))
  //stations.foreach(println)

  //val stationsId = stations.map(x => ((x._2), (x._1, x._3, x._4)))
  val stationsId = stations.map{case((a, b), c, d, e) => ((c), ((a, b), d, e))}
  //stationsId.foreach(println)

  //val trajets = sc.textFile("/my/directory/" + "trajets.csv").map(x => x.split(" ")).map(x => (x(4).toInt, x(0).toLong, x(1).toInt, x(7).toInt))
  val trajets = sc.parallelize(Array(1, 2, 3, 4)).map(x => (x*2, x.toLong, x*500, x*4))
  //trajets.foreach(println)

  val trajets1200 = trajets.filter(x => x._3 > 1200)
  //trajets1200.foreach(println)

  val occVille = trajets1200.map(x => (x._1, 1)).reduceByKey(_+_)
  //occVille.foreach(println)

  //val occVille2 = occVille.join(stationsId).map{case(a, (b, c)) => (a, (b, c._3))}
  val occVille2 = occVille.join(stationsId).map(x => (x._1, (x._2._1, x._2._2._3)))
  //occVille2.foreach(println)

  val occVille3 = occVille2.map(x => (x._2._2, 1)).reduceByKey(_+_)
  //occVille3.foreach(println)

  val occVille4 = stationsId.map(x => x._2._3).subtract(occVille3.map(x => x._1)).distinct
  //occVille4.foreach(println)
}
