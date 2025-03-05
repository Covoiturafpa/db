SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


-- jfrbnsrgohior ==> adminTest

CREATE SCHEMA covoiturafpa;

CREATE user adminTest WITH LOGIN PASSWORD 'test';

ALTER SCHEMA covoiturafpa OWNER TO adminTest;


-- TYPE
CREATE TYPE covoiturafpa.car_type_name AS ENUM (
    'COMPACT',
    'BERLINE',
    'SUV',
    'MONOSPACE',
    'UTILITAIRE'
);

CREATE TYPE covoiturafpa.day_name AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);

CREATE TYPE covoiturafpa.notification_type AS ENUM (
    'NEW_RESERVATION',
    'ACCEPTED_RESERVATION',
    'REJECTED_RESERVATION'
);

CREATE TYPE covoiturafpa.status_type AS ENUM (
    'PENDING',
    'ACCEPTED',
    'FINISHED'
);

ALTER TYPE covoiturafpa.car_type_name OWNER TO adminTest;
ALTER TYPE covoiturafpa.day_name OWNER TO adminTest;
ALTER TYPE covoiturafpa.notification_type OWNER TO adminTest;
ALTER TYPE covoiturafpa.status_type OWNER TO adminTest;


SET default_tablespace = '';
SET default_table_access_method = heap;


-- TABLES
CREATE TABLE covoiturafpa.person (
    id_person serial PRIMARY KEY,
    email varchar(50) UNIQUE,
    password varchar(255),
    surname varchar(50),
    first_name varchar(20),
    phone_number varchar(20),
    is_activated boolean,
    contact_by_sms boolean,
    contact_by_mail boolean,
    last_login timestamp without time zone,
    photo_path varchar(255),
    person_type varchar NOT NULL,
    start_activity date NOT NULL,
    end_activity date
);

CREATE TABLE covoiturafpa.fuel (
    id_fuel serial PRIMARY KEY,
    name varchar(20),
    price_by_unit numeric(5,2)
);

CREATE TABLE covoiturafpa.car_type (
    id_car_type serial PRIMARY KEY,
    name covoiturafpa.car_type_name,
    avg_fuel_consumption numeric(4,1),
    id_fuel integer NOT NULL,
    FOREIGN KEY (id_fuel) REFERENCES covoiturafpa.fuel(id_fuel)
);

CREATE TABLE covoiturafpa.car (
    id_car serial PRIMARY KEY,
    model varchar(50),
    seats smallint,
    avg_fuel_consumption numeric(4,1),
    id_car_type integer NOT NULL,
    id_person integer NOT NULL,
    FOREIGN KEY (id_car_type) REFERENCES covoiturafpa.car_type(id_car_type),
    FOREIGN KEY (id_person) REFERENCES covoiturafpa.person(id_person)
);

CREATE TABLE covoiturafpa.centre (
    id_centre serial PRIMARY KEY,
    name varchar(50),
    address varchar(255),
    latitude double precision,
    longitude double precision,
    phone_number varchar(20),
    contact_by_sms boolean NOT NULL
);

CREATE TABLE covoiturafpa.city (
    id_city serial PRIMARY KEY,
    name varchar(255) UNIQUE
);

CREATE TABLE covoiturafpa.day_timetable (
    id_day_timetable serial PRIMARY KEY,
    day covoiturafpa.day_name,
    start_morning time without time zone,
    end_morning time without time zone,
    start_afternoon time without time zone,
    end_afternoon time without time zone,
    id_centre integer NOT NULL,
    FOREIGN KEY (id_centre) REFERENCES covoiturafpa.centre(id_centre)
);

CREATE TABLE covoiturafpa.day_week (
    id_day_week serial PRIMARY KEY,
    name covoiturafpa.day_name
);

CREATE TABLE covoiturafpa.destination (
    id_destination serial PRIMARY KEY,
    latitude double precision,
    longitude double precision,
    is_from_afpa boolean,
    id_city integer,
    FOREIGN KEY (id_city) REFERENCES covoiturafpa.city(id_city) ON DELETE CASCADE
);

