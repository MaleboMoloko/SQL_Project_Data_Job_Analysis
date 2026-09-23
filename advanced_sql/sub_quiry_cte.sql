WITH january_jobs_cte AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
)
SELECT company_id,
    name AS name
FROM company_dim
WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = true
    )
SELECT *
FROM company_dim WITH company_job_count_cte AS (
        SELECT company_id,
            COUNT(*) AS total_jobs
        FROM job_postings_fact
        GROUP BY company_id
    )
SELECT company_dim.name AS company_name,
    company_job_count_cte.total_jobs
FROM company_dim
    LEFT JOIN company_job_count_cte ON company_job_count_cte.company_id = company_dim.company_id
ORDER BY company_job_count_cte.total_jobs DESC;