/* LinkedIn Job Market Analytics - SQL Analysis */

-- 1. Check for duplicate records
SELECT job_id, job_title, company_name, posting_date, COUNT(*) AS cnt
FROM [linkedin job postings]
GROUP BY job_id, job_title, company_name, posting_date
HAVING COUNT(*) > 1;

-- 2. Remove duplicate records (keep first occurrence)
WITH CTE_Duplicates AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY job_id, job_title, company_name, posting_date
            ORDER BY job_id
        ) AS rn
    FROM [linkedin job postings]
)
DELETE FROM CTE_Duplicates
WHERE rn > 1;

-- 3. Check missing values in key columns
SELECT 
    SUM(CASE WHEN salary_min_lpa IS NULL THEN 1 ELSE 0 END) AS missing_salary,
    SUM(CASE WHEN company_size IS NULL THEN 1 ELSE 0 END) AS missing_company_size,
    SUM(CASE WHEN required_skills IS NULL THEN 1 ELSE 0 END) AS missing_skills
FROM [linkedin job postings];

-- 4. Clean missing values
UPDATE [linkedin job postings]
SET company_size = 'Unknown'
WHERE company_size IS NULL;

UPDATE [linkedin job postings]
SET required_skills = 'Not Specified'
WHERE required_skills IS NULL;

-- 5. Clean company name formatting (trim whitespace)
UPDATE [linkedin job postings]
SET company_name = TRIM(company_name);

-- 6. Top 10 hiring companies
SELECT TOP 10 company_name, COUNT(*) AS job_postings
FROM [linkedin job postings]
GROUP BY company_name
ORDER BY job_postings DESC;

-- 7. Most in-demand skills (split comma-separated skills into rows)
SELECT 
    TRIM(value) AS skill,
    COUNT(*) AS demand_count
FROM [linkedin job postings]
CROSS APPLY STRING_SPLIT(required_skills, ',')
WHERE required_skills != 'Not Specified'
GROUP BY TRIM(value)
ORDER BY demand_count DESC;

-- 8. Average salary by experience level
SELECT 
    experience_level,
    ROUND(AVG(salary_min_lpa), 1) AS avg_min_salary_lpa,
    ROUND(AVG(salary_max_lpa), 1) AS avg_max_salary_lpa,
    COUNT(*) AS num_postings
FROM [linkedin job postings]
WHERE salary_min_lpa IS NOT NULL
GROUP BY experience_level
ORDER BY 
    CASE experience_level 
        WHEN 'Entry' THEN 1 
        WHEN 'Mid' THEN 2 
        WHEN 'Senior' THEN 3 
        WHEN 'Lead' THEN 4 
    END;

-- 9. Job postings by location (top 10 cities)
SELECT TOP 10 location, COUNT(*) AS job_postings
FROM [linkedin job postings]
GROUP BY location
ORDER BY job_postings DESC;

-- 10. Hiring trend over time (monthly)
SELECT 
    FORMAT(posting_date, 'yyyy-MM') AS month,
    COUNT(*) AS job_postings
FROM [linkedin job postings]
GROUP BY FORMAT(posting_date, 'yyyy-MM')
ORDER BY month;

-- 11. Remote vs Hybrid vs Onsite split
SELECT job_type, COUNT(*) AS job_postings,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM [linkedin job postings]
GROUP BY job_type
ORDER BY job_postings DESC;

-- 12. Experience level distribution
SELECT experience_level, COUNT(*) AS job_postings,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM [linkedin job postings]
GROUP BY experience_level
ORDER BY job_postings DESC;