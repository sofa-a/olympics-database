DROP TABLE IF EXISTS Venue;
CREATE TABLE Venue (
    venue VARCHAR(50)                ,
    venueCode VARCHAR(3)     NOT NULL,
    PRIMARY KEY (venueCode)
);
