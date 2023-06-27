# Module 12 Report Template

## Overview of the Analysis

In this section, describe the analysis you completed for the machine learning models used in this Challenge. This might include:

### Explain the purpose of the analysis.
* The purpose of this analysis was to determine whether we could develop a machine learning model to effectively and predictively classify loans as either "healthy" or "high risk." The ability to do so is of paramount importance to any bank or other lending institution, as lending to uncreditworthy borrowers en masse would expose the institution to substantial default risk, making possible much larger downstream effects as well (as we saw in the Financial Crisis in the late 2000s).    

### Explain what financial information the data was on, and what you needed to predict.
* In order to build and test our models, we used lending data comprised of 77,536 individual consumer loans. The data included loan size, interest rate, borrower income, debt to income ratio, number of accounts held by the borrower, derogatory marks, and total debt. Additionally, the dataset included 'loan_status' data, where a healthy loan was indicated with a 0, and a high-risk loan with a 1. This loan_status column became our target data for the ML models, as it is ultimately the value we would want to predict.   

### Provide basic information about the variables you were trying to predict (e.g., `value_counts`).
* Of the original 77,536 loans included in the data, 75,036 or 96.8% were healthy loans. Only 2500 or 3.2% were high-risk loans. While it is good news that the institution from which the data was collected has such a small portion of its loans falling in the high-risk class, this presents an issue from a modeling perspective: we may need to use resampling methods (oversampling, specifically) in order to train our models on enough high-risk loans to facilitate greater predictive performance. 


### Describe the stages of the machine learning process you went through as part of this analysis.
1. Import the source data from the provided csv and add to dataframe.
2. Separate target set (y or 'loan_status') from feature set (X, or all columns other than 'loan_status').
3. Split the aforementioned datasets into training and testing sets using ScikitLearn's train_test_split function. 
4. Create and fit a Logistic Regression model to the training data (X_test, y_test).
5. Make predictions with the model using the testing data.
6. Evaluate the model using the balanced_accuracy_score, confusion_matrix, and classification_report.

At this juncture, it became evident that we should at least try to improve upon the performance metrics (especially for high-risk predictive performance), and so it was decided to utilize oversampling (RandomOverSampler from imbalanced-learn) in order to train a new model, which could then be compared to the original.

7. Create the oversampler model, and use the fit_resample function to fit and resample the training datasets. NOTE: after resampling, value counts showed that we now had 56,271 values for BOTH classes.
8. Create and fit a new Logistic Regression model to the oversampled training data.
9. Make predictions with the new model using the original testing data.
10. Evaluate the new model using the balanced_accuracy_score, confusion_matrix, and classification_report.



### Briefly touch on any methods you used (e.g., `LogisticRegression`, or any resampling method).
* Logistic Regression was the ML technique used in this analysis for classifying and predicting loans into one of two classes: 0 (healthy) or 1 (high-risk).
* RandomOverSampling was used because of the small number of high-risk records in the original dataset; we wanted to ensure that these important values would be predicted as accurately, so we aimed to train the model on as many values in that class as we reasonably could. It appeared to serve its purpose, as the second model (trained on oversampled data) was more accurately able to predict high-risk loans than the first model (trained on the imbalanced original data).

## Results

Using bulleted lists, describe the balanced accuracy scores and the precision and recall scores of all machine learning models.

### Machine Learning Model 1:
Description of Model 1 Accuracy, Precision, and Recall scores.
* Balanced Accuracy: 95%
  * This means that the model made the correct call 95% of the time, which seems decent. Diving into the Index Balanced Accuracy in the classification report, however, I found those values (Healthy: 91%, High-Risk: 90%) to be less impressive.

* Precision: 99%
    * Healthy: 100%
    * High-Risk: 85%
  * The great disparity of precision (actual positives / total positives) was alarming. The low value for the high-risk class indicates that there would be more false positives (creditworthy borrowers wrongly classified as high-risk), which would unnecessarily reduce the number of loans that could potentially be issued. 
    
* Recall: 99%
    * Healthy: 99%
    * High-Risk: 91%
  * For the high-risk class, recall was also lower. This means that there would likely be more false negatives when predicting that class, i.e. actual high-risk borrowers being approved for loans when they should not be. Too much of this is an even larger problem than the one mentioned above in the 'Precision' notes.
    


### Machine Learning Model 2:
Description of Model 2 Accuracy, Precision, and Recall scores.
* Balanced Accuracy: 99%
    * Healthy: 99%
    * High-Risk: 99%
  * Much better thanks to oversampling. 
    
* Precision: 99%
    * Healthy: 100%
    * High-Risk: 84%
  * The high-risk precision very slightly decreased from Model 1 to 2, however, as noted in the explanations under Model 1, it is more important to have recall than precision in this particular case.

* Recall: 99%
    * Healthy: 99%
    * High-Risk: 99%
  * Much better thanks to oversampling. 


## Summary

Summarize the results of the machine learning models, and include a recommendation on the model to use, if any. For example:
* Which one seems to perform best? How do you know it performs best?
  * Model 2 performs better across all metrics for the high-risk class, except precision, which experienced a very small reduction. It is able to better predict high-risk loans/borrowers than Model 1.

* Does performance depend on the problem we are trying to solve? (For example, is it more important to predict the `1`'s, or predict the `0`'s? )
  * The most important performance metric depends on the specific situation or analysis. In this case, it is most important to effectively predict high-risk loan situations, as these are the ones that would hurt the lending institution should something go wrong (borrower default). In this case, I would recommend Model 2.
