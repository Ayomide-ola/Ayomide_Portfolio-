# Having  VS Where

SELECT OCCUPATION, AVG(SALARY)
FROM EMPLOYEE_SALARY
WHERE OCCUPATION LIKE '%MANAGER%'
GROUP BY OCCUPATION
HAVING AVG(SALARY)> 75000;


# LIMIT AND Aliasing

SELECT *
FROM employee_demographics
order by age desc
limit 3; # Filters out the 3 oldest employees in the organisation starting from the oldest.for

# Aliasing

SELECT Gender, avg(age) AS Sum_avg_age # Aliasing helps to name a function nd we can using it in the query subsequently without explicitly spelling ou the function again 
from employee_demographics
group by gender
having Sum_avg_age >40;
