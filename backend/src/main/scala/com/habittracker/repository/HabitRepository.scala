package com.habittracker.repository

import cats.effect.IO
import com.habittracker.domain.Habit
import com.habittracker.util.DbTransactor
import doobie.util.transactor.Transactor
import doobie._
import doobie.implicits._

import java.util.UUID

object HabitRepository {
  private val xa: Transactor[IO] = DbTransactor.transactor

  def create(habit: Habit): IO[Int] = {
    sql"""
         INSERT into habits (id, user_id, title, description, schedule_type, active, start_date, created_at)
         VALUES (${habit.id},${habit.userId},${habit.title},${habit.description},${habit.scheduleType},${habit.active},${habit.startDate},${habit.createdAt})
       """.update.run.transact(xa)
  }

  def findByUserId(userId: UUID): IO[List[Habit]] = {
    sql"""
         SELECT id, user_id, title, description, schedule_type, active, start_date, created_at
         FROM habits
         WHERE user_id = $userId
       """.query[Habit].to[List].transact(xa)
  }

  def findById(id: UUID): IO[Option[Habit]] = {
    sql"""
         SELECT id, user_id, title, description, schedule_type, active, start_date, created_at
         FROM habits
         WHERE id = $id
       """.query[Habit].option.transact(xa)
  }

  def update(habit: Habit): IO[Int] = {
    sql"""
         UPDATE habits
         SET title = ${habit.title},
             description = ${habit.description},
             schedule_type = ${habit.scheduleType},
             active = ${habit.active}
         WHERE id = ${habit.id}
       """.update.run.transact(xa)
  }

  def delete(id: UUID): IO[Int] = {
    sql"""
         DELETE
         FROM habits
         WHERE id = $id
       """.update.run.transact(xa)
  }

}
