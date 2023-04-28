# Questions for the Mod 4 Challenge


## Risk Analysis
Boxplot: How can I switch the x and y axes? The data (and labels) would be better displayed in such a way.

## Determine which portfolios are riskier than the S&P 500
Cannot find the proper way for a for loop to iterate through, compare port std and sp500 std, and print which is greater

Weighted returns for my portfolio. How????


-----------
LESSIMPORTANT

# Part 1 - Data Cleaning
Algo Returns: Algo 1 has data for all days, while Algo 2 has null returns for the first 6 days. When we dropna, the first 6 days are removed from the dataframe (removing the nulls for Algo 2 like we want, but also removing real data for Algo 1). Is this the desired outcome, or:
- is there a way to remove only the null days for Algo 2 (I dont think this would be possible, and it wouldnt really make sense anyway)?
- would we want to replace Algo 2's null values with zero, so that we could retain the values for Algo 1's first 6 days (this seems more appropriate)?

# Constructing my own portfolio
Doing things in a different order than what the starter code seems to have. My data retrieved from google finance is differently formatted than the sample data they have, so maybe this is okay?

# Use `ewm` to calculate the rolling window
all_returns_df.ewm(halflife=21).std().plot()
-Im not sure if this answers what is being asked


---------
# Resolved

(Part1) Fixing Data Types for SP500 close prices: Do I need to change the date format to match that of the other data (whale & algo)? If so, how?
- nevermind, this is done by creating an index column based on the existing date column, and then removing the original (non-index) date column:

#set Date as df index, inferring datetime format
sp500_close_df.set_index(pd.to_datetime(sp500_close_df['Date'], infer_datetime_format=True),inplace=True)

#drop extra date column
sp500_close_df.drop(columns=['Date'],inplace=True)

-------
(Part1) At stage where we combine the three df's into one, I was able to concat effectively just the headers - no data came through.
- this was because, while I set the index for the sp500 close prices (above Q), I did not do so for whale and algo returns.
- going back and indexing those two in the same way allowed me to concat all three df's without issue



### Calculate and Plot Beta for a chosen portfolio and the S&P 500
"Plot Beta Trend" - this is referring to the Xday rolling beta for the selected portfolio, correct?
