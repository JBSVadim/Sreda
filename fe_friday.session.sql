DROP TABLE IF EXISTS clients; 
DROP TABLE IF EXISTS conctracts;
DROP TABLE IF EXISTS ordersD;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS "ordersD_to_products";
DROP TABLE IF EXISTS "order_status";
/*--------*/
CREATE TABLE "clients" (
  id serial PRIMARY KEY,
  "firstName" VARCHAR(68) CHECK ("firstName" != ''),
  "lastName" VARCHAR(68) CHECK ("lastName" != ''),
  "phone" VARCHAR(68) NOT NULL,
  "birthday" date NOT NULL CHECK (
    "birthday" < current_date
    AND "birthday" > '1900/1/1'),
    "email" varchar(256) NOT NULL CHECK (email != '')
  );
  /*--------*/
  CREATE TABLE conctracts(
    id serial PRIMARY KEY,
    "clientId" int REFERENCES "clients"(id),
    "createAt" timestamp NOT NULL DEFAULT current_timestamp);
  /*-----------*/
  CREATE TABLE ordersD (
    id serial PRIMARY KEY,
    contractId int REFERENCES conctracts(id),
    delivelyDate date PRIMARY KEY NOT NULL CHECK (delivelyDate > current_date)
    );
  /*----------*/
  CREATE TABLE products(
    id serial PRIMARY KEY,
    "productName" VARCHAR(128) UNIQUE CHECK ("productName" != ''),
    "quantity" int NOT NULL CHECK (quantity > 0),
    "price" decimal(10, 2) NOT NULL CHECK (price > 0)
  );
  CREATE TABLE "ordersD_to_products" (
    id serial PRIMARY KEY,
    orderId int REFERENCES ordersD(id),
    productId int REFERENCES products(id),
    quantity int NOT NULL);
  /*-------------*/
  CREATE TABLE "order_status" (
    id serial,
    orderId int REFERENCES ordersD(id),
    delivelyDate REFERENCES ordersD(deliveryDate)
  )     