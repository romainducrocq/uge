import org.apache.spark.{SparkConf, SparkContext}

object main_td2 extends App {
  val conf = new SparkConf().setAppName("simpleSparkApp").setMaster("local")
  val sc = new SparkContext(conf)
  sc.setLogLevel("FATAL")

  val triples = sc.parallelize(Array((1,0,5),(5,1,8),(8,2,1),(2,0,6),(3,0,6),(6,1,9),(5,1,9),(9,3,11),(9,4,12),(4,0,7),(7,1,9),(7,2,10),(14,1,15),(15,1,16),(14,1,16),(17,0,18),(18,0,19),(19,1,20),(20,0,17)))
  //triples.foreach(println)

  var soPairs = triples.map(x => (x._1, x._3))
  //soPairs.foreach(println)

  val subjects = soPairs.map{case(s, o) => (s)}.distinct
  val objects = soPairs.map{case(s, o) => (o)}.distinct

  var roots = subjects.subtract(objects).map(x => (x, x)).distinct
  var leaves = objects.subtract(subjects).map(x => (x, x)).distinct
  //roots.foreach(println)
  //leaves.foreach(println)

  var oldCount = 0L
  var nextCount = soPairs.count
  val osPairs = soPairs.map(x => (x._2, x._1))
  do{
    oldCount = nextCount
    soPairs = soPairs.union(soPairs.join(osPairs).map(x => (x._2._2, x._2._1))).distinct().cache()
    nextCount = soPairs.count
  }while(nextCount != oldCount)
  //soPairs.sortByKey().foreach(println)

  val addedSoPairs = soPairs.subtract(osPairs.map(x => (x._2, x._1)))
  //addedSoPairs.foreach(println)

  val rooted = roots.join(soPairs.groupByKey()).map(x => (x._2._1, x._2._2.toList.sorted))
  //rooted.foreach(println)

  val cyc = soPairs.filter(x => x._1 == x._2)
  val cycles = cyc.join(soPairs).map(x => (x._2._2, x._1)).join(cyc).groupByKey().map(x => x._2.map(y => y._1)).distinct
  //cycles.foreach(println)

}
