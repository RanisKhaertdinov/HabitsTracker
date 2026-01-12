package com.habittracker

import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import com.habittracker.actors.{HabitActor, UserActor}
import com.habittracker.api.routes.{AuthRoutes, HabitRoutes}

import scala.concurrent.Await
import scala.concurrent.duration.Duration

object Main {

  def main(args: Array[String]): Unit = {

    val rootBehavior = Behaviors.setup[Nothing] { context =>

      val userActor = context.spawn(UserActor(), "userActor")
      val habitActor = context.spawn(HabitActor(), "habitActor")

      implicit val system: ActorSystem[_] = context.system
      implicit val ec = context.system.executionContext
      implicit val scheduler = context.system.scheduler

      val authRoutes = new AuthRoutes(userActor)
      val habitRoutes = new HabitRoutes(habitActor)
      val routes = {
        concat(
          path("health") {
            get {
              complete("Server is running!")
            }
          }, authRoutes.routes
           , habitRoutes.routes
        )

      }

      Http().newServerAt("0.0.0.0", 8080).bind(routes)
        .foreach(_ => println("Server started at http://0.0.0.0:8080/"))

      Behaviors.empty
    }

//    ActorSystem[Nothing](rootBehavior, "habittracker-system")
    val system = ActorSystem[Nothing](rootBehavior, "habittracker-system")
    Await.result(system.whenTerminated, Duration.Inf)
  }
}