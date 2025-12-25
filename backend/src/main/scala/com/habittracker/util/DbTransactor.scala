package com.habittracker.util

import cats.effect.IO
import doobie.Transactor

object DbTransactor {
  val transactor: Transactor[IO] = Transactor.fromDriverManager[IO] (
    driver = "org.postgresql.Driver",
    url = "jdbc:postgresql://localhost:5432/mydb",
    user = "myuser",
    pass = "mypassword"
  )
}