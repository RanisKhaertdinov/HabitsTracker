package com.habittracker.repository

import cats.effect.IO
import com.habittracker.security.RefreshToken
import com.habittracker.util.DbTransactor
import doobie._
import doobie.implicits._
import doobie.postgres.implicits._

import java.time.OffsetDateTime
import java.util.UUID

object RefreshTokenRepository {
  private val xa: Transactor[IO] = DbTransactor.transactor

  def create(refreshToken: RefreshToken): IO[Int] = {
    sql"""
         INSERT INTO refreshtokens
         (id, userid, refreshtoken, expiresat, createdat)
         VALUES
         (${UUID.randomUUID()}, ${refreshToken.userId}, ${refreshToken.refreshToken}, ${refreshToken.expiresAt}, ${refreshToken.createdAt})
       """.update.run.transact(xa)
  }

  def findByHash(tokenHash: String): IO[Option[RefreshToken]] = {
    sql"""
         SELECT
           refreshtoken AS "refreshToken",
           userid AS "userId",
           expiresat AS "expiresAt",
           createdat AS "createdAt"
         FROM refreshtokens
         WHERE refreshtoken = $tokenHash
       """.query[RefreshToken].option.transact(xa)
  }

  def deleteByHash(tokenHash: String): IO[Int] = {
    sql"""
         DELETE FROM refreshtokens
         WHERE refreshtoken = $tokenHash
       """.update.run.transact(xa)
  }

  def deleteAllByUserId(userId: UUID): IO[Int] = {
    sql"""
         DELETE FROM refreshtokens
         WHERE userid = $userId
       """.update.run.transact(xa)
  }

  def deleteExpired(now: OffsetDateTime): IO[Int] = {
    sql"""
        DELETE FROM refreshtokens
        WHERE expiresat < $now
       """.update.run.transact(xa)
  }
}