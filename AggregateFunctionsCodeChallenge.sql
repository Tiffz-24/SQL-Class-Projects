--Aggregate Functions Code Challenge

--the users table has the following columns:
-- id, first_name, last_name, email, password

-- Determine the number of users that have an email ending in ".com"
SELECT COUNT(*)
FROM users
WHERE email LIKE "%.com";

--Create a list of first names and occurences within the users table
SELECT first_name, COUNT(*) AS 'count'
FROM users
GROUP BY first_name
ORDER BY 2 DESC;

-- the watch_history table has the following columns:
-- id, user_id, watch_date, watch_duration_in_minutes

--Create a distribution of watch durations
SELECT
  ROUND(watch_duration_in_minutes,0) as duration,
  COUNT(*) as count
FROM watch_history
GROUP BY duration
ORDER BY duration ASC;

--generate a table of user ids and total watch duration for
--users who watched more than 400 minutes of content
SELECT user_id, SUM(watch_duration_in_minutes)
FROM watch_history
GROUP BY user_id
HAVING SUM(watch_duration_in_minutes) > 400;

--find the total number of minutes watched 
SELECT ROUND(SUM(watch_duration_in_minutes),0)
FROM watch_history;

--find the duration of the longest and shortest individual watch event
SELECT
  MAX(watch_duration_in_minutes) AS max,
  MIN(watch_duration_in_minutes) AS min
FROM watch_history;

--the payments table has the following columns:
-- id, user_id, amount, status, pay_date

--Find all users that have successfully made a payment and their total amount paid
SELECT user_id, SUM(amount)
FROM payments
WHERE status = 'paid'
GROUP BY user_id
ORDER BY SUM(amount) DESC;

--sort the list by days where the most money was paid
SELECT pay_date, SUM(amount)
FROM payments
WHERE status = 'paid'
GROUP BY pay_date
ORDER BY SUM(amount) DESC;

--Find the average payment amount for users who have successfully paid
SELECT AVG(amount)
FROM payments
WHERE status = 'paid';