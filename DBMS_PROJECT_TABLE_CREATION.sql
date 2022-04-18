CREATE DATABASE IF NOT EXISTS T4_Car_Insurance_DB;

USE T4_Car_Insurance_DB;

CREATE TABLE IF NOT EXISTS T4_Customer
(
	CUST_ID VARCHAR(20) PRIMARY KEY,
    CUST_FNAME VARCHAR(10),
    CUST_LNAME VARCHAR(10),
    CUST_DOB DATE,
    CUST_GENDER VARCHAR(2),
    CUST_ADDRESS VARCHAR(20),
    CUST_MOB_NUMBER INT,
    CUST_EMAIL VARCHAR(20),
    CUST_PASSPORT_NUMBER VARCHAR(20),
    CUST_MARITAL_STATUS VARCHAR(8),
    CUST_PPS_NUMBER INT
);

CREATE TABLE IF NOT EXISTS T4_Application
(
	APPLICATION_ID VARCHAR(20) PRIMARY KEY,
    CUST_ID VARCHAR(20),
    VEHICLE_ID VARCHAR(20), -- ADD THE FOREIGN KEY FOR THIS LATER ----------
    APPLICATION_STATUS VARCHAR(8),
    COVERAGE VARCHAR(50),
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID)
);

CREATE TABLE IF NOT EXISTS T4_Quote
(
	QUOTE_ID VARCHAR(20) PRIMARY KEY,
    APPLICATION_ID VARCHAR(20),
    CUST_ID VARCHAR(20),
    ISSUE_DATE DATE,
    VALID_FROM_DATE DATE,
    VALID_TILL_DATE DATE,
    DESCRIPTION VARCHAR(100),
    PRODUCT_ID VARCHAR(20), -- ADD FOREGN KEY FOR THIS LATER ----------
    COVERAGE_LEVEL VARCHAR(20),
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID),
    FOREIGN KEY (APPLICATION_ID) REFERENCES T4_Application(APPLICATION_ID)
);

CREATE TABLE IF NOT EXISTS T4_Premium_Payment
(
	PREMIUM_PAYMENT_ID VARCHAR(20) PRIMARY KEY,
    CUST_ID VARCHAR(20),
    POLICY_NUMBER VARCHAR(20), 
    PREMIUM_PAYMENT_SCHEDULE DATE,
    PREMIUM_PAYMENT_AMOUNT INT,
    RECEIPT_ID VARCHAR(20), -- foreign key to receipt, add later ---------
    
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID)
);

CREATE TABLE IF NOT EXISTS T4_Claim
(
	CLAIM_ID VARCHAR(20) PRIMARY KEY,
    CUST_ID VARCHAR(20),
    AGREEMENT_ID VARCHAR(20), -- ADD THE FOREGN KEY FOR THIS LATER ------------
    CLAIM_AMOUNT INT,
    INCIDENT_ID VARCHAR(20), -- ADD THE FOREIGN KEY FOR THIS LATER -------------
    DAMAGE_TYPE VARCHAR(20),
    DATE_OF_CLAIM DATE,
    CLAIM_STATUS VARCHAR(10),
    
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID)
);

CREATE TABLE IF NOT EXISTS T4_Claim_Settlement
(
	CLAIM_SETTLEMENT_ID VARCHAR(20) PRIMARY KEY,
    CLAIM_ID VARCHAR(20),
    CUST_ID VARCHAR(20),
    VEHICLE_ID VARCHAR(20), -- ADD FOREIGN KEY FOR THIS LATER ----------
    DATE_SETTLED DATE,
    AMOUNT_PAID INT,
    COVERAGE_ID VARCHAR(20),
    
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID),
    FOREIGN KEY (CLAIM_ID) REFERENCES T4_Claim(CLAIM_ID)
);

