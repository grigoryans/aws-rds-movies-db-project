import json
from faker import Faker
from faker.providers import internet
import pandas as pd
import my_functions as mf
import math

fake = Faker()

def lambda_handler(event, context):
    for i in range(7):
        rand_user = fake.simple_profile()
        mf.exec_query(mf.dicto_to_sql_insert(rand_user, 'users', 'main'))
        print(rand_user)
        print('\n')
