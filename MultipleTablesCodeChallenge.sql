--Multiple Tables Code Challenge

-- table plans has columns id, price, description
-- table premium_users has columns:
-- user_id, membership_plan_id, purchase_date, cancel_date

--find which plans are used by premium members
SELECT premium_users.user_id,
   plans.description
FROM premium_users
JOIN plans
  ON plans.id = premium_users.membership_plan_id;

--table users has columns id, first_name, last_name, age, gender
--table premium_users has columns user_id, membership_plan_id, purchase_date, cancel_date

--find the users who aren't premium users, select id from users
SELECT users.id
FROM users
LEFT JOIN premium_users
    ON premium_users.user_id = users.id
WHERE premium_users.user_id IS NULL;

--table songs has columns id, title, artist, year
--table plays has columns user_id, song_id, play_date, play_hour

--find the titles of the songs played by each user
-- select user_id from plays, play_date from plays, and title from songs
SELECT plays.user_id, plays.play_date, songs.title
FROM songs
JOIN plays
    on songs.id = plays.song_id;

-- create two temporary tables: 
-- january (contains all song plays from Jan 2017), feb (contains all song plays from feb 2017)

-- find which users played songs in January but not February
WITH january AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '01'
),
february AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '02'

)
SELECT january.user_id
FROM january
LEFT JOIN february
	ON january.user_id = february.user_id
WHERE february.user_id IS NULL;

-- with table months which includes column months and table premium_users

-- for each month in months find whether users were active or canceled
SELECT premium_users.user_id,
  months.months,
  CASE
    WHEN (
      premium_users.purchase_date <= months.months
      )
      AND
      (
        premium_users.cancel_date >= months.months
        OR
        premium_users.cancel_date IS NULL
      )
    THEN 'active'
    ELSE 'not_active'
  END AS 'status'
FROM premium_users
CROSS JOIN months;