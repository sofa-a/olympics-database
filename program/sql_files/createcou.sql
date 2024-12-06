-- creating table logic
DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
    countryCode VARCHAR(3)      NOT NULL, --code of the country
    name VARCHAR(50)            NOT NULL,
    PRIMARY KEY (countryCode)
);
