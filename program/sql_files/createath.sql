-- creating table logic
DROP TABLE IF EXISTS Athlete;
CREATE TABLE Athlete (
    athleteCode VARCHAR(7)      NOT NULL,
    name VARCHAR(50)            NOT NULL,
    gender CHAR(8)                      ,
    countryCode VARCHAR(3)      NOT NULL,
    PRIMARY KEY (athleteCode),
    FOREIGN KEY (countryCode) REFERENCES Country(countryCode) ON DELETE CASCADE ON UPDATE CASCADE
);
