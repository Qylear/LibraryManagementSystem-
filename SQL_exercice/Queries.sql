SELECT s.name AS student_name, c.course_name, c.credits
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

SELECT s.name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > c.capacity / 2;

SELECT s.name AS student_name, COUNT(e.course_id) AS num_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.name
ORDER BY num_courses DESC
LIMIT 1;

SELECT s.name AS student_name, SUM(c.credits) AS total_credits
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.name;

SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.student_id IS NULL;

DELETE FROM Enrollments
WHERE course_id = 1;

DELETE FROM Students
WHERE student_id NOT IN (SELECT DISTINCT student_id FROM Enrollments);