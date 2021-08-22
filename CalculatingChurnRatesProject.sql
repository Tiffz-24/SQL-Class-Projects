--Calculating Churn Rates Project

--table subscriptions with columns id, subscription_start, subscription_end, segment

--Determine the range of months of data provided
SELECT MIN(subscription_start), 
MAX(subscription_start) FROM subscriptions;

--Create a temporary table of months
--Then create a temporary table, cross_join, from subscriptions and your months. 
--Finally, create a temporary table, status, from the cross_join that contains:
--id, month (alias of first_day), is_active_87, is_active_30
--Add an is_canceled_87 and an is_canceled_30 column to the status table
--Create a status_aggregate temporary table that is a sum of active and
--canceled subscriptions for each segment for each month
--Calculate the churn rates for the two segments over the three month period

WITH months AS
(SELECT
    '2017-01-01' as first_day,
    '2017-01-31' as last_day
    UNION
    SELECT 
    '2017-02-01' as first_day,
    '2017-02-28' as last_day
    UNION 
    SELECT
    '2017-03-01' as first_day,
    '2017-03-31' as last_day
), cross_join AS 
(SELECT * FROM subscriptions
    CROSS JOIN months
), status AS
(SELECT
id,
first_day AS month,
CASE
    WHEN(subscription_start < first_day) AND
     (subscription_end > first_day OR subscription_end IS NULL) AND (segment = 87) THEN 1
     ELSE 0
    END AS is_active_87,
CASE
    WHEN(subscription_start < first_day) AND
     (subscription_end > first_day OR subscription_end IS NULL) AND (segment = 30) THEN 1
     ELSE 0
    END AS is_active_30,
CASE
    WHEN(subscription_end BETWEEN first_day AND last_day) AND (segment = 87) THEN 1
    ELSE 0
END AS is_canceled_87,
CASE
    WHEN(subscription_end BETWEEN first_day AND last_day) AND (segment = 30) THEN 1
    ELSE 0
END AS is_canceled_30
FROM cross_join
), status_aggregate AS 
(SELECT
    SUM(is_active_87) AS sum_active_87,
    SUM(is_active_30) AS sum_active_30,
    SUM(is_canceled_87) AS sum_canceled_87,
    SUM(is_canceled_30) AS sum_canceled_30
    FROM status
    GROUP BY month
) 




