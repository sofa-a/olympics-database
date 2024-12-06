DELIMITER //

DROP PROCEDURE IF EXISTS discipline_medals;
CREATE PROCEDURE discipline_medals(
    IN acode VARCHAR(17),
    IN disc VARCHAR(50),
    IN eve VARCHAR(50),
    OUT participation CHAR(8)
)
    BEGIN
        DECLARE curCount INT DEFAULT 0;
        DECLARE pcount INT DEFAULT 0;

	-- select statement checks if given athlete is in any of the
	-- participation data. only one join necessary for this part.
        SELECT COUNT(*)
        INTO curCount
        FROM Athlete ath
        JOIN Participate par
        ON ath.athleteCode=par.athleteCode
        WHERE par.discipline=disc AND par.event=eve AND par.athleteCode=acode;    
        SET pcount = pcount + curCount;

	-- select statement checks if given athlete is in any of the
	-- participation data. two joins necessary as going through team
	-- data. Covers scenario of athlete being part of a team that is in
	-- the event provided by the user.
    
        SELECT COUNT(*)
        INTO curCount
        FROM Athlete ath
        JOIN PartOf pao
            ON ath.athleteCode=pao.athleteCode
        JOIN Participate par
            ON pao.teamCode=par.teamCode
        WHERE par.discipline=disc AND par.event=eve AND par.athleteCode=acode;    
	-- two separate sets required after each select statement
        SET pcount = pcount + curCount;

	-- check to see if athlete has participated or not.
        IF pcount > 0 THEN
            SET participation = 'yes';
        ELSE
            SET participation = 'no';            
	END IF;

    END //

DELIMITER ;
