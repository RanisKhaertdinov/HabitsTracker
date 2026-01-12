package com.habittracker.actors

import akka.actor.typed.scaladsl.Behaviors
import akka.actor.typed.{ActorRef, Behavior}
import com.habittracker.domain.Habit
import com.habittracker.repository.HabitRepository
import cats.effect.unsafe.implicits.global
import com.habittracker.api.dto.{HabitType, HabitValue}
import io.circe.syntax._
import io.circe.generic.auto._
import io.circe.parser.decode

import java.time.{LocalDate, OffsetDateTime, ZoneOffset}
import java.util.UUID

object HabitActor {
  sealed trait Command

  final case class Create(
                           userId: UUID,
                           title: String,
                           description: String,
                           color: Int,
                           createdAt: OffsetDateTime,
                           endDate: OffsetDateTime,
                           habitType: HabitType,
                           replyTo: ActorRef[Response]
                         ) extends Command

  final case class Update(
                           habitId: UUID,
                           title: String,
                           description: String,
                           color: Int,
                           endDate: OffsetDateTime,
                           habitType: HabitType,
                           replyTo: ActorRef[Response]
                         ) extends Command
  sealed trait Response

  final case class CreateSuccess(
                                  title: String,
                                  description: String,
                                  color: Int,
                                  createdAt: OffsetDateTime,
                                  endDate: OffsetDateTime,
                                  habitType: HabitType
                                ) extends Response
  final case class CreateFailed(
                               reason: String
                               ) extends Response

  final case class UpdateSuccess(
                                  title: String,
                                  description: String,
                                  color: Int,
                                  createdAt: OffsetDateTime,
                                  endDate: OffsetDateTime,
                                  habitType: HabitType
                                ) extends Response
  final case class UpdateFailed(
                                 reason: String
                               ) extends Response



  def apply(): Behavior[Command] =
    Behaviors.receive { (context, message) =>
      message match {
        case Create(userId, title, description, color,createdAt, endDate, habitType, replyTo) => {
          val habitId = UUID.randomUUID()
          val habit = Habit(
            id = habitId,
            userId = userId,
            title = title,
            description = description,
            color = color,
            habitType = habitType.asJson,
            createdAt = createdAt,
            endDate = endDate
          )

          HabitRepository.create(habit).unsafeRunSync()

          decode[HabitType](habit.habitType.noSpaces) match {
            case Right(ht) =>
              replyTo ! CreateSuccess(
                title = habit.title,
                description = habit.description,
                color = habit.color,
                createdAt = habit.createdAt,
                endDate = habit.endDate,
                habitType = ht
              )

            case Left(err) =>
              replyTo ! CreateFailed(s"Failed to decode habitType: ${err.getMessage}")
          }
          Behaviors.same
        }
        case Update(habitId, title,description, color, endDate, habitType, replyTo) => {
          val existingHabitOpt = HabitRepository.findById(habitId).unsafeRunSync()

          existingHabitOpt match {
            case Some(habit) => {
              val updatedHabit = habit.copy(
                title = title,
                description = description,
                color = color,
                endDate = endDate,
                habitType = habitType.asJson,
              )
              HabitRepository.update(updatedHabit).unsafeRunSync()
              replyTo ! UpdateSuccess(
                title = updatedHabit.title,
                description = updatedHabit.description,
                color = updatedHabit.color,
                createdAt = updatedHabit.createdAt,
                endDate = updatedHabit.endDate,
                habitType = habitType
              )
              Behaviors.same
            }
            case None => {
              replyTo ! UpdateFailed(s"Habit with id $habitId not found")
              Behaviors.same
            }
          }
        }
      }
    }
}
