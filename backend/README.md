# Habits Tracker Backend

Scala + Akka HTTP бэкенд для приложения Habits Tracker.

## Технологический стек

- **Фреймворк**: Akka HTTP + Akka Typed
- **База данных**: PostgreSQL с Doobie
- **JSON**: Circe
- **Аутентификация**: JWT + BCrypt
- **Инструмент сборки**: SBT (Scala Build Tool)

## Структура репозитория (предположительно)
```
habit-tracker/
│
├── README.md                 # Общее описание проекта
├── .gitignore
├── docker-compose.yml        # PostgreSQL + сервисы (опционально)
│
├── backend/                  # Scala backend (Akka)
│   ├── README.md             # Backend-специфичное описание
│   ├── build.sbt
│   ├── project/
│   │   ├── build.properties
│   │   └── plugins.sbt
│   │
│   ├── src/
│   │   ├── main/
│   │   │   ├── scala/
│   │   │   │   └── com/
│   │   │   │       └── habittracker/
│   │   │   │           ├── Main.scala
│   │   │   │           │
│   │   │   │           ├── http/          # Akka HTTP routes
│   │   │   │           │   ├── AuthRoutes.scala
│   │   │   │           │   ├── HabitRoutes.scala
│   │   │   │           │   └── StatsRoutes.scala
│   │   │   │           │
│   │   │   │           ├── actor/         # Akka Typed actors
│   │   │   │           │   ├── UserActor.scala
│   │   │   │           │   ├── HabitActor.scala
│   │   │   │           │   └── StatsActor.scala
│   │   │   │           │
│   │   │   │           ├── domain/        # Доменные модели
│   │   │   │           │   ├── User.scala
│   │   │   │           │   ├── Habit.scala
│   │   │   │           │   └── HabitLog.scala
│   │   │   │           │
│   │   │   │           ├── repository/    # Работа с БД
│   │   │   │           │   ├── UserRepository.scala
│   │   │   │           │   ├── HabitRepository.scala
│   │   │   │           │   └── HabitLogRepository.scala
│   │   │   │           │
│   │   │   │           ├── security/      # JWT, пароли
│   │   │   │           │   ├── JwtService.scala
│   │   │   │           │   └── PasswordHasher.scala
│   │   │   │           │
│   │   │   │           ├── config/        # Конфигурация
│   │   │   │           │   └── AppConfig.scala
│   │   │   │           │
│   │   │   │           └── util/
│   │   │   │               └── DbTransactor.scala
│   │   │   │
│   │   │   └── resources/
│   │   │       ├── application.conf
│   │   │       └── db/
│   │   │           └── migration/
│   │   │               ├── V1__init.sql
│   │   │               └── V2__add_logs.sql
│   │   │
│   │   └── test/
│   │       └── scala/
│   │           └── com/
│   │               └── habittracker/
│   │                   └── ...
│   │
│   └── Dockerfile
│
├── frontend/                 # Flutter frontend
...
└── docs/                     # Документация
    ├── architecture.md
    ├── api.md
    └── diagrams/
```

## Дорожная карта разработки

Оптимальная последовательность разработки бэкенда с нуля — от настройки окружения до полнофункционального MVP.

### Фаза 1: Настройка окружения

1. Инициализация SBT-проекта (через IntelliJ, g8 или вручную)
2. Настройка зависимостей:
   - Akka HTTP + Akka Typed
   - Doobie + драйвер PostgreSQL
   - Circe (сериализация JSON)
   - JWT библиотека
   - BCrypt (хеширование паролей)
3. Проверка с `sbt compile` и запуск сервера через `sbt run`

### Фаза 2: Минимальный HTTP-сервер

Создание базового HTTP-сервера для проверки Akka HTTP:

```scala
val routes = path("health") {
  get {
    complete("Server is running!")
  }
}

Http().newServerAt("localhost", 8080).bind(routes)
```

**Цель**: Подтверждение работы SBT и Akka HTTP.

