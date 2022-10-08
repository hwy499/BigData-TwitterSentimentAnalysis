# 1.1 create rawdata table
CREATE EXTERNAL TABLE IF NOT EXISTS `twitterproject`.`rawdata` (
  `id` bigint,
  `name` string,
  `screen_name` string,
  `text` string,
  `followers_counts` int,
  `location` string,
  `created_at` string,
  `sentiment` double
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
WITH SERDEPROPERTIES ('serialization.format' = '1')
LOCATION 's3://wcd-evelyn/rawdata.csv'
TBLPROPERTIES ('has_encrypted_data' = 'false');

# 1.2 check if rawdata table was created properly
SELECT * FROM rawdata LIMIT 100;

# 2.1 create rawdaatatime table by addinng new columns to rawdata table
CREATE TABLE rawdatatime AS
SELECT * ,
        substring(created_at,12,2) as hours,
        substring(created_at,15,2) as mins,
        substring(created_at,18,2) as secs
FROM rawdata;

# 2.2  check if rawdatatime table was created properly
SELECT * FROM rawdatatime LIMIT 100;
-----------------------------------------------------------------------------------------

# 3.1 create predict table
CREATE EXTERNAL TABLE IF NOT EXISTS `twitterproject`.`predict` (
  `id` bigint,
  `sentiment` double,
  `tweet` string,
  `tokens` string,
  `filtered` string,
  `label` double,
  `prediction` double
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
WITH SERDEPROPERTIES ('serialization.format' = '1')
LOCATION 's3://wcd-evelyn/predict.csv'
TBLPROPERTIES ('has_encrypted_data' = 'false');

# 3.2 check if predict table was created properly
SELECT * FROM predict LIMIT 100;
-----------------------------------------------------------------------------------------

# 4.1 create a word_tokens table
CREATE EXTERNAL TABLE IF NOT EXISTS `twitterproject`.`word_tokens` (`word1` string, `count` int)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
WITH SERDEPROPERTIES ('serialization.format' = '1')
LOCATION 's3://wcd-evelyn/word_tokens.csv/'
TBLPROPERTIES ('has_encrypted_data' = 'false');

# 4.2 check if word_tokens table was created properly
SELECT * FROM word_tokens LIMIT 100;
-----------------------------------------------------------------------------------------

# 5.1 create a word_filtered table
CREATE EXTERNAL TABLE IF NOT EXISTS `twitterproject`.`word_filtered` (`word2` string, `count` int)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
WITH SERDEPROPERTIES ('serialization.format' = '1')
LOCATION 's3://wcd-evelyn/word_filtered.csv/'
TBLPROPERTIES ('has_encrypted_data' = 'false');

# 5.2 check if word_filtered table was created properly
SELECT * FROM word_filtered LIMIT 100;