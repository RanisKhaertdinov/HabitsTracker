package com.habittracker.domain

import com.habittracker.api.dto.HabitType
import io.circe.Json

import java.time.{LocalDate, OffsetDateTime}
import java.util.UUID

case class Habit(
                  id: UUID,
                  userId: UUID,
                  title: String,
                  description: String,
                  color: Int,
                  habitType: Json,
                  createdAt: OffsetDateTime,
                  endDate: OffsetDateTime
                )