-- Data Cleaning Using MYSQL

SELECT *
FROM layoffs;

# OBJECTIVES 
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary : Only do it when you are sure its truly irrelevant, but dont remove usually

-- creating a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens to preserve the raw data
CREATE TABLE tech_layoffs.layoffs_staging # This creates a new table withing tech_layoffs db 
LIKE tech_layoffs.layoffs; # copies the data in the layoffs table into the new layoffs_staging table. 

INSERT layoffs_staging
SELECT * 
FROM tech_layoffs.layoffs;

-- Removing duplictes from the data 

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off,`date`) AS row_num
FROM layoffs_staging;

# Creating CTES
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)

SELECT *
FROM DUPLICATE_CTE
WHERE ROW_NUM>1;

SELECT *
FROM LAYOFFS_STAGING
WHERE company =  'CASPER';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM LAYOFFS_STAGING2;

INSERT INTO layoffs_staging2

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM layoffs_staging2
WHERE row_num >1;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM layoffs_staging2;

# Now all duplicates are removed

-- Standardizing data: Finding issues in my data and fixing it
SELECT *
FROM layoffs_staging2;

SELECT DISTINCT company, TRIM(Company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SET SQL_SAFE_UPDATES = 0;

UPDATE layoffs_staging2
SET company = TRIM(company);


SELECT *
FROM layoffs_staging2
WHERe INDUSTRY LIKE 'Crypto%';

UPDATE LAYOFFS_STAGING2
SET INDUSTRY = 'Crypto'
WHERE INDUSTRY LIKE 'Crypto%';

SELECT DISTINCT INDUSTRY
FROM layoffs_staging2;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT COUNTRY
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERe COUNTRY LIKE 'United States%'
ORDER BY 1;

SELECT DISTINCT COUNTRY, TRIM(TRAILING '.' FROM COUNTRY)
FROM layoffs_staging2
ORDER BY 1;

UPDATE LAYOFFS_STAGING2
SET COUNTRY = TRIM(TRAILING '.' FROM COUNTRY)
WHERE COUNTRY LIKE 'United States%';


SELECT  `date`,
str_to_date(`date`, '%m/%d/%Y') AS Updated_date
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT  `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- Dealing with null vales 

SELECT*
FROM LAYOFFS_STAGING2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM LAYOFFS_STAGING2
WHERE INDUSTRY IS NULL
OR INDUSTRY = '';


SELECT *
FROM LAYOFFS_STAGING2
WHERE COMPANY = 'Airbnb';

SELECT *
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.COMPANY= T2.COMPANY
    #AND T1.LOCATION = T2.LOCATION
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY ='')
AND T2.INDUSTRY IS NOT NULL;

SELECT  T1.INDUSTRY, T2.INDUSTRY
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.COMPANY= T2.COMPANY
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY ='')
AND T2.INDUSTRY IS NOT NULL ;

UPDATE LAYOFFS_STAGING2 T1
JOIN LAYOFFS_STAGING2 T2
	ON T1.COMPANY = T2.COMPANY
SET T1.INDUSTRY = T2.INDUSTRY
WHERE T1.INDUSTRY IS NULL
AND T2.INDUSTRY IS NOT NULL;


UPDATE LAYOFFS_STAGING2
SET INDUSTRY = NULL
WHERE INDUSTRY = '';

SELECT *
FROM LAYOFFS_STAGING2
WHERE COMPANY = 'Bally%';

SELECT*
FROM LAYOFFS_STAGING2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE
FROM LAYOFFS_STAGING2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT*
FROM LAYOFFS_STAGING2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT*
FROM LAYOFFS_STAGING2;

ALTER TABLE layoffs_staging2
DROP COLUMN ROW_NUM;