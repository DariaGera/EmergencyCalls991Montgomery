--select distinct title, ADDR from montcoalert911 where ROWNUM<=50;
--select distinct twp, ADDR, TITLE from montcoalert911 where ROWNUM<=50 order by twp asc;
--select distinct substr(timestamp, 1, 10) as date_acc from montcoalert911 order by date_acc asc;
--select distinct substr(timestamp, 12, 19) as time_acc from montcoalert911 order by time_acc desc;

--insert into DateAcc
INSERT INTO DateAcc(date_acc)
VALUES('2015-12-17');
INSERT INTO DateAcc(date_acc)
VALUES('2016-01-11');
INSERT INTO DateAcc(date_acc)
VALUES('2017-05-19');
INSERT INTO DateAcc(date_acc)
VALUES('2018-08-30');
INSERT INTO DateAcc(date_acc)
VALUES('2019-02-05');

--insert into TimeAcc
INSERT INTO TimeAcc(time_acc)
VALUES('05:49:54');
INSERT INTO TimeAcc(time_acc)
VALUES('14:54:18');
INSERT INTO TimeAcc(time_acc)
VALUES('17:05:28');
INSERT INTO TimeAcc(time_acc)
VALUES('23:05:32');

--insert into Title
INSERT INTO Title(title)
VALUES('DIZZINESS');
INSERT INTO Title(title)
VALUES('VEHICLE ACCIDENT');
INSERT INTO Title(title)
VALUES('CARDIAC EMERGENCY');
INSERT INTO Title(title)
VALUES('HEAD INJURY');

--insert into Town
INSERT INTO Town(town)
VALUES('NORRISTOWN');
INSERT INTO Town(town)
VALUES('PLYMOUTH');

--insert into Address
INSERT INTO Address(address)
VALUES('SWEDE ST');
INSERT INTO Address(address)
VALUES('HAWS AVE');
INSERT INTO Address(address)
VALUES('PENN ST');
INSERT INTO Address(address)
VALUES('BROOK RD');
INSERT INTO Address(address)
VALUES('SPARANGO LN');

--insert into TimeStampp
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('14:54:18', '2016-01-11', 1);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('05:49:54', '2017-05-19', 2);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('17:05:28', '2015-12-17', 3);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('23:05:32', '2018-08-30', 4);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('17:05:28', '2019-02-05', 5);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('05:49:54', '2019-02-05', 6);
INSERT INTO TimeStampp(time_acc, date_acc, TimeStamp_id)
VALUES('05:49:54', '2016-01-11', 7);

--insert into Address_acc
INSERT INTO Address_acc(address, town, address_id)
VALUES('SWEDE ST', 'NORRISTOWN', 1);
INSERT INTO Address_acc(address, town, address_id)
VALUES('HAWS AVE', 'NORRISTOWN', 2);
INSERT INTO Address_acc(address, town, address_id)
VALUES('PENN ST', 'NORRISTOWN', 3);
INSERT INTO Address_acc(address, town, address_id)
VALUES('BROOK RD', 'PLYMOUTH', 4);
INSERT INTO Address_acc(address, town, address_id)
VALUES('SPARANGO LN', 'PLYMOUTH', 5);

--insert into Accident
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'VEHICLE ACCIDENT', 1);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'VEHICLE ACCIDENT', 4);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(3, 'VEHICLE ACCIDENT', 3);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(3, 'VEHICLE ACCIDENT', 1);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'VEHICLE ACCIDENT', 3);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'DIZZINESS', 5);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(3, 'DIZZINESS', 3);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'DIZZINESS', 2);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(2, 'CARDIAC EMERGENCY', 2);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(5, 'CARDIAC EMERGENCY', 1);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(5, 'CARDIAC EMERGENCY', 7);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(3, 'CARDIAC EMERGENCY', 1);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(1, 'HEAD INJURY', 1);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(2, 'HEAD INJURY', 4);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(4, 'HEAD INJURY', 4);
INSERT INTO Accident(address_id, title, TimeStamp_id)
VALUES(3, 'HEAD INJURY', 5);
