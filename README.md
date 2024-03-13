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

***Technologies Used:*** Jupyter Notebook, Python, Matplotlib, Seaborn, CSV, Pandas, Support Vector Machine learning algorithm, Github.

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
In conclusion, investors were advised to invest in fixing the two components that were suggested to be faulty due to the sensor not reporting data points hence producing significant null values as discussed in the report. Implementation of different operations on this project was insightful and interesting as I was able to challenge myself to learn more through self-directed study.

***GitHub Link***: https://github.com/Ayomide-ola/Bussiness_Analysis/blob/main/Haulage_Aps_failure.ipynb


***Project 2: Covid-19 survival optimization using Artificial intelegence***

***Description:***I believe it is safe to say that Covid-19 was a reset for the world. It was a test that came in form of a pandemic to test our readiness for a medical disaster of such magnitude. The medical practitioners took a significant hit as the entire world turned to them to help us make meaning of a virus that is ravaging lives in record numbers within a short period. Many medical reviews ahs confirmed that the major challenge medical practitioners face is a lack of technical know-how on how to handle individual patient. While some patients survived with symptomatic-based therapy, some other patient needed aggressive life support to survive and unfortunately some patients just didn't have a chance to pull through. 

***Project Definition***
This project aims to understand through analysis, the impact of comorbidities and other unique features on the survival or death of a sample of COVID-19 patients. I intend to build a robust Machine Learning model that helps to predict a patient’s survival. This project is a machien learning based project, its ultimate goal is to identify a pattern of survival and not survival patients and see the impact their comorbidities has on their outcome. This I believe if incorporated into medicine can save more lives as medical practitioners can decide on best medical approach for each patient.

***Objectives***
•	Perform a descriptive analysis of "covid-19 dataset" using statistical techniques and plots, as well as displaying the relationship between comorbidities and survival of a COVID-19 patient.
•	Perform data cleaning by engineering features and dropping features not relevant to this project scope. 
•	Use Random Forest and Gaussian Naive Bayes models to predict if a patient will die or survive covid-19 given patient's current symptoms. Furthermore, perform cross-validation and checks to see the performance   of the models.

***Technologies Used:*** Jupyter Notebook, Python, Matplotlib, Seaborn, CSV, Pandas, Random Forest and Gaussian Naive Bayes Machine learning algorithms, Github

***Key Findings:***

***EDA***
In its raw form, data had 21 columns and 1048575 rows, and after cleaning, there were 388878 rows and 16 columns in our data. 

![image](https://github.com/Ayomide-ola/Ayomide_Portfolio-/assets/147144682/348cd4a9-5c45-4704-b5ae-ad8a4b5ab49a)
The age column was grouped into 4 age categories, children age (0-15), adults (15-30), old (31-60), and seniors (61-120) are category 0,1,2,3,4 respectively. The count plot shows 2, has the highest count followed by 3, 1 and 0 in that order. 

###### Why is age important to covid-19?
Boxplot shows that the majority of the patients are aged between 0 and approximately 95 years old, with some outliers above 100. Domain knowledge suggests that COVID-19 has severe effects on old patients compared to younger patients, hence outliers are significant. 0 years old could be babies that are less than a year old. 
![image](https://github.com/Ayomide-ola/Ayomide_Portfolio-/assets/147144682/04e1221c-287d-4b58-824c-3d05cc0574b3)
Fig is a correlation plot of death and survival patients in each age category. Overall, more people survived COVID-19 in our sample data (fig 5). 
![image](https://github.com/Ayomide-ola/Ayomide_Portfolio-/assets/147144682/89342f19-3408-463a-9a69-827bd2f5f959)

###### Modelling
***Why Gaussian Naive Bayes and Random Forest (GNB and RF)?***
The died column was picked as the target to build a model that predicts if a COVID-19 patient survived covid-19 or not given independent variables. These models where selected because both are used for classification tasks. RF builds multiple decision trees and merges their predictions; therefore, it is more accurate and robust to outliers and noisy data. GNB is a probabilistic supervised learning model, that uses conditional probability to classify targets. 

The data has outliers hence I chose my primary model as RF, famous for its robustness against outliers, RF model promises to produce more accurate results even when outliers are present. GNB on otherhand is a probabilistic model. My model question is ***what is the probability a patient will survive, given condition(comorbidities)? 

###### Model performance and conclusion.
***Note:*** I kindly ask that you look into the project methodology to see the processes that led to this conclusion.
![image](https://github.com/Ayomide-ola/Ayomide_Portfolio-/assets/147144682/0636f606-6172-4756-a2b8-be94df9477e7)

Having carefully evaluated our model results, I observe that 'RF model' performed better for this sample data. This model is consistently predicting if a person died or survived Covid-19 with an Accuracy of 86% - 88% with a proportion of actual positives correctly identified (Recall) of 81% (survived) and 95% (died).
The results were obtained using:
1. Metrics from Sklearn to evaluate the Accuracy and Precision.
2. Classification report from Sklearn.metrics to evaluate Precision, Recall, F1-score and Accuracy.
3. Cross-validation score from Sklearn.model_selection to evaluate the Accuracy dividing the data into multiple subsets to obtain a reliable metric and compare it with our previous ones.

***GitHub Link:***https://github.com/Ayomide-ola/Machine-Learning/blob/main/CA1_ML.ipynb
