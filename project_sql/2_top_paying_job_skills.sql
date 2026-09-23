/*Question: what skills are required for the top paying data scientist jobs?
- What are the top 10 highest-paying data scientist jobs from the first query?
- Add specific skills required for these roles
-Why? It provides a detailed look at which higg-paying jobs demand certain skills, helping job seekers to understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs_cte AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Scientist' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL 
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs_cte.*, skills
FROM top_paying_jobs_cte
INNER JOIN skills_job_dim ON top_paying_jobs_cte.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC

/*
Python is the most common skill, appearing in 5 of 7 jobs.
SQL appears in 4 of 7 jobs.
AWS appears in 3 of 7 jobs.
Java and GCP appear in 2 jobs each.
Most of the remaining skills occur only once.

"job_id","job_title","salary_year_avg","company_name","skills"
40145,"Staff Data Scientist/Quant Researcher","550000.0","Selby Jennings","sql"
40145,"Staff Data Scientist/Quant Researcher","550000.0","Selby Jennings","python"
1714768,"Staff Data Scientist - Business Analytics","525000.0","Selby Jennings","sql"
1131472,"Data Scientist","375000.0","Algo Capital Group","sql"
1131472,"Data Scientist","375000.0","Algo Capital Group","python"
1131472,"Data Scientist","375000.0","Algo Capital Group","java"
1131472,"Data Scientist","375000.0","Algo Capital Group","cassandra"
1131472,"Data Scientist","375000.0","Algo Capital Group","spark"
1131472,"Data Scientist","375000.0","Algo Capital Group","hadoop"
1131472,"Data Scientist","375000.0","Algo Capital Group","tableau"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","azure"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","aws"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","tensorflow"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","keras"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","pytorch"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","scikit-learn"
126218,"Director Level - Product Management - Data Science","320000.0","Teramind","datarobot"
129924,"Director of Data Science","300000.0","Storm4","python"
129924,"Director of Data Science","300000.0","Storm4","pandas"
129924,"Director of Data Science","300000.0","Storm4","numpy"
457991,"Head of Battery Data Science","300000.0","Lawrence Harvey","python"
457991,"Head of Battery Data Science","300000.0","Lawrence Harvey","aws"
457991,"Head of Battery Data Science","300000.0","Lawrence Harvey","gcp"
38905,"Principal Data Scientist","300000.0","Storm5","sql"
38905,"Principal Data Scientist","300000.0","Storm5","python"
38905,"Principal Data Scientist","300000.0","Storm5","java"
38905,"Principal Data Scientist","300000.0","Storm5","c"
38905,"Principal Data Scientist","300000.0","Storm5","aws"
38905,"Principal Data Scientist","300000.0","Storm5","gcp" *\
*/