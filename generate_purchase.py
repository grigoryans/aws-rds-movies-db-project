import my_functions as mf
import random as r
import psycopg2

def random_purchase():
    ENDPOINT = "aca-db.csmgakk6oreg.eu-central-1.rds.amazonaws.com"
    PORT = "5430"
    USR = "postgres"
    PASS = 'postgres'
    REGION = "eu-central-1"
    DBNAME = "aca_movies_db"

    conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USR, password=PASS)
    cur = conn.cursor()

    for i in range(5):
        # random movie
        cur.execute("""SELECT id FROM main.movies ORDER BY random() LIMIT 1;""")
        rand_movie = cur.fetchall()[0][0]

        # random user
        cur.execute("""SELECT user_id FROM main.users ORDER BY random() LIMIT 1;""")
        rand_user = cur.fetchall()[0][0]

        # random tariff
        rand_tariff = r.randrange(0,5)

        # random datetime

        rand_datetime = mf.last_day_random_timestemp()
        print('rand movie: '+str(rand_movie)+\
              '\nrand user : '+str(rand_user)+\
              '\nrand tariff: '+str(rand_tariff)+\
              '\nrand date : '+str(rand_datetime)+'\n')

        mf.exec_query("INSERT INTO main.purchases VALUES ("+str(rand_movie)+","+str(rand_user)+", "+str(rand_tariff)+",\'"+str(rand_datetime)+"\')")


def lambda_handler(event, context):
    random_purchase()
