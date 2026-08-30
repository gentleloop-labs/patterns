ALTER TABLE events ADD COLUMN event_context TEXT;
CREATE INDEX idx_events_event_context ON events(event_context);
