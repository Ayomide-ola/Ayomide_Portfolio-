## Unions: In comparison to Joins, union allows me to combine rows of data togethe not columns

SELECT first_name,last_name
FROM employee_demographics
union 
Select first_name,last_name
from employee_salary;


SELECT first_name,last_name
FROM employee_demographics
union ALL
Select first_name,last_name
from employee_salary;


SELECT first_name,last_name,  'OLD Man' AS Label
FROM employee_demographics
WHERE age > 40 AND GENDER= 'MALE'
UNION
SELECT first_name,last_name,  'OLD LADY'
FROM employee_demographics
WHERE age > 40 AND GENDER= 'FEMALE'
UNION
SELECT first_name,last_name,  'Highly paid employee'
FROM employee_salary
WHERE SALARY > 70000
ORDER BY first_name, last_name
;