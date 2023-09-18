--create tables;
SELECT customer
INTO customers
FROM dbo.testS1_transactionsSQL
GROUP BY customer;

SELECT SUM(amount) as buy_co, customer
INTO buy_completed
FROM dbo.testS1_transactionsSQL
WHERE (type='BUY' AND status='COMPLETED' AND MONTH(date)=1)
GROUP BY customer;

SELECT SUM(amount)/100*10 as sell_co, customer
INTO sell_completed
FROM dbo.testS1_transactionsSQL
WHERE (type='SELL' AND status='COMPLETED' AND MONTH(date)=1)
GROUP BY customer;

SELECT SUM(amount)/100*(-1) as buy_ca, customer
INTO buy_canceled
FROM dbo.testS1_transactionsSQL
WHERE (type='BUY' AND status='CANCELED' AND MONTH(date)=1)
GROUP BY customer;

SELECT SUM(amount)/100*10/100*(-1) as sell_ca, customer
INTO sell_canceled
FROM dbo.testS1_transactionsSQL
WHERE (type='SELL' AND status='CANCELED' AND MONTH(date)=1)
GROUP BY customer;

--join tables;
SELECT c.customer, bco.buy_co, bca.buy_ca, sco.sell_co, sca.sell_ca
INTO total
FROM customers c
LEFT JOIN buy_completed bco ON c.customer=bco.customer
LEFT JOIN buy_canceled bca ON c.customer=bca.customer
LEFT JOIN sell_completed sco ON c.customer=sco.customer
LEFT JOIN sell_canceled sca ON c.customer=sca.customer

--replace NULL with 0s
UPDATE [total]
SET [buy_co]=0
WHERE [buy_co] IS NULL;

UPDATE [total]
SET [buy_ca]=0
WHERE [buy_ca] IS NULL;

UPDATE [total]
SET [sell_co]=0
WHERE [sell_co] IS NULL;

UPDATE [total]
SET [sell_ca]=0
WHERE [sell_ca] IS NULL;

--final table
SELECT  customer, ROUND(buy_co+buy_ca,2) as buy, ROUND(sell_co+sell_ca,2) as sell, ROUND(buy_co+buy_ca+sell_co+sell_ca,2) as total
FROM    total
ORDER BY total DESC;

DROP TABLE buy_completed;
DROP TABLE sell_completed;
DROP TABLE buy_canceled;
DROP TABLE sell_canceled;
