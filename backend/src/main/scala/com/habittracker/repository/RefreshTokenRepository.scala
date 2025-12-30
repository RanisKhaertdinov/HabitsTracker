package com.habittracker.repository

import cats.effect.IO
import com.habittracker.security.JwtService.RefreshTokenInSeconds
import com.habittracker.security.RefreshToken
import com.habittracker.util.DbTransactor
import doobie.util.transactor.Transactor
import doobie.postgres.implicits._
import doobie._
import doobie.implicits._

import java.time.Instant
import java.util.UUID



object RefreshTokenRepository {
  private val xa: Transactor[IO] = DbTransactor.transactor

  def create(refreshToken: RefreshToken) : IO[Int] = {
    sql"""
         INSERT INTO refresh_tokens
         (id, user_id, token_hash, expires_at, created_at)
         VALUES
         (${UUID.randomUUID()},${refreshToken.userId},${refreshToken.token}, ${refreshToken.expiresAt}, ${refreshToken.createdAt})
       """.update.run.transact(xa)
  }

  def findByHash(tokenHash: String): IO[Option[RefreshToken]] = {
    sql"""
         SELECT id, user_id, token_hash, expires_at, created_at
         FROM refresh_tokens
         WHERE token_hash = $tokenHash
       """.query[RefreshToken].option.transact(xa)
  }

  def deleteByHash(tokenHash: String): IO[Int] = {
    sql"""
         DELETE
         FROM refresh_tokens
         WHERE token_hash = $tokenHash
       """.update.run.transact(xa)
  }
  def deleteAllByUserId(userId: UUID): IO[Int] = {
    sql"""
         DELETE
         FROM refresh_tokens
         WHERE user_id = $userId
       """.update.run.transact(xa)
  }

  def deleteExpired(now: Instant): IO[Int] = {
    sql"""
        DELETE
        FROM refresh_tokens
        WHERE expires_at < $now
       """.update.run.transact(xa)
  }



}
