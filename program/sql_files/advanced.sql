/* ADVANCED QUERIES */

-- counts all the distinct phases of events in the olympics there are. 
SOURCE procedure1.sql;
CALL count_phases(@pcount);
SELECT @pcount;

-- user provides a discipline, event and an athleteCode, and the program tells
	-- the user if the athlete is in the event and discipline provided.
SOURCE procedure2.sql;
CALL discipline_medals('1946887', 'Badminton', "Women's Singles", @result);
SELECT @result;

-- creates a view of the location and start time of all team sports
SOURCE view1.sql;
SELECT * FROM team_loc;

-- creates a view of the start time of the first event in each discipline
SOURCE view2.sql;
SELECT * FROM start_discipline;
