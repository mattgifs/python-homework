DROP VIEW IF EXISTS transactions_by_customer;
DROP VIEW IF EXISTS transactions_under2_by_customer;
DROP VIEW IF EXISTS large_transactions_7to9;
DROP VIEW IF EXISTS large_transactions_by_hour;
DROP VIEW IF EXISTS top_5_at_risk_establishments;


--DATA ANALYSIS: PART 1
--How can you isolate (or group) the transactions of each cardholder?
CREATE VIEW transactions_by_customer AS
SELECT ch.cardholder_name, ch.cardholder_id, 
COUNT(t.transaction_id) AS "Transactions per Customer"
FROM credit_card cc
JOIN card_holder ch ON (cc.cardholder_id=ch.cardholder_id)
JOIN transaction t ON (cc.card_number=t.card_number)
GROUP BY ch.cardholder_id

--Count the transactions that are less than $2.00 per cardholder
CREATE VIEW transactions_under2_by_customer AS
SELECT ch.cardholder_name, ch.cardholder_id,
COUNT(t.transaction_id) AS "Transactions Under $2 by Customer"
FROM credit_card cc
JOIN card_holder ch
	ON (cc.cardholder_id=ch.cardholder_id)
JOIN transaction t
	ON (cc.card_number=t.card_number)
WHERE t.amount < 2
GROUP BY ch.cardholder_id
ORDER BY "Transactions Under $2 by Customer" DESC;

-- Judging by the resulting table alone, there is not enough
-- evidence to identify fraudulent activity. However, it may be worth
-- further investigating those customers with the highest number of 
-- transactions under $2; Cardholders 10, 11, 12, 19, and 24 all have 
-- 20 or more of these transactions. 

------------------------------------------------------------------------

--What are the top 100 highest transactions made between 7:00 am and 9:00 am?
CREATE VIEW large_transactions_7to9 AS
SELECT * FROM transaction
WHERE EXTRACT (HOUR FROM transaction_date)>=7
	AND EXTRACT (HOUR FROM transaction_date)<9
ORDER BY amount DESC
LIMIT 100

--Do you see any anomalous transactions that could be fraudulent?
-- The largest 8 transactions may be fraudulent. The amounts for 
-- these transactions are between $748 and $1894, all of which are
-- much larger than the majority of transactions, and seem like way too
-- much to spend at any of the included merchant categories (though there 
-- may be logical explanations).

--Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
CREATE VIEW large_transactions_by_hour AS
SELECT EXTRACT(HOUR FROM transaction_date) AS hour_of_day, 
COUNT(*) AS Transaction_Count 
FROM transaction
WHERE amount >700 
GROUP BY hour_of_day
ORDER BY Transaction_Count DESC;

-- The hours with the greatest number of transactions over $700 are 
-- 3pm (7 transactions) and 6am (6 transactions). 1am, 8am, 1pm, and 11pm
-- each have 5 transactions that meet these criteria. Each of these hours
-- are likely higher-traffic times for the food merchants (nighttime = bar hours,
-- morning=breakfast, midday=lunch), thus increasing the chances of some
-- fraudulent activity. Strangely, there are no significant spikes in this 
-- metric during common dinner hours.

CREATE VIEW top_5_at_risk_establishments AS 
SELECT m.id_merchant, m.merchant_name, mc.merchant_category_name,
COUNT (t.transaction_id) AS Small_Transaction_Count
FROM transaction t
JOIN merchant m 
	ON (t.id_merchant = m.id_merchant)
JOIN merchant_category mc 
	ON(m.id_merchant_category = mc.id_merchant_category)
WHERE t.amount < 2
GROUP BY m.id_merchant, mc.merchant_category_name
ORDER BY Small_Transaction_Count DESC
LIMIT 5;

