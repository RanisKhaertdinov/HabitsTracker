ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.13.14"

lazy val root = (project in file("."))
  .settings(
    name := "backend"
  )


val AkkaVersion = "2.6.21"
val AkkaHttpVersion = "10.2.10"
val CirceVersion = "0.14.6"
val JwtVersion = "5.0.0"

libraryDependencies ++= Seq(
  // Akka
  "com.typesafe.akka" %% "akka-actor-typed" % "2.6.21",
  "com.typesafe.akka" %% "akka-stream"      % "2.6.21",
  "com.typesafe.akka" %% "akka-http"        % "10.2.10",

  // Logback
  "ch.qos.logback" % "logback-classic" % "1.4.14",

  // Circe
  "io.circe" %% "circe-core"    % "0.14.6",
  "io.circe" %% "circe-generic" % "0.14.6",
  "io.circe" %% "circe-parser"  % "0.14.6",
  "de.heikoseeberger" %% "akka-http-circe" % "1.39.2",

  // Doobie + Postgres
  "org.tpolecat" %% "doobie-core"     % "1.0.0-RC1",
  "org.tpolecat" %% "doobie-postgres" % "1.0.0-RC1",
  "org.tpolecat" %% "doobie-hikari"   % "1.0.0-RC1",
  "org.tpolecat" %% "doobie-postgres-circe" % "1.0.0-RC1",
  "org.postgresql" % "postgresql"     % "42.6.0",

  "com.pauldijou" %% "jwt-core" % JwtVersion,
  "com.github.jwt-scala" %% "jwt-circe" % "10.0.1",
  "org.mindrot" % "jbcrypt" % "0.4",

  "org.scalatest" %% "scalatest" % "3.2.18" % Test
)

