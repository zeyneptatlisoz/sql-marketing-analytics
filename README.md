# SQL Marketing Campaign Performance Analysis

## Project Overview

This project analyzes marketing campaign performance by combining Facebook Ads and Google Ads data using SQL. The analysis focuses on campaign effectiveness, advertising performance, and Return on Marketing Investment (ROMI).

---

## Business Goal

The objective of this project is to:

- Combine advertising data from multiple platforms.
- Evaluate campaign performance using key marketing metrics.
- Identify the highest-performing campaign based on ROMI.
- Determine the best-performing ad set within the top campaign.

---

## Dataset

The analysis uses the following tables:

- facebook_ads_basic_daily
- facebook_campaign
- facebook_adset
- google_ads_basic_daily

---

## SQL Techniques Used

- Common Table Expressions (CTE)
- LEFT JOIN
- UNION ALL
- GROUP BY
- Aggregation Functions (SUM)
- HAVING
- ORDER BY
- NULLIF
- ROMI Calculation

---

## Analysis Performed

### 1. Campaign Performance Overview

- Combined Facebook Ads and Google Ads into one dataset.
- Aggregated advertising metrics by date, campaign, and ad set.
- Calculated total spend, impressions, reach, clicks, leads, and conversion value.

### 2. Top Campaign by ROMI

- Calculated ROMI for each campaign.
- Filtered campaigns with total spend greater than 500,000.
- Identified the campaign with the highest marketing return.

### 3. Top Ad Set by ROMI

- Focused on the highest-performing campaign.
- Compared ad sets based on ROMI.
- Identified the best-performing ad set.

---

## Technologies

- SQL
- PostgreSQL
- Marketing Analytics

---

## Repository Structure

```
sql-marketing-analytics/
│
├── README.md
└── marketing_analysis.sql
```

---

## Author

Zeynep Tatlısöz
Aspiring Data Analyst
