-- Einzeltabellen
SELECT * FROM design.servants;
SELECT * FROM design.products;
SELECT * FROM design.purchases;

-- Inner Join 1 / kombi (servants / products / purchases)

SELECT
     servant_name AS Diener,
     product_name AS "von X gekaufte Produkte:",
     CONCAT(servant_name,"kauft", product_name,".") AS Kaufhandlung
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
-- WHERE servant_name = "Hubert"
WHERE servant_name LIKE "%rian"
;


-- Wieviele Produkte hat X gekauft?
-- 2X kauft Y Produkte"

SELECT
    --  servant_name AS Diener,
    --  product_name AS "von X gekaufte Produkte:",
     CONCAT(servant_name,"kauft", COUNT(product_name),".") AS Kaufhandlung
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
-- WHERE servant_name = "Hubert"
WHERE servant_name LIKE "%rian"
;

-- Wie viel Geld hat Hubert ausgegeben?

SELECT
     servant_name AS Diener, -- organisch 
     COUNT(servant_name) AS Artikelanzahl, -- aggregiert / f()
     SUM(product_price) AS "Gesamtskosten(Euro)" -- aggregiert / f()
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
-- WHERE servant_name = "Hubert"
GROUP BY servant_name
;

-- Wer hat das Produkt X gekauft?  
-- Irgendwas mit Lachs / Irgendwas mit Sauce LIKE
-- Spalten --> Diener / Produkt
-- WHERE / LIKE
SELECT
	servant_name AS Diener,
    product_name AS "Irgendwas mit Sauce oder Lachs"
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
WHERE product_name LIKE "%Lachs%" OR product_name LIKE "%Sauce%" -- IN() ??
-- WHERE product_name LIKE "%Huhn%"
;

-- Wie oft wurde das Produkt X gekauft?
SELECT
    product_name AS Produkte,
    COUNT(product_name) AS Anzahl
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
GROUP BY product_name
ORDER BY Anzahl DESC
;

-- Welche Umsätze hatte das Produkt X?
SELECT
	product_name AS Produkte, -- nicht aggr.
    COUNT(product_name) AS Anzahl, -- aggr.
    SUM(product_price) AS Umsätze-- aggr. // count() * price
FROM design.purchases
INNER JOIN design.servants ON design.servants.id = design.purchases.servants_id
INNER JOIN design.products ON design.products.id = design.purchases.products_id
GROUP BY product_name
ORDER BY Umsätze DESC
;
