-- +goose Up
ALTER TABLE item_replay ADD COLUMN reply_once INTEGER NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS item_reply_records (
    id BIGSERIAL PRIMARY KEY,
    cookie_id TEXT NOT NULL REFERENCES cookies(id) ON DELETE CASCADE,
    chat_id TEXT NOT NULL,
    item_id TEXT NOT NULL,
    replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(cookie_id, chat_id, item_id)
);

-- +goose Down
DROP TABLE IF EXISTS item_reply_records;
ALTER TABLE item_replay DROP COLUMN reply_once;
