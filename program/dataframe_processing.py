import pandas as pd
import numpy as np
import dataframe_methods as dm

def dataframe_cols():
    """ retrieving any data that is useful from the csv files"""
    df_cols = {
        'athletes': ['code', 'current','name','gender','function','country_code','country','disciplines','events'],
        'medals': ['medal_code', 'discipline', 'event', 'code', 'country_code'],
        'schedules': ['start_date','end_date','discipline','discipline_code', 'event', 'phase', 'event_type','venue', 'venue_code'],
        'teams': ['code', 'current', 'country_code', 'discipline','disciplines_code', 'events','athletes_codes','num_athletes']
    }
    return df_cols

def create_dataframes(df_cols):
    # retrieving all the data that will be needed
    raw_athletes = dm.create_table("athletes.csv", df_cols['athletes'])
    raw_medals = dm.create_table("medals.csv", df_cols['medals'])
    raw_schedules = dm.create_table("schedules.csv", df_cols['schedules'])
    raw_teams = dm.create_table("teams.csv", df_cols['teams'])

    # PROCESSING TO DATA
    # COUNTRY
    cou1 = raw_athletes[['country_code','country']]
    Country = dm.remove_duplicates(cou1)
    # ATHLETE
    ath1 = dm.remove_non_current(raw_athletes)
    ath2 = dm.remove_non_athlete(ath1)
    Athlete = ath2[['code','name','gender','country_code']]
    # TEAM
    tea1 = dm.remove_non_current(raw_teams)
    tea2 = dm.remove_empty_cells(tea1)
    Team = tea2[['code','country_code','num_athletes']]
    # VENUE
    ven1 = raw_schedules[['venue','venue_code']]
    ven2 = dm.remove_empty_cells(ven1)
    Venue = dm.remove_duplicates(ven2)
    # DISCIPLINE
    dis1 = dm.remove_empty_cells(raw_schedules)
    dis2 = dis1[['discipline','discipline_code']]
    Discipline = dm.remove_duplicates(dis2)
    # EVENT
    eve1 = raw_schedules[['discipline','event','event_type']]
    eve2 = dm.remove_empty_cells(eve1)
    Event = dm.remove_duplicates_specifics(eve2, ['discipline', 'event'])
    # RESULTS
    res1 = dm.remove_empty_cells(raw_medals)
    res2 = dm.filter_codes(res1)
    Results = res2[['medal_code','discipline','event','athlete_code','team_code']]
    # LOCATION
    loc = raw_schedules[['start_date','end_date','discipline','event','phase','venue_code']]
    loc1 = dm.remove_empty_cells(loc)
    loc2 = dm.adding_time(loc1)
    Location = dm.remove_duplicates_specifics(loc2, ['start_date','start_time','discipline','event','phase'])
    # PARTOF
    pao3 = dm.list_to_string(tea2, 'athletes_codes')
    PartOf = pao3[['code','athletes_codes']]

    # PARTICIPATE
    # creating the team part of the participation table- cleaning and selecting
    par_tea1 = dm.remove_non_current(raw_teams)
    par_tea2 = dm.remove_empty_cells(par_tea1)
    par_tea3 = par_tea2[['code','discipline','events']]
    par_tea4 = par_tea3.rename(columns={'code': 'team_code', 'events': 'event'})

    # events table for individual sports
    singles = Event.merge(par_tea4, on=['discipline','event'],how='left',indicator=True)
    singles1 = singles[singles['_merge'] == 'left_only'].drop(columns=['_merge']) 
    singles2 = dm.remove_duplicates_specifics(singles1,['discipline','event'])

    # cleaning athletes section of participation dataframe
    par_ath1 = dm.remove_non_current(raw_athletes)
    par_ath2 = dm.remove_non_athlete(par_ath1)
    # selecting the values that are useful for the participation table
    par_ath3 = par_ath2[['code','disciplines','events']]
    # splitting discipline and the event lists in the athletes table
    par_ath4 = dm.list_to_string(par_ath3, 'disciplines')
    par_ath5 = dm.list_to_string(par_ath4, 'events')
    # merging with individual events to see which events in the athletes table
        # is an individual event and remove events that were allocated to  
        # disciplines incorrectly during the process of splitting
    par_ath6 = par_ath5.merge(singles2, left_on=['disciplines','events'],right_on=['discipline','event'],how='left',indicator=True)
    par_ath7 = par_ath6[par_ath6['_merge'] == 'both'].drop(columns=['_merge']) 
    # selecting useful info and renaming columns for easier concat
    par_ath8 = par_ath7[['code','discipline','event']]
    par_ath9 = par_ath8.rename(columns={'code': 'athlete_code'})

    # merging of the all the teams that are a part of the olympics and all the
        # athletes and each of the individual sports they competed in
    Participate = pd.concat([par_ath9, par_tea4])
    Participate['athlete_code'] = Participate['athlete_code'].fillna(0).astype(int)
    
    return [Country,Athlete,Team,Discipline,Venue,Event,PartOf,Results,Location,Participate]
