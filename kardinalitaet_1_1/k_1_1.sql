-- Vorbereitungen
USE design;
DROP TABLE IF EXISTS servants;
DROP TABLE IF EXISTS cats;

-- Mastertabelle: unverändert
CREATE TABLE IF NOT EXISTS cats
(
  id INT NOT NULL AUTO_INCREMENT,
  cat_name  VARCHAR(45) NOT NULL,
  fur_color VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

-- Struktur: MT
DESCRIBE design.cats;

-- Inserts: MT (Mastertable)
INSERT INTO cats (id, cat_name,fur_color) VALUES (DEFAULT, "Grizabella", "white");
INSERT INTO cats (id, cat_name,fur_color) VALUES (DEFAULT, "Alonzo", "grey");
INSERT INTO cats (id, cat_name,fur_color) VALUES (DEFAULT, "Mausi", "striped");

-- Inhalte: MT
SELECT * FROM design.cats;


-- Detailtabelle: Verbindung zur MT über Fremdschlüssel
CREATE TABLE IF NOT EXISTS servants
(
  id INT NOT NULL AUTO_INCREMENT,
  servant_name VARCHAR(45) NOT NULL,
  yrs_served   TINYINT NOT NULL,
  cats_id      INT     NOT NULL,
  PRIMARY KEY (id)
);

-- Fremdschlüssel: DT
ALTER TABLE servants
  ADD CONSTRAINT FK_cats_TO_servants
    FOREIGN KEY (cats_id)
    REFERENCES cats (id);

-- wichtig bei 1:1  UNIQUE im fk
ALTER TABLE servants
  ADD CONSTRAINT UQ_cats_id UNIQUE (cats_id);

-- Struktur: DT
DESCRIBE design.servants;

-- Inserts: DT
INSERT INTO servants (id, servant_name, yrs_served, cats_id) VALUES (DEFAULT, "Peter", 5, 1);
INSERT INTO servants (id, servant_name, yrs_served, cats_id) VALUES (DEFAULT, "Michael", 2, 2);
INSERT INTO servants (id, servant_name, yrs_served, cats_id) VALUES (DEFAULT, "Sven", 10, 3);

-- Inhalte: DT
SELECT * FROM design.servants;