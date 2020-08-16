# HRData

# Why?
I am an HR professional with passion for data analytics. Due to the sensitive nature of the data use in "real world" data analysis, it's usually not possible (and probably desirable) to have access to real HR data.

By HR data I mean a data set that would generally include information related to the following:
_Employee data (Name, Age, Race, etc.)
_Organizational data (Department name, date of engagement (i.e. date of hire), performance data, etc.)
_Actions (Promotions, hire, etc.)

Though a few dataset are available on-line I thought that it could be usefull to develop a syntetic dataset creator. 

## Syntetic HR data creator

The code is used to generate a random dataset of Human Resource data. The data is complitelly systetic, but tries to mimic a genuine HR Data set typically found in commerical or non profit organizations. 

In order to make the data set more usefull, particularly for data analysis test, it is possible to create biases in the dataset to see if these biases can be detected through following analysis.

The tool allow creator to set parameters for the dataset.

At the moment the following parameters can be set:
_Number of employees
_Yearly Percentage change: indicating the aproximate proportion of employee population that leaves the organization and is then replaced
_Number of periods: For each period a set of actions (see below) and a performance rating is generated
_Start Year: indicates what is the first year of the simulation

## The tool should be usable without further guidance, however you can continue reading for further details.

