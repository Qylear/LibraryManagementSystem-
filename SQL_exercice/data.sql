INSERT INTO `students` (`students_id`, `name`, `age`, `gender`)
 VALUES (NULL, 'Camille', '20', 'Feminin'),
  (NULL, 'Romain', '21', 'masculin'),
   (NULL, 'Alexis', '22', 'masculin'),
    (NULL, 'Lilia', '21', 'Feminin'),
     (NULL, 'Maxime', '19', 'masculin');


INSERT INTO `courses` (`course_id`, `course_name`, `credits`, `capacity`)
 VALUES (NULL, 'Alpha', '20', '3'),
 (NULL, 'beta', '90', '5'),
 (NULL, 'gamma', '50', '6'),
 (NULL, 'Delta', '100', '10');

 INSERT INTO `enrollments` (`enrollment_id`, `course_id`, `students_id`)
  VALUES (NULL, '1', '3'),
   (NULL, '2', '1'),
    (NULL, '4', '5'),
    (NULL, '3', '5'),
    (NULL, '1', '2'),
    (NULL, '2', '1'),
    (NULL, '4', '3'),
    (NULL, '3', '4');