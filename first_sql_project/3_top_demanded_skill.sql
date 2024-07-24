-- What are the most in demand skills.

SELECT 
        skills,
        COUNT (skills_job_dim.job_id) AS number_of_skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Business Analyst'
GROUP BY skills
ORDER BY number_of_skills DESC
LIMIT 10