DROP VIEW IF EXISTS team_loc;
CREATE VIEW team_loc AS
    -- many joins required as moving through the data from Team, to 
    -- Participate, to Event and then to Location where the time data is.
    SELECT DISTINCT loc.discipline,loc.phase,loc.startTime,loc.startDate, loc.venueCode
    FROM Team tea
    JOIN Participate par
        ON tea.teamCode = par.teamCode
    JOIN Event eve
        ON par.event=eve.event AND par.discipline=eve.discipline
    JOIN Location loc
        ON loc.event=eve.event AND loc.discipline=eve.discipline

    WHERE par.event=loc.event AND par.discipline=loc.discipline;
