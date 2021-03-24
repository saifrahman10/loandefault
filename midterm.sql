set global local_infile = 1;

-- CREATE DATABASE

DROP DATABASE IF EXISTS bank;
CREATE DATABASE IF NOT EXISTS bank;

use bank;

-- CREATE ACCOUNT TABLE
drop table if exists account;

CREATE TABLE account (
    account_id INT,
    district_id INT,
    frequency VARCHAR(40),
    date DATE,
    primary key (account_id)
);

truncate account;

load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/account.asc'
into table account
character set UTF8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from account;

-- CREATE CLIENT TABLE

drop table if exists client;

CREATE TABLE client (
    client_id INT,
    gender varchar(30),
    district_id INT,
    primary key (client_id)
);

truncate client;

load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/client.asc'
into table client
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

alter table client
add birth_date date;

update client
set
birth_date = convert(CONCAT('19',CASE
    WHEN convert(substr(gender,3,2),decimal) > 50 then
        concat(substr(gender,1,2),
            case when convert(substr(gender,3,2),decimal)-50 < 10 then concat('0',convert(substr(gender,3,2),decimal)-50)
                else convert(substr(gender,3,2),decimal)-50
                end,
            substr(gender,5,2))
    else gender
    end),date),
gender = (CASE when convert(substr(gender,3,2),decimal) > 50 then 'female' else 'male' end);

select * from client;

-- CREATE DISPOSITION TABLE

CREATE table disp (
    disp_id INT,
    client_id INT,
    account_id INT,
    type varchar(40),
    primary key (disp_id)
);

truncate disp;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/disp.asc'
into table disp
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from disp;

-- CREATE ORDER TABLE

drop table if exists orders;

CREATE table orders (
    order_id INT,
    account_id INT,
    bank_to VARCHAR(40),
    account_to INT,
    amount DECIMAL,
    ksymbol VARCHAR(30),
    primary key (order_id)
);

truncate orders;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/order.asc'
into table orders
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from orders;

-- CREATE TRANSACTION TABLE

drop table if exists trans;

CREATE table trans (
    trans_id INT,
    account_id INT,
    date DATE,
    type varchar(40),
    operation varchar(40),
    amount INT,
    balance INT,
    ksymbol VARCHAR(30),
    bank VARCHAR(40),
    account INT,
    primary key (trans_id)
);

truncate trans;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/trans.asc'
into table trans
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from trans;

-- CREATE LOAN TABLE

drop table if exists loan;

CREATE table loan (
    loan_id INT,
    account_id INT,
    date DATE,
    amount INT,
    duration INT,
    payments decimal,
    status VARCHAR(30),
    primary key (loan_id)
);

truncate loan;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/loan.asc'
into table loan
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from loan;

-- CREATE CARD TABLE

drop table if exists card;

CREATE table card (
    card_id INT,
    disp_id INT,
    type varchar(40),
    issued date,
    primary key (card_id)
);

truncate card;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/card.asc'
into table card
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from card;

-- CREATE DISTRICT TABLE

drop table if exists district;

CREATE table district (
    district_id int,
    A2 varchar(30),
    A3 varchar(30),
    A4 INT,
    A5 INT,
    A6 INT,
    A7 INT,
    A8 INT,
    A9 INT,
    A10 DECIMAL,
    A11 INT,
    A12 DECIMAL,
    A13 DECIMAL,
    A14 INT,
    A15 INT,
    A16 INT,
    primary key (district_id)
);

truncate district;
load data local infile '/Users/saifrahman/Documents/WeCloudData/Week_6/bank_loan/district.asc'
into table district
character set utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
