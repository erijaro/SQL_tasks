-- Create the R1_products table
CREATE TABLE dbo.R1_products (
    Brand VARCHAR(255),
    Item VARCHAR(255)
);

-- Create the R2_products table
CREATE TABLE dbo.R2_products (
    Brand VARCHAR(255),
    Item VARCHAR(255)
);

-- Create the R3_products table
CREATE TABLE dbo.R3_products (
    Brand VARCHAR(255),
    Item VARCHAR(255)
);



-- Load data from R1_products.csv into R1_products table, skipping the first row
BULK INSERT dbo.R1_products
FROM 'C:/Users/jaroc/Desktop/softwares/SQL/S2_task/R1_products.csv'
WITH (
    FIRSTROW = 2,                
    FIELDTERMINATOR = ',',       
    ROWTERMINATOR ='0x0D0A'       
);

-- Load data from R2_products.csv into R2_products table, skipping the first row
BULK INSERT dbo.R2_products
FROM 'C:/Users/jaroc/Desktop/softwares/SQL/S2_task/R2_products.csv'
WITH (
    FIRSTROW = 2,                
    FIELDTERMINATOR = ',',       
    ROWTERMINATOR = '0x0D0A'       
);

-- Load data from R3_products.csv into R3_products table, skipping the first row
BULK INSERT dbo.R3_products
FROM 'C:/Users/jaroc/Desktop/softwares/SQL/S2_task/R3_products.csv'
WITH (
    FIRSTROW = 2,                
    FIELDTERMINATOR = ',',       
    ROWTERMINATOR = '0x0D0A'        
);