DROP VIEW IF EXISTS start_discipline;

CREATE VIEW start_discipline AS
    -- inner join required for event and phase to be displayed
    -- if no join was done, only discipline would be able to dislayed due to group by
    SELECT loc.discipline, loc.phase, loc.startDate, loc.startTime
    FROM Location loc
    INNER JOIN (
        -- select query for the earliest event time in the discipline
        SELECT discipline, MIN(CONCAT(startDate, ' ', startTime)) as eventTime
     	FROM Location
	GROUP BY discipline
	) earliestEvent
    -- location and earliest event joined
    ON loc.discipline = earliestEvent.discipline
    AND CONCAT(loc.startDate, ' ', loc.startTime) = earliestEvent.eventTime

    -- displayed in ascending order to show which events are going first in which disciplines
    ORDER BY loc.startDate ASC, loc.startTime ASC;
