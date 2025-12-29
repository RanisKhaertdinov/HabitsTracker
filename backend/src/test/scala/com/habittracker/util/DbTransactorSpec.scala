package com.habittracker.util

import cats.effect.unsafe.implicits.global
import doobie.implicits._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.should.Matchers


class DbTransactorSpec extends AnyFreeSpec with Matchers{
  "DbTransactor" - {
    "should connect to database" in {
      var result =
        sql"SELECT 1"
          .query[Int]
          .unique
          .transact(DbTransactor.transactor)
          .unsafeRunSync()
      result shouldBe 1
    }
  }
}
