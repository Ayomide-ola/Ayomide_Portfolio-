## STRING FIUNCTIONS
# Built in functions in mysql that will help us waork with strings

#Lenght
SELECT LENGTH('SKYFALL');

SELECT FIRST_NAME, length(FIRST_NAME)
FROM employee_demographics
ORDER BY 2;

# UPPER 
SELECT UPPER('SKY') AS UP;
SELECT LOWER('SHY');

SELECT FIRST_NAME, UPPER(FIRST_NAME)
FROM employee_demographics
ORDER BY 2;

# TRIM :Takes the white space befor and behind and get rid of it

select TRIM('                SKY      ') AS TRIMMED,
LTRIM('         DAD        ') AS LT,
RTRIM('            MUM        ') AS RT
;

# LEFT AND RIGHT
SELECT FIRST_NAME, 
LEFT(FIRST_NAME,4),# 4 is specifying how many character from the left hand side we want to selcet
right(FIRST_NAME,4) 
from employee_demographics; 


# Substrings
SELECT FIRST_NAME, 
LEFT(FIRST_NAME,4),# 4 is specifying how many character from the left hand side we want to selcet
right(FIRST_NAME,4),
substring(first_name, 3,2) AS SUB,
birth_date,
substring(birth_date, 6,2) AS mob # Say we want to use substring to find the month someone was born alone from the DOB column
from employee_demographics; 

# REPLACE
SELECT FIRST_NAME, REPLACE(FIRST_NAME, 'A', 'Z') # Re-places specific string with another 
from employee_demographics;

# Locate
SELECT LOCATE('d','Ayomide') ;

# CONCAT
SELECT first_name,LAST_NAME,
CONCAT(FIRST_NAME,' ',LAST_NAME) AS FUll_NAME
FROM employee_demographics;

