CREATE TABLE events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_name TEXT NOT NULL,
  event_version INTEGER NOT NULL DEFAULT 1,
  install_id TEXT NOT NULL,
  platform TEXT NOT NULL,
  app_version TEXT,
  event_timestamp INTEGER NOT NULL,
  received_at INTEGER NOT NULL
);

CREATE INDEX idx_events_event_name ON events(event_name);
CREATE INDEX idx_events_install_id ON events(install_id);
CREATE INDEX idx_events_event_timestamp ON events(event_timestamp);
