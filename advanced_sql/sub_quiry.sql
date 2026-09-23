SELECT *
FROM (
                --subquery starts here
                SELECT *
                FROM job_postings_fact
                WHERE EXTRACT(
                                MONTH
                                FROM job_posted_date
                        ) = 1 -- subquery ends here
        ) AS january_job_subq