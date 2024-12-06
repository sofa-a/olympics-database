/* needed to add foreign keys separately. For the PartOf table it had no 
 	reason why it was acting up but for Particpate, there was some
	athelete codes that got through that needed to be removed before
	the foreign keys could be added. */

DELETE FROM PartOf 
WHERE athleteCode NOT IN(SELECT athleteCode FROM Athlete);

ALTER TABLE PartOf 
ADD CONSTRAINT fk_pao_teamCode 
FOREIGN KEY (teamCode) REFERENCES Team(teamCode)
ON DELETE CASCADE;

ALTER TABLE PartOf 
ADD CONSTRAINT fk_pao_athleteCode 
FOREIGN KEY (athleteCode) REFERENCES Athlete(athleteCode)
ON DELETE CASCADE;

DELETE FROM Participate 
WHERE athleteCode NOT IN(SELECT athleteCode FROM Athlete);

ALTER TABLE Participate 
ADD CONSTRAINT fk_par_teamCode 
FOREIGN KEY (teamCode) REFERENCES Team(teamCode)
ON DELETE CASCADE;

ALTER TABLE Participate 
ADD CONSTRAINT fk_par_athleteCode 
FOREIGN KEY (athleteCode) REFERENCES Athlete(athleteCode)
ON DELETE CASCADE;
