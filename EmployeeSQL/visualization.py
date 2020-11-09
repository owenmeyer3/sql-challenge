

#import sqlalchemy to connect to sql-challenge database
from sqlalchemy import create_engine
import sys
credentialPath = '/Users/Owen/Desktop/DSV/_HW_Repos/sql-challenge/'
if credentialPath not in sys.path:
    sys.path.append(credentialPath)
import pandas as pd
import matplotlib.pyplot as plt
from pg_credentials import pg_user, pg_pwd

######1. Create a histogram to visualize the most common salary ranges for employees.
query1 = 'SELECT * FROM salaries'
######2. Create a bar chart of average salary by title.
query2 = '''
    SELECT title, AVG(salary)
    FROM employees AS e
        LEFT JOIN titles AS t ON e.emp_title_id = t.title_id
        LEFT JOIN salaries AS s ON e.emp_no = s.emp_no
    GROUP BY t.title_id
    '''

#create and connect engine to connect to postgresql database
pg_port = "5432"
engine = create_engine(f'postgresql://{pg_user}:{pg_pwd}@localhost:{pg_port}/sql-challenge')
try:
    connection = engine.connect()
    print('DB connection successful')
except:
    sys.exit('DB connection failure')

#query database for tables
result1 = connection.execute(query1).fetchall()
result2 = connection.execute(query2).fetchall()
connection.close()

######1. Create a histogram to visualize the most common salary ranges for employees.
df1 = pd.DataFrame(result1, columns = ['emp_no', 'salary'])
df1['salary']=df1['salary'].astype(int)
df1['salary'].plot.hist(bins = [0, 20000, 40000, 60000, 80000, 100000, 120000, 999999])
plt.title('Employee Salaries')
plt.ylabel('Number of Employees')
plt.xlabel('Salary')
plt.xlim(0,140000)
plt.show()

######2. Create a bar chart of average salary by title.
df2 = pd.DataFrame(result2, columns = ['title', 'average_salary'])
df2['average_salary']=df2['average_salary'].astype(float)
df2.plot.bar(x = 'title', y = 'average_salary', rot = 45, legend = None)
plt.title('Title Salaries')
plt.ylabel('Average Salary')
plt.xlabel('Title')
plt.show()