CREATE TABLE covoiturafpa.formation (
    id_formation serial PRIMARY KEY,
    name varchar(50),
    id_centre integer NOT NULL,
    FOREIGN KEY (id_centre) REFERENCES covoiturafpa.centre(id_centre)
);

CREATE TABLE covoiturafpa.notification (
    id_notification serial PRIMARY KEY,
    type covoiturafpa.notification_type,
    created_time timestamp without time zone,
    is_unread boolean,
    id_person integer NOT NULL,
    content varchar NOT NULL,
    FOREIGN KEY (id_person) REFERENCES covoiturafpa.person(id_person)
);

CREATE TABLE covoiturafpa.employee (
    id_person integer PRIMARY KEY,
    is_admin boolean,
    id_centre integer NOT NULL,
    is_teacher boolean,
    FOREIGN KEY (id_centre) REFERENCES covoiturafpa.centre(id_centre),
    FOREIGN KEY (id_person) REFERENCES covoiturafpa.person(id_person)
);

CREATE TABLE covoiturafpa.partner (
    id_partner serial PRIMARY KEY,
    name varchar(50),
    logo_picture_path varchar(255),
    id_centre integer NOT NULL,
    FOREIGN KEY (id_centre) REFERENCES covoiturafpa.centre(id_centre)
);

CREATE TABLE covoiturafpa.ride (
    id_ride serial PRIMARY KEY,
    is_active boolean,
    departure_time time without time zone,
    comment varchar(255),
    id_destination integer NOT NULL,
    id_car integer NOT NULL,
    price numeric(5,2),
    ride_type varchar NOT NULL,
    FOREIGN KEY (id_car) REFERENCES covoiturafpa.car(id_car),
    FOREIGN KEY (id_destination) REFERENCES covoiturafpa.destination(id_destination) ON DELETE CASCADE
);

CREATE TABLE covoiturafpa.one_time (
    id_ride integer PRIMARY KEY,
    departure_day date,
    FOREIGN KEY (id_ride) REFERENCES covoiturafpa.ride(id_ride) ON DELETE CASCADE
);

CREATE TABLE covoiturafpa.recurring (
    id_ride integer PRIMARY KEY,
    beginning date,
    ending date,
    FOREIGN KEY (id_ride) REFERENCES covoiturafpa.ride(id_ride) ON DELETE CASCADE
);

CREATE TABLE covoiturafpa.recurring_days (
    id_ride integer NOT NULL,
    id_day_week integer NOT NULL,
    PRIMARY KEY (id_ride, id_day_week),
    FOREIGN KEY (id_day_week) REFERENCES covoiturafpa.day_week(id_day_week),
    FOREIGN KEY (id_ride) REFERENCES covoiturafpa.recurring(id_ride)
);

CREATE TABLE covoiturafpa.ride_passenger (
    id_person integer NOT NULL,
    id_ride integer NOT NULL,
    status covoiturafpa.status_type,
    last_update timestamp without time zone,
    is_driver boolean,
    PRIMARY KEY (id_person, id_ride),
    FOREIGN KEY (id_person) REFERENCES covoiturafpa.person(id_person),
    FOREIGN KEY (id_ride) REFERENCES covoiturafpa.ride(id_ride) ON DELETE CASCADE
);

CREATE TABLE covoiturafpa.teacher_of (
    id_formation integer NOT NULL,
    id_teacher integer NOT NULL,
    PRIMARY KEY (id_formation, id_teacher),
    FOREIGN KEY (id_formation) REFERENCES covoiturafpa.formation(id_formation),
    FOREIGN KEY (id_teacher) REFERENCES covoiturafpa.employee(id_person)
);

CREATE TABLE covoiturafpa.trainee (
    id_person integer PRIMARY KEY,
    id_formation integer,
    FOREIGN KEY (id_person) REFERENCES covoiturafpa.person(id_person),
    FOREIGN KEY (id_formation) REFERENCES covoiturafpa.formation(id_formation)
);


