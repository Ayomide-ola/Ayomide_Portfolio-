-- Joins
# Joins allows me to join two tables or more if they have a common column

# Perks_and_recreation data base
# Table 1: Employee_demographics
# Table 2: Employee_salary

SELECT *
FROM parks_and_recreation.EMPLOYEE_SALARY;

SELECT *
FROM parks_and_recreation.employee_demographics;

# Inner Join: will return rows that are the same in both columns 
SELECT *
FROM EMPLOYEE_demographics 
INNER JOIN employee_salary
	ON EMPLOYEE_demographics.employee_id = EMPLOYEE_salary.employee_id # This is too long, we can solve that by 'Aliasing'
    ;
    
#Adding Aliasing
SELECT *
FROM EMPLOYEE_demographics AS ED
INNER JOIN employee_salary AS ES
	ON ED.employee_id = ES.employee_id # Now we call the aliase not the whole characters..
    ;
# Selecting the actual columns
SELECT ED.employee_id, age, occupation
FROM EMPLOYEE_demographics AS ED
INNER JOIN employee_salary AS ES
	ON ED.employee_id = ES.employee_id # Now we call the aliase not the whole characters..
    ;
    
# Outer Joins (LEFT/RIGHT)
# a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join
SELECT *
FROM EMPLOYEE_demographics AS ED # Left table 
LEFT JOIN employee_salary AS ES # Right Table 
	ON ED.employee_id = ES.employee_id # Now we call the aliase not the whole characters..
    ;
    
SELECT *
FROM EMPLOYEE_demographics AS ED # Left table 
Right JOIN employee_salary AS ES # Right Table 
	ON ED.employee_id = ES.employee_id # Now we call the aliase not the whole characters..
    ;
    
# Self Join: Joins the table to itself Example, pering employees togeter for secrete santa
SELECT*
FROM EMPLOYEE_SALARY EMP1
JOIN EMPLOYEE_SALARY EMP2
	ON EMP1.EMPLOYEE_ID + 1 = EMP2.EMPLOYEE_ID;

# SELECTING the first and last names only and id number

SELECT EMP1.EMPLOYEE_ID AS san_emp,
EMP1.FIRST_NAME AS FNS,
EMP1.LAST_NAME AS LNS,
EMP2.EMPLOYEE_ID AS name_emp,
EMP2.FIRST_NAME AS FNS,
EMP2.LAST_NAME AS LNS
FROM EMPLOYEE_SALARY EMP1
JOIN EMPLOYEE_SALARY EMP2
	ON EMP1.EMPLOYEE_ID + 1 = EMP2.EMPLOYEE_ID;
    
# Joing multiple tables together

SELECT *
FROM EMPLOYEE_demographics AS ED
INNER JOIN employee_salary AS ES
	ON ED.employee_id = ES.employee_id # Now we call the aliase not the whole characters..
INNER JOIN parks_departments AS pd
	on ES.dept_id = pd.department_id
;

    
