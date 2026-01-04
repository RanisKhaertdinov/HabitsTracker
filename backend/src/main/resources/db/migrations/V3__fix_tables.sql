ALTER TABLE users RENAME COLUMN password_hash TO passwordHash;
ALTER TABLE users RENAME COLUMN created_at TO createdAt;
ALTER TABLE users ALTER COLUMN createdAt TYPE TIMESTAMPTZ USING createdAt AT TIME ZONE 'UTC';

ALTER TABLE habits RENAME COLUMN user_id TO userId;
ALTER TABLE habits RENAME COLUMN schedule_type TO scheduleType;
ALTER TABLE habits RENAME COLUMN start_date TO startDate;
ALTER TABLE habits RENAME COLUMN created_at TO createdAt;
ALTER TABLE habits ALTER COLUMN createdAt TYPE TIMESTAMPTZ USING createdAt AT TIME ZONE 'UTC';

ALTER TABLE habit_logs RENAME TO habitLogs;
ALTER TABLE habitLogs RENAME COLUMN habit_id TO habitId;

ALTER TABLE refresh_tokens RENAME TO refreshTokens;
ALTER TABLE refreshTokens RENAME COLUMN user_id TO userId;
ALTER TABLE refreshTokens RENAME COLUMN token_hash TO refreshToken;
ALTER TABLE refreshTokens RENAME COLUMN expires_at TO expiresAt;
ALTER TABLE refreshTokens RENAME COLUMN created_at TO createdAt;
ALTER TABLE refreshTokens ALTER COLUMN expiresAt TYPE TIMESTAMPTZ USING expiresAt AT TIME ZONE 'UTC';
ALTER TABLE refreshTokens ALTER COLUMN createdAt TYPE TIMESTAMPTZ USING createdAt AT TIME ZONE 'UTC';