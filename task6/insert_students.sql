INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '1' AS ID, 'Назар Винник' AS Student, '1' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Назар Винник'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '2' AS ID, 'Александр Рекун' AS Student, '2' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Александр Рекун'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '3' AS ID, 'Олег Бандрівський' AS Student, '3' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Олег Бандрівський'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '4' AS ID, 'Владимир Бурдыко' AS Student, '4' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Владимир Бурдыко'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '5' AS ID, 'Вадим Марков' AS Student, '5' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Вадим Марков'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '6' AS ID, 'Игорь Войтух' AS Student, '7' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Игорь Войтух'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '7' AS ID, 'Дмитрий Мошна' AS Student, '8' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Дмитрий Мошна'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '8' AS ID, 'Евгений Козловский' AS Student, '9' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Евгений Козловский'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '9' AS ID, 'Эд Еленский' AS Student, '10' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Эд Еленский'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '10' AS ID, 'Игорь Зинченко' AS Student, '11' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Игорь Зинченко'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '11' AS ID, 'Виталий Костюков' AS Student, '14' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Виталий Костюков'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '12' AS ID, 'Евгений Лактюшин' AS Student, '16' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Евгений Лактюшин'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '13' AS ID, 'Михаил Лопаев' AS Student, '18' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Михаил Лопаев'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '14' AS ID, 'Михаил Мостыка' AS Student, '19' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Михаил Мостыка'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '15' AS ID, 'Андрей Новогродский' AS Student, '20' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Андрей Новогродский'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '16' AS ID, 'Сазонова Анна' AS Student, '21' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Сазонова Анна'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '17' AS ID, 'Дмитрий Соловей' AS Student, '22' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Дмитрий Соловей'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '18' AS ID, 'Артём Фортунатов' AS Student, '23' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Артём Фортунатов'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '19' AS ID, 'Хоменко Іван' AS Student, '24' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Хоменко Іван'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '20' AS ID, 'Алексей Шутов' AS Student, '26' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Алексей Шутов'
);
INSERT INTO Students (ID, Student, StudentId)
SELECT * FROM (SELECT '21' AS ID, 'Юрий Щербина' AS Student, '27' AS StudentId) AS temp
WHERE NOT EXISTS (
    SELECT Student FROM Students WHERE Student = 'Юрий Щербина'
);
