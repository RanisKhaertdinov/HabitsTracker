package com.habittracker.repository

import cats.effect.unsafe.implicits.global
import com.habittracker.domain.User
import com.habittracker.util.DbTransactor
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.should.Matchers

import java.time.Instant
import java.util.UUID

class UserRepositorySpec extends AnyFreeSpec with Matchers{
  val xa = DbTransactor.transactor
  val repo = UserRepository

  "UserRepository" - {
    "should insert, find, update and delete a user" in {
      val userId = UUID.randomUUID()
      val user = User(
        id = userId,
        email = "test@example.com",
        passwordHash = "hashed_password",
        createdAt = Instant.now()
      )

      // insert
      val insertCount = repo.create(user).unsafeRunSync()
      insertCount shouldBe 1

      //findById
      val foundById = repo.findById(userId).unsafeRunSync()
      foundById.isDefined shouldBe true
      foundById.get.email shouldBe user.email

      //findByEmail
      val foundByEmail = repo.findByEmail(user.email).unsafeRunSync()
      foundByEmail.isDefined shouldBe true
      foundByEmail.get.id shouldBe user.id

      //update
      val updatedUser = user.copy(email = s"updated_$userId@example.com")
      val updatedCount = repo.update(updatedUser).unsafeRunSync()
      updatedCount shouldBe 1

      val foundUpdated = repo.findById(userId).unsafeRunSync()
      foundUpdated.get.email shouldBe updatedUser.email

      //delete
      val deleteCount = repo.delete(userId).unsafeRunSync()
      deleteCount shouldBe 1

      val foundAfterDelete = repo.findById(userId).unsafeRunSync()
      foundAfterDelete shouldBe None
    }
  }
}
