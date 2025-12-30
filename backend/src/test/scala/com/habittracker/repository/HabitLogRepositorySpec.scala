package com.habittracker.repository

import cats.effect.unsafe.implicits.global
import com.habittracker.domain.{Habit, HabitLog, User}
import com.habittracker.util.DbTransactor
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.should.Matchers

import java.time.{Instant, LocalDate}
import java.util.UUID

class HabitLogRepositorySpec extends AnyFreeSpec with Matchers{
  val xa = DbTransactor.transactor
  val repo = HabitLogRepository

  "HabitLogRepository" - {
    "should create, findByHabitId, findByHabitIdAndDate, update and delete a habit log" in {

      val userId = UUID.randomUUID()
      val testUser = User(userId, s"user_$userId@example.com", "hashedPassword", Instant.now())
      UserRepository.create(testUser).unsafeRunSync()

      val habitId = UUID.randomUUID()
      val testHabit = Habit(
        id = habitId,
        userId = userId,
        title = "Example title",
        description = "Example description",
        scheduleType = "daily",
        active = true,
        startDate = LocalDate.now(),
        createdAt = Instant.now()
      )
      HabitRepository.create(testHabit).unsafeRunSync()

      val habitLogId = UUID.randomUUID()
      val habitLog = HabitLog (
        id = habitLogId,
        habitId = habitId,
        date = LocalDate.now(),
        completed = false
      )

      //insert
      val insertCount = repo.create(habitLog).unsafeRunSync()
      insertCount shouldBe 1

      //findByHabitId
      val logsByHabitId = repo.findByHabitId(habitId).unsafeRunSync()
      logsByHabitId.map(_.id) should contain(habitLogId)

      //findByHabitIdAndDate
      val logByHabitIdAndDate = repo.findByHabitIdAndDate(habitId, habitLog.date).unsafeRunSync()
      logByHabitIdAndDate.isDefined shouldBe true
      logByHabitIdAndDate.get.id shouldBe habitLogId

      //update
      val updatedHabitLog = habitLog.copy(completed = true)
      val updatedCount = repo.update(updatedHabitLog).unsafeRunSync()
      updatedCount shouldBe 1

      val foundUpdated = repo.findByHabitIdAndDate(habitId, habitLog.date).unsafeRunSync()
      foundUpdated.get.completed shouldBe true

      //delete
      val deleteCount = repo.delete(habitLogId).unsafeRunSync()
      deleteCount shouldBe 1

      val foundAfterDelete = repo.findByHabitIdAndDate(habitId, habitLog.date).unsafeRunSync()
      foundAfterDelete shouldBe None
    }
  }
}
