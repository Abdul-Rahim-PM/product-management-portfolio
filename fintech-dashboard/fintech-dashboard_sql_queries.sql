-- SQL Queries for Fintech Payment Optimization Dashboard
-- 1. Analyze fraud alerts by date
SELECT date, COUNT(*) AS fraud_alerts,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS alert_percentage
FROM transactions
WHERE is_flagged = 1
GROUP BY date
ORDER BY date;

-- 2. Calculate transaction volume
SELECT date, SUM(amount) AS total_volume
FROM transactions
WHERE date BETWEEN '2022-07-01' AND '2022-12-31'
GROUP BY date
ORDER BY date;

-- 3. Identify false positives
SELECT transaction_id, amount
FROM transactions
WHERE is_flagged = 1 AND is_fraud = 0
ORDER BY amount DESC;

-- 4. Transaction processing time
SELECT AVG(processing_time) AS avg_processing_time
FROM transactions
WHERE date BETWEEN '2022-07-01' AND '2022-12-31'
GROUP BY date;

-- 5. Fraud alerts by transaction type
SELECT transaction_type, 
       COUNT(*) AS fraud_alerts,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY transaction_type), 2) AS alert_rate
FROM transactions
WHERE is_flagged = 1
GROUP BY transaction_type;

-- 6. High-value transactions
SELECT transaction_id, amount, merchant_id
FROM transactions
WHERE amount > 10000
AND date BETWEEN '2022-07-01' AND '2022-12-31'
ORDER BY amount DESC;

-- 7. Merchant-level fraud trends
SELECT m.merchant_name, COUNT(*) AS fraud_alerts
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
WHERE t.is_flagged = 1
GROUP BY m.merchant_name
ORDER BY fraud_alerts DESC;

-- 8. Transaction success rate
SELECT date, 
       SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) / COUNT(*) AS success_rate
FROM transactions
GROUP BY date;