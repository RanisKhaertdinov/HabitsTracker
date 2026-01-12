package com.habittracker.api.dto
import java.time.OffsetDateTime
import java.util.UUID


final case class HabitType(
                            `type`: String,
                            goalPeriod: String,
                            value: HabitValue
                          )
final case class HabitValue(
                             count: Int,
                             unit: String
                           )


final case class CreateHabitRequest(
                                     title: String,
                                     description: String,
                                     color: Int,
                                     createdAt: OffsetDateTime,
                                     endDate: OffsetDateTime,
                                     habitType: HabitType
                                   )
final case class UpdateHabitRequest(
                                   title: String,
                                   description: String,
                                   color: Int,
                                   endDate: OffsetDateTime,
                                   habitType: HabitType
                                   )

final case class CreateHabitResponse(
                                      title: String,
                                      description: String,
                                      color: Int,
                                      createdAt: OffsetDateTime,
                                      endDate: OffsetDateTime,
                                      habitType: HabitType
                                    )

final case class UpdateHabitResponse(
                                      title: String,
                                      description: String,
                                      color: Int,
                                      createdAt: OffsetDateTime,
                                      endDate: OffsetDateTime,
                                      habitType: HabitType
                                    )