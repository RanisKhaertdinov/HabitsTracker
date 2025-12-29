package com.habittracker.security

import org.mindrot.jbcrypt.BCrypt

object PasswordHasher {
  def hashPassword(password: String): String = {
    BCrypt.hashpw(password, BCrypt.gensalt(12))
  }

  def verifyPassword(plain: String, hashed: String): Boolean = {
    BCrypt.checkpw(plain, hashed)
  }
}