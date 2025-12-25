package com.habittracker.domain

import java.time.{Instant, LocalDate}
import java.util.UUID

case class Habit(
                id: UUID,
                userId: UUID,
                title: String,
                description: String,
                scheduleType: String,
                active: Boolean,
                startDate: LocalDate,
                createdAt: Instant
                )
