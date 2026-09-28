-- Schema:
-- CREATE TABLE "dnd-character" (
--   property     TEXT    NOT NULL,
--   input        TEXT    NOT NULL,
--   strength     INTEGER         ,
--   dexterity    INTEGER         ,
--   constitution INTEGER         ,
--   intelligence INTEGER         ,
--   wisdom       INTEGER         ,
--   charisma     INTEGER         ,
--   modifier     INTEGER         ,
--   hitpoints    INTEGER
-- );
--
-- Task: update the dnd-character table and set the appropriate columns based on the property and the input.
CREATE TEMP TABLE dice_values AS
WITH slots(slot) AS (
  VALUES (1), (2), (3), (4), (5), (6), (7)
), dice(die) AS (
  VALUES (1), (2), (3), (4)
)
SELECT slots.slot, 1 + abs(random() % 6) AS value
FROM slots CROSS JOIN dice;

CREATE TEMP TABLE ability_rolls AS
SELECT slot, SUM(value) - MIN(value) AS score
FROM dice_values
GROUP BY slot;

DROP TABLE dice_values;

UPDATE "dnd-character"
SET modifier = CASE
  WHEN constitution < 10 AND (constitution - 10) % 2 <> 0
    THEN (constitution - 10) / 2 - 1
  ELSE (constitution - 10) / 2
END
WHERE property = 'modifier' AND input = 'score';

UPDATE "dnd-character"
SET strength = (SELECT score FROM ability_rolls WHERE slot = 7)
WHERE property = 'ability' AND input = 'random';

UPDATE "dnd-character"
SET
  strength = (SELECT score FROM ability_rolls WHERE slot = 1),
  dexterity = (SELECT score FROM ability_rolls WHERE slot = 2),
  constitution = (SELECT score FROM ability_rolls WHERE slot = 3),
  intelligence = (SELECT score FROM ability_rolls WHERE slot = 4),
  wisdom = (SELECT score FROM ability_rolls WHERE slot = 5),
  charisma = (SELECT score FROM ability_rolls WHERE slot = 6),
  modifier = CASE
    WHEN (SELECT score FROM ability_rolls WHERE slot = 3) < 10
      AND ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) % 2 <> 0
      THEN ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) / 2 - 1
    ELSE ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) / 2
  END,
  hitpoints = 10 + CASE
    WHEN (SELECT score FROM ability_rolls WHERE slot = 3) < 10
      AND ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) % 2 <> 0
      THEN ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) / 2 - 1
    ELSE ((SELECT score FROM ability_rolls WHERE slot = 3) - 10) / 2
  END
WHERE property = 'character' AND input = 'random';

UPDATE "dnd-character"
SET
  strength = (SELECT strength FROM "dnd-character" WHERE property = 'character' AND input = 'random'),
  dexterity = (SELECT dexterity FROM "dnd-character" WHERE property = 'character' AND input = 'random'),
  constitution = (SELECT constitution FROM "dnd-character" WHERE property = 'character' AND input = 'random'),
  intelligence = (SELECT intelligence FROM "dnd-character" WHERE property = 'character' AND input = 'random'),
  wisdom = (SELECT wisdom FROM "dnd-character" WHERE property = 'character' AND input = 'random'),
  charisma = (SELECT charisma FROM "dnd-character" WHERE property = 'character' AND input = 'random')
WHERE property = 'character' AND input = '';
