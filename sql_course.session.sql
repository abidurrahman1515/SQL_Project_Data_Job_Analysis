-- -- -- -- January 2023 jobs
-- -- -- CREATE TABLE jan_2023_jobs AS
-- -- -- SELECT *
-- -- -- FROM job_postings_fact
-- -- -- WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
-- -- --   AND EXTRACT(MONTH FROM job_posted_date) = 1;

-- -- -- -- February 2023 jobs
-- -- -- CREATE TABLE feb_2023_jobs AS
-- -- -- SELECT *
-- -- -- FROM job_postings_fact
-- -- -- WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
-- -- --   AND EXTRACT(MONTH FROM job_posted_date) = 2;

-- -- -- -- March 2023 jobs
-- -- -- CREATE TABLE mar_2023_jobs AS
-- -- -- SELECT *
-- -- -- FROM job_postings_fact
-- -- -- WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
-- -- --   AND EXTRACT(MONTH FROM job_posted_date) = 3;

-- -- SELECT
-- --   COUNT(job_id) AS number_of_job,
-- --   CASE
-- --     WHEN job_location = 'Anywhere' THEN 'Remote'
-- --     WHEN job_location = 'New York, NY' THEN 'Local'
-- --     ELSE 'Onsite'
-- --   END AS job_category
-- -- FROM job_postings_fact
-- -- WHERE
-- --   job_title_short = 'Data Analyst'
-- -- GROUP BY
-- --   job_category
-- -- ORDER BY
-- --   number_of_job DESC;

-- -- SELECT  
-- --   COUNT(*) AS number_of_jobs,
-- --   AVG(salary_year_avg) AS total_avg_salary,
-- --   CASE 
-- --     WHEN salary_year_avg > 150000 THEN 'High'
-- --     WHEN salary_year_avg > 60000 THEN 'Standard'
-- --     ELSE 'Low'
-- --   END AS salary_category
-- -- FROM job_postings_fact
-- -- WHERE
-- --   job_title_short = 'Data Analyst'
-- -- GROUP BY
-- --   salary_category
-- -- ORDER BY
-- --   total_avg_salary DESC;

-- -- SELECT *
-- -- FROM (
-- --   SELECT *
-- --   FROM job_postings_fact
-- --   WHERE 
-- --     EXTRACT(MONTH FROM job_posted_date) = 1
-- -- ) AS january_jobs

-- -- WITH january_jobs AS (
-- --   SELECT *
-- --   FROM job_postings_fact
-- --   WHERE
-- --     EXTRACT(MONTH FROM job_posted_date) = 1
-- -- )
-- -- SELECT *
-- -- FROM january_jobs

-- -- SELECT
-- --   company_id,
-- --   name AS company_name
-- -- FROM company_dim
-- -- WHERE
-- --   company_id IN (
-- --     SELECT 
-- --       company_id
-- --     FROM job_postings_fact
-- --     WHERE job_no_degree_mention = TRUE
-- --     ORDER BY company_id
-- --   )

-- -- WITH company_job_count AS(
-- -- SELECT
-- --   company_id,
-- --   count(*) AS job_count
-- -- FROM job_postings_fact
-- -- GROUP BY 
-- --   company_id
-- -- )

-- -- SELECT 
-- --   company_dim.name,
-- --   company_job_count.job_count
-- -- FROM company_dim
-- -- LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
-- -- ORDER BY job_count DESC;

-- -- practice problem 1
-- -- WITH skill_count AS(
-- -- SELECT 
-- --   skill_id,
-- --   count(*) total_skill
-- -- FROM skills_job_dim
-- -- GROUP BY skill_id

-- -- )
-- -- SELECT
-- --   skills,
-- --   skill_count.total_skill
-- -- FROM skills_dim
-- -- LEFT JOIN skill_count ON skill_count.skill_id = skills_dim.skill_id
-- -- ORDER BY total_skill DESC
-- -- LIMIT 5;

-- -- -- practice problem 2
-- -- WITH company_job_count AS (
-- --   SELECT
-- --     company_id,
-- --     COUNT(job_id) AS total_job
-- --   FROM job_postings_fact
-- --   GROUP BY company_id
-- -- )
-- -- SELECT 
-- --   name AS company_name,
-- --   CASE
-- --     WHEN company_job_count.total_job > 50 THEN 'Large'
-- --     WHEN company_job_count.total_job BETWEEN 10 AND 50 THEN 'Medium'
-- --     ELSE 'Small'
-- --   END AS company_size
-- -- FROM company_dim
-- -- LEFT JOIN company_job_count 
-- -- ON company_job_count.company_id = company_dim.company_id;

-- -- Count how many times each skill appears across job postings
-- -- SELECT 
-- --   s.skill_id,              -- Skill ID from the skills table
-- --   s.skills,                -- Skill name
-- --   COUNT(sj.skill_id) AS skill_count  -- Number of times the skill appears
-- -- FROM skills_dim s
-- -- JOIN skills_job_dim sj ON s.skill_id = sj.skill_id  -- Join to link skills to job postings
-- -- Join job_postings_fact j ON j.job_id = sj.job_id
-- -- WHERE
-- --   job_work_from_home = TRUE
-- -- GROUP BY s.skill_id, s.skills                      -- Group by both skill ID and name
-- -- ORDER BY skill_count DESC
-- -- LIMIT 5;    
-- --                      -- Optional: Order by popularity

-- WITH Remote_job_skills AS(
-- SELECT
--   skill_id,
--   count(*) skills_count
-- FROM skills_job_dim
-- INNER JOIN job_postings_fact
-- ON job_postings_fact.job_id = skills_job_dim.job_id
-- WHERE
--   job_work_from_home = TRUE AND
--   job_postings_fact.job_title_short = 'Data Analyst'
-- GROUP BY
--   skill_id
-- )

-- SELECT  
--   Remote_job_skills.skill_id,
--   skills skills_name,
--   skills_count
-- FROM skills_dim
-- INNER JOIN Remote_job_skills
-- ON Remote_job_skills.skill_id = skills_dim.skill_id
-- ORDER BY
--   skills_count DESC
-- LIMIT 5;