ALTER TABLE covoiturafpa.car OWNER TO adminTest;
ALTER TABLE covoiturafpa.car_type OWNER TO adminTest;
ALTER TABLE covoiturafpa.centre OWNER TO adminTest;
ALTER TABLE covoiturafpa.city OWNER TO adminTest;
ALTER TABLE covoiturafpa.day_timetable OWNER TO adminTest;
ALTER TABLE covoiturafpa.day_week OWNER TO adminTest;
ALTER TABLE covoiturafpa.destination OWNER TO adminTest;
ALTER TABLE covoiturafpa.employee OWNER TO adminTest;
ALTER TABLE covoiturafpa.formation OWNER TO adminTest;
ALTER TABLE covoiturafpa.fuel OWNER TO adminTest;
ALTER TABLE covoiturafpa.notification OWNER TO adminTest;
ALTER TABLE covoiturafpa.one_time OWNER TO adminTest;
ALTER TABLE covoiturafpa.partner OWNER TO adminTest;
ALTER TABLE covoiturafpa.person OWNER TO adminTest;
ALTER TABLE covoiturafpa.recurring OWNER TO adminTest;
ALTER TABLE covoiturafpa.recurring_days OWNER TO adminTest;
ALTER TABLE covoiturafpa.ride OWNER TO adminTest;
ALTER TABLE covoiturafpa.ride_passenger OWNER TO adminTest;
ALTER TABLE covoiturafpa.teacher_of OWNER TO adminTest;
ALTER TABLE covoiturafpa.trainee OWNER TO adminTest;

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

INSERT INTO covoiturafpa.person VALUES (1,'admin@admin.com',
'$2a$10$HN6dEs1e1PewsSoiM7iOauwPq8UeA1ra6OPX11p1H421poM9CE1mG',
'ADMIN',
'ADMIN',
'0606606060',
true,
false,
false,
null,
null,
'E',
'2025-03-04',
'2100-01-01'
);
INSERT INTO covoiturafpa.formation VALUES (1,'CDA',1);
INSERT INTO covoiturafpa.employee VALUES (1,true,1,true);
INSERT INTO covoiturafpa.teacher_of values (1,1);

-- UPDATE covoiturafpa.person set person_type ='E' where id_person=1;



CREATE extension cube SCHEMA covoiturafpa;
CREATE extension earthdistance SCHEMA covoiturafpa;

CREATE OR REPLACE FUNCTION covoiturafpa.get_distance(latitude_1 double precision, longitude_1 double precision, latitude_2 double precision, longitude_2 double precision)
RETURNS double precision
LANGUAGE sql
IMMUTABLE STRICT
RETURN covoiturafpa.earth_distance(covoiturafpa.ll_to_earth(latitude_1, longitude_1), covoiturafpa.ll_to_earth(latitude_2, longitude_2)) / 1000;

CREATE ROLE "afpaUser" WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'Afpa4apfA!';
COMMENT ON ROLE "afpaUser" IS 'Classic User for covoiturafpa';

GRANT USAGE ON SCHEMA covoiturafpa TO "afpaUser";

GRANT ALL ON TABLE covoiturafpa.car TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.car_type TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.centre TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.city TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.day_timetable TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.destination TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.employee TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.formation TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.fuel TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.notification TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.one_time TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.partner TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.person TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.recurring TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.ride TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.ride_passenger TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.trainee TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.day_week TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.recurring_days TO "afpaUser";
GRANT ALL ON TABLE covoiturafpa.teacher_of TO "afpaUser";

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA covoiturafpa TO "afpaUser";
GRANT EXECUTE ON FUNCTION covoiturafpa.get_distance(float8, float8, float8, float8) TO "afpaUser";


CREATE OR REPLACE FUNCTION covoiturafpa.prevent_delete_update()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.id_person = 1 THEN
        RAISE EXCEPTION 'SUPER ADMIN cannot be deleted';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER prevent_delete_update_trigger
BEFORE DELETE OR UPDATE ON covoiturafpa.person
FOR EACH ROW
EXECUTE PROCEDURE covoiturafpa.prevent_delete_update();
