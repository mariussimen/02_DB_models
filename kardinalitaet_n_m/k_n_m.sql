
-- Vorbereitung
USE design;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS servants;

/* SERVANTS */

-- Servants: ohne Fremdschlüssel
CREATE TABLE IF NOT EXISTS servants
(
  id           INT         NOT NULL AUTO_INCREMENT,
  servant_name VARCHAR(45) NOT NULL,
  yrs_served   TINYINT     NOT NULL,
  PRIMARY KEY (id)
);

-- Servants: Struktur
DESCRIBE design.servants;

-- Servants: Inserts
INSERT INTO servants (id, servant_name, yrs_served) VALUES (DEFAULT, "Hubert", 5);
INSERT INTO servants (id, servant_name, yrs_served) VALUES (DEFAULT, "Arian", 3);

-- Servants: Inhalte 
SELECT * FROM design.servants;

/*  PRODUCTS */

-- Products: ohne Fremdschlüssel
CREATE TABLE IF NOT EXISTS products
(
  id            INT          NOT NULL AUTO_INCREMENT,
  product_name  VARCHAR(45)  NOT NULL,
  product_price DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (id)
);

-- Products: Struktur
DESCRIBE design.products;

-- Products: Inserts
INSERT INTO products (id, product_name, product_price) VALUES (DEFAULT, "Whiskas|Lachs", 2.75);
INSERT INTO products (id, product_name, product_price) VALUES (DEFAULT, "Whiskas|Huhn", 2.80);
INSERT INTO products (id, product_name, product_price) VALUES (DEFAULT, "Felix|Jelly", 3.75);
INSERT INTO products (id, product_name, product_price) VALUES (DEFAULT, "Felix|Sauce", 3.80);

-- Products: Inhalte 
SELECT * FROM design.products;

/*  PURCHASES (Kaufprozesse)*/

-- ServantsProducts (purchases)
CREATE TABLE IF NOT EXISTS purchases
(
  servants_id INT NOT NULL,
  products_id INT NOT NULL
);

ALTER TABLE purchases
  ADD CONSTRAINT FK_servants_TO_purchases
    FOREIGN KEY (servants_id)
    REFERENCES servants (id);

ALTER TABLE purchases
  ADD CONSTRAINT FK_products_TO_purchases
    FOREIGN KEY (products_id)
    REFERENCES products (id);

-- Purchases: Struktur
DESCRIBE design.purchases;

-- Purchases: Inserts (Kaufprozesse : Käufer - Produkt)
INSERT INTO purchases (servants_id, products_id) VALUES (1, 2);
INSERT INTO purchases (servants_id, products_id) VALUES (1, 3);
INSERT INTO purchases (servants_id, products_id) VALUES (2, 1);
INSERT INTO purchases (servants_id, products_id) VALUES (2, 2);
INSERT INTO purchases (servants_id, products_id) VALUES (2, 3);
INSERT INTO purchases (servants_id, products_id) VALUES (2, 4);

-- Purchases: Inhalte 
SELECT * FROM design.purchases;
