package com.habittracker.domain

import java.time.Instant
import java.util.UUID

case class User(
               id: UUID,
               email: String,
               passwordHash: String,
               createdAt: Instant
               )



