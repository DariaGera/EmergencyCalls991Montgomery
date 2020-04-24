-- first query
SELECT table2.town, table4.year, table4.amount 
    FROM(
        SELECT 
            town
            ,SUM(amount) AS total_amount   
        FROM(
            SELECT
                town
                ,EXTRACT(year FROM accident.timestampp) AS year
                ,COUNT(town) AS amount
            FROM accident 
            GROUP BY EXTRACT(year FROM accident.timestampp), town
        )table1                 
        WHERE ROWNUM<10
        GROUP BY town               
        ORDER BY total_amount ASC    
)table2  
    JOIN
(SELECT
    town
    ,EXTRACT(year FROM accident.timestampp) AS year
    ,COUNT(town) AS amount
FROM accident 
GROUP BY EXTRACT(year FROM accident.timestampp), town
)table4
    ON table2.town=table4.town
    GROUP BY table4.year, table2.town, table4.amount
    ORDER BY table4.year, table2.town, table4.amount;
  

--second query                       
SELECT
    EXTRACT(year FROM accident.timestampp) AS year
    ,title
    ,town
    ,COUNT(town) as amount
    ,nvl(round(COUNT(town)*100/(
        SELECT SUM(table2.amount)    
            FROM( 
                SELECT
                    title
                    ,COUNT(town) AS amount   
                FROM accident 
                WHERE EXTRACT(year FROM accident.timestampp)=2019 
                    AND title='Traffic: VEHICLE ACCIDENT -'
                GROUP BY title,town)table2
            GROUP BY  table2.title), 2), 0) AS percentage    
FROM accident 
WHERE EXTRACT(year FROM accident.timestampp)=2019 
    AND title='Traffic: VEHICLE ACCIDENT -'
GROUP BY title,town, EXTRACT(year FROM accident.timestampp)
ORDER BY town;


--third query
SELECT
    town
    ,EXTRACT(year FROM accident.timestampp) AS year
    ,COUNT(town) AS amount
FROM accident
WHERE town='NORRISTOWN'
GROUP BY EXTRACT(year FROM accident.timestampp), town
ORDER BY EXTRACT(year FROM accident.timestampp);






     