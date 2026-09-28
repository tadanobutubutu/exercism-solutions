UPDATE results
   SET result = CASE property
     WHEN 'scores' THEN (
       SELECT group_concat(score, ',')
         FROM (SELECT score FROM scores WHERE game_id = results.game_id ORDER BY rowid)
     )
     WHEN 'latest' THEN (
       SELECT CAST(score AS TEXT) FROM scores
        WHERE game_id = results.game_id ORDER BY rowid DESC LIMIT 1
     )
     WHEN 'personalBest' THEN (
       SELECT CAST(MAX(score) AS TEXT) FROM scores WHERE game_id = results.game_id
     )
     WHEN 'personalTopThree' THEN (
       SELECT group_concat(score, ',')
         FROM (SELECT score FROM scores WHERE game_id = results.game_id ORDER BY score DESC LIMIT 3)
     )
   END;
