# HOSPITAL.DB

## About

A Hospital Database consists of details of Patients,Doctors and Admission details and to perform various queries for SQL practice.

## About Data

### Patients table
| Column                  |  Data Type      |
| :---------------------- |  :------------- |
| patient_id              |  INT            |
| first_name              |  VARCHAR        |
| last_name               |  VARCHAR        |
| gender                  |  VARCHAR        |
| birth_date              |  DATE           |
| city                    |  VARCHAR        |
| province_id             |  VARCHAR        |
| allergies               |  VARCHAR        |
| height                  |  INT            |
| weight                  |  INT            |

### Admissions table
| Column                  |  Data Type      |
| :---------------------- |  :------------- |
| patient_id              |  INT            |
| admission_date          |  DATE           |
| discharge_date          |  DATE           |
| diagnosis               |  VARCHAR        |
| attending_doctor_id     |  INT            |

### Doctors table
| Column                  |  Data Type      |
| :---------------------- |  :------------- |
| doctor_id               |  INT            |
| first_name              |  VARCHAR        |
| last_name               |  VARCHAR        |
| specialty               |  VARCHAR        |

### Province table
| Column                  |  Data Type      |
| :---------------------- |  :------------- |
| province_id             |  VARCHAR        |
| province_name           |  VARCHAR        |


## Generic Question to Practice

### EASY LEVEL
1.  Show first name, last name, and gender of patients whose gender is 'M'
2.  Show first name and last name of patients who does not have allergies. (null)
3.  Show first name of patients that start with the letter 'C'
4.  Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
5.  Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
6.  Show first name and last name concatinated into one column to show their full name.
7.  Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
8.  Show how many patients have a birth_date with 2010 as the birth year.
9.  Show the first_name, last_name, and height of the patient with the greatest height.
10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
11. Show all the columns from admissions where the patient was admitted and discharged on the same day.
12. Show the patient id and the total number of admissions for patient_id 579.
13. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
14. Write a query to find the first_name, last name, and birth date of patients who has height greater than 160 and weight greater than 70
15. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

### MEDIUM LEVEL
1.  Show unique birth years from patients and order them by ascending.
2.  Show unique first names from the patients table which only occurs once in the list.
    For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
    If only 1 person is named 'Leo' then include them in the output.  
3.  Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
4.  Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
5.  Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
6.  Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
7.  Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
    Show results ordered ascending by allergies then by first_name then by last_name.
8.  Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
9.  Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
10. Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
11. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
12. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
    Separate the last_name and first_name with a comma. Order the list by the first_name in decending order.
    EX: SMITH,jane
13. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
14. Show the all columns for patient_id 542's most recent admission_date.
15. Show patient_id, attending_doctor_id, and diagnosis for admissions that patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
16. Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.
17. For each doctor, display their id, full name, and the first and last admission date they attended.		 
18. Display the total amount of patients for each province. Order by descending.
19. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
20. display the first name, last name and number of duplicate patients based on their first name and last name.	 
21. Display patient's full name, height in the unit feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated. 
    Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205.

### HARD LEVEL
1. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.
   For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
2. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Dementia'.
   Check patients, admissions, and doctors tables for required information.
3. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first 
   admission. Show the patient_id and temp_password. The password must be of patient_id, the numerical length of patient's last_name, year of patient's birth_date:   
4. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
   Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance.  Add up the admission_total cost for each has_insurance group.
5. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
6. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
7. We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for
   that year.         
8. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria: First_name contains an 'r' after the first two letters.
   Identifies their gender as 'F', Born in February, May, or December, Their weight would be between 60kg and 80kg, Their patient_id is an odd number.
