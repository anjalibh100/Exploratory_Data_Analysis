Project Date : 9/11/2024

Situation:
----------
The "World Life Expectancy" dataset contained missing values and duplicate data, which needed to be cleaned to ensure the data was accurate and ready for analysis. The dataset was loaded into MySQL for cleaning, and SQL queries were used to address the data issues.

Task:
------
The task was to clean the dataset by removing duplicates, handling missing data in key columns, and ensuring the dataset was ready for further analysis.

Action:
-------
Created a new schema and database to load the dataset.
Used SQL Workbench’s Table Data Import Wizard to import the data from the .csv file into the new database.
Identified and resolved data issues:
Missing values in the "Status" column were updated with common values from the corresponding rows.
Missing values in the "Life Expectancy" column were filled by calculating the average of the values from the rows before and after the missing entry.
Duplicate records were identified and removed to ensure data consistency.

Result:
--------
The dataset was successfully cleaned, with missing values addressed and duplicates removed, resulting in a reliable dataset containing 2941 records that is now ready for further analysis and insights.
