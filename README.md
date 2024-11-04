
# INTRODUCTION
Looking into the data job posted in 2023 on LinkedIn where the location is "Anywhere" and sepecifically "Business Analyst" role. 

Data source: datanerd.tech

This project explore the following questions.

1. What are the top-paying business analysis jobs?
2. What skills are required for this top-paying jobs?
3. What skills are most in demand skills for businsss analyst?
4. What skills are associated to higher salary?
5. What are the most optimal skills to learn?


# BACKGROUND
Driven by the quest to know business analyst job market more effectively, this project is tailored to pinpoint top-paid jobs and in-demand skills streamlining others work to find optimal jobs as a business analyst. 


In other to achieve this result, four tables were created. job_postings_fact table, company_dim table, skill_dim table, and skills_job_dim table.

The job_postings_fact table contain the folllowing columns; job_id, company_id, job_title_short, job_title, job_location, job_via, job_schedule_type, job_work_from_home, search_location, job_posted_date,  job_no_degree_mention, job_health_insurance, job_country, salary_rate, salary_year_avg, and salary_hour_avg.

The skill_dim table (skill dimension) contain the following colums; skill_id, skills, and type.

The skills_job_dim table (skills job dimension) contains two columns; job_id and skill_id.

The company_dim table (company dimension) contains the following columns; company_id, name, link, link_google, and thumbnail.


# THE TOOLS I USED
For deep diving into the business analyst job market, I harnessed several tools such as;
- SQL: The backbone of my analysis unabling me to query the database to gain critical insights.
- PostgresSQL: The choosen database management system, ideal for handling the job posting data.
- Visual Studio Code: The go to for database management and excuting SQL queries. 
- Git GitHub: Esential for version control and sharing SQL script and analysis ensuring, collaboration, and project tracking.

# THE ANALYSIS
Each query in this analysis is aimed at investigating specifically business analyst job market.
Here is how I approached each quesions. 

## 1. Top paying Business Analyst Jobs.
Explanation: To identify the highest paying roles, I filttered business analyst position by average yearly salary, and the location, focused on jobs located "Anywhere". This query highlight the highest paying opportunities in the field.

``` sql
    SELECT  

        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Business Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
``` 
### Insight From Analysis:

**Job Titles and Specializations:**

Leadership and Management Roles: Several high-paying positions have titles indicating leadership roles, such as "Lead Business Intelligence Engineer," "Manager II, Applied Science - Marketplace Dynamics," and "Manager Analytics and Reporting." This suggests that management and leadership skills are highly valued.

**Niche Specializations:**

Jobs like "Senior Economy Designer" and "Staff Revenue Operations Analyst" indicate a demand for specialized skills within the business analysis domain.

**Remote Flexibility:**

All the listed jobs have "Anywhere" as their location, indicating that remote work is a significant trend.

**High Compensation:** 

Salaries range from $134,550 to $220,000, reflecting the high value placed on skilled business analysts. The top-paying job, "Lead Business Intelligence Engineer" at Noom, has an average salary of $220,000. 

![Top Paying Business Analyst Roles](first_sql_project\assets\salary_by_job_title_v2.png) 

**Bar graph visualizing top 10 business analyst role with average yearly salary range.**


## 2. Top Paying Job Skills. 
Explanation: I joined job_postings_fact with company_dim to get the company names associated with each job.
I filttered the results for job titles 'Business Analyst' and I ordered the results by average yearly salary in descending order.
The output was limited to the top 10 jobs.

``` sql 
WITH top_Paying_job AS (

    SELECT 
            job_id,
            job_title,
            salary_year_avg,
            name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Business Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
)

SELECT top_Paying_job.*,
        skills
FROM top_Paying_job
INNER JOIN skills_job_dim ON top_Paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 10

```
### Insight from Analysis for Top Paying Business Analyst Skills.

**Common Skills:**

Python: The skill python appears frequently across different job roles and companies. It is a versatile programming language used in data analysis, machine learning, and automation.

SQL: This skill is essential for database management and querying, highlighting the importance of data manipulation and retrieval in business analysis.

