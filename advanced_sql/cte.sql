SELECT *
FROM job_postings_fact
LIMIT 10 WITH skills_cte AS (
        SELECT skills_dim.skill_id,
            skills as skill_name,
            job_postings_fact.job_location
        FROM skills_dim
            INNER JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
            INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
        WHERE job_postings_fact.job_location = 'Anywhere'
            and -- LIMIT 10
    )
SELECT skill_id,
    skill_name,
    count(*)
FROM skills_cte
GROUP BY skill_id,
    skill_name
ORDER BY count(*) DESC
LIMIT 5;