SELECT 
    'private ' || 
    DECODE(DATA_TYPE, 'NUMBER', 'int ', 'String ') || 
    LOWER(SUBSTR(REPLACE(INITCAP(REPLACE(LOWER(COLUMN_NAME), '_', ' ')), ' ', ''), 1, 1)) || 
    SUBSTR(REPLACE(INITCAP(REPLACE(LOWER(COLUMN_NAME), '_', ' ')), ' ', ''), 2) || 
    ';'
FROM COLS
WHERE TABLE_NAME = 'COUNTRIES'
ORDER BY COLUMN_ID;