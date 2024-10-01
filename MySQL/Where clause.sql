# WHERE Clause
# Where clause is used to filter rows in our table while SLECT is used to filter columns.alter

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM PARKS_AND_RECREATION.EMPLOYEE_DEMOGRAPHICS 
WHERE (FIRST_NAME IN ('Leslie', 'Tom', 'Jerry') AND AGE >=36)
OR GENDER != 'Male';

SELECT *
FROM PARKS_AND_RECREATION.EMPLOYEE_DEMOGRAPHICS 
WHERE (FIRST_NAME like 'L__%' OR
		First_name like '%_m' or
        first_name like 'J____') 
AND AGE >=36;

#OR GENDER != 'Male';




# Equal to 'comparison operator'

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

# Greater than 'comparisom operator'

SELECT *
FROM employee_salary
WHERE salary > 50000
;
# Greater or equal to 'CO'
SELECT *
FROM employee_salary
WHERE salary >= 50000
;
# Is not equal to
SELECT *
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT *
FROM employee_demographics
WHERE  birth_date >  '1985-01-01'
;

## Logical operators: Allows us to have diffrent logic 

SELECT *
FROM employee_demographics
WHERE  birth_date >  '1985-01-01'
And gender != 'Female'
;

SELECT *
FROM employee_demographics
WHERE  birth_date >  '1985-01-01'
OR NOT gender = 'male'
;
# Looking up specific rows 
SELECT *
FROM employee_demographics
WHERE  (first_name = 'leslie' and age = '44')
;

SELECT *
FROM employee_demographics
WHERE  (first_name = 'leslie' and age = '44') or age >50
;
# LIKE statement: looks for pattern, not specific..
-- [% and _]
SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE 'JER%' # Saying anythings that starts with JER and %: anything else
;

SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE '%ER%' # Saying anythings comes before and after but has 'er' in their name
;

SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE 'a__' # Saying first name that starts with 'a' and only has 2 character after character a i.e 3 letter name that starts with 'a'
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%' # Saying first name that starts with 'a' and only has 2 character after character a i.e 3 letter name that starts with 'a'
;
