import cx_Oracle

username = 'WORKSHOP2'
password = 'oracle'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

"""-------------------------------------------------------------------------------------
Запит 1 - вивести топ 10 міст(Township) з найменшою кількістю всіх випадків по рокам."""

query = """
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
    ORDER BY table4.year, table3.town, table4.amount
"""

cursor.execute(query)
print('Запит 1')
print('|Town           |year|Amount of accidents|')
print('-'*41)
row=cursor.fetchone()
while row:
    print("|{:15s}|{:2d}|{:2d}".format(row[0], row[1], row[2]))
    row = cursor.fetchone()

print()

"""--------------------------------------------------------------------------------------------
Запит 2 - вивести назву ситуації в місті(Township) та частоту її виникнення(%) відносно частоти
 виникнення цієї ситуації в інших містах округа Монтгомері, Пенсильванія. (за конкретний рік)"""

query = """
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
                    AND title=:title
                GROUP BY title,town, EXTRACT(year FROM accident.timestampp)
                ORDER BY town)table2
            GROUP BY table2.year ,table2.title), 2), 0) AS percentage    
FROM accident 
WHERE EXTRACT(year FROM accident.timestampp)=:year 
    AND title='Traffic: VEHICLE ACCIDENT -'
GROUP BY title,town, EXTRACT(year FROM accident.timestampp)
ORDER BY town
"""
cursor.execute(query, title='Traffic: VEHICLE ACCIDENT -', year='2019')
print('Запит 2')
print('|Year|Title                      |Town           |Amount|Percentage|')
print('-'*67)
row=cursor.fetchone()
while row:
    print("|{:4d}|{:25s}|{:15s}|{:6d}|{:.3f}".format(row[0], row[1], row[2], row[3], row[4]))
    row = cursor.fetchone()

print()


"""--------------------------------------------------------------------------------------------
Запит 3 - вивести динаміку дзвінків(тобто ситуацій) по роках в конкретному місті. """

query = """
SELECT
    town
    ,EXTRACT(year FROM accident.timestampp) AS year
    ,COUNT(town) AS amount
FROM accident
WHERE town=:town
GROUP BY EXTRACT(year FROM accident.timestampp), town
ORDER BY EXTRACT(year FROM accident.timestampp)
"""
cursor.execute(query, town='NORRISTOWN')
print('Запит 1')
print('|Town           |year|Amount of accidents|')
print('-'*41)
row=cursor.fetchone()
while row:
    print("|{:15s}|{:4d}|{:5d}".format(row[0], row[1], row[2]))
    row = cursor.fetchone()

print()

cursor.close()
connection.close()