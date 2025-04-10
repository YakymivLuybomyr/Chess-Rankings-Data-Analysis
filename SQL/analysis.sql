1. General Statistics

Top 10 Countries by Number of Players in FIDE Rankings
Which countries have the most ranked players?

SELECT country, COUNT(*) as players_count
FROM `project.dataset.chess_fide_rankings`
GROUP BY country
ORDER BY players_count DESC
LIMIT 10

  

Player Distribution by Rating Categories
How many players fall into these rating ranges: <1000, 1000-1500, 1500-2000, 2000-2500, 2500+?

SELECT 
  CASE 
    WHEN rating < 1000 THEN '<1000'
    WHEN rating <= 1500 THEN '1000-1500'
    WHEN rating <= 2000 THEN '1500-2000'
    WHEN rating <= 2500 THEN '2000-2500'
    ELSE '2500+'
  END as rating_group,
  COUNT(*) as players_count
FROM `project.dataset.chess_fide_rankings`
GROUP BY rating_group
ORDER BY rating_group
--------------------------------------------------------------------------------------------------------------

2. Top Players & Countries

Top 20 Players by Rating
Who has the highest FIDE rating? Include country and gender.

SELECT name, country, rating, gender
FROM `project.dataset.chess_fide_rankings`
ORDER BY rating DESC
LIMIT 20


Average Rating by Country (for countries with >50 players)
Which countries have the strongest players on average?

SELECT country, AVG(rating) as avg_rating
FROM `project.dataset.chess_fide_rankings`
GROUP BY country
HAVING COUNT(*) > 50
ORDER BY avg_rating DESC
LIMIT 10
----------------------------------------------------------------------------------------------------------------

3. Gender Analysis

Gender Distribution
What percentage of players are female/male?

SELECT 
  gender, 
  COUNT(*) as players_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `project.dataset.chess_fide_rankings`), 2) as percentage
FROM `project.dataset.chess_fide_rankings`
GROUP BY gender


Top 10 Female Players by Rating
Who are the strongest female players?

SELECT name, country, rating
FROM `project.dataset.chess_fide_rankings`
WHERE gender = 'F'
ORDER BY rating DESC
LIMIT 10
--------------------------------------------------------------------------------------------------------------------

4. Rating Dynamics (if historical data exists)

Biggest Rating Increase Over the Last Year
Which players gained the most rating points?

SELECT name, country, rating, rating - previous_rating as rating_increase
FROM `project.dataset.chess_fide_rankings`
ORDER BY rating_increase DESC
LIMIT 10
