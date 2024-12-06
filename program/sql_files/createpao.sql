DROP TABLE IF EXISTS PartOf;
CREATE TABLE PartOf (
    teamCode VARCHAR(17)       NOT NULL,
    athleteCode VARCHAR(50)    NOT NULL,
    PRIMARY KEY(teamCode, athleteCode)
);
