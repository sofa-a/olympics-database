import pandas as pd
import ast
import re

def create_table(table_name, columns):
    """ reads csv file into a dataframe and selects specific columns """
    all_data = pd.read_csv(f"./data/{table_name}")
    return all_data[columns]

def remove_duplicates(df):
    # removes duplicate data
    new_df = df.drop_duplicates()
    return new_df

def remove_non_current(df):
    # removes athletes/teams who under the column current says False - not current
    new_df = df.copy()
    for x in new_df.index:
        if new_df.loc[x, "current"] == False:
            new_df.drop(x, inplace = True)
    return new_df

def remove_non_athlete(df):
    # removes athletes who under the column function says alternate athlete
    new_df = df.copy()
    for x in new_df.index:
        if new_df.loc[x, "function"] == "Alternate Athlete":
            new_df.drop(x, inplace = True)
    return new_df
    
def remove_empty_cells(df):
    # removes rows where null data is present
    new_df = df.dropna()
    return new_df

def remove_duplicates_specifics(df, cols):
    # removes duplicates based on specific data
    new_df = df.drop_duplicates(subset=cols)
    return new_df

def adding_time(df):
    # separates datetime format into separate values of date and time
    new_df = df.copy()
    # splitting data on T and +
    for index, row in new_df.iterrows():
        parts = re.split(r'[T+]',row['start_date'])
        parte = re.split(r'[T+]',row['end_date'])
        new_df.loc[index, 'start_date'] = parts[0]
        new_df.loc[index, 'start_time'] = parts[1]
        new_df.loc[index, 'end_date'] = parte[0]
        new_df.loc[index, 'end_time'] = parte[1]
    return new_df
 
def filter_codes(df):
    # athlete codes and team codes in the same column are moved to separate columns
    new_df = df.copy()
    new_df['athlete_code'] = df['code'].apply(lambda x: x if x.isdigit() else None)    
    new_df['team_code'] = df['code'].apply(lambda x: x if not x.isdigit() else None)    
    return new_df

def list_to_string(df, column):
    # several column values are in string format and needs to be converted to list
    new_df = df.copy()
    new_df[column] = new_df[column].apply(ast.literal_eval)
    # explode function is then able to separate the list into separate strings
    return new_df.explode(column,ignore_index=True)
