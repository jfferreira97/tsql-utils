-- Utility query to get foreign key information for a specified table
-- Usage: Replace 'YourSearchTermHere' with your table name

DECLARE @TableName NVARCHAR(256) ='YourSearchTermHere';

SELECT 
    fk.name AS foreign_key_name,
    OBJECT_NAME(fk.parent_object_id) AS referencing_table,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS referencing_column,
    OBJECT_NAME(fk.referenced_object_id) AS referenced_table,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS referenced_column
FROM 
    sys.foreign_keys AS fk
INNER JOIN 
    sys.foreign_key_columns AS fkc 
    ON fk.object_id = fkc.constraint_object_id
WHERE 
    OBJECT_NAME(fk.referenced_object_id) = @TableName
ORDER BY 
    referencing_table;
