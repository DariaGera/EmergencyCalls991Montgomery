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
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','GODSHALL RD & BROOKSIDE RD',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('CONSHOHOCKEN','FAYETTE ST & E 5TH AVE',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('BRIDGEPORT','BORO LINE RD & DEAD END',to_timestamp('10-JUL-19 08.46.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('PERKIOMEN','GODSHALL RD & BROOKSIDE RD',to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'EMS: NAUSEA/VOMITING');
insert into accident(TOWN,ADDRESS,TIMESTAMPP,TITLE) values ('NORRISTOWN','WALNUT ST & E FORNANCE ST',to_timestamp('25-JUL-19 03.17.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'Fire: BUILDING FIRE');
