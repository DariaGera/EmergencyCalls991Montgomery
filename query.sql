-- first query
SELECT table3.town, table4.year, table4.amount FROM(
    SELECT * 
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
            GROUP BY town               
            ORDER BY total_amount ASC
        )table2
    WHERE ROWNUM<10
)table3  
    JOIN
(SELECT
    town
    ,EXTRACT(year FROM accident.timestampp) AS year
    ,COUNT(town) AS amount
FROM accident 
GROUP BY EXTRACT(year FROM accident.timestampp), town
)table4
    ON table3.town=table4.town
    GROUP BY table4.year, table3.town, table4.amount
    ORDER BY table4.year, table3.town, table4.amount;
  

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
                    EXTRACT(year FROM accident.timestampp) AS year
                    ,title
                    ,town
                    ,COUNT(town) AS amount   
                FROM accident 
                WHERE EXTRACT(year FROM accident.timestampp)=2019 
                    AND title='Traffic: VEHICLE ACCIDENT -'
                GROUP BY title,town, EXTRACT(year FROM accident.timestampp)
                ORDER BY town)table2
            GROUP BY table2.year ,table2.title), 2), 0) AS percentage    
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






     