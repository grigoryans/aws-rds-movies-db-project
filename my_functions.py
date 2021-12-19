import psycopg2
import sys
import boto3
import os
import pandas as pd
import re
import math
from datetime import datetime, timedelta, date
import random as r
import time

# Execute any given query on my db
def exec_query(query):

    ENDPOINT = os.getenv('RDS_ENDPOINT')
    PORT = os.getenv('RDS_PORT')
    USR = os.getenv('RDS_USER')
    PASS = os.getenv('RDS_PASS')
    REGION = os.getenv('RDS_REGION')
    DBNAME = os.getenv('RDS_DB_MOVIES')

    try:
        conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USR, password=PASS)
        cur = conn.cursor()
        cur.execute(query)
        cur.close()
        conn.commit()
    except Exception as e:
        print("Database connection failed due to {}".format(e))


# Generate INSERT statement on given CSV file
def csv_to_sql_ins(file_path, schema_name=''):
    if '/' in file_path:
        table_name = file_path[file_path.rindex('/')+1:].split(".")[0]
    else: table_name = file_path.split(".")[0]

    df = pd.read_csv(file_path)
    ins_statement = "SET search_path = '"+str(schema_name)+"'; INSERT INTO \""+table_name+"\" VALUES "

    df_dict = df.to_dict()

    vals = ''
    for i in range(len(df)):
        vals+='('
        for col_name in df.columns:
            if type(df_dict[col_name][i])==str:
                vals+='\''+str(df_dict[col_name][i]).replace("'", "''")+'\','
            elif math.isnan(df_dict[col_name][i]):
                vals+='NULL,'
            else: vals+=str(df_dict[col_name][i])+','
        vals = vals[:-1]
        vals+='),'
    vals = vals[:-1]

    return ins_statement+vals

# Generate INSERT statement on given python dictionary (single value)
def dicto_to_sql_insert(dict, table_name, schema_name=''):

    order = '('
    for i in dict.keys():
        order+=str(i)+', '
    order = order[:-2]
    order+= ')'

    if schema_name=='':
        ins_statement = "INSERT INTO \""+table_name+"\" "+order+" VALUES "
    else:
        ins_statement = "SET search_path = '"+str(schema_name)+"'; INSERT INTO \""+table_name+"\" "+order+" VALUES "

    vals = '('
    for col_name in list(dict.keys()):
        vals+='\''+str(dict[col_name]).replace("'", "''")+'\','
    vals = vals[:-1]
    vals+=')'

    return ins_statement + vals


# Generate random datetime
def str_time_prop(start, end, time_format, prop):
    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))

def random_date(start, end, prop):
    return str_time_prop(start, end, '%Y-%m-%d %X', prop)

def last_day_random_timestemp():
    # current datetime
    now = datetime.now()
    current_dt = now.strftime("%Y-%m-%d %H:%M:%S")

    # one day before
    one_day_before = (datetime.now() - timedelta(days=3)).strftime("%Y-%m-%d %H:%M:%S")

    # generate a random datetime for last one day
    random_timestamp = random_date(one_day_before,current_dt, r.random())
    return random_timestamp

def select_query(query):
    ENDPOINT = os.getenv('RDS_ENDPOINT')
    PORT = os.getenv('RDS_PORT')
    USR = os.getenv('RDS_USER')
    PASS = os.getenv('RDS_PASS')
    REGION = os.getenv('RDS_REGION')
    DBNAME = os.getenv('RDS_DB_MOVIES')

    conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USR, password=PASS)

    return pd.read_sql(query, con=conn)
