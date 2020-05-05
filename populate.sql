insert into town(town) values('NORRISTOWN');
insert into town(town) values('CONSHOHOCKEN');
insert into town(town) values('BRIDGEPORT');
insert into town(town) values('PERKIOMEN');

insert into TimeStampp(TimeStampp) values(to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
insert into TimeStampp(TimeStampp) values(to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));

insert into title(title) values('Fire: BUILDING FIRE');
insert into title(title) values('EMS: NAUSEA/VOMITING');

insert into Address(address) values('WALNUT ST & E FORNANCE ST');
insert into Address(address) values('FAYETTE ST & E 5TH AVE');
insert into Address(address) values('BORO LINE RD & DEAD END');
insert into Address(address) values('GODSHALL RD & BROOKSIDE RD');

insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','WALNUT ST & E FORNANCE ST',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('GODSHALL RD & BROOKSIDE RD',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','FAYETTE ST & E 5TH AVE',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','BORO LINE RD & DEAD END',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('GODSHALL RD & BROOKSIDE RD',to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','WALNUT ST & E FORNANCE ST',to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');









-------dont do it befote creating table montcoalert911 from csv-------------------------------------------------
delete from montcoalert911 
where addr is null 
    or timestamp is null 
    or title is null 
    or twp is null;
---------------------------------------------------------------------------------

insert into title(title)
select unique(title) from montcoalert911
where ROWNUM<19; --13
--delete from title where exists(select * from title);

insert into Town(town)
select unique(twp) from montcoalert911
where ROWNUM<5; -- there are 4 towns
--delete from town where exists(select * from town);

insert into Address(address)
select            
    unique(addr)
from montcoalert911 join town
    on montcoalert911.twp=town.town 
group by twp, addr;-- 2367
--delete from Address where exists(select * from Address);


-------------------supporting_tables----------------------------
create table twp_addr as(
select
    twp
    ,addr
from montcoalert911 join town
    on montcoalert911.twp=town.town 
join address
    on montcoalert911.addr=address.address
group by twp, addr);
--drop table twp_addr;        

create table twp_addr_title as(
select 
    twp
    ,addr
from montcoalert911 join title
    on montcoalert911.title=title.title
group by twp, addr);
--drop table twp_addr_title;      

create table inter_sect as(
select twp, addr from(
        select * from twp_addr
        INTERSECT
        select * from twp_addr_title));
--drop table inter_sect;  
-------------------supporting_tables----------------------------
insert into timestampp(timestampp)
select unique(timestamp) from montcoalert911
join inter_sect
    on montcoalert911.twp=inter_sect.twp
    and montcoalert911.addr=inter_sect.addr
group by timestamp;
--delete from timestampp where exists(select * from timestampp);
--------------------------------------------------------
REM INSERTING into WORKSHOP2.ACCIDENT
SET DEFINE OFF;
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','WALNUT ST & E FORNANCE ST',to_timestamp('21-DEC-15 04.06.06.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','HAMILTON RD & RED COAT RD',to_timestamp('21-JAN-16 11.32.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: SYNCOPAL EPISODE');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','LAFAYETTE ST & SWEDE ST',to_timestamp('03-FEB-16 11.16.13.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: FALL VICTIM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','HAWS AVE & W MAIN ST',to_timestamp('24-FEB-16 12.29.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','SCHUYLKILL AVE & DEKALB ST',to_timestamp('06-SEP-16 11.41.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: FIRE ALARM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','FAYETTE ST & E 5TH AVE',to_timestamp('08-DEC-16 09.06.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','BASIN ST & VIOLET ST',to_timestamp('03-JAN-17 09.46.14.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','AIRY ST & CHURCH ST',to_timestamp('03-JAN-17 09.50.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','GREEN ST & E OAK ST',to_timestamp('10-JAN-17 06.37.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','CHERRY ST & W ELM ST',to_timestamp('12-JAN-17 11.02.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','PINE ST & W ROBERTS ST',to_timestamp('09-APR-17 10.58.48.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','GODSHALL RD & BROOKSIDE RD',to_timestamp('09-JUL-17 11.04.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: ABDOMINAL PAINS');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','HIGHLAND MANOR DR & DEAD END',to_timestamp('26-OCT-17 09.03.45.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: ABDOMINAL PAINS');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','CHAIN ST & W LAFAYETTE ST',to_timestamp('04-DEC-17 11.52.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','JUNIPER ST & BAILEY ALY',to_timestamp('28-DEC-17 09.44.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','6TH ST & MILL ST',to_timestamp('18-JAN-18 10.01.37.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','DEKALB ST & E LAFAYETTE ST',to_timestamp('18-JAN-18 10.19.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','BUSH ST & OAK ALY',to_timestamp('13-FEB-18 09.21.03.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: CARDIAC EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','FOREST AVE & W AIRY ST',to_timestamp('17-APR-18 11.14.23.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','MAIN ST & ASTOR ST',to_timestamp('21-JUL-18 04.39.10.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: CARDIAC EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','MAPLE AVE & GLENNVIEW LN',to_timestamp('12-AUG-18 10.07.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: RESPIRATORY EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','W LOGAN ST & MARKLEY ST',to_timestamp('22-AUG-18 01.03.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','HAMILTON ST & W MAIN ST',to_timestamp('17-OCT-18 06.26.46.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: FIRE ALARM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','4TH ST & HOLSTEIN ST',to_timestamp('17-OCT-18 06.33.28.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','STANBRIDGE ST & W AIRY ST',to_timestamp('26-NOV-18 11.23.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','8TH AVE & HARRY ST',to_timestamp('08-DEC-18 07.05.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: FALL VICTIM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','GREEN ST & E ELM ST',to_timestamp('13-DEC-18 05.23.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','POWELL ST & E FREEDLEY ST',to_timestamp('28-FEB-19 11.26.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: CARDIAC EMERGENCY');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','GEORGE ST & W OAK ST',to_timestamp('10-APR-19 12.38.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: FIRE ALARM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','BORO LINE RD & DEAD END',to_timestamp('27-APR-19 04.41.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','WALNUT ST & E PENN ST',to_timestamp('12-MAY-19 08.39.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','GEORGE ST & W AIRY ST',to_timestamp('22-MAY-19 09.58.39.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: FIRE ALARM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','E 1ST AVE & HARRY ST',to_timestamp('29-JUN-19 07.56.35.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','BRIDGE ST & GRAVEL PIKE',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','POPLAR ST & MARKLEY ST',to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: FIRE ALARM');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','STANBRIDGE ST & W AIRY ST',to_timestamp('30-JUL-19 04.04.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','E 11TH AVE & FAYETTE ST',to_timestamp('24-NOV-19 09.11.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
Insert into WORKSHOP2.ACCIDENT (TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','FAYETTE ST & W 6TH AVE',to_timestamp('18-JAN-20 11.18.07.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Traffic: VEHICLE ACCIDENT -');
