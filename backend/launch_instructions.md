1) Проверь, что Docker установлен:

```bash
   docker --version
```

Пример вывода:
```Docker version 28.1.1, build 4eba377```

2) Проверь, что Docker Compose установлен:

```bash
   docker compose version
```

Пример вывода:
```Docker Compose version v2.35.1-desktop.1```


3) ЗАПУСК КОНТЕЙНЕРОВ

С корневой папки ../HabitsTracker запускаешь команды. Только после запуска можешь проверить ручки.Бэкенд будет доступен на http://0.0.0.0:8080 ￼

```bash
   docker compose up --build
```
(запуститься в foreground)

или

```bash
   docker compose up -d --build
```
(запуститься на фоне)

4) Работа с PostgresSqL

```bash
   docker exec -it habit-tracker-postgres psql -U myuser -d habit_tracker
```



Внутри psql можно выполнять команды, например
```bash
    -- Показать все таблицы
    \dt
    
    -- Проверить содержимое таблицы
    SELECT * FROM users;
    
    -- Выйти из psql
    \q
```

5) Остановка контейнеров

```bash
   docker compose down
  ```
