-- What are the top skills based on salary roles.
-- Average salary associated with each Business Analyst roles.


SELECT 
        skills,
        ROUND (AVG (salary_year_avg), 0) AS AVERAGE_SALARY
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY AVERAGE_SALARY DESC
LIMIT 10

Analysis of Top 10 Paying Skills for Business Analysts

From the provided data, we can observe several interesting trends regarding the top-paying skills for Business Analysts in 2023. Here are some insights:

Variety of Skills: The top-paying skills span across various domains, including DevOps (e.g., Chef), data manipulation (e.g., NumPy), programming languages (e.g., Ruby, Julia, C), big data technologies (e.g., Hadoop), and machine learning frameworks (e.g., PyTorch).

Emerging Technologies: Some of the high-paying skills like Julia, Airflow, and Phoenix are relatively newer and specialized, indicating a trend towards niche expertise.

Salary Range: The salaries range from $120,333 to $220,000, showing a significant variation based on the skill. Chef, as a DevOps tool, tops the list with an average salary of $220,000, suggesting a high demand for automation and infrastructure management skills.

Interdisciplinary Demand: Skills like NumPy and PyTorch highlight the demand for professionals who can handle both statistical analysis and machine learning, reflecting the interdisciplinary nature of modern data science roles.


[
  {
    "skills": "chef",
    "average_salary": "220000"
  },
  {
    "skills": "numpy",
    "average_salary": "157500"
  },
  {
    "skills": "ruby",
    "average_salary": "150000"
  },
  {
    "skills": "hadoop",
    "average_salary": "139201"
  },
  {
    "skills": "julia",
    "average_salary": "136100"
  },
  {
    "skills": "airflow",
    "average_salary": "135410"
  },
  {
    "skills": "phoenix",
    "average_salary": "135248"
  },
  {
    "skills": "electron",
    "average_salary": "131000"
  },
  {
    "skills": "c",
    "average_salary": "123329"
  },
  {
    "skills": "pytorch",
    "average_salary": "120333"
  }
]