-- Queries Code Challenge

-- The babies table has the following columns:
-- name (the name of the baby)
-- year (the year the name was given)
-- gender (the gender of the baby)
-- number (the number of times the name was given)

-- Find the number of girls who were named Lillian for the full span of time of the database.
-- Select only the year and number columns.

SELECT year, number
FROM babies
WHERE name = 'Lillian';

--Find 20 distinct names that start with 'S'. Select only the name column

SELECT name
FROM babies
WHERE name LIKE 'S%'
LIMIT 20;

--Find the top 10 names in 1880. Select the name, gender, and number columns


SELECT name, gender, number
FROM babies
WHERE year = '1880'
ORDER BY number DESC
LIMIT 10;

--The nomnom table has the following columns:
-- name (the restaurant name)
-- neighborhood (the neighborhood name)
-- cuisine (the cuisine type)
-- review (the average user review)
-- price (the price range)
-- health (the health inspection grade)

--Return all restaurants that are Japanese and $$. Select all columns
SELECT * 
FROM nomnom
WHERE cuisine = 'Japanese' AND price = '$$';

--Find a restaurant that contains the word 'noodle' in it. Select all columns
SELECT *
FROM nomnom
WHERE name LIKE '%noodle%';

--Find the restaurants that have empty health values. Select all columns
SELECT *
FROM nomnom
WHERE health IS NULL;

--The news table has the following columns"
-- id (the article identifier)
-- title (the article title)
-- publisher (the article publisher)
-- category (the article category)
-- timestamp (the time of publication)
-- url (the article web address)

-- Order the table by title. Select only the title and publisher columns
SELECT title, publisher
FROM news
ORDER BY title;

--Find all article names that have the word 'bitcoin' in it. Select all columns
SELECT *
FROM news
WHERE title LIKE '%bitcoin%';

--Find the 20 business articles published most recently. Select all columns
SELECT *
FROM news
WHERE category = 'b'
ORDER by timestamp DESC
LIMIT 20;