INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '1' AS ID, '1' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '1'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '2' AS ID, '2' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '2'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '3' AS ID, '3' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '3'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '4' AS ID, '4' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '4'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '5' AS ID, '5' AS StudentId, 'Done' AS Task1, 'Done' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Not competed' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '5'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '6' AS ID, '7' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '7'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '7' AS ID, '8' AS StudentId, 'Done' AS Task1, 'Not competed' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Not competed' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '8'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '8' AS ID, '9' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '9'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '9' AS ID, '10' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '10'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '10' AS ID, '11' AS StudentId, 'Done' AS Task1, 'Done' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '11'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '11' AS ID, '14' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '14'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '12' AS ID, '16' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '16'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '13' AS ID, '18' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '18'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '14' AS ID, '19' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '19'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '15' AS ID, '20' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '20'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '16' AS ID, '21' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '21'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '17' AS ID, '22' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '22'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '18' AS ID, '23' AS StudentId, 'Done' AS Task1, 'Done' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '23'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '19' AS ID, '24' AS StudentId, 'Done' AS Task1, 'Done' AS Task2, 'Done' AS Task3, 'Done' AS Task4, 'Not competed' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '24'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '20' AS ID, '26' AS StudentId, 'Done' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '26'
);
INSERT INTO Result (ID, StudentId, Task1, Task2, Task3, Task4, Task5)
SELECT * FROM (SELECT '21' AS ID, '27' AS StudentId, 'Done with honors' AS Task1, 'Done with honors' AS Task2, 'Done with honors' AS Task3, 'Done with honors' AS Task4, 'Done with honors' AS Task5) AS temp
WHERE NOT EXISTS (
    SELECT StudentId FROM Result WHERE StudentId = '27'
);
