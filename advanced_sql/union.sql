SELECT job_title_short,
    company_id,
    job_posted_date
FROM job_postings_fact
WHERE (
        EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
        OR EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 2
        OR EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 3
    )
    AND EXTRACT(
        YEAR
        FROM job_posted_date
    ) = 2023;
WITH average_quarterly_jobs AS (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
SELECT job_title_short,
    company_id,
    job_posted_date,
    salary_year_avg
FROM average_quarterly_jobs
WHERE salary_year_avg > 70000;