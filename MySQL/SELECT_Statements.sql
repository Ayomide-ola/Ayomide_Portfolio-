SELECT * 
FROM parks_and_recreation.employee_demographics where employee_id IN (3, 4, 10,12);

# ANOTHER DATABASE 'sakila' IN the same note
SELECT *
FROM SAKILA.ACTOR;

SELECT first_name,
last_name,
actor_id
from sakila.actor;


SELECT first_name,last_name,birth_date,
age,
age+10
FROM parks_and_recreation.employee_demographics;
# Arritmetic Order in SQL: PEMDAS [Parentesis,Exponent, Multiplication, Division, Addition, Subtraction]: This is the order SQL will run multi arritmetic calculations. 

# Select specific column
SELECT first_name
FROM parks_and_recreation.employee_demographics;

# SELECT DISTINCT statement : This will produce distinct data only.

SELECT DISTINCT GENDER
FROM parks_and_recreation.employee_demographics;

SELECT * FROM EMPLOYEE_SALARY;

SELECT DISTINCT DEPT_ID,OCCUPATION
FROM PARKS_AND_RECREATION.EMPLOYEE_SALARY;