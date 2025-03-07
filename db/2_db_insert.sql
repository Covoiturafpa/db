INSERT INTO covoiturafpa.fuel VALUES (1, 'ESSENCE', 1.82);
INSERT INTO covoiturafpa.fuel VALUES (2, 'ESSENCE SUPERTHANOL', 0.82);
INSERT INTO covoiturafpa.fuel VALUES (3, 'GAZOLE', 1.82);
INSERT INTO covoiturafpa.fuel VALUES (4, ' ELECTRIQUE', 0.17);
INSERT INTO covoiturafpa.fuel VALUES (5, 'GPL', 0.87);

INSERT INTO covoiturafpa.car_type VALUES (1, 'COMPACT', 7.3, 1);
INSERT INTO covoiturafpa.car_type VALUES (2, 'COMPACT', 7.3, 2);
INSERT INTO covoiturafpa.car_type VALUES (3, 'COMPACT', 5.2, 3);
INSERT INTO covoiturafpa.car_type VALUES (4, 'COMPACT', 7.8, 4);
INSERT INTO covoiturafpa.car_type VALUES (5, 'COMPACT', 9.5, 5);
INSERT INTO covoiturafpa.car_type VALUES (6, 'BERLINE', 7.5, 1);
INSERT INTO covoiturafpa.car_type VALUES (7, 'BERLINE', 7.5, 2);
INSERT INTO covoiturafpa.car_type VALUES (8, 'BERLINE', 6.8, 3);
INSERT INTO covoiturafpa.car_type VALUES (9, 'BERLINE', 15.6, 4);
INSERT INTO covoiturafpa.car_type VALUES (10, 'BERLINE', 12.2, 5);
INSERT INTO covoiturafpa.car_type VALUES (11, 'SUV', 8.0, 1);
INSERT INTO covoiturafpa.car_type VALUES (12, 'SUV', 8.0, 2);
INSERT INTO covoiturafpa.car_type VALUES (13, 'SUV', 7.2, 3);
INSERT INTO covoiturafpa.car_type VALUES (14, 'SUV', 16.0, 4);
INSERT INTO covoiturafpa.car_type VALUES (15, 'SUV', 16.0, 5);
INSERT INTO covoiturafpa.car_type VALUES (16, 'MONOSPACE', 7.0, 1);
INSERT INTO covoiturafpa.car_type VALUES (17, 'MONOSPACE', 7.0, 2);
INSERT INTO covoiturafpa.car_type VALUES (18, 'MONOSPACE', 6.2, 3);
INSERT INTO covoiturafpa.car_type VALUES (19, 'MONOSPACE', 15.6, 4);
INSERT INTO covoiturafpa.car_type VALUES (20, 'MONOSPACE', 10.5, 5);
INSERT INTO covoiturafpa.car_type VALUES (21, 'UTILITAIRE', 14.3, 3);
INSERT INTO covoiturafpa.car_type VALUES (22, 'UTILITAIRE', 14.3, 2);
INSERT INTO covoiturafpa.car_type VALUES (23, 'UTILITAIRE', 11.6, 3);
INSERT INTO covoiturafpa.car_type VALUES (24, 'UTILITAIRE', 25.0, 4);
INSERT INTO covoiturafpa.car_type VALUES (25, 'UTILITAIRE', 18.6, 5);


INSERT INTO covoiturafpa.centre VALUES (1, 'Centre Afpa de Dunkerque', '407 Av. de la Gironde', 51.00609, 2.33884, '+33972723936', true);


INSERT INTO covoiturafpa.day_timetable VALUES (1, 'MONDAY', '09:00:00', '12:00:00', '13:00:00', '18:00:00', 1);
INSERT INTO covoiturafpa.day_timetable VALUES (2, 'TUESDAY', '08:00:00', '12:00:00', '13:00:00', '18:00:00', 1);
INSERT INTO covoiturafpa.day_timetable VALUES (3, 'WEDNESDAY', '08:00:00', '12:00:00', '13:00:00', '18:00:00', 1);
INSERT INTO covoiturafpa.day_timetable VALUES (4, 'THURSDAY', '08:00:00', '12:00:00', '13:00:00', '18:00:00', 1);
INSERT INTO covoiturafpa.day_timetable VALUES (5, 'FRIDAY', '08:00:00', '12:00:00', '13:00:00', '18:00:00', 1);
INSERT INTO covoiturafpa.day_timetable VALUES (6, 'SATURDAY', NULL, NULL, NULL, NULL, 1);
INSERT INTO covoiturafpa.day_timetable VALUES (7, 'SUNDAY', NULL, NULL, NULL, NULL, 1);


INSERT INTO covoiturafpa.day_week VALUES (1, 'MONDAY');
INSERT INTO covoiturafpa.day_week VALUES (2, 'TUESDAY');
INSERT INTO covoiturafpa.day_week VALUES (3, 'WEDNESDAY');
INSERT INTO covoiturafpa.day_week VALUES (4, 'THURSDAY');
INSERT INTO covoiturafpa.day_week VALUES (5, 'FRIDAY');
INSERT INTO covoiturafpa.day_week VALUES (6, 'SATURDAY');
INSERT INTO covoiturafpa.day_week VALUES (7, 'SUNDAY');


INSERT INTO covoiturafpa.partner VALUES (1, 'Afaq_9001', 'Afaq_9001.png', 1);
INSERT INTO covoiturafpa.partner VALUES (2, 'France Relance', 'france-relance.png', 1);
INSERT INTO covoiturafpa.partner VALUES (3, 'fse', 'fse.jpg', 1);
INSERT INTO covoiturafpa.partner VALUES (6, 'Synofdes', 'synofdes.png', 1);
INSERT INTO covoiturafpa.partner VALUES (5, 'region Nouvelle-Aquitaine', 'region.jpg', 1);
INSERT INTO covoiturafpa.partner VALUES (4, 'opqf', 'opqf.png', 1);