CREATE TABLE IF NOT EXISTS T4_Coverage
(
	COVERAGE_ID VARCHAR(20) PRIMARY KEY,
    COMPANY_NAME VARCHAR(20),
    COVERAGE_AMOUNT INT,
    COVERAGE_TYPE VARCHAR(10),
    COVERAGE_LEVEL VARCHAR(15),
    PRODUCT_ID VARCHAR(20), -- ADD FOREIGN KEY FOR THIS LATER --------
	COVERAGE_DESCRIPTION VARCHAR(100),
    COVERAGE_TERMS VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS T4_Insurance_policy (
    Agreement_id VARCHAR(20) PRIMARY KEY,
    Application_id VARCHAR(20), -- ADDING FOREIGN KEY -------
    Cust_id VARCHAR(20), -- ADDING FOREIGN KEY --------
    Department_name VARCHAR(20), -- ADDING FOREIGN KEY --------
    Policy_number VARCHAR(20),
    Start_date DATE,
    Expiry_date DATE,
    Term_condition_description VARCHAR(100)
);




CREATE TABLE IF NOT EXISTS T4_Vehicle (
    Vehicle_id VARCHAR(20) PRIMARY KEY,
    Cust_id VARCHAR(20), -- FOREIGN KEY ------
    Policy_id VARCHAR(20),
    Dependent_nok_id VARCHAR(20), -- FOREIGN KEY , HAD TO CREATE NEXT OF KIN TABLE -------
    Vehicle_registration_number VARCHAR(20),
    Vehicle_value INT,
    Vehicle_type VARCHAR(20),
    Vehicle_size INT,
    Vehicle_number_of_seat INT,
    Vehicle_manufacturer VARCHAR(20),
    Vehicle_engine_number INT,
    Vehicle_chasis_number INT,
    Vehicle_number VARCHAR(20),
    Vehicle_model_number VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS T4_Department (
    Department_name VARCHAR(20) PRIMARY KEY,
    Company_name VARCHAR(20), -- FOREIGN KEY ------
    Office VARCHAR(20), -- FOREIGN KEY -------
    Contact_information VARCHAR(20),
    Department_staff VARCHAR(50),
    Department_leader VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS T4_Office (
    Office_name VARCHAR(20) PRIMARY KEY,
    Department_name VARCHAR(20), -- FOREIGN KEY ------
    Company_name VARCHAR(20), -- FOREIGN KEY ------
    Office_leader VARCHAR(20),
    Contact_information VARCHAR(20),
    Address VARCHAR(20),
    Admin_cost INT,
    Staff VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS T4_Vehicle_service (
    Vehicle_service VARCHAR(20) PRIMARY KEY,
    Vehicle_id VARCHAR(20), -- FOREIGN KEY ----
    Cust_id VARCHAR(20), -- FOREIGN KEY ----
    Department_name CHAR(20), -- FOREIGN KEY -----
    Vehicle_service_address VARCHAR(20),
    Vehicle_service_contact VARCHAR(20),
    Vehicle_service_incharge CHAR(20),
    Vehicle_service_type VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS T4_Product (
    Product_number VARCHAR(20) PRIMARY KEY,
    Company_name VARCHAR(20), -- FOREIGN KEY -----
    Product_price INT,
    Product_type CHAR(15)
);

CREATE TABLE IF NOT EXISTS T4_Insurance_company (
    Company_name VARCHAR(20) PRIMARY KEY,
    Company_address VARCHAR(20),
    Company_contact_number INT,
    Company_fax INT,
    Company_email VARCHAR(20),
    Company_website VARCHAR(20),
    Company_location VARCHAR(20),
    Company_department_name VARCHAR(20),
    Company_office_name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS T4_Receipt
(
	RECEIPT_ID VARCHAR(20) PRIMARY KEY,
    PREMIUM_PAYMENT_ID VARCHAR(20),
    CUST_ID VARCHAR(20),
    COST INT,
    TIME DATE,
    
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID),
    FOREIGN KEY (PREMIUM_PAYMENT_ID) REFERENCES T4_Premium_Payment(PREMIUM_PAYMENT_ID)
);

CREATE TABLE IF NOT EXISTS T4_Insurance_Policy_Coverage
(
	AGREEMENT_ID VARCHAR(20) PRIMARY KEY,
    COVERAGE_ID VARCHAR(20),
    
    FOREIGN KEY (COVERAGE_ID) REFERENCES T4_Coverage(COVERAGE_ID)
);

CREATE TABLE IF NOT EXISTS T4_Incident
(
	INCIDENT_ID VARCHAR(20) PRIMARY KEY,
    INCIDENT_TYPE VARCHAR(30),
    INCIDENT_DATE DATE,
	DESCRIPTION VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS T4_Incident_Report
(
	INCIDENT_REPORT_ID VARCHAR(20) PRIMARY KEY,
    INCIDENT_ID VARCHAR(20),
    CUST_ID VARCHAR(20),
    INCIDENT_INSPECTOR VARCHAR(20),
    INCIDENT_COST INT,
    INCIDENT_TYPE VARCHAR(10),
    INCIDENT_REPORT_DESCRIPTION VARCHAR(100),
    
    FOREIGN KEY (INCIDENT_ID) REFERENCES T4_Incident(INCIDENT_ID),
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID)
);

CREATE TABLE IF NOT EXISTS T4_NOK
(
	NOK_ID VARCHAR(20) PRIMARY KEY,
    AGREEMENT_ID VARCHAR(20),
    CUST_ID VARCHAR(20),
    NOK_NAME VARCHAR(20),
    NOK_ADDRESS VARCHAR(20),
    NOK_PHONE_NUMBER INT,
    NOK_MARITAL_STATUS VARCHAR(8),
    NOK_GENDER VARCHAR(2),
    
    FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID),
    FOREIGN KEY (AGREEMENT_ID) REFERENCES T4_Insurance_Policy(AGREEMENT_ID)
);

ALTER TABLE T4_Application
ADD FOREIGN KEY (VEHICLE_ID) REFERENCES T4_Vehicle(VEHICLE_ID);

ALTER TABLE T4_Quote
ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T4_Product(Product_Number);

ALTER TABLE T4_Premium_Payment
ADD FOREIGN KEY (RECEIPT_ID) REFERENCES T4_Receipt(RECEIPT_ID);

ALTER TABLE T4_Claim
ADD FOREIGN KEY (AGREEMENT_ID) REFERENCES T4_Insurance_Policy(AGREEMENT_ID); 

ALTER TABLE T4_Claim
ADD FOREIGN KEY (INCIDENT_ID) REFERENCES T4_Incident(INCIDENT_ID);

ALTER TABLE T4_CLaim_Settlement
ADD FOREIGN KEY (VEHICLE_ID) REFERENCES T4_Vehicle(VEHICLE_ID);

ALTER TABLE T4_Insurance_Policy
ADD FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID);

ALTER TABLE T4_Insurance_Policy
ADD FOREIGN KEY (DEPARTMENT_NAME) REFERENCES T4_Department(DEPARTMENT_NAME);

ALTER TABLE T4_Insurance_Policy_Coverage
ADD FOREIGN KEY (AGREEMENT_ID) REFERENCES T4_Insurance_Policy(AGREEMENT_ID);

ALTER TABLE T4_Vehicle
ADD FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID);

ALTER TABLE T4_Vehicle
ADD FOREIGN KEY (DEPENDENT_NOK_ID) REFERENCES T4_NOK(NOK_ID);

ALTER TABLE T4_Department
ADD FOREIGN KEY (COMPANY_NAME) REFERENCES T4_Insurance_Company(COMPANY_NAME);

ALTER TABLE T4_Department
ADD FOREIGN KEY (OFFICE) REFERENCES T4_Office(OFFICE_NAME);

ALTER TABLE T4_Office
ADD FOREIGN KEY (DEPARTMENT_NAME) REFERENCES T4_Department(DEPARTMENT_NAME);

ALTER TABLE T4_Office
ADD FOREIGN KEY (COMPANY_NAME) REFERENCES T4_Insurance_Company(COMPANY_NAME);

ALTER TABLE T4_Vehicle_Service
ADD FOREIGN KEY (CUST_ID) REFERENCES T4_Customer(CUST_ID);

ALTER TABLE T4_Vehicle_Service
ADD FOREIGN KEY (DEPARTMENT_NAME) REFERENCES T4_Department(DEPARTMENT_NAME);

ALTER TABLE T4_Vehicle_Service
ADD FOREIGN KEY (VEHICLE_ID) REFERENCES T4_Vehicle(VEHICLE_ID);

ALTER TABLE T4_Product
ADD FOREIGN KEY (COMPANY_NAME) REFERENCES T4_Insurance_Company(COMPANY_NAME);









