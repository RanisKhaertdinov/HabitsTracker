package com.habittracker.repository

import cats.effect.IO

import java.util.UUID
import com.habittracker.domain.User
import com.habittracker.util.DbTransactor
import doobie._
import doobie.implicits._
import doobie.postgres.implicits._


object UserRepository {
  private val xa: Transactor[IO] = DbTransactor.transactor

  def create(user: User):IO[Int] = {
    sql"""
         INSERT INTO users (id, email, password_hash, created_at)
         VALUES (${user.id}, ${user.email}, ${user.passwordHash}, ${user.createdAt})
         """.update.run.transact(xa)
  }

  def findByEmail(email: String): IO[Option[User]] = {
    sql"""
         SELECT id, email, password_hash, created_at
         FROM users
         WHERE email = $email
       """.query[User].option.transact(xa)
  }

  def findById(id: UUID): IO[Option[User]] = {
    sql"""
         SELECT id, email, password_hash, created_at
         FROM users
         WHERE id = $id
       """.query[User].option.transact(xa)
  }

  def update(user: User): IO[Int] = {
    sql"""
         UPDATE users
         SET email = ${user.email}, password_hash = ${user.passwordHash}
         WHERE id = ${user.id}
       """.update.run.transact(xa)
  }

  def delete(id: UUID): IO[Int] = {
    sql"""
         DELETE
         FROM users
         WHERE id = $id
       """.update.run.transact(xa)
  }

}
