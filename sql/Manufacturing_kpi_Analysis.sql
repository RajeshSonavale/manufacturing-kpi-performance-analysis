CREATE DATABASE Manufacturing_KPI_Analysis ;
USE Manufacturing_KPI_Analysis;

CREATE TABLE manufacturing_data (
    Date DATE,
    Machine_ID VARCHAR(10),
    Shift VARCHAR(5),
    Plant_Location VARCHAR(20),
    Downtime_Reason VARCHAR(50),

    Planned_Production_Time FLOAT,
    Downtime FLOAT,
    Operating_Time FLOAT,
    Ideal_Cycle_Time FLOAT,

    Total_Production FLOAT,
    Defective_Production FLOAT,
    Good_Production FLOAT,

    Availability FLOAT,
    Performance FLOAT,
    Quality FLOAT,
    OEE FLOAT
);


SELECT COUNT(*) FROM Manufacturing_data;

SELECT * FROM manufacturing_data LIMIT 5;

# Data Insights

SELECT 
    AVG(Availability) AS avg_availability,
    AVG(Performance) AS avg_performance,
    AVG(Quality) AS avg_quality,
    AVG(OEE) AS avg_oee
FROM manufacturing_data;


# Machine Wise Analysis
SELECT 
    Machine_ID,
    AVG(Availability) AS availability,
    AVG(Performance) AS performance,
    AVG(Quality) AS quality,
    AVG(OEE) AS oee
FROM manufacturing_data
GROUP BY Machine_ID
ORDER BY oee DESC;


# Root Cause Analysis
SELECT 
    Machine_ID,
    AVG(Availability),
    AVG(Performance),
    AVG(Quality)
FROM manufacturing_data
GROUP BY Machine_ID;

# Downtime reason analysis
SELECT 
    Downtime_Reason,
    AVG(Downtime) AS avg_downtime
FROM manufacturing_data
GROUP BY Downtime_Reason
ORDER BY avg_downtime DESC;

# Shift Wise Performace Analysis
SELECT 
    Shift,
    AVG(OEE) AS avg_oee
FROM manufacturing_data
GROUP BY Shift
ORDER BY avg_oee DESC;

# Creating Star Schema

# Create Dimension Table
CREATE TABLE dim_machine (
    Machine_ID VARCHAR(10) PRIMARY KEY,
    Machine_Type VARCHAR(50)
);

INSERT INTO dim_machine VALUES
('M1','High Downtime Machine'),
('M2','High Defect Machine'),
('M3','Low Performance Machine'),
('M4','Best Machine');

# create Dim Shift 
CREATE TABLE dim_shift (
    Shift VARCHAR(5) PRIMARY KEY,
    Shift_Name VARCHAR(50)
);

INSERT INTO dim_shift VALUES
('A','Morning'),
('B','Afternoon'),
('C','Night');

# Create Dim Downtime
CREATE TABLE dim_downtime (
    Downtime_Reason VARCHAR(50) PRIMARY KEY,
    Category VARCHAR(50)
);

INSERT INTO dim_downtime VALUES
('Breakdown','Unplanned'),
('Maintenance','Planned'),
('Setup','Planned'),
('Power Failure','Unplanned');

# Create Dim Location 
CREATE TABLE dim_location (
    Plant_Location VARCHAR(50) PRIMARY KEY,
    Region VARCHAR(50)
);
INSERT INTO dim_location VALUES
('Mumbai','West'),
('Pune','West'),
('Chennai','South');

# Create Dim Data
CREATE TABLE dim_date (
    Date DATE PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT,
    Quarter INT
);

INSERT INTO dim_date
SELECT DISTINCT 
    Date,
    YEAR(Date),
    MONTH(Date),
    DAY(Date),
    QUARTER(Date)
FROM manufacturing_data;

# Create the Fact Table

CREATE TABLE fact_production AS
SELECT 
    Date,
    Machine_ID,
    Shift,
    Plant_Location,
    Downtime_Reason,

    Planned_Production_Time,
    Downtime,
    Operating_Time,
    Total_Production,
    Defective_Production,
    Good_Production,

    Availability,
    Performance,
    Quality,
    OEE
FROM manufacturing_data;


#  Add Forgien key relationships 
ALTER TABLE fact_production
ADD CONSTRAINT fk_machine
FOREIGN KEY (Machine_ID)
REFERENCES dim_machine(Machine_ID);

ALTER TABLE fact_production
ADD CONSTRAINT fk_downtime
FOREIGN KEY (Downtime_Reason)
REFERENCES dim_downtime(Downtime_Reason);

ALTER TABLE fact_production
ADD CONSTRAINT fk_location
FOREIGN KEY (Plant_Location)
REFERENCES dim_location(Plant_Location);

ALTER TABLE fact_production
ADD CONSTRAINT fk_date
FOREIGN KEY (Date)
REFERENCES dim_date(Date);


# Check join
SELECT 
    m.Machine_Type,
    AVG(f.OEE) AS avg_oee
FROM fact_production f
JOIN dim_machine m 
    ON f.Machine_ID = m.Machine_ID
GROUP BY m.Machine_Type
ORDER BY avg_oee DESC;
