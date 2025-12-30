package com.habittracker.domain

import java.time.LocalDate
import java.util.UUID

case class HabitLog(
                   id: UUID,
                   habitId: UUID,
                   date: LocalDate,
                   completed: Boolean
                   )
