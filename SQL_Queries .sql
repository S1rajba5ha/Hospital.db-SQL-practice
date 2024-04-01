create table patients(
patient_id	INT,
first_name	TEXT,
last_name	TEXT,
gender	VARCHAR,
birth_date	DATE,
city	TEXT,
province_id	CHAR,
allergies	TEXT,
height	INT,
weight	INt );

create table admissions(
patient_id	INT,
admission_date	DATE,
discharge_date	DATE,
diagnosis	TEXT,
attending_doctor_id	INT );

create table doctors(
doctor_id	INT,
first_name	varchar,
last_name	varchar,
specialty	varchar );

create table province(
province_id	varchar,
province_name varchar );


alter table patients
alter column province_id type varchar

copy patients from 'E:\share\Intel\New Projects\hospital.patients1.csv' delimiter ','csv header;

copy patients from 'E:\share\Intel\New Projects\Hospital DB\hospital.admissions.csv' delimiter ','csv header;

copy doctors from 'E:\share\Intel\New Projects\Hospital DB\hospital.doctors.csv' delimiter ','csv header;

copy province from 'E:\share\Intel\New Projects\Hospital DB\hospital.province.csv' delimiter ','csv header;

select * from patients
select * from admissions
select * from doctors
select * from province

/*  EASY LEVEL  */
-- Show first name, last name, and gender of patients whose gender is 'M'
SElECT first_name,
       last_name,
	   gender
FROM patients
WHERE gender = 'M';

-- Show first name and last name of patients who does not have allergies. (null)
SElECT first_name,
       last_name
FROM patients
WHERE allergies = 'NULL';

-- Show first name of patients that start with the letter 'C'
SElECT first_name     
FROM patients
WHERE first_name like 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SElECT first_name,
       last_name,
	   weight
FROM patients
WHERE weight BETWEEN 100 and 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = 'NKA'
WHERE allergies = 'NULL'

-- Show first name and last name concatinated into one column to show their full name.
SELECT concat(first_name,' ',last_name) as names
FROM patients;	   

-- Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'
SELECT p.first_name,
       p.last_name,
	   pr.province_name
FROM patients p 
JOIN province pr on pr.province_id = p.province_id;	   

-- Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(1)
FROM patients
WHERE EXTRACT(YEAR FROM birth_date) ='2010';

SELECT COUNT(1)
FROM patients
WHERE birth_date>='2010-01-01' AND 
      birth_date <='2010-12-31';

SELECT COUNT(*)
FROM patients
WHERE birth_date BETWEEN '2010-01-01' AND '2010-12-31';

-- Show the first_name, last_name, and height of the patient with the greatest height.
SElECT first_name,
       last_name,
	   height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

SElECT first_name,
       last_name,
	   MAX(height)
FROM patients
GROUP BY first_name,
       last_name,
	   height
ORDER BY height DESC
LIMIT 1;

-- Show all columns for patients who have one of the following patient_ids:
-- 1,45,534,879,1000
SELECT *
FROM patients
WHERE patient_id in (1,45,534,879,1000);

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.
SELECT patient_id,
       COUNT(1)
FROM admissions
WHERE patient_id = 579
GROUP BY patient_id;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT(city)
FROM patients
WHERE province_id='NS';

-- Write a query to find the first_name, last name, and birth date of patients who has height greater than 160 and weight greater than 70
SELECT first_name,
       last_name,
       birth_date
FROM patients
WHERE height>160
AND weight>70;

-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT first_name, 
       last_name, 
       allergies
FROM patients
WHERE city = 'Hamilton' 
AND allergies != 'NKA';

/*  MEDIUM LEVEL  */
-- Show unique birth years from patients and order them by ascending.
SELECT DISTINCT(EXTRACT(YEAR FROM birth_date)) AS year
FROM patients
ORDER BY year ASC;

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
-- If only 1 person is named 'Leo' then include them in the output.
SELECT first_name 
FROM (SELECT first_name,
	  COUNT(1) AS ss
	  FROM patients
	  GROUP BY first_name) x
WHERE x.ss = 1;
	  
-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id,
       first_name
FROM patients
WHERE first_name like'S%s'
AND length(first_name) >= 6;

SELECT patient_id,
       first_name
FROM patients
WHERE first_name like'S____%s';

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.
SELECT p.patient_id, 
       p.first_name, 
	   p.last_name
FROM patients p
JOIN admissions a ON 
a.patient_id = p.patient_id
WHERE a.diagnosis = 'Dementia'; 

-- Display every patient's first_name.
-- Order the list by the length of each name and then by alphabetically
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name),
         first_name;
		 
-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.
select
(select count(*) from patients where gender='M')as male,
(select count(*) from patients where gender='F')as female;

select 
sum(case when gender='M' then 1 end) as male,
sum(case when gender='F' then 1 end) as female
from patients

select 
count(case when gender='M' then 'male' end) as male,
count(case when gender='F' then 'female' end) as female
from patients

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
-- Show results ordered ascending by allergies then by first_name then by last_name.
SELECT first_name,
       last_name,
	   allergies
FROM patients
WHERE allergies LIKE 'Penicillin' or
allergies LIKE 'Morphine';

SELECT first_name,
       last_name,
	   allergies
FROM patients
WHERE allergies = 'Penicillin'
OR allergies = 'Morphine';

SELECT first_name,
       last_name,
	   allergies
FROM patients
WHERE allergies IN ('Penicillin','Morphine');

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, 
       diagnosis
FROM admissions
GROUP BY patient_id,
diagnosis
HAVING COUNT(patient_id) > 1;    

