-- Schema:
-- CREATE TABLE "secret-handshake" (
--     number INTEGER NOT NULL,
--     result TEXT
-- );
--
-- Task: update secret-handshake table and set result column based on the number.
WITH actions(bit, position, action) AS (
  VALUES (1, 1, 'wink'), (2, 2, 'double blink'),
         (4, 3, 'close your eyes'), (8, 4, 'jump')
)
UPDATE "secret-handshake"
SET result = COALESCE(
  (
    SELECT group_concat(action, ', ')
    FROM (
      SELECT actions.action
      FROM actions
      WHERE ("secret-handshake".number & actions.bit) <> 0
      ORDER BY CASE
        WHEN ("secret-handshake".number & 16) <> 0 THEN -actions.position
        ELSE actions.position
      END
    )
  ),
  ''
);
