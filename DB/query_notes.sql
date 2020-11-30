-- create table

IF object_id('timestamp') is null
BEGIN
    CREATE TABLE timestamp
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        timestamp DATETIME
    )
END

-- drop table

DROP TABLE timestamp

-- insert record with current time (time on SQL server instance)

INSERT INTO timestamp (timestamp)  
VALUES (GETDATE());  

-- select last top 10 records

SELECT TOP 10 * 
FROM timestamp
ORDER BY id DESC