SELECT patient_id, 
		diagnosis 
        FROM (SELECT patient_id, 
					diagnosis,
					COUNT(*) AS cnt
					FROM admissions
			 GROUP BY patient_id,
             diagnosis) x
WHERE x.cnt > 1;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.
SELECT city,
       COUNT(*) AS cnt
FROM patients
GROUP BY city
ORDER BY cnt DESC,
         city;

-- Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
SELECT allergies,
       COUNT(*) AS cnt
FROM patients
WHERE allergies != 'NKA'
GROUP BY allergies
ORDER BY cnt DESC;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
SELECT first_name, 
       last_name,
       birth_date
FROM patients
WHERE EXTRACT(YEAR from birth_date) <= 1970;

-- We want to display each patient's full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane
SELECT CONCAT(UPPER(last_name),',',first_name)
FROM patients
ORDER BY first_name DESC;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT MAX(height)-MIN(weight)
FROM patients
WHERE last_name = 'Maroni';

-- Show the all columns for patient_id 542's most recent admission_date.
SELECT patient_id,
       admission_date
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT patient_id, 
       attending_doctor_id, 
	   diagnosis
FROM admissions
WHERE (patient_id%2) != 0
AND attending_doctor_id IN (1,5,19)
ORDER BY patient_id,
         attending_doctor_id;

-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.
SELECT d.first_name, 
       d.last_name,
	   COUNT(*)
FROM doctors d
LEFT JOIN admissions a ON a.attending_doctor_id = d.doctor_id
GROUP BY d.first_name, 
         d.last_name;

-- For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT d.doctor_id,
       CONCAT(d.first_name,' ',d.last_name),	   
	   MIN(a.admission_date),
	   MAX(a.admission_date)
FROM doctors d
JOIN admissions a ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id,
         d.first_name, 
         d.last_name
ORDER BY d.doctor_id;		 

-- Display the total amount of patients for each province. Order by descending.
SELECT p.province_name,
       COUNT(*) AS cnt
FROM province p
JOIN patients pa ON 
p.province_id = pa.province_id
GROUP BY p.province_name
ORDER BY cnt DESC

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT p.patient_id,
       CONCAT(p.first_name,' ',p.last_name) AS patient_name,
	   a.diagnosis,
	   CONCAT(d.first_name,' ',d.last_name) AS doctor_name
FROM patients p 
JOIN admissions a ON a.patient_id = p.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
ORDER BY p.patient_id

-- display the first name, last name and number of duplicate patients based on their first name and last name.
SELECT first_name, 
       last_name,
	   COUNT(*)
FROM patients
GROUP BY first_name, 
         last_name
		 
-- Display patient's full name,
-- height in the unit feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.
SELECT CONCAT(first_name,' ',last_name) AS patient_name,
       ROUND((height/30.48),1),
	   FLOOR(weight*2.205),
	   birth_date,
	   gender
FROM patients	   

/*  HARD LEVEL  */
-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT CONCAT(first_name,' ',last_name) AS patient_name,
       (CASE WHEN weight BETWEEN 1 AND 50 THEN 50
	        WHEN weight BETWEEN 51 AND 100 THEN 100
			ELSE 150
			END) AS weight
FROM patients

-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Dementia'.
-- Check patients, admissions, and doctors tables for required information.
SELECT p.patient_id, 
       p.first_name, 
	   p.last_name,
	   d.specialty
FROM patients p 
JOIN admissions a ON a.patient_id = p.patient_id
JOIN doctors d ON d.doctor_id = a.attending_doctor_id
WHERE a.diagnosis = 'Dementia';

-- All patients who have gone through admissions, can see their medical documents on our site. 
-- Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date
SELECT CONCAT(first_name,' ',last_name) AS patient_name,
       CONCAT(patient_id,LENGTH(last_name),birth_date)
FROM patients

-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
-- All patients with an even patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. 
-- Add up the admission_total cost for each has_insurance group.
WITH status AS (SELECT patient_id,
					   first_name,
					   last_name,
					   (CASE WHEN (patient_id%2)=0 THEN 'Yes'
						ELSE 'No'
						END ) AS insurance_status
				FROM patients
				--WHERE (patient_id%2)=0
				ORDER BY patient_id)
SELECT *,
      (CASE WHEN insurance_status='Yes' THEN '$10'
	   ELSE '$50'
	   END ) AS payment
FROM status

-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
SELECT p.province_id,
       pr.province_name,
       p.gender,
	   count(*)
FROM patients p 
JOIN province pr ON pr.province_id = p.province_id
GROUP BY p.province_id,
         pr.province_name,
         p.gender;

-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
SELECT (COUNT(*))*100/(SELECT COUNT(*) FROM patients) AS perc
FROM patients
WHERE gender = 'M'

-- We need a breakdown for the total amount of admissions each doctor has started each year. 
-- Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
SELECT d.doctor_id, 
       CONCAT(d.first_name,' ',d.last_name) as name,
	   d.specialty, 
	   EXTRACT(year FROM a.admission_date) AS yr
	   -- COUNT(4)
FROM admissions a 
JOIN doctors d ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id,
         d.first_name,
		 d.last_name,
		 d.specialty,
		 a.admission_date
         
-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
SELECT first_name, 
       last_name
FROM patients
WHERE first_name like '__r%'
AND gender = 'F'
AND (EXTRACT(MONTH FROM birth_date)) in (02,05,12)
AND weight BETWEEN 60 and 80
AND (patient_id%2) != 0;
