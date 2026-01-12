ALTER TABLE habits
DROP COLUMN scheduleType;

ALTER TABLE habits
DROP COLUMN active;

ALTER TABLE habits
DROP COLUMN startDate;

ALTER TABLE habits
ADD COLUMN habitType JSONB NOT NULL DEFAULT '{"type":"default","goalPeriod":"daily","value":{"count":0,"unit":"none"}}'::jsonb;

ALTER TABLE habits
ADD COLUMN color INT NOT NULL DEFAULT 0;

ALTER TABLE habits
ADD COLUMN endDate TIMESTAMPTZ NOT NULL DEFAULT now();

ALTER TABLE habits
ALTER COLUMN createdAt TYPE TIMESTAMPTZ USING createdAt AT TIME ZONE 'UTC';