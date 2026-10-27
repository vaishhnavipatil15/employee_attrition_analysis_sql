# Employee Attrition Analysis (SQL)

Analysis of employee attrition for 1,470 employees to find which groups are most likely to leave.

## Dataset
IBM HR Analytics Employee Attrition & Performance (Kaggle):
https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

## Tools
MySQL, MySQL Workbench, Excel

## SQL concepts used
GROUP BY, CASE, subqueries, CTEs, window functions (RANK)

## Key findings
- Overall attrition: 16.12% (237 of 1,470 employees)
- Sales has the highest department attrition at 20.63%
- Employees working overtime left at 30.53% vs 10.44% without overtime
- Employees earning under 3k left at 28.61% vs 8.90% for those earning 10k+
- First-year employees left at 34.88% vs 10.81% for those with 5+ years
- Sales Representatives had the highest role attrition at 39.76%

## Files
- hr_analysis.sql: all queries with comments
