/*
 Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
 -Identify skills in high demand and associated with high average salaries for data scientist roles
 -concentrate on remote positions with specified salaries
 - Why? Target skills offer job security (high demand) and financial benefits (high salaries), offereing strategetic insights for career development in data analytics.
 */
WITH skills_demand AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        count(skills_dim.skill_id) AS skills_demand_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        round(AVG(salary_year_avg), 0) as avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
)
SELECT skills_demand.skill_id,
    skills_demand.skill_name,
    skills_demand_count,
    avg_salary
FROM skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE skills_demand_count > 10
ORDER BY skills_demand_count DESC,
    avg_salary DESC
LIMIT 25