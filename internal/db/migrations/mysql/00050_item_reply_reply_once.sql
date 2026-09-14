-- +goose Up
ALTER TABLE item_replay ADD COLUMN reply_once TINYINT(1) NOT NULL DEFAULT 0 AFTER reply_content;

CREATE TABLE IF NOT EXISTS item_reply_records (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cookie_id VARCHAR(255) NOT NULL,
    chat_id VARCHAR(255) NOT NULL,
    item_id VARCHAR(255) NOT NULL,
    replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_item_reply_records (cookie_id, chat_id, item_id),
    CONSTRAINT fk_item_reply_records_cookie FOREIGN KEY (cookie_id) REFERENCES cookies(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- +goose Down
DROP TABLE IF EXISTS item_reply_records;
ALTER TABLE item_replay DROP COLUMN reply_once;
