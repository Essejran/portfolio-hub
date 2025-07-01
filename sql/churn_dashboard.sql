-- CHURN DASHBOARD QUERIES

-- 1. Overall churn rate
SELECT 
  COUNT(*) AS total_customers,
  SUM(churned) AS churned_customers,
  ROUND(SUM(churned) / COUNT(*), 4) AS churn_rate
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`;

-- 2. Churn rate by premium membership
SELECT 
  is_premium,
  COUNT(*) AS customers,
  SUM(churned) AS churned,
  ROUND(SUM(churned) / COUNT(*), 4) AS churn_rate
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`
GROUP BY is_premium
ORDER BY churn_rate DESC;

-- 3. Churn rate by number of logins
SELECT 
  CASE 
    WHEN num_logins_last_month = 0 THEN '0'
    WHEN num_logins_last_month BETWEEN 1 AND 2 THEN '1-2'
    WHEN num_logins_last_month BETWEEN 3 AND 5 THEN '3-5'
    WHEN num_logins_last_month > 5 THEN '6+'
  END AS login_band,
  COUNT(*) AS customers,
  ROUND(AVG(churned), 4) AS churn_rate
FROM 
  `portfolio-hub-464520.portfolio_hub.customer_master`
GROUP BY login_band
ORDER BY login_band;
