package com.habittracker

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._

import scala.concurrent.ExecutionContextExecutor


object Main {
  def main(args: Array[String]): Unit = {
    implicit val system: ActorSystem = ActorSystem("habittracker-system")
    implicit val ec: ExecutionContextExecutor = system.dispatcher

    val routes =
      path("health") {
        get {
          complete("Server is running!")
        }
      }

    Http()
      .newServerAt("localhost", 8080)
      .bind(routes)
      .foreach(_ => println("Server started at http://localhost:8080/health"))
  }
}
