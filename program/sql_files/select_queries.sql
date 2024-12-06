-- Show all the events that occurred in the morning of the first week of the Olympics (24th of July to 28th of July).
SELECT endTime, endDate, phase, discipline 
FROM Location
WHERE endDate < '2024-07-28' AND endTime < '12:00:00';

-- Select all the athletes that have the last name Brown. 
SELECT *
FROM Athlete
WHERE SUBSTRING_INDEX(name,' ', 1) = 'Brown';

-- Show all the ties that occurred.
SELECT r1.medal, r1.athleteCode, r1.discipline, r1.event
FROM Results r1
JOIN (
    SELECT medal, discipline, event
    FROM Results
    GROUP BY medal, discipline, event
    HAVING COUNT(athleteCode) > 1
) r2
ON r1.medal = r2.medal AND r1.discipline=r2.discipline AND r1.event=r2.event;

-- What is the most times a venue was used?
SELECT COUNT(venueCode) AS maxCount
FROM Location
GROUP BY venueCode
ORDER BY maxCount DESC
LIMIT 1;

-- How many athletes participated in the Olympics in the afternoons?
SELECT COUNT(DISTINCT ath.athleteCode) as parAfternoon
FROM Athlete ath
JOIN Participate par 
    ON ath.athleteCode = par.athleteCode
JOIN Event eve 
    ON par.event=eve.event AND par.discipline=eve.discipline
JOIN Location loc
    ON eve.event=loc.event AND eve.discipline=loc.discipline
WHERE loc.startTime > '12:00:00' and loc.endTime < '18:00:00';

-- Show all medals won by all countries and display in descending order.
SELECT COALESCE(ath.countryCode, tea.countryCode) as countryCode,
    COUNT(CASE WHEN res.medal='1' THEN 1 END) AS gold,
    COUNT(CASE WHEN res.medal='2' THEN 1 END) AS silver,
    COUNT(CASE WHEN res.medal='3' THEN 1 END) AS bronze
FROM Results res
LEFT JOIN Athlete ath ON ath.athleteCode=res.athleteCode
LEFT JOIN Team tea ON tea.teamCode=res.teamCode
GROUP BY countryCode
ORDER BY gold DESC, silver DESC, bronze DESC;
