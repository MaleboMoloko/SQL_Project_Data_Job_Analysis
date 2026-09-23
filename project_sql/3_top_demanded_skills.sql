/* 
 Question: What are the most in-demand skills for data scientist?
 -Join job postings to inner join table similar to query 2
 - Identify the top 5 in-demand skills for data analyst
 -focus on all job postins
 Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights intio the most valuable skills for job seekers.
 
 */
SELECT skills_dim.skills AS skill_name,
    count(skills_dim.skill_id) AS skills_top_demand
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND job_work_from_home = TRUE
GROUP BY skill_name
ORDER BY skills_top_demand DESC
LIMIT 5 -- Without remote, we get sas as 4th skill
    -- with remote we get sas aws 4th skill