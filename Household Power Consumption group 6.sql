CREATE TABLE electric_consumption (
Date DATE,
Time TIME,
Global_active_power FLOAT,
Global_reactive_power FLOAT,
Voltage FLOAT,
Global_intensity FLOAT,
Sub_metering_1 FLOAT,
Sub_metering_2 FLOAT,
Sub_metering_3 FLOAT
);

SELECT * FROM electric_consumption;

-- Daily average global active power
SELECT date, AVG(global_active_power) AS avg_power
FROM electric_consumption
GROUP BY date
ORDER BY date;


-- Hourly power usage trend
SELECT EXTRACT(HOUR FROM time) AS hour,
       AVG(global_active_power) AS avg_power
FROM electric_consumption
GROUP BY hour
ORDER BY hour;

-- Monthly power usage 
SELECT EXTRACT(MONTH FROM date) AS month,
       AVG(global_active_power) AS avg_power
FROM electric_consumption
GROUP BY month
ORDER BY month;

-- Sub-metering contribution
SELECT date,
       SUM(sub_metering_1) AS sm1,
       SUM(sub_metering_2) AS sm2,
       SUM(sub_metering_3) AS sm3
FROM electric_consumption
GROUP BY date
ORDER BY date;

-- Power factor (efficiency measure)
SELECT date, time,
       global_active_power / 
       SQRT(POWER(global_active_power,2) + POWER(global_reactive_power,2)) AS power_factor
FROM electric_consumption
	limit 100;