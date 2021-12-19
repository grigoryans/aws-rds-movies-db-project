import my_functions as mf


# create tables
tables_cr = open("create_tables.sql","r").read()
mf.exec_query(tables_cr)


# insert data
csv_files_arr = os.listdir('data/')
print(csv_files_arr)

for i in csv_files_arr:
    if i[-4:]=='.csv':
        mf.exec_query(mf.csv_to_sql_ins('data/'+str(i),'main'))
