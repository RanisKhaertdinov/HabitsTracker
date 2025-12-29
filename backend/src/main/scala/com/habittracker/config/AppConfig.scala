package com.habittracker.config

object AppConfig {
  val dbUrl: String = sys.env("DB_URL")
  val dbUser: String = sys.env("DB_USER")
  val dbPassword: String = sys.env("DB_PASSWORD")
  val jwtSecret: String = sys.env("JWT_SECRET")
}
