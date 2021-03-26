SELECT pto."orderId",
  sum(pto.quantity * p.price) as "cost"
FROM phones_to_orders AS pto
  JOIN phones AS p ON p.id = pto."phoneId"
GROUP BY pto."orderId"
  /*         */
SELECT avg(owc.cost)
FROM (
    SELECT pto."orderId",
      sum(pto.quantity * p.price) as "cost"
    FROM phones_to_orders AS pto
      JOIN phones as p On p.id = pto."phoneId"
    GROUP BY pto."orderId"
  ) AS "owc"
  /*      */
SELECT owc.*
FROM (
    SELECT pto."orderId",
      sum(pto.quantity * p.price) AS "cost"
    FROM phones_to_orders AS pto
      JOIN phones AS p On p.id = pto."phoneId"
    GROUP BY pto."orderId"
  ) AS "owc"
WHERE owc.cost > (
    SELECT avg(owc.cost)
    FROM (
        SELECT sum(pto.quantity * p.price) AS "cost"
        FROM phones_to_orders AS pto
          JOIN phones AS p On p.id = pto."phoneId"
        GROUP BY pto."orderId"
      ) AS "owc"
  )
  /*                    */
SELECT count(o.id) AS "NOO",
  u.id
FROM users AS u
  JOIN orders AS o ON u.id = o."userId"
GROUP BY u.id
SELECT avg(owc.noo)
FROM (
    SELECT count(o.id) AS "noo",
      u.id
    FROM users AS u
      JOIN orders AS o ON u.id = o."userId"
    GROUP BY u.id
  ) AS "owc"
  /*                        */
SELECT owc.*
FROM(
    SELECT count(o.id) AS "noo",
      u.id
    FROM users AS u
      JOIN orders AS o ON u.id = o."userId"
    GROUP BY u.id
  ) as "owc"
WHERE owc.noo > (
    SELECT avg(owc.noo)
    FROM (
        SELECT count(o.id) AS "noo",
          u.id
        FROM users AS u
          JOIN orders AS o ON u.id = o."userId"
        GROUP BY u.id
      ) AS "owc"
  )
  /*--------------------------*/
  WITH "user_to_avg_orders" AS (
    SELECT count(o.id) AS "noo",
      u.id
    FROM users AS u
      JOIN orders AS o ON u.id = o."userId"
    GROUP BY u.id
  )
SELECT owc.*
FROM "user_to_avg_orders" AS owc
WHERE owc.noo > (
    SELECT avg(owc.noo)
    FROM "user_to_avg_orders" AS owc
  )
  /*---------------------*/
