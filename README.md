# Ayomide_Data_Analytics_and_Machine_Learning_Projects-
Welcome to my portfolio! This repository contains a collection of my data analytics, statistical analysis, and machine learning projects. Below, you'll find an overview of the projects included in this portfolio.

# Projects Overview

***Project 1: Haulage company:***

***Description:*** Haulage is a truck company. The data used in this project were collected from the everyday usage of heavy Scania trucks by the Haulage company. The context in which the data has been collected is specifically on the Air-Pressure system (APS) and stored in a comma-separated value format (CSV) file. APS generates pressurized air that is used by different functions in the company's trucks. Examples include braking and gear change functions, etc.

The Data has two broad aspects to it: the first is failures recorded on different component sensors that have been selected by experts. The second aspect is a class variable, which has both positive and negative classes. Positive classes are given to component failures that have to do with the failure of a component in the APS. The negative class represents failures of components that are not as a result of a failure of an APS component. ***There are 60,000 observations and 171 features in the data collected for this project.***

***Objectives:*** The objectives of this project are:

1. Analysis of failures and understanding information related to APS failures relative to those not related to APS.
2. Extract statistical insights from highly dimensional data.
3. Perform Principal Component Analysis on the data.
4. Identify and advise stakeholders on where investment is needed for the next business season.
5. Detailed markdown report to educate internal technicians and auditors on the justification for each step of the project methodology.

***Academic Objectives:***

1. Identify errors in the data and fix them before proceeding to data exploration.
2. Provide detailed statistical, EDA, and visual analysis of the project and justify the methodology and approach.
3. Implement Principal Component Analysis.
4. Prepare the data for machine learning.
5. Technologies Used: Jupyter Notebook, Python, Matplotlib, Seaborn, CSV, Pandas, Support Vector Machine learning algorithm, Github.

***Key Findings:***
***EDA***
I found that the dataset is highly dimensional, with 171 columns and 60,000 rows. Early data analysis revealed that the features were not in the right data type as defined by the data dictionary. 170 features were objects, and 1 feature was an integer. The class feature variable was expected to be in object format, leaving 169 features not in their right format. This revelation led to the implementation of operations to find unique data, hence informing decisions on how to handle them. I implemented several operations such as reading the CSV file in batches of 20 to get the unique values in each variable, but this method proved inefficient. I also tried creating a function that looped through the entire dataframe and returned a list of objects, but the function as well was inefficient as the storage for its output was too much. But I was finally able to use regular expression and replace methods to replace all floats in the data, leaving a new dataframe of all values that are not float. After which I explicitly asked Pandas to treat unique values as NAN, and all features returned to numerical data. The astype method was used to convert all component sensors to floats as defined by the data dictionary. Class EDA revealed that over 90% of sensor failures were not related to failures of the Air Pressure system, and less than 10% of sensor failures had to do with air pressure system failure. Distribution plots also revealed that data was highly skewed, and the difference between the min and max observations in some features was over 20000, thus affecting modeling until after normalization was implemented.

***Data cleaning:***
Two cleaning methods were implemented: drop and fill method. Component sensor ab_000 had a significantly high number of null values compared to recorded observations, so the column was dropped. Statistical summary showed the data was highly skewed, so I replaced the null values with median as this is not sensitive to outliers which were present in the data.

***Scaling:***
Min-Max scaling (normalization) technique was used to scale the features. This was because the data is very skewed, and various articles referenced suggest it is better to normalize when the distribution is skewed. Also, before deciding normalization was warranted, I tried to do modeling without normalization, and the SVM model had computational problems. It was taking over 20 minutes training without a successful attempt at training the independent variable. However, after normalization, SVM was able to train the data. Also, PCA explained line plot was more readable after normalization than before.

***PCA:***
Principal Component Analysis was warranted to reduce the dimensionality of the data. After PCA explained the variance, it was visible that with approximately 25 features, we can retain 99.5% of the variance in the data, which was then implemented accordingly.

***Support vector machien:***
A supervised model seems appropriate for this task as we are trying to classify positive and negative failures. However, the model behaved differently at different testing and training sizes. 5% test and 95% training performed the best of all. It recorded 98% accuracy and 84% precision.

**Conclusion:***
In conclusion, investors were advised to invest in fixing the two components that were suggested to be faulty due to the sensor not reporting data points hence producing significant Null-Values as discussed in the report. Implementation of different operations on this project was insightful and interesting as I was able to challenge myself to learn more through self-directed study.
