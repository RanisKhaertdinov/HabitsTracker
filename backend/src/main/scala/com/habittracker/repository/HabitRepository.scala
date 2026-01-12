package com.habittracker.repository

import cats.effect.IO
import com.habittracker.domain.Habit
import com.habittracker.util.DbTransactor
import doobie._
import doobie.implicits._
import doobie.postgres.implicits._
import doobie.postgres.circe.jsonb.implicits._
import io.circe.Json

import java.util.UUID

object HabitRepository {

  private val xa = DbTransactor.transactor

  def create(habit: Habit): IO[Int] =
    sql"""
      INSERT INTO habits (id, userId, title, description, color, habitType, createdAt, endDate)
      VALUES
      (
        ${habit.id},
        ${habit.userId},
        ${habit.title},
        ${habit.description},
        ${habit.color},
        ${habit.habitType},
        ${habit.createdAt},
        ${habit.endDate}
      )
    """.update.run.transact(xa)

  def findByUserId(userId: UUID): IO[List[Habit]] =
    sql"""
      SELECT id, userId, title, description, color, habitType, createdAt, endDate
      FROM habits
      WHERE userId = $userId
    """.query[Habit].to[List].transact(xa)

  def findById(id: UUID): IO[Option[Habit]] =
    sql"""
      SELECT id, userId, title, description, color, habitType, createdAt, endDate
      FROM habits
      WHERE id = $id
    """.query[Habit].option.transact(xa)

  def update(habit: Habit): IO[Int] =
    sql"""
      UPDATE habits
      SET
        title = ${habit.title},
        description = ${habit.description},
        color = ${habit.color},
        habitType = ${habit.habitType},
        endDate = ${habit.endDate}
      WHERE id = ${habit.id}
    """.update.run.transact(xa)

  def delete(id: UUID): IO[Int] =
    sql"""
      DELETE FROM habits WHERE id = $id
    """.update.run.transact(xa)
}