Excel: Despite being a traditional tool, excel remains highly relevant for data analysis and reporting tasks.


Visualization (Tableau and BI Tools):These tools are popular for business intelligence and data visualization, indicating a trend towards the need for skills in creating insightful reports and dashboards.

![Top Paying Business Analyst Roles](first_sql_project\assets\skills_count.png) 

**This column bar visualization shows the top paying business analyst skills**

## 3. In-Demand Skills For Business Analyst.
Explanation: I joined job_postings_fact with skills_job_dim to get job postings associated with specific skills and joined skills_job_dim with skills_dim to get the skill names.
I filttered the results for job titles 'Business Analyst'. Also, I group by skills and count the number of times each skill is mentioned. Lastly, I order the results by the count of skills in descending order and limited the output to the top 10 skills.

``` sql
    SELECT 
        skills,
        COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10
``` 
### Insight from Analysis of In-Demand Skills for Business Analysts.

**Core Technical Skills:**

SQL and Excel: These skills are the most in-demand, with sql having 17,372 mentions and excel close behind at 17,134 mentions. This highlights the critical role of data manipulation, querying, and spreadsheet proficiency in business analysis.

Python: With 8,097 mentions, Python is also highly in-demand, indicating its importance for more advanced data analysis, automation, and machine learning tasks.

Tableau and Power BI: Tableau (9,324 mentions) and Power BI (9,251 mentions) are the leading tools for data visualization and business intelligence. 

PowerPoint and Word: These tools, with 4,591 and 3,675 mentions respectively, are essential for creating presentations and reports.

R and SAS: These tools, with 4,035 and 3,604 mentions respectively, are important for statistical analysis and data modeling.

![In-demand Business Analyst Skills](first_sql_project\assets\demand_count_by_skill.png)

**Bar graph visualizig the top 10 in-demand skills for business analyst jobs.**



## 4. Top Skills Based On Salary. 
Explanation: I joined the job_postings_fact, skills_job_dim, and skills_dim tables to link job postings with their associated skills.
I filttered the job postings to include only those with the job title 'Business Analyst'.
I group the results by skill and calculate the average salary for each skill. Lastly, the results was order by average salary in descending order and limited the output to the top 10 skills.

``` sql 
    SELECT 
        skills,
        ROUND (AVG (salary_year_avg), 0) AS Average_Salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY Average_Salary DESC
LIMIT 10
```
### Insight from Analysis of Top 10 Paying Skills for Business Analysts.

**Variety of Skills:** *The top-paying skills span across various domains*, including DevOps (e.g., Chef), data manipulation (e.g., NumPy), programming languages (e.g., Ruby, Julia, C), big data technologies (e.g., Hadoop), and machine learning frameworks (e.g., PyTorch).

**Emerging Technologies:** Some of the high-paying skills like Julia, Airflow, and Phoenix are relatively newer and specialized, indicating a trend towards niche expertise.

**Salary Range:** The salaries range from $120,333 to $220,000, showing a significant variation based on the skill. Chef, as a DevOps tool, tops the list with an average salary of $220,000, suggesting a high demand for automation and infrastructure management skills.

**Interdisciplinary Demand:** Skills like NumPy and PyTorch highlight the demand for professionals who can handle both statistical analysis and machine learning, reflecting the interdisciplinary nature of modern data science roles.

![In-demand Business Analyst Skills]()


## 5. The Most Optimal Skills To Learn
Explanation: This query was written using CTE (Common Table Expression) to draw a corollary between in-demand skills and top paying skills based on salary to give insight on the optimal skills to learn in business analysis based on demand and salary. 

``` sql
    WITH skills_demand AS (

SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
), AVERAGE_Salary AS (

    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND (AVG (salary_year_avg), 0) AS Average_Salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    number_of_skills,
    Average_Salary

FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE number_of_skills > 10
ORDER BY Average_Salary DESC,
        demand_count DESC
LIMIT 10
```
### Insight and Analysis of Optimal Skills to Learn for Business Analysts based on Salary.



**High Demand Skills:**
Skills like Python, with 143 occurrences, indicate a very high demand. The significant number of job postings mentioning Python suggests that it is a foundational skill for Business Analysts.

