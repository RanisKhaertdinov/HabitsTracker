package com.habittracker.api.routes

import akka.actor.typed.{ActorRef, ActorSystem, Scheduler}
import akka.http.scaladsl.server.Directives.{get, _}
import akka.http.scaladsl.server.Route
import com.habittracker.api.dto.{CreateHabitRequest, CreateHabitResponse, ErrorResponse, HabitType, HabitValue, UpdateHabitRequest, UpdateHabitResponse}
import akka.actor.typed.scaladsl.AskPattern._
import com.habittracker.actors.HabitActor
import com.habittracker.repository.HabitRepository
import com.habittracker.security.JwtService
import cats.effect.unsafe.implicits.global

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.DurationInt
import io.circe.generic.auto._
import de.heikoseeberger.akkahttpcirce.FailFastCirceSupport._
import io.circe.Json


class HabitRoutes (
                    habitActor: ActorRef[HabitActor.Command]
                  ) (
                    implicit system: ActorSystem[_],
                    scheduler: Scheduler
                  ) {
  implicit val ec: ExecutionContext = system.executionContext
  implicit val timeout = 3.seconds

  val routes: Route =
    pathPrefix("habits") {
      concat(
        post {
          optionalHeaderValueByName("Authorization") {
            case Some(authHeader) if authHeader.startsWith("Bearer ") => {
              val token = authHeader.substring("Bearer ".length)

              JwtService.validateToken(token) match {
                case Right(authUser) => {
                  entity(as[CreateHabitRequest]) {req =>
                    val result = habitActor.ask(replyTo =>
                      HabitActor.Create(authUser.userId, req.title, req.description,req.color, req.createdAt, req.endDate, req.habitType, replyTo)
                    )(timeout, scheduler)
                    onSuccess(result) {
                      case HabitActor.CreateSuccess(title, description, color, createdAt, endDate, habitType) => {
                        complete(CreateHabitResponse(title, description, color, createdAt, endDate, habitType))
                      }
                      case  HabitActor.CreateFailed(reason) => {
                        complete(400, ErrorResponse(reason))
                      }
                    }
                  }
                }
                case Left(error) => complete(401, ErrorResponse(s"Invalid access token: $error"))
              }
            }
            case _ => complete(401, ErrorResponse("Authorization header must start with Bearer"))
          }
        },
        get {
          optionalHeaderValueByName("Authorization") {
            case Some(authHeader) if authHeader.startsWith("Bearer ") => {
              val token = authHeader.substring("Bearer ".length)

              JwtService.validateToken(token) match {
                case Right(authUser) => {
                  val habits = HabitRepository.findByUserId(authUser.userId).unsafeRunSync()

                  val response = habits.map { habit =>
                    CreateHabitResponse(
                      title = habit.title,
                      description = habit.description,
                      color = habit.color,
                      createdAt = habit.createdAt,
                      endDate = habit.endDate,
                      habitType = io.circe.parser.parse(habit.habitType.noSpaces).getOrElse(Json.Null).as[HabitType].getOrElse(HabitType("default","daily", HabitValue(0,"none")))
                    )
                  }
                  complete(200, response)
                }
                case Left(error) => complete(401, ErrorResponse(s"Invalid access token: $error"))
              }
            }
            case _ =>  complete(401, ErrorResponse("Authorization header must start with Bearer"))
          }
        },
        path(JavaUUID) { habitId =>
          concat(
            put {
              optionalHeaderValueByName("Authorization") {
                case Some(authHeader) if authHeader.startsWith("Bearer ") => {
                  val token = authHeader.substring("Bearer ".length)

                  JwtService.validateToken(token) match {
                    case Right(_) => {
                      entity(as[UpdateHabitRequest]) { req =>
                        val result = habitActor.ask(replyTo =>
                          HabitActor.Update(habitId, req.title, req.description, req.color,  req.endDate, req.habitType, replyTo)
                        )(timeout, scheduler)
                        onSuccess(result) {
                          case HabitActor.UpdateSuccess(title, description, color, createdAt, endDate, habitType) => {
                            complete(UpdateHabitResponse(title, description, color, createdAt, endDate, habitType))
                          }
                          case HabitActor.UpdateFailed(reason) => {
                            complete(400, ErrorResponse(reason))
                          }
                        }
                      }
                    }
                    case Left(error) => complete(401, ErrorResponse(s"Invalid access token: $error"))
                  }
                }
                case _ => complete(401, ErrorResponse("Authorization header must start with Bearer"))
              }
            },
            delete {
              optionalHeaderValueByName("Authorization") {
                case Some(authHeader) if authHeader.startsWith("Bearer ") => {
                  val token = authHeader.substring("Bearer ".length)

                  JwtService.validateToken(token) match {
                    case Right(_) => {
                      val existedHabit = HabitRepository.findById(habitId).unsafeRunSync()
                      existedHabit match {
                        case Some(habit) => {
                          HabitRepository.delete(habit.id).unsafeRunSync()
                          complete(204,"Deleted successfully")
                        }
                        case None => {
                          complete(404, s"Habit with id: $habitId not found")
                        }
                      }
                    }
                    case Left(error) => complete(401, ErrorResponse(s"Invalid access token: $error"))
                  }
                }
                case _ => complete(401, ErrorResponse("Authorization header must start with Bearer"))
              }
            }
          )
        }
      )
    }

}