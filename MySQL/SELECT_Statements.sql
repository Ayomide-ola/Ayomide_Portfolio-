SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name,last_name,birth_date,
age,
age+10
FROM parks_and_recreation.employee_demographics;
# Arritmetic Order in SQL: PEMDAS [Parentesis,Equal, Multiplication, Division, Addition, Subtraction]: This is the order SQL will run multi arritmetic calculations. 

# Select specific column
SELECT first_name
FROM parks_and_recreation.employee_demographics;

# SELECT DISTINCT statement : This will produce distinct data only.

SELECT DISTINCT GENDER
FROM parks_and_recreation.employee_demographics;