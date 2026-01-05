package com.habittracker.domain

import java.time.{Instant, OffsetDateTime}
import java.util.UUID

case class User(
               id: UUID,
               email: String,
               name: String,
               passwordHash: String,
               createdAt: OffsetDateTime
               )



