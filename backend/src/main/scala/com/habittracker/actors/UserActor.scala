package com.habittracker.actors

import cats.effect.unsafe.implicits.global
import akka.actor.typed.scaladsl.Behaviors
import akka.actor.typed.{ActorRef, Behavior}
import com.habittracker.domain.User
import com.habittracker.repository.{RefreshTokenRepository, UserRepository}
import com.habittracker.security.JwtService
import com.habittracker.security.PasswordHasher.{hashPassword, verifyPassword}

import java.time.{Instant, OffsetDateTime, ZoneOffset}
import java.util.UUID

object UserActor {
  sealed trait Command

  final case class Register(
                           email: String,
                           password: String,
                           name: String,
                           replyTo: ActorRef[Response]
                           ) extends Command

  final case class Login(
                             email: String,
                             password: String,
                             replyTo: ActorRef[Response]
                           ) extends Command
  final case class Refresh(
                          refreshToken: String,
                          replyTo: ActorRef[Response]
                          ) extends Command

  final case class Logout(
                           refreshToken: String,
                           replyTo: ActorRef[Response]
                         ) extends Command

  sealed trait Response

  final case class Tokens(
                         accessToken: String,
                         refreshToken: String,
                         expiresIn: Int
                         )
  final case class UserDto(
                          id: UUID,
                          email: String,
                          name: String
                          )

  final case class AuthSuccess(
                             token: Tokens,
                             user: UserDto
                           ) extends Response

  final case class AuthFailed(
                             reason: String
                           ) extends Response
  final case class RefreshSuccess(
                                   accessToken: String,
                                   expiresIn: Int
                                 ) extends Response

  final case class RefreshFailed(
                               reason: String
                             ) extends Response

  final case class LogoutSuccess() extends Response
  final case class LogoutFailed(
                                  reason: String
                                ) extends Response

  def apply(): Behavior[Command] =
    Behaviors.receive { (context, message) =>
      message match {
        case Register(email, password, name, replyTo) => {
          UserRepository.findByEmail(email).unsafeRunSync() match {
            case Some(_) => {
              replyTo ! AuthFailed("User already exists")
              Behaviors.same
            }

            case None => {
              val userId = UUID.randomUUID()
              val hashedPassword = hashPassword(password)

              val user = User(
                id = userId,
                email = email,
                name = name,
                passwordHash = hashedPassword,
                createdAt = Instant.now()
              )
              UserRepository.create(user).unsafeRunSync()

              val userDto = UserDto(
                id = user.id, email = user.email, name = user.name
              )

              val refreshToken = JwtService.createRefreshToken(userId)
              RefreshTokenRepository.create(refreshToken).unsafeRunSync()

              val tokens = Tokens(
                accessToken = JwtService.createAccessToken(userId, email),
                refreshToken = refreshToken.refreshToken,
                expiresIn = 900
              )
              replyTo ! AuthSuccess(tokens, userDto)
              Behaviors.same
            }
          }
        }
        case Login(email, password, replyTo) => {
          UserRepository.findByEmail(email).unsafeRunSync() match {
            case None => {
              replyTo ! AuthFailed("Authentication failed")
              Behaviors.same
            }
            case Some(user) => {
              if (!verifyPassword(password, user.passwordHash)) {
                replyTo ! AuthFailed("Wrong password")
              } else {
                val userDto = UserDto(
                  id = user.id, email = user.email, name = user.name
                )
                val refreshToken = JwtService.createRefreshToken(user.id)
                RefreshTokenRepository.create(refreshToken).unsafeRunSync()

                val tokens = Tokens(
                  accessToken = JwtService.createAccessToken(user.id, email),
                  refreshToken = refreshToken.refreshToken,
                  expiresIn = 900
                )
                replyTo ! AuthSuccess(tokens, userDto)
              }
              Behaviors.same
            }
          }
        }
        case Refresh(refreshToken, replyTo) => {
          RefreshTokenRepository.findByHash(refreshToken).unsafeRunSync() match {
            case None => {
              replyTo ! RefreshFailed("Invalid refresh token")
              Behaviors.same
            }
            case Some(token) => {
              val now = OffsetDateTime.now(ZoneOffset.UTC)
              if (token.expiresAt.isBefore(now)) {
                replyTo ! RefreshFailed("Refresh token expired")
                Behaviors.same
              } else {
                UserRepository.findById(token.userId).unsafeRunSync() match {
                  case None => {
                    replyTo ! RefreshFailed("User not found")
                    Behaviors.same
                  }
                  case Some(user) => {
                    val accessToken = JwtService.createAccessToken(user.id, user.email)
                    replyTo ! RefreshSuccess(accessToken, 900)
                    Behaviors.same

                  }
                }
              }
            }
          }
        }
        case Logout(refreshToken, replyTo) => {
          RefreshTokenRepository.findByHash(refreshToken).unsafeRunSync() match {
            case None => {
              replyTo ! LogoutFailed("Invalid refresh token")
              Behaviors.same
            }
            case Some(token) => {
              RefreshTokenRepository.deleteByHash(refreshToken).unsafeRunSync()
              replyTo ! LogoutSuccess()
              Behaviors.same
            }
          }
        }
      }
    }

}
