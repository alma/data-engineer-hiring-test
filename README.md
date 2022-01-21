# Data Engineer hiring test

## Objective

The aim of the first exercise is to test your SQL knowledge and modelization concept.
The second exercise is a data ingestion workflow modelisation using Airflow DAGs. 

We don't want to test only your coding skills but also your capacity to modelize and anticipate potential issues.



## 1st Part - SQL queries and anonymizing

Please find below a simple schema of three sql tables extracted from a basic application handling payments execution for shops. 
SQL dump is available in the exercise_1 repo.

- payment: Containing information regarding payments
- shop: Containing information regarding the online or physical where the payment occured
- payment_log: Containing information regarding payments events and life cycle


1) We would like to retrieve some information from these tables.
Volumes will increase very fast in this application, we need to pay attention to queries execution performances. The payment log table already contains billions of lines.

Please write queries to retrieve:
- The number of paid payments not using several instalments (use payment.type) per month
- The number of payments paid using several instalments and the induced amount in € per merchant name
- The running total of all payments per year only for shops of retail activity
- The number of payments with at least one 'debit done' event per merchant
- The full export of payments info with shop name, activity and the associated number of logs

2) We would like to expose the shop table to Data Analyst team. However we don't want to show exact value of shop contact email and phone.
Data Analyst still want to report on these fields and distinguish unique values.
Please propose a technical solution to replace and expose these sensitive data.



## 2nd Part - Data ingestion/transformation workflow

For this exercice, we'll work on dataset available [here](https://github.com/fivethirtyeight/data/blob/master/hip-hop-candidate-lyrics/genius_hip_hop_lyrics.csv). This dataset contains data about hip-hop lyrics referencing to US election candidate. The objective is to ingest this dataset in our local Postgres database.
From this dataset we would like to create two tables: 
- One table lyrics containing the lyric part mentioning a candidate and an artist ID external key. It's a professional project, we should find a way to transform all bad words (replace it with '*' for example).
- One table artist containing a primary key ID, and some information about the artist (label name, year of creation, music style and country) available with this [API](https://theaudiodb.com/api/) - ([Doc](https://www.theaudiodb.com/api_guide.php))

You don't need to actually code and execute the DAG but propose a detailed DAG structure with python/sql operators completing this workflow.

If needed a docker-compose file is available to build a local Airflow environment ([source](https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html)).


## Deliverable

There is no expected format for deliverable you can either send files and report by email or store this in a github repository.
In case of using a github repository, please grant Alexis Charrier (Github Id: [AlexisCharrier](https://github.com/AlexisCharrier)) access to this repo.
