--Usage Funnels with Warby Parker
---Given funnels & tables:
-- Quiz Funnel : survey, Home Try-On Funnel: quiz, home_try_on, purchase

-- Select all columns from the first 10 rows
SELECT *
FROM survey
LIMIT 10;

-- Create a quiz funnel using GROUP BY
SELECT question,
  COUNT (DISTINCT user_id) AS 'responses'
FROM survey
GROUP BY 1
ORDER BY 1;

-- Combine the three tables starting with the top of the funnel (quiz) 
-- and ending with the bottom of the funnel (purchase)
--select only the first 10 rows from the table
SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'  
FROM quiz q
LEFT JOIN home_try_on h
  ON h.user_id = q.user_id
LEFT JOIN purchase p
  ON p.user_id = h.user_id  
LIMIT 10;

-- Calculate overall conversion rates by aggregating across all rows
WITH funnel AS(
SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'  
FROM quiz q
LEFT JOIN home_try_on h
  ON h.user_id = q.user_id
LEFT JOIN purchase p
  ON p.user_id = h.user_id)  
SELECT COUNT(*) AS 'num_quiz',
  SUM(is_home_try_on) AS 'num_home_try_on',
  SUM(is_purchase) AS 'num_purchase'
FROM funnel;  

-- Compare conversion from quiz --> home_try_on and home_try_on --> purchase
SELECT COUNT(*) AS 'num_quiz',
  SUM(is_home_try_on) AS 'num_home_try_on',
  SUM(is_purchase) AS 'num_purchase',
  1.0 * SUM(is_home_try_on) / COUNT(user_id) AS '%_home_try_on',
  1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS '%_purchase'
FROM funnel;  

-- Calculate the most common results of the style quiz
SELECT style,
 COUNT(*) AS 'number'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;
SELECT fit,
 COUNT(*) AS 'number'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;
SELECT shape,
  COUNT(*) AS 'number'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;
SELECT color,
  COUNT(*) AS 'number'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

--Calculate the most common types of purchase made
SELECT style,
 COUNT(*) AS 'number'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;
SELECT model_name,
 COUNT(*) AS 'number'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;
SELECT color,
 COUNT(*) AS 'number'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;
SELECT price,
 COUNT(*) AS 'number'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;