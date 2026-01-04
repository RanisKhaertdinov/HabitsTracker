package com.habittracker.api.dto

import com.habittracker.actors.UserActor.{Tokens, UserDto}

import java.util.UUID

final case class RegisterRequest(
                            email: String,
                            password: String,
                            name: String
                            )
final case class LoginRequest(
                                  email: String,
                                  password: String
                                )

final case class RefreshRequest(
                               refreshToken: String
                               )


final case class AuthResponse(
                             tokens: Tokens,
                             user: UserDto
                             )
final case class RefreshResponse(
                                accessToken: String,
                                expiresIn: Int
                                )
final case class ErrorResponse(
                              error: String
                              )
