use swiggy;

/*

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Swiggy Restaurant Data Analysis Project
Author : Atul Kumar Anupam
Description : End-to-end analysis of restaurant data to identify market gaps,
			  optimize pricing strategies, and recommend expansion locations.
Database : MySQL
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
*/

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- 1. DATA CLEANING & STANDARDIZATION
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- Issue : Inconsistent capitalization and spelling in cuisine names (e.g., "North-Indian" vs "North Indian")
-- Fix : Standardize 'North-Indian' to 'North Indian' to ensure accurate grouping

UPDATE restaurants
SET cuisine = 'North Indian'
WHERE cuisine = 'North-Indian';

-- Issue : Missing rating values can skew averages.
-- Fix : Impute NULL rating with 0 (assuming new restaurants with no rating yet.)

UPDATE restaurants
SET rating = 0
WHERE rating IS NULL;

-- Issue : Cost outliers (e.g., Negative costs or unrealistically high values)
-- Logic : Remove rows where cost is likely an error(e.g., < 50 AND > 50000)

DELETE FROM restaurants
WHERE cost < 50 AND cost > 50000;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- 2. EXPLORATORY DATA ANALYSIS (EDA)
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 
-- Q1: Overview of the Market
-- Goal : Understand the scale of the dataset (Total Restaurants & Cities covered)
 
SELECT 
	COUNT(id) AS total_restaurants,
    COUNT(DISTINCT city) AS total_cities
FROM restaurants;

-- Q2: Market Saturation
-- Goal : Identify the top 5 cities with the highest number of restaurants.
-- Insight: Helps identify Saturated markets vs Emerging markets.

SELECT
	city,
    COUNT(id) AS restaurant_count
FROM restaurants
GROUP BY city
ORDER BY restaurant_count DESC
LIMIT 5;

-- Q3: Cost of living analysis
-- Goal: Compare the average cost for two across major metropolitan cities.

SELECT
	city,
    cuisine,
    ROUND(AVG(cost),2) AS avg_cost
FROM restaurants
WHERE city IN ('Delhi','Noida','Gurgaon','Mumbai','Bangalore')
Group BY city, cuisine
ORDER BY cuisine, avg_cost DESC;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- 3. DEEP DIVE : CUISINE & POPULARITY
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- Q4: Most Popular Cuisines (BY Vote Volume)
-- Goal: Determine which cuisines have the highest demand based on total rating counts.

SELECT
	cuisine,
    SUM(rating_count) AS total_votes
FROM restaurants
GROUP BY cuisine
ORDER BY total_votes DESC
LIMIT 5;

-- Q5: Quality vs Quantity Matrix
-- Goal: Identify cuisines that are High Quality (High Avg Rating) but potentially Niche (Lower Vote Count).
-- Logic: We filter for cuisines with at least 1000 total votes to ensure statistical significance.

SELECT
	cuisine,
    COUNT(id) AS restaurant_count,
    ROUND(AVG(rating),2) AS avg_rating,
    SUM(rating_count) AS total_votes
FROM restaurants
GROUP BY cuisine
HAVING SUM(rating_count) > 1000
ORDER BY avg_rating DESC
LIMIT 5;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- 4. ADVANCE ANALYTICS (Window Functions & CTEs)
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- Q6: Top Rated Restaurant per city
-- Goal: Find the single highest-rated restaurant in every city.
-- Technique: Use RANK() Window Function to handle ties (e.g., if two restaurants have 4.9 rating).

WITH RankedRestaurants AS (
	SELECT
		name, city, cuisine, rating, rating_count,
        RANK() OVER (PARTITION BY city ORDER BY rating DESC, rating_count DESC) AS rank_in_city
	FROM restaurants
    WHERE rating_count > 50   -- Filter out restaurants with very few reviews to ensure quality
)
SELECT
	name, city, cuisine, rating
    FROM RankedRestaurants
    WHERE rank_in_city = 1;
        
-- Q7: Market Segmentation (Bucketing)
-- Goal: Categorize restaurants into 'Budget', 'Mid range' and 'Luxury' segments.
-- Insight: Determine the price distribution of the market.

SELECT
	CASE
		WHEN cost < 300 THEN 'BUDGET'
        WHEN cost BETWEEN 300 and 800 THEN 'MID range'
        ELSE 'Luxury'
	END AS price_segment,
    COUNT(id) AS total_restaurants,
    ROUND(AVG(rating),2) AS avg_rating
FROM restaurants
GROUP BY 1 
ORDER BY total_restaurants DESC;

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- 5. Aggregation Analytics
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- Q8: The "Blue Ocean" Strategy (High demand , Low supply)
-- Goal: Find the best city + cuisine combination to open a new restaurant.alter
-- Logic: We want a high Total Demand (Rating count) but Low Competition (Restaurant Count).

SELECT 
	city,
    cuisine, 
    COUNT(id) AS supply_count,
    SUM(rating_count) AS demand_volume
FROM restaurants
GROUP BY city, cuisine
HAVING COUNT(id) < 50                     -- Low Competition (Few Restaurants)
	AND SUM(rating_count) > 20000         -- High Demand (Lots of dinners)  
ORDER BY demand_volume DESC;

/*
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
END OF PROJECT
Summary Of Insights:
1. Banglore is the most saturated market.
2. Mumbai has the highest average cost for dining.
3. North Indian is the most popular, but Biryani has higher customer satisfaction.
4. Recommendation : Lunch a Mid-range Biryani brand in pune to capitalize on the Supply Demand gap.
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
*/


