CREATE DATABASE czech_bank;

USE czech_bank;

CREATE TABLE account (
	account_id INT PRIMARY KEY,
    district_id INT,
    frequency VARCHAR (255),
    date INT
);

CREATE TABLE card (
	card_id INT PRIMARY KEY,
    disp_id int,
    type VARCHAR (255),
    issued VARCHAR (255)
);

CREATE TABLE client (
	client_id INT PRIMARY KEY,
    birth_number INT,
    district_id INT
);

CREATE TABLE disp (
	disp_id INT PRIMARY KEY,
    client_id INT,
    account_id INT,
    type VARCHAR (255)
);

CREATE TABLE district (
	A1 INT PRIMARY KEY,
    A2 VARCHAR (255),
    A3 VARCHAR (255),
    A4 INT,
    A5 INT,
    A6 INT,
    A7 INT,
    A8 INT,
    A9 INT,
    A10 DOUBLE,
    A11 INT,
    A12 DOUBLE,
    A13 DOUBLE,
    A14 INT,
    A15 INT,
    A16 INT
);

CREATE TABLE loan (
	loan_id INT PRIMARY KEY,
    account_id INT,
    date INT,
    amount INT,
    duration INT,
    payments DOUBLE,
    status VARCHAR (1)
);

CREATE TABLE `order` (
	order_id INT PRIMARY KEY,
    account_id INT,
    bank_to VARCHAR (255),
    account_to INT,
    amount DOUBLE,
    k_symbol VARCHAR (255)
);

CREATE TABLE trans (
	trans_id INT PRIMARY KEY,
	account_id INT,
    date INT,
    type VARCHAR (255),
    operation VARCHAR (255),
    amount DOUBLE,
    balance DOUBLE,
    k_symbol VARCHAR (255),
    bank VARCHAR (255),
    account VARCHAR (255)
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/account.csv'
INTO TABLE account
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/card.csv'
INTO TABLE card
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/client.csv'
INTO TABLE client
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/disp.csv'
INTO TABLE disp
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/district.csv'
INTO TABLE district
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/loan.csv'
INTO TABLE loan
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/order.csv'
INTO TABLE `order`
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/anton/OneDrive/Desktop/czech_bank/trans.csv'
INTO TABLE trans
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;