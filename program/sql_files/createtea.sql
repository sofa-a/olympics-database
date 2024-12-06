DROP TABLE IF EXISTS Team;
CREATE TABLE Team (
    teamCode VARCHAR(17)    NOT NULL,
    countryCode VARCHAR(3)  NOT NULL,
    noAthletes SMALLINT             ,
    PRIMARY KEY (teamCode),
    FOREIGN KEY (countryCode) REFERENCES Country(countryCode) ON DELETE CASCADE ON UPDATE CASCADE
);
