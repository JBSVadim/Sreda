CREATE TABLE A(v char(3), t int);
CREATE TABLE B(v char(3));
INSERT INTO A
VALUES ('XXX', 1),
  ('ZXX', 2),
  ('XXY', 1),
  ('ZXY', 2),
  ('XXZ', 1),
  ('ZXZ', 2),
  ('XYX', 3),
  ('XYY', 3),
  ('XYZ', 3),
  ('YXZ', 4),
  ('YXX', 4),
  ('YXY', 4),
  ('YYY', 5)
RETURNING *;
INSERT INTO B
VALUES ('ABC'),
  ('ZXZ'),
  ('YXZ'),
  ('YXY'),
  ('XXX');
SELECT *
FROM "orders" AS o
  JOIN "phones_to_orders" AS pto ON o.id = pto."orderId"
  JOIN "phones" AS p ON p.id = pto."phoneId"
WHERE p.brand ILIKE 'samsung'
SELECT o.id,
  count(p.model)
FROM orders AS o
  JOIN "phones_to_orders" AS pto ON o.id = pto."orderId"
  JOIN "phones" AS p ON p.id = pto."phoneId"
WHERE p.brand ILIKE 'iphone'
GROUP BY o.id
  /*  */
SELECT sum(pto.quantity * p.price),
  o.id
FROM orders AS o
  JOIN "phones_to_orders" AS pto ON o.id = pto."orderId"
  JOIN "phones" AS p ON pto."phoneId" = p.id
GROUP BY o.id
ORDER BY o.id
  /**/
SELECT count(o.id) "Salery orders",
  u.email
FROM users AS u
  FULL OUTER JOIN orders AS o On o."userId" = u.id
GROUP BY o."userId",
  u.id
ORDER BY o."userId"
  /**/
SELECT count(pto."orderId") AS "Number of Position in order",
  o.id
FROM orders AS o
  JOIN "phones_to_orders" AS pto ON o.id = pto."orderId"
GROUP BY o.id
  /**/
SELECT sum(pto."quantity") AS "Number of phones what was add to order",
  p."model", p."brand"
FROM orders AS o
  JOIN "phones_to_orders" AS pto On o.id = pto."orderId"
  JOIN "phones" AS p ON pto."phoneId" = p.id
GROUP BY p."model", p."brand"
ORDER BY p."model"
LIMIT 1