package com.habittracker.repository

import com.habittracker.util.DbTransactor
import cats.effect.unsafe.implicits.global
import com.habittracker.domain.{Habit, User}
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.should.Matchers

import java.time.{Instant, LocalDate}
import java.util.UUID

class HabitRepositorySpec extends AnyFreeSpec with Matchers {
  val xa = DbTransactor.transactor
  val repo = HabitRepository

  "HabitRepository" - {
    "should create, findByUserId, findById, update and delete a habit" in {

      val userId = UUID.randomUUID()
      val testUser = User(userId, s"user_$userId@example.com", "hashedPassword", Instant.now())
      UserRepository.create(testUser).unsafeRunSync()

      val habitId = UUID.randomUUID()
      val habit = Habit(
        id = habitId,
        userId = userId,
        title = "Example title",
        description = "Example description",
        scheduleType = "daily",
        active = true,
        startDate = LocalDate.now(),
        createdAt = Instant.now()
      )

      //insert
      val insertCount = repo.create(habit).unsafeRunSync()
      insertCount shouldBe 1

      //findByUserId
      val habitsByUserId = repo.findByUserId(userId).unsafeRunSync()
      habitsByUserId.map(_.id) should contain(habitId)

      //findById
      val habitById = repo.findById(habitId).unsafeRunSync()
      habitById.isDefined shouldBe true
      habitById.get.title shouldBe "Example title"

      //update
      val updatedHabit = habit.copy(title = s"habit $habitId Title")
      val updatedCount = repo.update(updatedHabit).unsafeRunSync()
      updatedCount shouldBe 1

      val foundUpdated = repo.findById(habitId).unsafeRunSync()
      foundUpdated.get.title shouldBe updatedHabit.title

      //delete
      val deleteCount = repo.delete(habitId).unsafeRunSync()
      deleteCount shouldBe 1

      val foundAfterDelete = repo.findById(habitId).unsafeRunSync()
      foundAfterDelete shouldBe None
    }
  }
}
