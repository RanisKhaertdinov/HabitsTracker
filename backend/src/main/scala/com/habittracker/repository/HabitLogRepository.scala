package com.habittracker.repository

import cats.effect.IO
import com.habittracker.domain.HabitLog
import com.habittracker.util.DbTransactor
import doobie.Transactor
import doobie._
import doobie.implicits._
import doobie.postgres.implicits._

import java.time.LocalDate
import java.util.UUID


object HabitLogRepository {
  private val xa: Transactor[IO] = DbTransactor.transactor

  def create(log: HabitLog): IO[Int] = {
    sql"""
         INSERT INTO habit_logs (id, habit_id, date, completed)
         VALUES (${log.id},${log.habitId},${log.date},${log.completed})
       """.update.run.transact(xa)
  }

  def findByHabitId(habitId: UUID): IO[List[HabitLog]] = {
    sql"""
         SELECT id, habit_id, date, completed
         FROM habit_logs
         WHERE habit_id = $habitId
       """.query[HabitLog].to[List].transact(xa)
  }

  def findByHabitIdAndDate(habitId: UUID, date: LocalDate): IO[Option[HabitLog]] = {
    sql"""
         SELECT id, habit_id, date, completed
         FROM habit_logs
         WHERE habit_id = $habitId AND date = $date
       """.query[HabitLog].option.transact(xa)
  }

  def update(log: HabitLog): IO[Int] = {
    sql"""
         UPDATE habit_logs
         SET date = ${log.date}, completed = ${log.completed}
         WHERE id = ${log.id}
       """.update.run.transact(xa)
  }

  def delete(id: UUID): IO[Int] = {
    sql"""
         DELETE
         FROM habit_logs
         WHERE id = $id
       """.update.run.transact(xa)
  }
}
