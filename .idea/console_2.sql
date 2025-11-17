INSERT INTO Tables (Id, NoOfSeats) VALUES
                                       (1, 2),
                                       (2, 4),
                                       (3, 4),
                                       (4, 6),
                                       (5, 8);
INSERT INTO Customers (Id, Name) VALUES
                                     (1, 'Marcel Kainz'),
                                     (2, 'Anna Steiner'),
                                     (3, 'Leon Wagner'),
                                     (4, 'Sophie Leitner'),
                                     (5, 'David Hofer'),
                                     (6, 'Klara Gruber'),
                                     (7, 'Tom Berger');


INSERT INTO Reservation (Tables_Id, Customers_Id, Date) VALUES
                                                            (1, 1, '2025-06-20'),
                                                            (2, 3, '2025-06-20'),
                                                            (3, 5, '2025-06-20'),

                                                            (4, 2, '2025-06-21'),
                                                            (1, 4, '2025-06-21'),

                                                            (5, 6, '2025-06-22'),
                                                            (2, 7, '2025-06-22'),
                                                            (3, 1, '2025-06-22'),

                                                            (4, 5, '2025-06-23'),
                                                            (1, 3, '2025-06-23');

use restaurant;

-- Wer hat derzeit keinen Tisch reserviert?
SELECT c.Id, c.Name
FROM Customers c
         LEFT JOIN Reservation r ON r.Customers_Id = c.Id
WHERE r.Customers_Id IS NULL;

-- Welche Tische sind an einem bestimmten Datum frei?
SELECT t.Id, t.NoOfSeats
FROM Tables t
         LEFT JOIN Reservation r
                   ON r.Tables_Id = t.Id AND r.Date = '2025-06-20'
WHERE r.Tables_Id IS NULL;

-- Wer hat mehr als einen Tisch an einem Tag reserviert?
SELECT
    c.Id,
    c.Name,
    r.Date,
    COUNT(*) AS NumberOfTables
FROM Reservation r
         JOIN Customers c ON c.Id = r.Customers_Id
GROUP BY c.Id, r.Date
HAVING COUNT(*) > 1;

-- Wer hat mehr als einen Tisch über mehrere Tage hinweg reserviert?
SELECT
    c.Id,
    c.Name,
    COUNT(*) AS TotalReservations
FROM Reservation r
         JOIN Customers c ON c.Id = r.Customers_Id
GROUP BY c.Id
HAVING COUNT(*) > 1;
