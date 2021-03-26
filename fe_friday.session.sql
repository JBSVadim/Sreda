DROP TABLE clients; 
DROP TABLE contracts;
DROP TABLE ordersD;
DROP TABLE products:
DROP TABLE "ordersD_to_products"
/*--------*/
CREATE TABLE clients (
  id serial PRIMARY KEY,
  firstName VARCHAR(68) CHECK (firstName != ''),
  lastName VARCHAR(68) CHECK (lastName != ''),
  phone NOT NULL,
  birtday date NOT NULL CHECK (
    birthday < current_date
    AND birthday > '1900/1/1',
    email varchar(256) NOT NULL CHECK (email != '')
  );
  /*--------*/
  CREATE TABLE conctracts(
    id serial PRIMARY KEY,
    clientId REFERENCES clients(id),
    createAt timestamp NOT NULL DEFAULT current_timestamp);
  /*-----------*/
  CREATE TABLE ordersD (
    id serial PRIMARY KEY,
    contractId int REFERENCES contracts(id),
    delivelyDate date NOT NULL CHECK (delivelyDate > current_date)
    );
  /*----------*/
  CREATE TABLE products(
    id serial PRIMARY KEY,
    productName VARCHAR(128) UNIQUE CHECK (productName != ''),
    quantity int NOT NULL CHECK (quantity > 0),
    price decimal(10, 2) NOT NULL CHECK (price > 0),
  );
  CREATE TABLE "ordersD_to_products" (
    id serial PRIMARY KEY,
    orderId int REFERENCES ordersD(id),
    productId int REFERENCES products(id),
    quantity int NOT NULL)   