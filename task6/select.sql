SELECT Students.Student, Result.Task1, Result.Task2, Result.Task3, Result.Task4, Result.Task5
FROM Students, Result
WHERE Students.StudentId = Result.StudentId and Students.Student='Виталий Костюков';