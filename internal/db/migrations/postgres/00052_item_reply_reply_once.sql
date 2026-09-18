-- +goose Up
-- 本迁移刻意使用 IF NOT EXISTS：该功能最初以 00050 号发布过，
-- 后因上游占用 00050 而改号为 00052。对已经应用过旧 00050 的库，
-- 重置 goose 账本后重跑本迁移必须不报错，否则升级会卡在重复列上。
ALTER TABLE item_replay ADD COLUMN IF NOT EXISTS reply_once INTEGER NOT NULL DEFAULT 0;

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
