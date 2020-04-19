--entity TimeStampp
CREATE TABLE TimeStampp(
    TimeStampp TimeStamp NOT NULL PRIMARY KEY
);
--entity Title
CREATE TABLE Title (
    title VARCHAR(128) NOT NULL PRIMARY KEY
);
--entity Town
CREATE table Town(
    town VARCHAR(50) NOT NULL PRIMARY KEY
);
--entity Address
CREATE table Address(
    address VARCHAR(128) NOT NULL PRIMARY KEY
);
--entity Accident
CREATE TABLE Accident (
    town VARCHAR(50) NOT NULL REFERENCES Town(town),
    address VARCHAR(128) NOT NULL REFERENCES Address(address),
    TimeStampp TimeStamp NOT NULL REFERENCES TimeStampp(TimeStampp),
    title VARCHAR(50) NOT NULL REFERENCES Title(title),   
    CONSTRAINT PK_accident PRIMARY KEY (town, address, TimeStampp)
    );


