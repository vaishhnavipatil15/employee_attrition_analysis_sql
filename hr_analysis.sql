USE hr_analysis;

-- Overall attrition rate
SELECT COUNT(*) AS total_employees,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees;

-- Attrition by department
SELECT Department,
       COUNT(*) AS headcount,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY Department
ORDER BY attrition_pct DESC;

-- Attrition: overtime vs no overtime
SELECT OverTime,
       COUNT(*) AS headcount,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY OverTime;

-- Attrition by income band
SELECT CASE
         WHEN MonthlyIncome < 3000 THEN '1. Below 3k'
         WHEN MonthlyIncome < 6000 THEN '2. 3k-6k'
         WHEN MonthlyIncome < 10000 THEN '3. 6k-10k'
         ELSE '4. 10k+'
       END AS income_band,
       COUNT(*) AS headcount,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY income_band
ORDER BY income_band;

-- Attrition by tenure
SELECT CASE
         WHEN YearsAtCompany <= 1 THEN '1. 0-1 yr'
         WHEN YearsAtCompany <= 3 THEN '2. 2-3 yrs'
         WHEN YearsAtCompany <= 5 THEN '3. 4-5 yrs'
         ELSE '4. 5+ yrs'
       END AS tenure,
       COUNT(*) AS headcount,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY tenure
ORDER BY tenure;

-- Job roles with above-average attrition (CTE + subquery)
WITH role_stats AS (
    SELECT JobRole,
           COUNT(*) AS headcount,
           SUM(Attrition = 'Yes') AS left_company,
           100 * SUM(Attrition = 'Yes') / COUNT(*) AS attrition_pct
    FROM employees
    GROUP BY JobRole
)
SELECT JobRole, headcount, left_company,
       ROUND(attrition_pct, 2) AS attrition_pct
FROM role_stats
WHERE attrition_pct > (
    SELECT 100 * SUM(Attrition = 'Yes') / COUNT(*) FROM employees
)
ORDER BY attrition_pct DESC;

-- Top 3 earners per department (window function)
SELECT Department, JobRole, MonthlyIncome, income_rank
FROM (
    SELECT Department, JobRole, MonthlyIncome,
           RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS income_rank
    FROM employees
) ranked
WHERE income_rank <= 3
ORDER BY Department, income_rank;

-- Job satisfaction vs attrition
SELECT JobSatisfaction,
       COUNT(*) AS headcount,
       SUM(Attrition = 'Yes') AS left_company,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;