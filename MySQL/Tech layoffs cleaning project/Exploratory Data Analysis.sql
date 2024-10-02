-- Exploratory Data Analysis 

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off)
FROM layoffs_staging2; # 12,000

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2; # 100%

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY fund_raised_millions DESC;
 
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;


SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;



SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH ROLLING_TOTAL AS 
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS TOTAL_OFF
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(TOTAL_OFF) OVER(ORDER BY `MONTH`) AS rolling_total
from Rolling_Total;



SELECT company, YEAR(`date`), SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

SELECT company, YEAR(`date`), SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;


WITH COMPANY_YEAR (company, years,total_liad_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT*, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_liad_off DESC) AS RANKING
FROM COMPANY_YEAR
WHERE years IS NOT NULL
ORDER BY RANKING ASC;

WITH COMPANY_YEAR (company, years,total_liad_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS

(SELECT*, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_liad_off DESC) AS RANKING
FROM COMPANY_YEAR
WHERE years IS NOT NULL
)
SELECT *
FROM COMPANY_YEAR_RANK
WHERE RANKING <= 5
;



