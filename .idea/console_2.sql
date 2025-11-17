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
