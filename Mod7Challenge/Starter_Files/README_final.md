# Mod 7 Assignment

## Data Engineering Portion
Please see /DatabaseSetup for the following files:
- db_diagram_input.md (text input used to generate diagram)
- db_diagram.png (completed ERD)
- db_setup_and_seed.sql (table creation and seed data used)

## Data Analysis Pt 1 (sql queries and view creation in data_analysis_pt1.sql)

### Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders.
- How can you isolate (or group) the transactions of each cardholder?
    ** Please see data_analysis_pt1.sql ** 
    
- Count the transactions that are less than $2.00 per cardholder.
    ** Please see data_analysis_pt1.sql ** 

- Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
Judging by the resulting table alone, there is not enough evidence to identify fraudulent activity. However, it may be worth further investigating those customers with the highest number of transactions under $2; Cardholders 10, 11, 12, 19, and 24 all have 20 or more of these transactions. 

### Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made.

- What are the top 100 highest transactions made between 7:00 am and 9:00 am?
    ** Please see data_analysis_pt1.sql ** 

- Do you see any anomalous transactions that could be fraudulent?
The largest 8 transactions may be fraudulent. The amounts for these transactions are between $748 and $1894, all of which are much larger than the majority of transactions, and seem like way too much to spend at any of the included merchant categories (though there may be logical explanations).

- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
AND 
- If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.

The hours with the greatest number of transactions over $700 are 3pm (7 transactions) and 6am (6 transactions). 1am, 8am, 1pm, and 11pm each have 5 transactions that meet these criteria. Each of these hours are likely higher-traffic times for the food merchants (nighttime = bar hours, morning=breakfast, midday=lunch), thus increasing the chances of some fraudulent activity. Strangely, there are no significant spikes in this metric during common dinner hours.

- What are the top 5 merchants prone to being hacked using small transactions?
(id_merchant, merchant_name, merchant_category_name, small_transaction_count)
141	"Wood-Ramirez"	"bar"	7
48	"Baker Inc"	"food truck"	6
145	"Hood-Phillips"	"bar"	6
129	"Sweeney-Paul"	"coffee shop"	5
149	"Clark and Sons"	"food truck"	5

## Data Analysis Pt 2
Answers are inline with the code in visual_data_analysis.ipynb

## Challenge 
I was unable to complete the challenge assignment this time around. 
