DELIMITER //
DROP PROCEDURE IF EXISTS count_phases;
CREATE PROCEDURE count_phases(
    OUT pcount INT
)
    BEGIN
        DECLARE done INT DEFAULT 0;
        DECLARE eve CHAR(50);
        DECLARE disc CHAR(50);
        DECLARE cur CURSOR FOR SELECT event, discipline FROM Event;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        SET pcount = 0;

        OPEN cur;
		
	-- cursor to loop through all distinct events
 
        read_loop: LOOP
            FETCH cur INTO eve, disc;
	    -- info put into the variables eve and disc
            IF done THEN
                LEAVE read_loop;
		-- leave loop if no more data to iterate over
            END IF;

	    -- counts distinct phases (phase is duplicated in data at 
		-- different times - to determine final winners
            SELECT COUNT(DISTINCT phase) 
            INTO @curCount
            FROM Location
            WHERE event = eve AND discipline = disc;
	    -- if event and discipline match what's in cursor add one to count

	    SET pcount = pcount + @curCount;
	    -- add count from select statement into pcount every loop
        END LOOP;
        CLOSE cur;
    END //
DELIMITER ;
