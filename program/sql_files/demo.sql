INSERT INTO Athlete VALUES ('5000000', 'SMITH John', 'Male', 'AUS');
SELECT * FROM Athlete WHERE athleteCode='5000000';

UPDATE Athlete SET name='SMALL John' WHERE athleteCode='5000000';
SELECT * FROM Athlete WHERE athleteCode='5000000';

DELETE FROM Athlete WHERE athleteCode='5000000';
SELECT * FROM Athlete WHERE athleteCode='5000000';
