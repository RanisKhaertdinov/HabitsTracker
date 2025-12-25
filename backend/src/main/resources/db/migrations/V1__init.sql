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
    date DATE NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE
);