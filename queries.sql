-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT 
YEAR(enrolment_date) AS year,
COUNT(id) AS enrolments
FROM students
GROUP BY year


-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT 
CONVERT(office_number, SIGNED) AS office_number  ,
COUNT(office_number) AS teachers
FROM teachers 
GROUP BY office_number 
ORDER BY office_number 


-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT 
exam_id, 
AVG(vote) AS average_vote
FROM exam_student
GROUP BY exam_id 


-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT 
department_id, 
COUNT(id) courses
FROM degrees 
GROUP BY department_id


-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT 
students.id AS student_id,
students.name AS student_name,
students.surname AS student_surname,
students.degree_id,
degrees.name AS degree_name
FROM students
JOIN degrees ON degrees.id = students.degree_id 
WHERE degrees.name = "Corso di Laurea in Economia" 


-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT 
degrees.id AS degree_id,
degrees.name AS degree_name,
degrees.level AS degree_level,
departments.id AS department_id,
departments.name AS department_name
FROM degrees 
JOIN departments ON departments.id = degrees.department_id 
WHERE level = "Magistrale"
AND departments.name = "Dipartimento di Neuroscienze"


-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT 
course_id,
courses.name AS course_name,
description AS course_description
FROM course_teacher
JOIN courses ON courses.id = course_teacher.course_id 
WHERE course_teacher.teacher_id = 44



-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti 
-- e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT *
FROM students
JOIN degrees ON degrees.id = students.degree_id
JOIN departments ON departments.id = degrees.department_id 
ORDER BY surname, students.name



-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT *
FROM degrees
JOIN courses ON courses.degree_id  = degrees.id 
JOIN course_teacher ON course_teacher.course_id = courses.id
JOIN teachers ON teachers.id = course_teacher.teacher_id 
ORDER BY degrees.id, courses.id, teachers.id



-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT 
DISTINCT teachers.id AS teacher_id,
teachers.name AS teacher_name,
teachers.surname AS teacher_surname,
departments.id AS department_id,
departments.name AS department_name
FROM teachers
JOIN course_teacher ON course_teacher.teacher_id = teachers.id
JOIN courses ON courses.id = course_teacher.course_id
JOIN degrees ON degrees.id = courses.degree_id 
JOIN departments ON departments.id = degrees.department_id 
WHERE departments.name = "Dipartimento di Matematica"
ORDER BY teachers.id



-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT student_id , course_id, COUNT(course_id) AS attempts
FROM exam_student es 
JOIN exams e ON e.id = es.exam_id 
JOIN courses c ON c.id = e.course_id 
GROUP BY student_id , course_id
ORDER BY student_id 
