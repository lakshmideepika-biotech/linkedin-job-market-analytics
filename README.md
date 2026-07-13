# LinkedIn Job Market Analytics

Analysis of 6,200 data-role job postings (Data Analyst, Data Scientist, BI Analyst, Data Engineer, and related roles) across Indian companies, exploring hiring trends, in-demand skills, salary progression, and location patterns.

## Tools Used
- **SQL Server (SSMS)** — data cleaning, deduplication, and 12 analytical queries
- **Python (Pandas, Matplotlib)** — data visualization, hosted on Kaggle Notebooks
- **Power BI Desktop** — interactive dashboard with KPI cards and charts

## Dataset
- 6,293 raw job postings → cleaned to 6,200 unique records
- Columns: job title, company, industry, location, experience level, salary range (LPA), required skills, posting date, applicant count, job type, employment type
- Realistic messiness included: ~6% missing salary data, ~8% missing company size, inconsistent casing/whitespace in company names — cleaned using SQL and Power Query

## Key Insights

1. **Top hiring companies:** Tata Consultancy (156 postings), HDFC Bank (153), and Capgemini (147) lead the market.

2. **Most in-demand skills:** SQL, Excel, Power BI, Python, and Statistics are the top 5 skills requested across postings.

3. **Salary growth by experience:**

   | Level | Salary Range (LPA) | Share of Postings |
   |---|---|---|
   | Entry | ₹4.5 – 8 | 37.9% |
   | Mid | ₹10.5 – 14.1 | 31.0% |
   | Senior | ₹20.6 – 24.1 | 23.4% |
   | Lead | ₹34 – 37.5 | 7.7% |

   Salary roughly doubles at each career stage.

4. **Location:** Hyderabad (811 postings) and Bengaluru (757) lead hiring volume; Chennai has solid local demand (383 postings).

5. **Hiring is steady year-round** — no major seasonal spikes or dips, ranging 300–380 postings/month.

6. **Work mode:** Onsite roles still dominate (44.3%), followed by Hybrid (36.9%) and Remote (18.9%).

7. **Entry-level roles are the largest single segment** (37.9% of all postings).

## Project Files
- `linkedin_job_postings.csv` — cleaned dataset
- `analysis_queries.sql` — 12 SQL analysis queries
- `LinkedIn_Job_Market_Dashboard.pbix` — Power BI dashboard
- Python notebook: [https://www.kaggle.com/code/lakshmideepikapeyala/linkedinjobpostings]
