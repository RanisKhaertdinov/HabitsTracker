package com.habittracker.api.routes

import akka.actor.typed.{ActorRef, ActorSystem, Scheduler}
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.server.Route
import akka.util.Timeout
import akka.actor.typed.scaladsl.AskPattern._
import cats.effect.unsafe.implicits.global
import com.habittracker.actors.UserActor
import com.habittracker.api.dto.{AuthResponse, ErrorResponse, LoginRequest, LogoutRequest, RefreshRequest, RefreshResponse, RegisterRequest}
import com.habittracker.repository.UserRepository
import com.habittracker.security.JwtService

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.DurationInt
import io.circe.generic.auto._
import de.heikoseeberger.akkahttpcirce.FailFastCirceSupport._

class AuthRoutes (
                   userActor: ActorRef[UserActor.Command]
                 ) (
                    implicit system: ActorSystem[_],
                    scheduler: Scheduler
                    ) {
  implicit val ec: ExecutionContext = system.executionContext
  implicit val timeout: Timeout = 3.seconds

  val routes: Route =
    pathPrefix("auth") {
      concat(
        path("register") {
          post {
            entity(as[RegisterRequest]) { req =>
              val result = userActor.ask(replyTo =>
                  UserActor.Register(req.email, req.password,req.name, replyTo)
                )(timeout, scheduler)

              onSuccess(result) {
                case UserActor.AuthSuccess(tokens, user) => {
                  complete(AuthResponse(tokens, user))
                }
                case UserActor.AuthFailed(reason) => {
                  complete(400, reason)
                }
              }

            }
          }
        },
        path("login") {
          post {
            entity(as[LoginRequest]) {req =>
              val result = userActor.ask(replyTo =>
                  UserActor.Login(req.email, req.password, replyTo)
                )(timeout, scheduler)
              onSuccess(result) {
                case UserActor.AuthSuccess(tokens, user) => {
                  complete(AuthResponse(tokens, user))
                }
                case UserActor.AuthFailed(reason) => {
                  complete(401, ErrorResponse(reason))
                }
              }
            }
          }
        },
        path("refresh") {
          post {
            entity(as[RefreshRequest]) { req =>
              val result = userActor.ask(replyTo =>
                UserActor.Refresh(req.refreshToken, replyTo)
              )(timeout, scheduler)
              onSuccess(result) {
                case UserActor.RefreshSuccess(accessToken, expiresIn) => {
                  complete(RefreshResponse(accessToken, expiresIn))
                }
                case UserActor.RefreshFailed(reason) => {
                  complete(401, ErrorResponse(reason))
                }
              }
            }
          }
        },
        path("logout") {
          post {
            entity(as[LogoutRequest]) { req =>
              val result = userActor.ask(replyTo =>
                UserActor.Logout(req.refreshToken, replyTo)
              )(timeout, scheduler)
              onSuccess(result) {
                case _ : UserActor.LogoutSuccess => {
                  complete(200)
                }
                case _ : UserActor.LogoutFailed => {
                  complete(400)
                }
              }
            }
          }
        },
        path("me") {
          get {
            optionalHeaderValueByName("Authorization") {
              case Some(authHeader) if authHeader.startsWith("Bearer ") => {
                val token = authHeader.substring("Bearer ".length)

                JwtService.validateToken(token) match {
                  case Right(authUser) => {
                    UserRepository.findById(authUser.userId).unsafeRunSync() match {
                      case Some(user) => {
                        val userDto = UserActor.UserDto(user.id, user.email, user.name)
                        complete(200, userDto)
                      }
                      case None => complete(404)
                    }
                  }
                  case Left(_) => complete(401)
                }
              }
              case _ => complete(401)

            }
          }
        }
      )

    }


}

