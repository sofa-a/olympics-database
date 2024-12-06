from tabulate import tabulate
import mysql.connector
import sqlparse

def database_insert(sql_cur, dataframe, query):
    # inserts data from dataframes into the sql tables
    print(f"Executing {query}")
    for i, row in dataframe.iterrows():
        new_query = sqlparse.format(query, strip_comments=True).strip()
        sql_cur.execute(new_query, tuple(row))

def connect_sql(username, password):
    # connection initiation
    db = mysql.connector.connect(host='localhost', user=username, password=password)
    return db

def sql_command(cur, new_command):
    # handles sql logic
    command = sqlparse.format(new_command, strip_comments=True).strip()
    # removal of comments
    case1 = ["CREATE", "UPDATE", "INSERT", "DROP", "USE", "ALTER","DELETE"]
    case2 = ["SELECT", "DESCRIBE"]            
    case3 = ["SOURCE", "./"]
    # different cases for the code to handle different things

    if command:
        if command.upper().split(" ")[0] in case1:
            print(f"Executing: {command}")
            cur.execute(command)
        elif command.upper().split(" ")[0] in case2:
            print(f"Executing: {command}")
            cur.execute(command)
            result = cur.fetchall()
            col = [desc[0] for desc in cur.description]
            # more coding required for select and describe as needs to be displayed
            print(tabulate(result, headers=col, tablefmt="pretty"))
        elif command.upper().split(" ")[0] in case3:
            source_file = command.split()[1]
            print(f"Executing SOURCE file: {source_file}")
            read_sql_file(cur, source_file)
            # recursion for reading another file in a file
        else:
            print(f"unknown command: {command.split()[0]}")


def read_sql_file(cur, file):
    """ contains logic to process any sql statements """
    with open(f"./sql_files/{file}", 'r') as file:
        file = file.read()
        print(file)
    # uses logic that every command is separated by ;
    commands = file.split(";")
    for command in commands:
        sql_command(cur, command)
