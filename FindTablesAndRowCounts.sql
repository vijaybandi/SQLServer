USE OurDatabaseName 
GO
/* 

Quickly find the rowcounts of all the tables in a database

Very useful if searching an unknown database 

*/
-- Create the table that will hold the values
CREATE TABLE #TableNameRowCount(
   TableName sysname,
   [RowCount] int
)
-- Insert the table names and how many rows they have
EXEC sp_MSForEachTable 'INSERT #TableNameRowCount (TableName, [RowCount]) SELECT ''?'', COUNT(*) FROM ?'
-- Obtain the table and row information
SELECT REPLACE(REPLACE(REPLACE(TableName,'[dbo].',''),'[',''),']','') AS TableName, [RowCount]
FROM #TableNameRowCount
WHERE [RowCount] <> 0
ORDER BY [RowCount] DESC