### Фаза 3: Настройка базы данных

1. Запустить PostgreSQL (локально или через Docker)
2. Создать директорию `db/migrations/` с файлом миграции `V1__init.sql`:

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE habits (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  title VARCHAR NOT NULL,
  description TEXT,
  schedule_type VARCHAR,
  active BOOLEAN DEFAULT TRUE,
  start_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE habit_logs (
  id UUID PRIMARY KEY,
  habit_id UUID REFERENCES habits(id),
  date DATE,
  completed BOOLEAN
);
```

3. Настроить `DbTransactor.scala` для доступа к базе данных через Doobie

### Фаза 4: Доменные модели

Создать основные модели данных в `src/main/scala/domain/`:

- `User.scala` - Учетная запись пользователя
- `Habit.scala` - Определение привычки
- `HabitLog.scala` - Записи выполнения привычек

**Фокус**: Определение структур данных и типов, логика позже.

### Фаза 5: Слой репозиториев

Реализовать слой доступа к данным в `src/main/scala/repository/`:

- `UserRepository.scala` - Регистрация и поиск пользователей
- `HabitRepository.scala` - CRUD операции привычек
- `HabitLogRepository.scala` - Отслеживание выполнения

Начать с синхронных реализаций, позже рефакторить на асинхронные (Cats IO / Future).

### Фаза 6: Безопасность

Реализовать компоненты безопасности в `src/main/scala/security/`:

- `PasswordHasher.scala` - Безопасное хеширование паролей с BCrypt
- `JwtService.scala` - Генерация и валидация JWT токенов
- Middleware/перехватчики для защиты роутов

### Фаза 7: Слой Actors

Построить слой бизнес-логики с помощью Akka Typed Actors в `src/main/scala/actors/`:

- `UserActor.scala` - Регистрация пользователей и аутентификация
- `HabitActor.scala` - Операции привычек и отслеживание выполнения
- `StatsActor.scala` - Статистика: расчет streaks и процента выполнения

**Цель**: Инкапсулировать всю бизнес-логику в typed actors.

### Фаза 8: HTTP роуты

Определить REST API endpoints в `src/main/scala/routes/`:

- `AuthRoutes.scala` 
  - `POST /auth/register`
  - `POST /auth/login`
- `HabitRoutes.scala`
  - `GET/POST/PUT/DELETE /habits`
  - `POST /habits/{id}/complete`
- `StatsRoutes.scala`
  - `GET /stats/{habitId}`

**Ответственность**: Валидация запросов и делегирование логики actors.

### Фаза 9: Реализация MVP

Построить минимально функциональную реализацию:

1. Регистрация и логин пользователей
2. CRUD операции с привычками
3. Отметка привычек как выполненные
4. Получение статистики привычек

**Тестирование**: Проверка через Postman, curl или аналогичный HTTP-клиент.

### Фаза 10: Будущие улучшения

- Продвинутая аналитика и графики в `StatsActor`
- Структурированное логирование и управление конфигурацией
- Комплексные unit и integration тесты
- Поддержка WebSocket для real-time обновлений

## Сборка и запуск

```bash
# Компиляция проекта
sbt compile

# Запуск сервера
sbt run

# Запуск тестов
sbt test

# Сборка production jar
sbt assembly
```

## Архитектурные заметки

Реализация следует многоуровневой архитектуре:

- **Routes**: Обработка HTTP запросов и валидация
- **Actors**: Инкапсуляция бизнес-логики (Akka Typed)
- **Repositories**: Слой доступа к данным (Doobie)
- **Models**: Доменные сущности
- **Security**: Аутентификация и авторизация

Начните с минимального HTTP сервера + база + репозитории + UserActor. Когда этот основной блок работает, добавление новых actors и роутов становится более простым и надежным.

## Начало работы

Для подробных инструкций по настройке обратитесь к конфигурации сборки в [build.sbt](build.sbt).