import chart_studio

chart_studio.tools.set_credentials_file(username='dariagera', api_key='T7GBkfPRVdtxOQIgxs91')
import plotly.graph_objs as go
import chart_studio.plotly as py
import cx_Oracle
import re
import chart_studio.dashboard_objs as dashboard


# ----------------------------------------------------------------------
def fileId_from_url(url):
    # Return fileId from a url
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


def unique_values(some_list):
    new_list = []
    new_list.append(some_list[0])
    for element in some_list:
        if element not in new_list:
            new_list.append(element)
    return new_list


def amount(some_list, town, year_list):
    new_list = []
    for year in year_list:
        for lst in some_list:
            if lst[0] == town and lst[1] == year:
                new_list += [lst[2]]
    return new_list


def insert_zero(year_list, some_list, help_list):
    for year in year_list:
        for el in some_list:
            if [el[0], year, el[2] >= 0] in help_list:
                continue
            elif [el[0], year, 0] not in all:
                some_list.append([el[0], year, 0])
    return some_list
# ------------------------------------------------------------------------

username = 'WORKSHOP2'
password = 'oracle'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

"""-------------------------------------------------------------------------------------
Запит 1 - вивести топ 10 міст(Township) з найменшою кількістю всіх випадків по рокам."""

query = """
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
    ORDER BY table4.year, table2.town, table4.amount
"""
cursor.execute(query)
print('Запит 1')
print('|Town           |year|Amount of accidents|')
print('-' * 41)

towns = []
years = []
all = []
help_all = []

row = cursor.fetchone()
while row:
    print("|{:15s}|{:2d}|{:2d}".format(row[0], row[1], row[2]))
    towns += [row[0]]
    years += [row[1]]
    all += [[row[0], row[1], row[2]]]
    help_all += [[row[0], row[1], row[2] > 0]]
    row = cursor.fetchone()

unique_town = unique_values(towns)
unique_year = unique_values(years)

all_new = all
all_new = insert_zero(unique_year, all, help_all)
print()


# Visualization of query 1st---------------------------------------------------------------------
fig = go.Figure()

fig.add_trace(go.Bar(x=unique_year,
                     y=amount(all_new, unique_town[0], unique_year),
                     name=unique_town[0],
                     marker_color='rgb(55, 83, 109)'
                     ))
fig.add_trace(go.Bar(x=unique_year,
                     y=amount(all_new, unique_town[1], unique_year),
                     name=unique_town[1],
                     marker_color='rgb(26, 118, 255)'
                     ))

fig.add_trace(go.Bar(x=unique_year,
                     y=amount(all_new, unique_town[2], unique_year),
                     name=unique_town[2],
                     marker_color='rgb(148, 0, 211)'
                     ))

fig.add_trace(go.Bar(x=unique_year,
                     y=amount(all_new, unique_town[3], unique_year),
                     name=unique_town[3],
                     marker_color='rgb(0, 0, 205)'
                     ))

fig.update_layout(
    xaxis=dict(
        title='Years',
        titlefont_size=16,
        tickfont_size=14,
    ),
    yaxis=dict(
        title='Amount of accidents',
        titlefont_size=16,
        tickfont_size=14,
    ),
    legend=dict(
        x=0,
        y=1.0,
        bgcolor='rgba(255, 255, 255, 0)',
        bordercolor='rgba(255, 255, 255, 0)'
    ),
    barmode='group',
    bargap=0.15,  # gap between bars of adjacent location coordinates.
    bargroupgap=0.1  # gap between bars of the same location coordinate.
)
query_1 = py.plot(fig, filename='accidents')



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
                    title
                    ,COUNT(town) AS amount   
                FROM accident 
                WHERE EXTRACT(year FROM accident.timestampp)=:year 
                    AND title=:title
                GROUP BY title,town)table2
            GROUP BY  table2.title), 2), 0) AS percentage    
FROM accident 
WHERE EXTRACT(year FROM accident.timestampp)=:year 
    AND title=:title
GROUP BY title,town, EXTRACT(year FROM accident.timestampp)
ORDER BY town
"""
cursor.execute(query, title='Traffic: VEHICLE ACCIDENT -', year='2019')
print('Запит 2')
print('|Year|Title                      |Town           |Amount|Percentage|')
print('-'*67)

towns = []
percentage = []

row = cursor.fetchone()
# year = row[0]
# t_tle = row[1]
# ("Accident:{:s}in town. Year{:d}".format(t_tle,year))

while row:
    print("|{:4d}|{:25s}|{:15s}|{:6d}|{:.3f}".format(row[0], row[1], row[2], row[3], row[4]))
    towns += [row[2]]
    percentage += [row[3]]
    row = cursor.fetchone()

print()
# Visualization of query 2st---------------------------------------------------------------------
labels = towns
values = percentage
pie = go.Pie(labels = labels, values = values, pull =[0, 0, 0.15, 0])
query_2 = py.plot([pie], filename='percentage')



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

years = []
amount = []

row=cursor.fetchone()
while row:
    print("|{:15s}|{:4d}|{:5d}".format(row[0], row[1], row[2]))
    years += [row[1]]
    amount += [row[2]]
    row = cursor.fetchone()

print()
# Visualization of query 3st---------------------------------------------------------------------
data = go.Scatter(
    x = years,
    y = amount,
    mode='lines+markers'
)

query_3 = py.plot([data], filename='years')



# --------CREATE_DASHBOARD------------------

my_dboard = dashboard.Dashboard()

top_least_amount_towns = fileId_from_url(query_1)
one_accident = fileId_from_url(query_2)
accidents_per_year = fileId_from_url(query_3)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': top_least_amount_towns,
    'title': 'Tоп міст з найменшою кількістю всіх випадків по рокам'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': one_accident,
    'title': 'Traffic: VEHICLE ACCIDENT - в містах за 2019 рік'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': accidents_per_year,
    'title': 'Кількість випадків по роках в  місті NORRISTOWN'
}

my_dboard.insert(box_1)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_3, 'left', 2)

py.dashboard_ops.upload(my_dboard, "Daria Gerazymchuk KM-82")
