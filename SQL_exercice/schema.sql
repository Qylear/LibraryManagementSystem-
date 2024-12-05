CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    credits INT,
    capacity INT
);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- --
CREATE TRIGGER prevent_over_capacity BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE course_capacity INT;
    DECLARE num_students INT;

    SELECT capacity INTO course_capacity
    FROM Courses
    WHERE course_id = NEW.course_id;

    SELECT COUNT(*) INTO num_students
    FROM Enrollments
    WHERE course_id = NEW.course_id;

    IF num_students >= course_capacity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course has reached its capacity.';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER check_max_courses
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE current_courses INT;
    

    SELECT COUNT(*) INTO current_courses
    FROM Enrollments
    WHERE student_id = NEW.student_id;
    
    IF current_courses >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L\'étudiant a atteint la limite de 5 cours.';
    END IF;
END $$

DELIMITER ;



