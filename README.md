# 🍽️ Swiggy Data Analysis Project

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Excel](https://img.shields.io/badge/Tool-Excel-green)
![Power BI](https://img.shields.io/badge/Visualization-PowerBI-yellow)
![Project Type](https://img.shields.io/badge/Project-Data%20Analysis-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Project Overview
This project analyzes restaurant data to uncover meaningful business insights for a food delivery platform like Swiggy. It focuses on identifying customer preferences, market trends, and expansion opportunities using SQL.

---

## 🎯 Business Objective
To identify **high-demand, low-supply opportunities (Blue Ocean Strategy)** and help optimize decisions related to:
- City expansion
- Cuisine popularity
- Pricing strategy

---

## 🛠️ Tools & Technologies

- **SQL (MySQL):** Data cleaning, aggregation, joins, CTEs, and window functions (RANK)
- **Microsoft Excel:** Initial data inspection and preprocessing
- **Power BI (Planned):** Dashboard creation for visual insights

---

## 🧹 Data Cleaning

- Standardized inconsistent cuisine names  
- Handled missing values in ratings  
- Removed outliers in cost column  
- Filtered invalid and inconsistent records  

---

## 📊 Exploratory Data Analysis (EDA)

- Total number of restaurants  
- City-wise restaurant distribution  
- Average cost analysis by city and cuisine  
- Popular cuisines based on rating counts  

---

## 📁 Dataset

The dataset contains information about restaurants listed on Swiggy.

### 🔑 Columns Description

- **restaurant_name** → Name of the restaurant  
- **city** → Location of the restaurant  
- **cuisine** → Type of food offered  
- **cost** → Average cost for two people  
- **rating** → Customer rating (0–5)  
- **rating_count** → Number of users who rated  

📌 File: `restaurants.csv`

---

## 🔍 Key SQL Queries Explained

### 1. Top Cities by Restaurant Count
Used `COUNT()` and `GROUP BY` to identify cities with the highest number of restaurants.

---

### 2. Popular Cuisines
Used `SUM(rating_count)` to measure demand instead of just counting restaurants.

---

### 3. Top Restaurants by City
Used `RANK()` window function to find the best restaurants in each city based on rating and reviews.

---

### 4. Market Segmentation
Used `CASE WHEN` to divide restaurants into Budget, Mid-range, and Luxury categories.

---

### 5. Blue Ocean Strategy
Identified cuisines with:
- Low supply (few restaurants)
- High demand (high rating counts)

This helps find expansion opportunities.

---

## 🍴 Key Analysis

### 🔹 Top Cities by Restaurants
Identified cities with the highest number of restaurants.

### 🔹 Cost Analysis
Compared average pricing across cities and cuisines.

### 🔹 Popular Cuisines
Used total rating counts to determine demand.

### 🔹 Quality vs Quantity
Filtered cuisines with high demand and strong ratings.

### 🔹 Top Restaurants by City
Used **window functions (RANK)** to find top-performing restaurants.

### 🔹 Market Segmentation
Restaurants categorized into:
- Budget (< ₹300)
- Mid-range (₹300–₹800)
- Luxury (> ₹800)

### 🔹 Blue Ocean Strategy 🔥
Identified opportunities where:
- Supply is low (fewer restaurants)
- Demand is high (high rating counts)

---

## 📈 Key Insights

- Bangalore shows signs of market saturation  
- Mumbai has higher average restaurant costs  
- Biryani is one of the most popular cuisines  
- Mid-range restaurants dominate demand  

---

## 🚀 Business Recommendations

- Expand mid-range restaurants in high-demand cities  
- Focus on high-performing cuisines like Biryani  
- Target cities with high demand but limited supply  

---

## 💡 Future Improvements

- Build Power BI dashboard for visualization  
- Use advanced SQL (median, percentiles)  
- Improve missing value handling techniques  
- Add predictive analysis for demand forecasting  

---

## 👨‍💻 Author

**Atul Kumar Anupam**  
- Aspiring Data Analyst / Data Scientist  
- Skills: SQL, Python, Power BI, Excel  

---

## ⭐ Support

If you found this project useful:
- ⭐ Star this repository  
- Share feedback  
- Connect with me on LinkedIn  
