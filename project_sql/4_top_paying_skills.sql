/*
 Question: What are top skills based on salary?
 - Look at the average salary associated with each skills for data scientist position
 - focuses on roles with specified salaries, regardless of location
 Why? It reveals how the different skills impact salary levels for data scientist and helps identify the most financially rewarding skills to acquire or improve
 */
SELECT skills_dim.skills AS skill_name,
    round(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skill_name
ORDER BY avg_salary DESC
LIMIT 25
    /*
     The highest-paying Data Scientist vacancies in this dataset appear to be associated with specialised technical skills, production-oriented data infrastructure, advanced programming languages, and niche applications such as computer vision and automated machine learning.
     The top-paying skills aren't necessarily the most common skills.
     *\