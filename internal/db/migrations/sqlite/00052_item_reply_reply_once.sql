-- +goose Up
ALTER TABLE item_replay ADD COLUMN reply_once BOOLEAN NOT NULL DEFAULT FALSE;

CREATE TABLE IF NOT EXISTS item_reply_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cookie_id TEXT NOT NULL,
    chat_id TEXT NOT NULL,
    item_id TEXT NOT NULL,
    replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(cookie_id, chat_id, item_id),
    FOREIGN KEY (cookie_id) REFERENCES cookies(id) ON DELETE CASCADE
);

-- +goose Down
DROP TABLE IF EXISTS item_reply_records;
ALTER TABLE item_replay DROP COLUMN reply_once;
