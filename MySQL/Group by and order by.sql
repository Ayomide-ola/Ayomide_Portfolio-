-- Group By
-- When you use the GROUP BY clause in a MySQL query, it groups together rows that have the same values in the specified column or columns.
-- GROUP BY is going to allow us to group rows that have the same data and run aggregate functions on them


SELECT *
FROM EMPLOYEE_DEMOGRAPHICS;


SELECT GENDER
FROM EMPLOYEE_DEMOGRAPHICS
GROUP BY GENDER;

SELECT GENDER, AVG(AGE)
FROM EMPLOYEE_DEMOGRAPHICS
GROUP BY GENDER; # This will perform a group by on the gender column, and group together all the unique genders in 'gender' i.e (male and female)
# Additionally, it performes the average age of the all the rows that was grouped togethwer. TGhis means based on result the average age of the females is 41.000 and male is 41.2857

SELECT occupation, salary
FROM EMPLOYEE_salary
GROUP BY occupation, salary; # This groups together each unique occupation and salary in the employee salary table.

SELECT occupation, AVG(salary)
FROM EMPLOYEE_salary
GROUP BY occupation; # This groups together each unique occupation, as well as give the average salaries of each of those occupations


SELECT GENDER, AVG(AGE), MAX(AGE), MIN(AGE), COUNT(AGE), MODE(AGE)
FROM EMPLOYEE_DEMOGRAPHICS
GROUP BY GENDER;


--- # ORDER BY: Arrge in accending /decending order

SELECT *
FROM EMPLOYEE_DEMOGRAPHICS
Order BY gender, age DESC;

SELECT *
FROM EMPLOYEE_DEMOGRAPHICS
Order BY 5,4;# Using index positionig of the columns