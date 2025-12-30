package com.habittracker.util

import cats.effect.IO
import com.habittracker.config.AppConfig
import doobie.Transactor

object DbTransactor {
  val transactor: Transactor[IO] = Transactor.fromDriverManager[IO] (
    driver = "org.postgresql.Driver",
    url = AppConfig.dbUrl,
    user = AppConfig.dbUser,
    pass = AppConfig.dbPassword
  )
}