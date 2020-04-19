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
--entity Address_acc
CREATE TABLE Address_acc (
    address VARCHAR(128) NOT NULL REFERENCES Address(address),
    town VARCHAR(50) NOT NULL REFERENCES Town(town),
    address_id INT NOT NULL UNIQUE,
    CONSTRAINT PK_address_acc PRIMARY KEY (address, town, address_id)
    );
--entity Accident
CREATE TABLE Accident (
    address_id INT NOT NULL REFERENCES Address_acc(address_id),
    title VARCHAR(50) NOT NULL REFERENCES Title(title),
    TimeStampp TimeStamp NOT NULL REFERENCES TimeStampp(TimeStampp),
    CONSTRAINT PK_accident PRIMARY KEY (address_id, title, TimeStampp)
    );


