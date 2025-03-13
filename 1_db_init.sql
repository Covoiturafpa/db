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
-- aled
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
    FOREIGN KEY (id_ride) REFERENCES covoiturafpa.recurring(id_ride) ON DELETE CASCADE
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

CREATE extension cube SCHEMA covoiturafpa;
CREATE extension earthdistance SCHEMA covoiturafpa;

CREATE OR REPLACE FUNCTION covoiturafpa.get_distance(latitude_1 double precision, longitude_1 double precision, latitude_2 double precision, longitude_2 double precision)
RETURNS double precision
LANGUAGE sql
IMMUTABLE STRICT
RETURN covoiturafpa.earth_distance(covoiturafpa.ll_to_earth(latitude_1, longitude_1), covoiturafpa.ll_to_earth(latitude_2, longitude_2)) / 1000;