**Big Data Technologies:** Skills such as Hadoop and Snowflake are notable. Hadoop, despite being mentioned less frequently, commands a high average salary, reflecting its value in handling large-scale data processing.

**Cloud Computing:** Skills like AWS and Azure are in demand, highlighting the importance of cloud computing in modern business analysis. Both AWS and Azure have substantial job postings and offer competitive salaries.

**Specialized Tools:** Tools like Phoenix and Looker, while not as commonly mentioned, offer high salaries. This indicates that specialized expertise in certain tools can be highly lucrative.

**Statistical and Programming Skills:** Skills in programming languages like R and Go, and statistical tools, emphasize the need for strong analytical capabilities. These skills are essential for data manipulation and analysis in business contexts.

**Interdisciplinary Knowledge:** The mix of skills across different domains (e.g., data processing, cloud computing, programming) suggests that Business Analysts benefit from a broad and interdisciplinary skill set.


| skill_id |   skills   | demand_count | average_salary |
|----------|------------|------------------|----------------|
|    97    |   hadoop   |        14        |     139201     |
|   137    |  phoenix   |        16        |     135248     |
|    2     |   nosql    |        11        |     119330     |
|    80    | snowflake  |        34        |     112543     |
|   185    |   looker   |        25        |     110581     |
|    76    |    aws     |        25        |     105996     |
|    5     |     r      |        73        |     105969     |
|    8     |     go     |        33        |     105701     |
|    1     |   python   |       143        |     104277     |
|    74    |   azure    |        22        |     103836     |


### Analysis of Optimal Skills to Learn for Business Analysts based on demand.

**High Demand Skills:** SQL and Excel are the most frequently mentioned skills, with 312 and 226 occurrences respectively. This indicates their fundamental importance in business analysis for data management and analysis.

**Visualization Tools:** Tableau and Power BI are highly mentioned, highlighting the demand for data visualization skills. These tools help in presenting data insights effectively, making them crucial for business analysts.

**Programming and Statistical Analysis:** Python and R are key programming languages with substantial mentions. Python, with 143 occurrences, and R, with 73, indicate the importance of programming for data manipulation and statistical analysis.

**General Office Tools:** Tools like PowerPoint and Word, though not as highly paid, are frequently mentioned, suggesting that presentation and documentation skills are also valued in business analysis.

**Specialized Tools:** Tools like SAS and Flow are mentioned less frequently but still offer competitive salaries. This indicates that specialized knowledge can be valuable and potentially rewarding.



| skill_id |  skills   | demand_count | average_salary |
|----------|-----------|------------------|----------------|
|    0     |    sql    |        312       |     95292      |
|   181    |   excel   |        226       |     87212      |
|   182    |  tableau  |        212       |     98794      |
|    1     |  python   |        143       |    104277      |
|   183    | power bi  |        139       |     92059      |
|   196    | powerpoint|         74       |     88182      |
|    5     |     r     |         73       |    105969      |
|   215    |   flow    |         51       |     92445      |
|   188    |   word    |         51       |     87075      |
|    7     |    sas    |         37       |    100308      |




# WHAT I LEARNED
Embarking on this journey in the first instance is one of the best decision I have made in improving my skills as a data analyst. 

I have been able to adequately improve my query skills which is the top leading skill as a data analyst.

Also, this analysis has also taught me the importance of having multiple skills and being versatile which can make one extremely valuable in the job market and irresitable for clients. 

More importantly, this project taught me patience, resilience, and perseverance.

# CONCLUSION 
## Insights From Project.


**Core Analytical Tools:** SQL, Excel, and Python are essential for data handling and analysis, making them critical skills for business analysts.

**Visualization Skills:** Proficiency in Tableau and Power BI is highly sought after, reflecting the importance of data visualization in business analysis.

**Programming Knowledge:** Python and R are crucial for advanced data analysis and statistical modeling, indicating a trend towards more technical and analytical roles.

**Office Suite Proficiency:** Familiarity with general office tools like PowerPoint and Word remains important for creating reports and presentations.
