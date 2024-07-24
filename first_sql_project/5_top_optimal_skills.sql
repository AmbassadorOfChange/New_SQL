-- What the most optimal skills to learn.
-- Identiying high demand and high salary.

WITH skills_demand AS (

SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS number_of_skills
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
        ROUND (AVG (salary_year_avg), 0) AS AVERAGE_SALARY
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
    AVERAGE_SALARY

FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE number_of_skills > 10
ORDER BY AVERAGE_SALARY DESC,
        number_of_skills DESC
LIMIT 10