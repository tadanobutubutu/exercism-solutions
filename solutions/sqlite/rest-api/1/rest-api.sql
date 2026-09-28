WITH
  requests AS (
    SELECT rowid AS request_id, "database", payload, url
    FROM "rest-api"
  ),
  users AS (
    SELECT
      requests.request_id,
      json_extract(user_json.value, '$.name') AS name,
      json_extract(user_json.value, '$.owes') AS owes,
      json_extract(user_json.value, '$.owed_by') AS owed_by
    FROM requests
    CROSS JOIN json_each(requests."database", '$.users') AS user_json
  ),
  debts AS (
    SELECT
      users.request_id,
      users.name AS debtor,
      debt.key AS creditor,
      CAST(debt.value AS REAL) AS amount
    FROM users
    CROSS JOIN json_each(users.owes) AS debt
  ),
  iou AS (
    SELECT
      requests.request_id,
      json_extract(requests.payload, '$.lender') AS lender,
      json_extract(requests.payload, '$.borrower') AS borrower,
      CAST(json_extract(requests.payload, '$.amount') AS REAL) AS amount,
      COALESCE((
        SELECT amount FROM debts
        WHERE debts.request_id = requests.request_id
          AND debts.debtor = json_extract(requests.payload, '$.lender')
          AND debts.creditor = json_extract(requests.payload, '$.borrower')
      ), 0.0) - COALESCE((
        SELECT amount FROM debts
        WHERE debts.request_id = requests.request_id
          AND debts.debtor = json_extract(requests.payload, '$.borrower')
          AND debts.creditor = json_extract(requests.payload, '$.lender')
      ), 0.0) - CAST(json_extract(requests.payload, '$.amount') AS REAL) AS remaining
    FROM requests
    WHERE requests.url = '/iou'
  ),
  debts_without_iou_pair AS (
    SELECT debts.*
    FROM debts
    WHERE NOT EXISTS (
      SELECT 1 FROM iou
      WHERE iou.request_id = debts.request_id
        AND ((debts.debtor = iou.lender AND debts.creditor = iou.borrower)
          OR (debts.debtor = iou.borrower AND debts.creditor = iou.lender))
    )
  ),
  adjusted_debts AS (
    SELECT * FROM debts_without_iou_pair
    UNION ALL
    SELECT
      request_id,
      CASE WHEN remaining > 0 THEN lender ELSE borrower END AS debtor,
      CASE WHEN remaining > 0 THEN borrower ELSE lender END AS creditor,
      ABS(remaining) AS amount
    FROM iou
    WHERE remaining <> 0
  ),
  response_users AS (
    SELECT request_id, name FROM users
    UNION ALL
    SELECT
      requests.request_id,
      json_extract(requests.payload, '$.user') AS name
    FROM requests
    WHERE requests.url = '/add'
  ),
  user_json AS (
    SELECT
      response_users.request_id,
      response_users.name,
      json_object(
        'name', response_users.name,
        'owes', json(COALESCE((
          SELECT json_group_object(adjusted_debts.creditor, adjusted_debts.amount)
          FROM adjusted_debts
          WHERE adjusted_debts.request_id = response_users.request_id
            AND adjusted_debts.debtor = response_users.name
        ), '{}')),
        'owed_by', json(COALESCE((
          SELECT json_group_object(adjusted_debts.debtor, adjusted_debts.amount)
          FROM adjusted_debts
          WHERE adjusted_debts.request_id = response_users.request_id
            AND adjusted_debts.creditor = response_users.name
        ), '{}')),
        'balance', CAST(
          COALESCE((
            SELECT SUM(adjusted_debts.amount)
            FROM adjusted_debts
            WHERE adjusted_debts.request_id = response_users.request_id
              AND adjusted_debts.creditor = response_users.name
          ), 0.0)
          - COALESCE((
            SELECT SUM(adjusted_debts.amount)
            FROM adjusted_debts
            WHERE adjusted_debts.request_id = response_users.request_id
              AND adjusted_debts.debtor = response_users.name
          ), 0.0)
          AS REAL
        )
      ) AS user_object
    FROM response_users
  ),
  response AS (
    SELECT
      requests.request_id,
      CASE requests.url
        WHEN '/add' THEN (
          SELECT user_object FROM user_json
          WHERE user_json.request_id = requests.request_id
            AND user_json.name = json_extract(requests.payload, '$.user')
        )
        WHEN '/users' THEN json_object(
          'users', json(COALESCE((
            SELECT json_group_array(json(selected.user_object))
            FROM (
              SELECT user_json.user_object
              FROM user_json
              WHERE user_json.request_id = requests.request_id
                AND (
                  json_type(requests.payload, '$.users') IS NULL
                  OR EXISTS (
                    SELECT 1
                    FROM json_each(requests.payload, '$.users') AS requested
                    WHERE requested.value = user_json.name
                  )
                )
              ORDER BY user_json.name
            ) AS selected
          ), '[]'))
        )
        WHEN '/iou' THEN json_object(
          'users', json(COALESCE((
            SELECT json_group_array(json(selected.user_object))
            FROM (
              SELECT user_json.user_object
              FROM user_json
              WHERE user_json.request_id = requests.request_id
                AND user_json.name IN (
                  json_extract(requests.payload, '$.lender'),
                  json_extract(requests.payload, '$.borrower')
                )
              ORDER BY user_json.name
            ) AS selected
          ), '[]'))
        )
      END AS result
    FROM requests
  )
UPDATE "rest-api"
SET result = (
  SELECT response.result
  FROM response
  WHERE response.request_id = "rest-api".rowid
);
