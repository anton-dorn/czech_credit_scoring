USE czech_bank;

-- SELECT date, STR_TO_DATE (date, '%y%m%d') FROM account;

ALTER TABLE account ADD column date_clean DATE;

-- SELECT * FROM account;

UPDATE account
SET date_clean = STR_TO_DATE(date, '%y%m%d');

-- SELECT * FROM account;

ALTER TABLE account ADD column frequency_en VARCHAR(255);

-- SELECT * FROM account;

UPDATE account
SET frequency_en = CASE
	WHEN frequency = 'POPLATEK MESICNE' THEN 'monthly issuance'
    WHEN frequency = 'POPLATEK TYDNE' THEN 'weekly issuance'
	WHEN frequency = 'POPLATEK PO OBRATU' THEN 'issuance after transaction'
END;

-- SELECT * FROM account;

-- SELECT * FROM card;

ALTER TABLE card ADD column issued_clean DATE;

-- SELECT issued, STR_TO_DATE (issued, '%y%m%d') FROM card;

UPDATE card
SET issued_clean = STR_TO_DATE (issued, '%y%m%d %H:%i:%s');

-- SELECT * FROM card;

-- SELECT * FROM client;

ALTER TABLE client ADD COLUMN gender VARCHAR(10);

UPDATE client
SET gender = CASE
	WHEN SUBSTRING(birth_number, 3 , 2) > 50 THEN 'female'
    ELSE 'male'
END;

ALTER TABLE client ADD COLUMN birth_date date;

UPDATE client
SET birth_date = CASE
	WHEN gender = 'female' THEN STR_TO_DATE(birth_number - 5000, '%y%m%d')
    ELSE STR_TO_DATE(birth_number, '%y%m%d')
END;

UPDATE client
SET birth_date = DATE_SUB(birth_date, INTERVAL 100 YEAR)
WHERE birth_date > '1999-12-31';

SELECT * FROM loan;

ALTER TABLE loan ADD COLUMN date_clean DATE;

UPDATE loan
SET date_clean = STR_TO_DATE(date, '%y%m%d');

ALTER TABLE loan ADD COLUMN result VARCHAR(5);

UPDATE loan
SET result = CASE
	WHEN status IN ('A', 'C') THEN 'pass'
    WHEN status IN ('B', 'D') THEN 'fail'
END;

SELECT * FROM district;

ALTER TABLE district
ADD COLUMN district_id INT,
ADD COLUMN name VARCHAR(255),
ADD COLUMN region VARCHAR (255),
ADD COLUMN inhabitants INT,
ADD COLUMN muni_0_499 INT,
ADD COLUMN muni_500_1999 INT,
ADD COLUMN muni_2000_9999 INT,
ADD COLUMN muni_10k_plus INT,
ADD COLUMN no_cities INT,
ADD COLUMN urban_ratio DOUBLE,
ADD COLUMN avg_salary INT,
ADD COLUMN unemp_1995 DOUBLE,
ADD COLUMN unemp_1996 DOUBLE,
ADD COLUMN entr_per_1k INT,
ADD COLUMN crimes_1995 INT,
ADD COLUMN crimes_1996 INT;

UPDATE district
SET district_id = A1,
	name = A2,
	region = A3,
	inhabitants = A4,
	muni_0_499 = A5,
	muni_500_1999 = A6,
	muni_2000_9999 = A7,
	muni_10k_plus = A8,
	no_cities = A9,
	urban_ratio = A10,
	avg_salary = A11,
	unemp_1995 = A12,
	unemp_1996 = A13,
	entr_per_1k = A14,
	crimes_1995 = A15,
	crimes_1996 = A16;

SELECT * FROM `order`;

ALTER TABLE `order` ADD COLUMN purpose VARCHAR(10);

UPDATE `order`
SET purpose = CASE
	WHEN k_symbol = 'SIPO' THEN 'household'
    WHEN k_symbol = 'UVER' THEN 'loan'
    WHEN k_symbol = 'LEASING' THEN 'leasing'
    WHEN k_symbol = 'POJISTNE' THEN 'insurance'
END;

SELECT * FROM trans;

ALTER TABLE trans
	ADD COLUMN date_clean date,
    ADD COLUMN type_en VARCHAR(20),
    ADD COLUMN operation_en VARCHAR(50),
    ADD COLUMN purpose VARCHAR(50);
    
UPDATE trans
	SET date_clean = STR_TO_DATE(date, '%y%m%d');
    
UPDATE trans
	SET type_en = CASE
		WHEN type = 'PRIJEM' THEN 'inflow'
        WHEN type = 'VYDAJ' THEN 'outflow'
	END;
    
UPDATE trans
SET operation_en = CASE
		WHEN operation = 'VYBER KARTOU' THEN 'cash atm'
        WHEN operation IN ('VKLAD', 'VYBER') THEN 'cash'
        WHEN operation IN ('PREVOD Z UCTU', 'PREVOD NA UCET') THEN 'bank transfer'
END;

UPDATE trans
SET purpose = CASE
	WHEN k_symbol = 'SIPO' THEN 'household'
    WHEN k_symbol = 'UVER' THEN 'loan'
    WHEN k_symbol = 'POJISTNE' THEN 'insurance'
    WHEN k_symbol = 'SLUZBY' THEN 'bank fee'
    WHEN k_symbol = 'UROK' THEN 'interest'
    WHEN k_symbol = 'SANKC. UROK' THEN 'sanction interest'
    WHEN k_symbol = 'DUCHOD' THEN 'pension'
END;
