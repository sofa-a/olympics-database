import dataframe_processing as dp
import sql_methods as sm
import pandas as pd
import numpy as np
    
def main():
    # retrieving data from csv files and creating a dataframe
    dfcols = dp.dataframe_cols()
    frames = dp.create_dataframes(dfcols)
    
    for i in range(len(frames)):
        frames[i] = frames[i].replace({0: None})
        frames[i] = frames[i].replace({np.nan: None})

    # connect to mysql using the given user name and password
    username = input("Enter your username: ")
    password = input("Enter your password: ")
    sql_database = sm.connect_sql(username, password)
    if sql_database.is_connected():
        sql_cur = sql_database.cursor()
        # method for parsing sql file logic. setup.sql sets up database
        sm.read_sql_file(sql_cur, "setup.sql")

        queries = [
            "INSERT INTO Country VALUES(%s,%s)",
            "INSERT INTO Athlete VALUES(%s,%s,%s,%s)",
            "INSERT INTO Team VALUES(%s,%s,%s)",
            "INSERT INTO Discipline VALUES(%s,%s)",
            "INSERT INTO Venue VALUES(%s,%s)",
            "INSERT INTO Event VALUES(%s,%s,%s)",
            "INSERT INTO PartOf VALUES(%s,%s)",
            "INSERT INTO Results (medal,discipline,event,athleteCode,teamCode) VALUES(%s,%s,%s,%s,%s)",
            "INSERT INTO Location (startDate,endDate,discipline,event,phase,venueCode,startTime,endTime) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)",
            "INSERT INTO Participate (athleteCode,discipline,event,teamCode) VALUES(%s,%s,%s,%s)"
        ]
        
        # takes dataframe and puts it into athlete table
        for i in range(len(queries)):
            sm.database_insert(sql_cur,frames[i], queries[i])
        
        sm.read_sql_file(sql_cur, "add_fks.sql")

	# menu selection part of code
        done = False 
        while done != True:
            print("Would you like to:")
            print("(1) read a sql file")
            print("(2) create a query?")
            print("(0) exit")
            choice = input()
            if int(choice) == 1:
                file = input("Enter the filename: ")
                sm.read_sql_file(sql_cur, file)
            elif int(choice) == 2:
                query = input("Enter a query you would like to make to database: ")    
                sm.sql_command(sql_cur, query)
            elif int(choice) == 0:
                done = True
            else:
                print("Please enter a valid choice")
                
        # closing cursors, committing to database
        sql_database.commit()
        sql_cur.close()
        sql_database.close()
    else:
        print('wrong username or password entered')
        
if __name__ == "__main__":
    main() 
