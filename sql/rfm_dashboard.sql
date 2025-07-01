-- RFM DASHBOARD QUERIES

-- 1. Average RFM values
SELECT 
  ROUND(AVG(Recency), 1) AS avg_recency,
  ROUND(AVG(Frequency), 1) AS avg_frequency,
  ROUND(AVG(Monetary), 2) AS avg_monetary
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`;

-- 2. RFM segments based on basic rules
SELECT 
  CASE 
    WHEN Recency <= 30 AND Frequency >= 5 THEN 'Champions'
    WHEN Recency <= 60 AND Frequency >= 3 THEN 'Loyal'
    WHEN Recency > 180 THEN 'At Risk'
    ELSE 'Others'
  END AS rfm_segment,
  COUNT(*) AS customer_count,
  ROUND(AVG(churned), 4) AS avg_churn_rate
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`
GROUP BY rfm_segment
ORDER BY customer_count DESC;

-- 3. Top monetary customers
SELECT 
  customer_id,
  ROUND(Monetary, 2) AS total_spent,
  Recency,
  Frequency,
  churned
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`
ORDER BY total_spent DESC
LIMIT 10;

