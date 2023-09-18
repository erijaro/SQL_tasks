-- create a column with retailer all tables;
ALTER TABLE dbo.R1_products
ADD Retailer nvarchar(50) NOT NULL DEFAULT ('R1');

ALTER TABLE dbo.R2_products
ADD Retailer nvarchar(50) NOT NULL DEFAULT ('R2');

ALTER TABLE dbo.R3_products
ADD Retailer nvarchar(50) NOT NULL DEFAULT ('R3');

ALTER TABLE dbo.Master_list
ADD Master_T nvarchar(50) NOT NULL DEFAULT ('Master');


--join tables;
CREATE TABLE final (
    Brand VARCHAR(255),
    Item VARCHAR(255),
    Retailer VARCHAR(255),
    Master_T VARCHAR(255)
);

-- Insert the result of the query into the new table
INSERT INTO final (Brand, Item, Retailer, Master_T)
SELECT Brand, Item, Retailer, NULL AS Master_T
FROM dbo.R1_products
UNION ALL
SELECT Brand, Item, Retailer, NULL AS Master_T
FROM dbo.R2_products
UNION ALL
SELECT Brand, Item, Retailer, NULL AS Master_T
FROM dbo.R3_products
UNION ALL
SELECT Brand, Item, NULL AS Retailer, Master_T
FROM dbo.Master_list;


SELECT * FROM final;


-- show unique items
SELECT DISTINCT Brand, Item
FROM final
WHERE Retailer IS NOT NULL;


-- find items which are selling in more than one retailer;
SELECT Item, COUNT(Retailer) AS RetailerCount
FROM final
GROUP BY Item
HAVING COUNT(Retailer) > 1
ORDER BY COUNT(Retailer) DESC;


-- find the items which are not in master and other than Jurassic World brand - not licensed
SELECT DISTINCT t1.Item AS UniqueItemsWithoutMaster, t1.Brand
FROM final AS t1
WHERE t1.Item NOT IN (
    SELECT DISTINCT t2.Item
    FROM final AS t2
    WHERE t2.Master_T = 'Master'
) AND t1.Brand <> 'Jurassic World';

