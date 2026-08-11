/*
Project: SQL Marketing Campaign Performance Analysis

Description:
This project combines Facebook Ads and Google Ads data to analyze
marketing campaign performance using SQL. The analysis includes
aggregated advertising metrics and ROMI calculations to identify
the best-performing campaign and ad set.

Skills:
- CTE
- LEFT JOIN
- UNION ALL
- Aggregation
- GROUP BY
- HAVING
- ORDER BY
- NULLIF
- ROMI Analysis


-- =========================================================
-- Analysis 1: Campaign Performance Overview
-- Combine Facebook Ads and Google Ads data
-- and calculate aggregated performance metrics
-- =========================================================

WITH facebook_data AS (
    SELECT
        f.ad_date,
        c.campaign_name,
        a.adset_name,
        f.spend,
        f.impressions,
        f.reach,
        f.clicks,
        f.leads,
        f.value
    FROM facebook_ads_basic_daily AS f
    LEFT JOIN facebook_adset AS a
        ON f.adset_id = a.adset_id
    LEFT JOIN facebook_campaign AS c
        ON f.campaign_id = c.campaign_id
),

all_ads_data AS (
    SELECT
        ad_date,
        'Facebook Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM facebook_data

    UNION ALL

    SELECT
        ad_date,
        'Google Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM google_ads_basic_daily
)

SELECT
    ad_date,
    media_source,
    campaign_name,
    adset_name,
    SUM(spend) AS total_spend,
    SUM(impressions) AS total_impressions,
    SUM(reach) AS total_reach,
    SUM(clicks) AS total_clicks,
    SUM(leads) AS total_leads,
    SUM(value) AS total_conversion_value
FROM all_ads_data
GROUP BY
    ad_date,
    media_source,
    campaign_name,
    adset_name
ORDER BY
    ad_date,
    media_source,
    campaign_name,
    adset_name;



-- =========================================================
-- Analysis 2: Top Campaign by ROMI
-- Identify the campaign with the highest ROMI
-- among campaigns with total spend greater than 500,000
-- =========================================================

WITH facebook_data AS (
    SELECT
        f.ad_date,
        c.campaign_name,
        a.adset_name,
        f.spend,
        f.impressions,
        f.reach,
        f.clicks,
        f.leads,
        f.value
    FROM facebook_ads_basic_daily AS f
    LEFT JOIN facebook_adset AS a
        ON f.adset_id = a.adset_id
    LEFT JOIN facebook_campaign AS c
        ON f.campaign_id = c.campaign_id
),

all_ads_data AS (
    SELECT
        ad_date,
        'Facebook Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM facebook_data

    UNION ALL

    SELECT
        ad_date,
        'Google Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM google_ads_basic_daily
)

SELECT
    campaign_name,
    SUM(spend) AS total_spend,
    SUM(value) AS total_conversion_value,
    ROUND(
        (SUM(value) - SUM(spend)) * 100.0
        / NULLIF(SUM(spend), 0),
        2
    ) AS romi_percent
FROM all_ads_data
GROUP BY campaign_name
HAVING SUM(spend) > 500000
ORDER BY romi_percent DESC
LIMIT 1;



-- =========================================================
-- Analysis 3: Top Ad Set by ROMI
-- Identify the highest-ROMI ad set
-- within the top-performing campaign
-- =========================================================

WITH facebook_data AS (
    SELECT
        f.ad_date,
        c.campaign_name,
        a.adset_name,
        f.spend,
        f.impressions,
        f.reach,
        f.clicks,
        f.leads,
        f.value
    FROM facebook_ads_basic_daily AS f
    LEFT JOIN facebook_adset AS a
        ON f.adset_id = a.adset_id
    LEFT JOIN facebook_campaign AS c
        ON f.campaign_id = c.campaign_id
),

all_ads_data AS (
    SELECT
        ad_date,
        'Facebook Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM facebook_data

    UNION ALL

    SELECT
        ad_date,
        'Google Ads' AS media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM google_ads_basic_daily
)

SELECT
    campaign_name,
    adset_name,
    SUM(spend) AS total_spend,
    SUM(value) AS total_conversion_value,
    ROUND(
        (SUM(value) - SUM(spend)) * 100.0
        / NULLIF(SUM(spend), 0),
        2
    ) AS romi_percent
FROM all_ads_data
WHERE campaign_name = 'Promos'
GROUP BY
    campaign_name,
    adset_name
ORDER BY romi_percent DESC
LIMIT 1;
