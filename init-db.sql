CREATE TABLE codes (code TEXT UNIQUE, used BOOLEAN NOT NULL CHECK (used IN (0, 1)));
CREATE TABLE users (firstname TEXT, lastname TEXT, email TEXT NOT NULL, username TEXT UNIQUE NOT NULL PRIMARY KEY, password TEXT NOT NULL);
CREATE TABLE tickets (name TEXT NOT NULL, issue TEXT, timestamp REAL, assigned TEXT, FOREIGN KEY (assigned) REFERENCES users(username));
CREATE TABLE archive (name TEXT NOT NULL, issue TEXT, timestamp REAL, assigned TEXT, resolution TEXT, FOREIGN KEY (assigned) REFERENCES users(username));
