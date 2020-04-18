--select substr(timestamp, 1, 10) as date_acc from montcoalert911;
--entity DateAcc
CREATE TABLE DateAcc(
date_acc VARCHAR(50) NOT NULL PRIMARY KEY
);

--select substr(timestamp, 12, 19) as time_acc from montcoalert911;
--entity TimeAcc
CREATE TABLE TimeAcc(
time_acc VARCHAR(50) NOT NULL PRIMARY KEY
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

--entity TimeStampp
CREATE TABLE TimeStampp (
    time_acc VARCHAR(50) NOT NULL REFERENCES TimeAcc(time_acc),
    date_acc VARCHAR(50) NOT NULL REFERENCES DateAcc(date_acc),
    TimeStamp_id INT NOT NULL UNIQUE,
    CONSTRAINT PK_timestamp PRIMARY KEY (time_acc, date_acc, TimeStamp_id)
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
    address_id INT NOT NULL UNIQUE REFERENCES Address_acc(address_id),
    title VARCHAR(50) NOT NULL REFERENCES Title(title),
    TimeStamp_id INT NOT NULL UNIQUE REFERENCES TimeStampp(TimeStamp_id),
    CONSTRAINT PK_accident PRIMARY KEY (address_id, title, TimeStamp_id)
    );


