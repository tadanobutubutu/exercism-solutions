-- Schema: CREATE TABLE "bob" ("input" TEXT, "reply" TEXT);
-- Task: update the bob table and set the reply based on the input.
UPDATE bob
SET reply = CASE
  WHEN trim(input, char(9) || char(10) || char(11) || char(12) || char(13) || ' ') = ''
    THEN 'Fine. Be that way!'
  WHEN input GLOB '*[A-Z]*'
    AND input NOT GLOB '*[a-z]*'
    AND substr(rtrim(input, char(9) || char(10) || char(11) || char(12) || char(13) || ' '), -1) = '?'
    THEN 'Calm down, I know what I''m doing!'
  WHEN input GLOB '*[A-Z]*' AND input NOT GLOB '*[a-z]*'
    THEN 'Whoa, chill out!'
  WHEN substr(rtrim(input, char(9) || char(10) || char(11) || char(12) || char(13) || ' '), -1) = '?'
    THEN 'Sure.'
  ELSE 'Whatever.'
END;
