package com.habittracker.security

import com.habittracker.domain.User
import io.circe.syntax._
import io.circe.parser._
import pdi.jwt.{Jwt, JwtAlgorithm, JwtClaim}

import java.time.Instant
import java.util.UUID

case class AuthUser (
                    userId: UUID,
                    email: String,
                    role: String
                    )
final case class RefreshToken(
                               token: String,
                               userId: UUID,
                               expiresAt: Instant,
                               createdAt: Instant
                             )

object JwtService {
  val jwtSecret = sys.env.getOrElse("JWT_SECRET", throw new IllegalStateException("JWT_SECRET not set"))

  def toAuthUser(user: User): AuthUser = {
    AuthUser(
      userId = user.id,
      email = user.email,
      role = "user"
    )
  }

  def createAccessToken(userId: UUID, email:String) = {
    val claims: JwtClaim = JwtClaim(
      content = Map(
        "userId" -> userId.toString,
        "email" -> email,
        "role" -> "user"
      ).asJson.noSpaces,
      issuer = Some("habit-tracker"),
      subject = Some(userId.toString),
      audience = Some(Set("habit-tracker-api")),
      expiration = Some(Instant.now().getEpochSecond + 3600),
      issuedAt = Some(Instant.now().getEpochSecond)
    )

    Jwt.encode(claims, jwtSecret, JwtAlgorithm.HS256)
  }

  private val RefreshTokenInSeconds = 60 * 60 * 24 * 10

  def createRefreshToken(userId: UUID) = {
    RefreshToken(
      token = UUID.randomUUID().toString,
      userId = userId,
      expiresAt = Instant.now().plusSeconds(RefreshTokenInSeconds),
      createdAt = Instant.now()
    )
  }

  def validateToken(token:String): Either[String, AuthUser] = {
    Jwt.decode(token, jwtSecret, Seq(JwtAlgorithm.HS256))
       .toEither
       .left.map(_.getMessage)
       .flatMap { claim =>
         if (claim.expiration.exists(_ < Instant.now().getEpochSecond)) {
           Left("Token expired")
         } else {
           parse(claim.content)
             .left.map(_.getMessage)
             .flatMap { json =>
               for {
                 userId <- json.hcursor.get[String]("userId").left.map(_.getMessage)
                 email <- json.hcursor.get[String]("email").left.map(_.getMessage)
                 role <- json.hcursor.get[String]("role").left.map(_.getMessage)
               } yield AuthUser(UUID.fromString(userId), email, role)
             }
         }
       }
  }
}
