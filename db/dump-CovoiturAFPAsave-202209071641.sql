--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-09-07 16:41:52

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
--
-- TOC entry 3521 (class 1262 OID 17832)
-- Name: CovoiturAFPAsave; Type: DATABASE; Schema: -; Owner: postgres
--

-- CREATE DATABASE "CovoiturAFPAsave" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_France.1252';


ALTER DATABASE "CovoiturAFPAsave" OWNER TO postgres;

\connect "CovoiturAFPAsave"

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

--
-- TOC entry 6 (class 2615 OID 18416)
-- Name: CovoiturAFPA; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "CovoiturAFPA";


ALTER SCHEMA "CovoiturAFPA" OWNER TO postgres;

--
-- TOC entry 856 (class 1247 OID 18418)
-- Name: car_type_name; Type: TYPE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TYPE "CovoiturAFPA".car_type_name AS ENUM (
    'COMPACT',
    'BERLINE',
    'SUV',
    'MONOSPACE',
    'UTILITAIRE'
);


ALTER TYPE "CovoiturAFPA".car_type_name OWNER TO postgres;

--
-- TOC entry 859 (class 1247 OID 18430)
-- Name: day_name; Type: TYPE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TYPE "CovoiturAFPA".day_name AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);


ALTER TYPE "CovoiturAFPA".day_name OWNER TO postgres;

--
-- TOC entry 862 (class 1247 OID 18446)
-- Name: notification_type; Type: TYPE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TYPE "CovoiturAFPA".notification_type AS ENUM (
    'NEW_RESERVATION',
    'ACCEPTED_RESERVATION',
    'REJECTED_RESERVATION'
);


ALTER TYPE "CovoiturAFPA".notification_type OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 18454)
-- Name: status_type; Type: TYPE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TYPE "CovoiturAFPA".status_type AS ENUM (
    'PENDING',
    'ACCEPTED',
    'FINISHED'
);


ALTER TYPE "CovoiturAFPA".status_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 18461)
-- Name: car; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".car (
    id_car integer NOT NULL,
    model character varying(50),
    seats smallint,
    avg_fuel_consumption numeric(4,1),
    id_car_type integer NOT NULL,
    id_person integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".car OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 18464)
-- Name: car_id_car_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".car_id_car_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".car_id_car_seq OWNER TO postgres;

--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 211
-- Name: car_id_car_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".car_id_car_seq OWNED BY "CovoiturAFPA".car.id_car;


--
-- TOC entry 212 (class 1259 OID 18465)
-- Name: car_type; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".car_type (
    id_car_type integer NOT NULL,
    name "CovoiturAFPA".car_type_name,
    avg_fuel_consumption numeric(4,1),
    id_fuel integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".car_type OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 18468)
-- Name: car_type_id_car_type_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".car_type_id_car_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".car_type_id_car_type_seq OWNER TO postgres;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 213
-- Name: car_type_id_car_type_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".car_type_id_car_type_seq OWNED BY "CovoiturAFPA".car_type.id_car_type;


--
-- TOC entry 214 (class 1259 OID 18469)
-- Name: centre; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".centre (
    id_centre integer NOT NULL,
    name character varying(50),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    phone_number character varying(20),
    id_notif_config integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".centre OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18472)
-- Name: centre_id_centre_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".centre_id_centre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".centre_id_centre_seq OWNER TO postgres;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 215
-- Name: centre_id_centre_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".centre_id_centre_seq OWNED BY "CovoiturAFPA".centre.id_centre;


--
-- TOC entry 216 (class 1259 OID 18473)
-- Name: city; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".city (
    id_city integer NOT NULL,
    name character varying(255)
);


ALTER TABLE "CovoiturAFPA".city OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18476)
-- Name: city_id_city_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".city_id_city_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".city_id_city_seq OWNER TO postgres;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 217
-- Name: city_id_city_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".city_id_city_seq OWNED BY "CovoiturAFPA".city.id_city;


--
-- TOC entry 218 (class 1259 OID 18477)
-- Name: day_timetable; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".day_timetable (
    id_day_timetable integer NOT NULL,
    day "CovoiturAFPA".day_name,
    start_morning time without time zone,
    end_morning time without time zone,
    start_afternoon time without time zone,
    end_afternoon time without time zone,
    id_centre integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".day_timetable OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18480)
-- Name: day_timetable_id_day_timetable_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".day_timetable_id_day_timetable_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".day_timetable_id_day_timetable_seq OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 219
-- Name: day_timetable_id_day_timetable_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".day_timetable_id_day_timetable_seq OWNED BY "CovoiturAFPA".day_timetable.id_day_timetable;


--
-- TOC entry 220 (class 1259 OID 18481)
-- Name: day_week; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".day_week (
    id_day_week integer NOT NULL,
    name "CovoiturAFPA".day_name
);


ALTER TABLE "CovoiturAFPA".day_week OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18484)
-- Name: day_week_id_day_week_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".day_week_id_day_week_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".day_week_id_day_week_seq OWNER TO postgres;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 221
-- Name: day_week_id_day_week_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".day_week_id_day_week_seq OWNED BY "CovoiturAFPA".day_week.id_day_week;


--
-- TOC entry 222 (class 1259 OID 18485)
-- Name: destination; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".destination (
    id_destination integer NOT NULL,
    latitude double precision,
    longitude double precision,
    is_from_afpa boolean,
    id_city integer
);


ALTER TABLE "CovoiturAFPA".destination OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18488)
-- Name: destination_id_destination_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".destination_id_destination_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".destination_id_destination_seq OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 223
-- Name: destination_id_destination_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".destination_id_destination_seq OWNED BY "CovoiturAFPA".destination.id_destination;


--
-- TOC entry 224 (class 1259 OID 18489)
-- Name: employee; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".employee (
    id_person integer NOT NULL,
    role character varying(50),
    is_admin boolean,
    start_contract date,
    end_contract date,
    id_centre integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".employee OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18492)
-- Name: formation; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".formation (
    id_formation integer NOT NULL,
    name character varying(50),
    id_centre integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".formation OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18495)
-- Name: formation_id_formation_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".formation_id_formation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".formation_id_formation_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 226
-- Name: formation_id_formation_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".formation_id_formation_seq OWNED BY "CovoiturAFPA".formation.id_formation;


--
-- TOC entry 227 (class 1259 OID 18496)
-- Name: fuel; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".fuel (
    id_fuel integer NOT NULL,
    name character varying(20),
    price_by_unit numeric(5,2)
);


ALTER TABLE "CovoiturAFPA".fuel OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18499)
-- Name: fuel_id_fuel_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".fuel_id_fuel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".fuel_id_fuel_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 228
-- Name: fuel_id_fuel_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".fuel_id_fuel_seq OWNED BY "CovoiturAFPA".fuel.id_fuel;


--
-- TOC entry 229 (class 1259 OID 18500)
-- Name: happen; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".happen (
    id_ride integer NOT NULL,
    id_day_week integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".happen OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18503)
-- Name: notif_config; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".notif_config (
    id_notif_config integer NOT NULL,
    contact_by_sms boolean
);


ALTER TABLE "CovoiturAFPA".notif_config OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18506)
-- Name: notif_config_id_notif_config_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".notif_config_id_notif_config_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".notif_config_id_notif_config_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 231
-- Name: notif_config_id_notif_config_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".notif_config_id_notif_config_seq OWNED BY "CovoiturAFPA".notif_config.id_notif_config;


--
-- TOC entry 232 (class 1259 OID 18507)
-- Name: notification; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".notification (
    id_notification integer NOT NULL,
    type "CovoiturAFPA".notification_type,
    created_time timestamp without time zone,
    is_unread boolean,
    id_person integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".notification OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18510)
-- Name: notification_id_notification_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".notification_id_notification_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".notification_id_notification_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 233
-- Name: notification_id_notification_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".notification_id_notification_seq OWNED BY "CovoiturAFPA".notification.id_notification;


--
-- TOC entry 234 (class 1259 OID 18511)
-- Name: one_time; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".one_time (
    id_ride integer NOT NULL,
    departure_day date
);


ALTER TABLE "CovoiturAFPA".one_time OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18514)
-- Name: partner; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".partner (
    id_partner integer NOT NULL,
    name character varying(50),
    logo_picture_path character varying(255),
    id_centre integer NOT NULL
);


ALTER TABLE "CovoiturAFPA".partner OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18517)
-- Name: partner_id_partner_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".partner_id_partner_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".partner_id_partner_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 236
-- Name: partner_id_partner_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".partner_id_partner_seq OWNED BY "CovoiturAFPA".partner.id_partner;


--
-- TOC entry 237 (class 1259 OID 18518)
-- Name: person; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".person (
    id_person integer NOT NULL,
    email character varying(50),
    password character varying(50),
    surname character varying(50),
    first_name character varying(20),
    phone_number character varying(20),
    is_activated boolean,
    contact_by_sms boolean,
    contact_by_mail boolean,
    last_login timestamp without time zone,
    photo_path character varying(255),
    person_type character varying NOT NULL
);


ALTER TABLE "CovoiturAFPA".person OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18523)
-- Name: person_id_person_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".person_id_person_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".person_id_person_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 238
-- Name: person_id_person_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".person_id_person_seq OWNED BY "CovoiturAFPA".person.id_person;


--
-- TOC entry 239 (class 1259 OID 18524)
-- Name: recurring; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".recurring (
    id_ride integer NOT NULL,
    beginning date,
    ending date
);


ALTER TABLE "CovoiturAFPA".recurring OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 18527)
-- Name: ride; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".ride (
    id_ride integer NOT NULL,
    is_active boolean,
    departure_time time without time zone,
    comment character varying(255),
    id_destination integer NOT NULL,
    id_car integer NOT NULL,
    price numeric(5,2),
    ride_type character varying NOT NULL
);


ALTER TABLE "CovoiturAFPA".ride OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18532)
-- Name: ride_id_ride_seq; Type: SEQUENCE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE SEQUENCE "CovoiturAFPA".ride_id_ride_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CovoiturAFPA".ride_id_ride_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 241
-- Name: ride_id_ride_seq; Type: SEQUENCE OWNED BY; Schema: CovoiturAFPA; Owner: postgres
--

ALTER SEQUENCE "CovoiturAFPA".ride_id_ride_seq OWNED BY "CovoiturAFPA".ride.id_ride;


--
-- TOC entry 242 (class 1259 OID 18533)
-- Name: ride_passenger; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".ride_passenger (
    id_person integer NOT NULL,
    id_ride integer NOT NULL,
    status "CovoiturAFPA".status_type,
    last_update timestamp without time zone
);


ALTER TABLE "CovoiturAFPA".ride_passenger OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18536)
-- Name: trainee; Type: TABLE; Schema: CovoiturAFPA; Owner: postgres
--

CREATE TABLE "CovoiturAFPA".trainee (
    id_person integer NOT NULL,
    start_training date,
    end_training date,
    id_formation integer
);


ALTER TABLE "CovoiturAFPA".trainee OWNER TO postgres;

--
-- TOC entry 3266 (class 2604 OID 18539)
-- Name: car id_car; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car ALTER COLUMN id_car SET DEFAULT nextval('"CovoiturAFPA".car_id_car_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 18540)
-- Name: car_type id_car_type; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car_type ALTER COLUMN id_car_type SET DEFAULT nextval('"CovoiturAFPA".car_type_id_car_type_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 18541)
-- Name: centre id_centre; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".centre ALTER COLUMN id_centre SET DEFAULT nextval('"CovoiturAFPA".centre_id_centre_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 18542)
-- Name: city id_city; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".city ALTER COLUMN id_city SET DEFAULT nextval('"CovoiturAFPA".city_id_city_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 18543)
-- Name: day_timetable id_day_timetable; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".day_timetable ALTER COLUMN id_day_timetable SET DEFAULT nextval('"CovoiturAFPA".day_timetable_id_day_timetable_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 18544)
-- Name: day_week id_day_week; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".day_week ALTER COLUMN id_day_week SET DEFAULT nextval('"CovoiturAFPA".day_week_id_day_week_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 18545)
-- Name: destination id_destination; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".destination ALTER COLUMN id_destination SET DEFAULT nextval('"CovoiturAFPA".destination_id_destination_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 18546)
-- Name: formation id_formation; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".formation ALTER COLUMN id_formation SET DEFAULT nextval('"CovoiturAFPA".formation_id_formation_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 18547)
-- Name: fuel id_fuel; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".fuel ALTER COLUMN id_fuel SET DEFAULT nextval('"CovoiturAFPA".fuel_id_fuel_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 18548)
-- Name: notif_config id_notif_config; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".notif_config ALTER COLUMN id_notif_config SET DEFAULT nextval('"CovoiturAFPA".notif_config_id_notif_config_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 18549)
-- Name: notification id_notification; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".notification ALTER COLUMN id_notification SET DEFAULT nextval('"CovoiturAFPA".notification_id_notification_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 18550)
-- Name: partner id_partner; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".partner ALTER COLUMN id_partner SET DEFAULT nextval('"CovoiturAFPA".partner_id_partner_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 18551)
-- Name: person id_person; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".person ALTER COLUMN id_person SET DEFAULT nextval('"CovoiturAFPA".person_id_person_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 18552)
-- Name: ride id_ride; Type: DEFAULT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride ALTER COLUMN id_ride SET DEFAULT nextval('"CovoiturAFPA".ride_id_ride_seq'::regclass);


--
-- TOC entry 3482 (class 0 OID 18461)
-- Dependencies: 210
-- Data for Name: car; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".car VALUES (4, 'Porsche Taurus', 6, 4.2, 4, 43);
INSERT INTO "CovoiturAFPA".car VALUES (2, 'BMW ATS', 5, 1.8, 3, 43);
INSERT INTO "CovoiturAFPA".car VALUES (3, 'Chrysler Land Cruiser', 6, 6.3, 1, 45);


--
-- TOC entry 3484 (class 0 OID 18465)
-- Dependencies: 212
-- Data for Name: car_type; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".car_type VALUES (1, 'COMPACT', 7.3, 1);
INSERT INTO "CovoiturAFPA".car_type VALUES (2, 'COMPACT', 7.3, 2);
INSERT INTO "CovoiturAFPA".car_type VALUES (3, 'COMPACT', 5.2, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (4, 'COMPACT', 7.8, 4);
INSERT INTO "CovoiturAFPA".car_type VALUES (5, 'COMPACT', 9.5, 5);
INSERT INTO "CovoiturAFPA".car_type VALUES (6, 'BERLINE', 7.5, 1);
INSERT INTO "CovoiturAFPA".car_type VALUES (7, 'BERLINE', 7.5, 2);
INSERT INTO "CovoiturAFPA".car_type VALUES (8, 'BERLINE', 6.8, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (9, 'BERLINE', 15.6, 4);
INSERT INTO "CovoiturAFPA".car_type VALUES (10, 'BERLINE', 12.2, 5);
INSERT INTO "CovoiturAFPA".car_type VALUES (11, 'SUV', 8.0, 1);
INSERT INTO "CovoiturAFPA".car_type VALUES (12, 'SUV', 8.0, 2);
INSERT INTO "CovoiturAFPA".car_type VALUES (13, 'SUV', 7.2, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (14, 'SUV', 16.0, 4);
INSERT INTO "CovoiturAFPA".car_type VALUES (15, 'SUV', 16.0, 5);
INSERT INTO "CovoiturAFPA".car_type VALUES (16, 'MONOSPACE', 7.0, 1);
INSERT INTO "CovoiturAFPA".car_type VALUES (17, 'MONOSPACE', 7.0, 2);
INSERT INTO "CovoiturAFPA".car_type VALUES (18, 'MONOSPACE', 6.2, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (19, 'MONOSPACE', 15.6, 4);
INSERT INTO "CovoiturAFPA".car_type VALUES (20, 'MONOSPACE', 10.5, 5);
INSERT INTO "CovoiturAFPA".car_type VALUES (21, 'UTILITAIRE', 14.3, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (22, 'UTILITAIRE', 14.3, 2);
INSERT INTO "CovoiturAFPA".car_type VALUES (23, 'UTILITAIRE', 11.6, 3);
INSERT INTO "CovoiturAFPA".car_type VALUES (24, 'UTILITAIRE', 25.0, 4);
INSERT INTO "CovoiturAFPA".car_type VALUES (25, 'UTILITAIRE', 18.6, 5);


--
-- TOC entry 3486 (class 0 OID 18469)
-- Dependencies: 214
-- Data for Name: centre; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".centre VALUES (28, 'Velit explicabo minima rem', '56606 bld Verdun Charlotte', 51.4139, -2.5798, '+33472864830', 13);


--
-- TOC entry 3488 (class 0 OID 18473)
-- Dependencies: 216
-- Data for Name: city; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".city VALUES (1, 'La Rochelle');
INSERT INTO "CovoiturAFPA".city VALUES (2, 'Chatellerault');


--
-- TOC entry 3490 (class 0 OID 18477)
-- Dependencies: 218
-- Data for Name: day_timetable; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".day_timetable VALUES (1, 'MONDAY', '00:00:00', '00:00:00', '00:00:00', '00:00:00', 28);


--
-- TOC entry 3492 (class 0 OID 18481)
-- Dependencies: 220
-- Data for Name: day_week; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".day_week VALUES (1, 'MONDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (2, 'TUESDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (3, 'WEDNESDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (4, 'THURSDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (5, 'FRIDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (6, 'SATURDAY');
INSERT INTO "CovoiturAFPA".day_week VALUES (7, 'SUNDAY');


--
-- TOC entry 3494 (class 0 OID 18485)
-- Dependencies: 222
-- Data for Name: destination; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".destination VALUES (1, 59.9211, 81.1344, false, 1);
INSERT INTO "CovoiturAFPA".destination VALUES (2, 59.9211, 81.1344, true, 2);


--
-- TOC entry 3496 (class 0 OID 18489)
-- Dependencies: 224
-- Data for Name: employee; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".employee VALUES (57, 'administration', false, '2022-01-01', '2022-01-01', 28);
INSERT INTO "CovoiturAFPA".employee VALUES (51, 'formateur', false, '2022-01-01', '2022-01-01', 28);
INSERT INTO "CovoiturAFPA".employee VALUES (97, 'restauration', true, '2022-01-01', '2022-01-01', 28);


--
-- TOC entry 3497 (class 0 OID 18492)
-- Dependencies: 225
-- Data for Name: formation; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".formation VALUES (1, 'Necessitserunt quo cumque', 28);
INSERT INTO "CovoiturAFPA".formation VALUES (4, 'Ullam doloribus praesentium quisqu', 28);
INSERT INTO "CovoiturAFPA".formation VALUES (7, 'Molestias iusto veniam ut cum.', 28);
INSERT INTO "CovoiturAFPA".formation VALUES (2, 'Et quia eerum quo alias nisi magni.', 28);
INSERT INTO "CovoiturAFPA".formation VALUES (5, 'Voluptatrecusandae nisi.', 28);


--
-- TOC entry 3499 (class 0 OID 18496)
-- Dependencies: 227
-- Data for Name: fuel; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".fuel VALUES (1, 'ESSENCE', 1.82);
INSERT INTO "CovoiturAFPA".fuel VALUES (2, 'ESSENCE SUPERTHANOL', 0.82);
INSERT INTO "CovoiturAFPA".fuel VALUES (3, 'GAZOLE', 1.82);
INSERT INTO "CovoiturAFPA".fuel VALUES (4, ' ELECTRIQUE', 0.17);
INSERT INTO "CovoiturAFPA".fuel VALUES (5, 'GPL', 0.87);


--
-- TOC entry 3501 (class 0 OID 18500)
-- Dependencies: 229
-- Data for Name: happen; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".happen VALUES (3, 1);
INSERT INTO "CovoiturAFPA".happen VALUES (3, 2);
INSERT INTO "CovoiturAFPA".happen VALUES (3, 3);
INSERT INTO "CovoiturAFPA".happen VALUES (3, 4);


--
-- TOC entry 3502 (class 0 OID 18503)
-- Dependencies: 230
-- Data for Name: notif_config; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".notif_config VALUES (13, false);


--
-- TOC entry 3504 (class 0 OID 18507)
-- Dependencies: 232
-- Data for Name: notification; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".notification VALUES (82, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 97);
INSERT INTO "CovoiturAFPA".notification VALUES (78, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 97);
INSERT INTO "CovoiturAFPA".notification VALUES (32, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 97);
INSERT INTO "CovoiturAFPA".notification VALUES (93, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 97);
INSERT INTO "CovoiturAFPA".notification VALUES (73, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', true, 43);
INSERT INTO "CovoiturAFPA".notification VALUES (8, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', true, 45);
INSERT INTO "CovoiturAFPA".notification VALUES (30, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 43);
INSERT INTO "CovoiturAFPA".notification VALUES (76, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', true, 45);
INSERT INTO "CovoiturAFPA".notification VALUES (5, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', false, 57);
INSERT INTO "CovoiturAFPA".notification VALUES (25, 'ACCEPTED_RESERVATION', '2022-01-01 00:00:00', true, 51);


--
-- TOC entry 3506 (class 0 OID 18511)
-- Dependencies: 234
-- Data for Name: one_time; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".one_time VALUES (6, '2022-01-01');


--
-- TOC entry 3507 (class 0 OID 18514)
-- Dependencies: 235
-- Data for Name: partner; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".partner VALUES (5, 'Wolff', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/634.jpg', 28);
INSERT INTO "CovoiturAFPA".partner VALUES (4, 'Botsford', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/119.jpg', 28);


--
-- TOC entry 3509 (class 0 OID 18518)
-- Dependencies: 237
-- Data for Name: person; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".person VALUES (43, 'MadgeSmith@mail.fr', 'b4lnkw50s5kvt9cx01m7', 'Bergnaum', 'Karson', '+33672728649', false, true, true, '2022-01-01 00:00:00', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1223.jpg', 'T');
INSERT INTO "CovoiturAFPA".person VALUES (45, 'KrystelRath@mail.fr', 'v60zs9egqj9n65aec37j', 'Howell', 'Godfrey', '+33430830984', false, true, true, '2022-01-01 00:00:00', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/390.jpg', 'T');
INSERT INTO "CovoiturAFPA".person VALUES (97, 'OdaBoyle@mail.fr', 'bnbhmg8jufhon5zc6z8j', 'Leffler', 'Billie', '+33458210191', false, false, true, '2022-01-01 00:00:00', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/658.jpg', 'E');
INSERT INTO "CovoiturAFPA".person VALUES (51, 'MohammadGreenfelder@mail.fr', '6sjngbrc3t1tigidn826', 'Bailey', 'Wava', '+33983567107', true, false, false, '2022-01-01 00:00:00', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/420.jpg', 'E');
INSERT INTO "CovoiturAFPA".person VALUES (57, 'CristopherWolf@mail.fr', 'movlejxx6c3fpybxlw6o', 'Weber', 'Casper', '+33511397860', false, false, false, '2022-01-01 00:00:00', 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/684.jpg', 'E');


--
-- TOC entry 3511 (class 0 OID 18524)
-- Dependencies: 239
-- Data for Name: recurring; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".recurring VALUES (3, '2022-01-01', '2022-03-01');


--
-- TOC entry 3512 (class 0 OID 18527)
-- Dependencies: 240
-- Data for Name: ride; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".ride VALUES (6, true, '00:00:00', 'Es. Re ullam accusantium neque odio repudiandae natus. Inventore numquam accusantium sed sint.', 1, 4, 10.00, 'O');
INSERT INTO "CovoiturAFPA".ride VALUES (3, true, '00:00:00', 'Et doloribus velit rem. Quidem dolore consequatur voluptate excepturi aut accusamus a.', 2, 2, 15.00, 'R');


--
-- TOC entry 3514 (class 0 OID 18533)
-- Dependencies: 242
-- Data for Name: ride_passenger; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".ride_passenger VALUES (51, 3, 'PENDING', '2022-03-01 00:00:00');
INSERT INTO "CovoiturAFPA".ride_passenger VALUES (57, 3, 'PENDING', '2022-03-01 00:00:00');
INSERT INTO "CovoiturAFPA".ride_passenger VALUES (51, 6, 'PENDING', '2022-03-01 00:00:00');


--
-- TOC entry 3515 (class 0 OID 18536)
-- Dependencies: 243
-- Data for Name: trainee; Type: TABLE DATA; Schema: CovoiturAFPA; Owner: postgres
--

INSERT INTO "CovoiturAFPA".trainee VALUES (43, '2022-01-01', '2022-01-01', 1);
INSERT INTO "CovoiturAFPA".trainee VALUES (45, '2022-01-01', '2022-01-01', 4);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 211
-- Name: car_id_car_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".car_id_car_seq', 1, false);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 213
-- Name: car_type_id_car_type_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".car_type_id_car_type_seq', 1, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 215
-- Name: centre_id_centre_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".centre_id_centre_seq', 1, false);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 217
-- Name: city_id_city_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".city_id_city_seq', 1, false);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 219
-- Name: day_timetable_id_day_timetable_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".day_timetable_id_day_timetable_seq', 1, false);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 221
-- Name: day_week_id_day_week_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".day_week_id_day_week_seq', 1, false);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 223
-- Name: destination_id_destination_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".destination_id_destination_seq', 1, false);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 226
-- Name: formation_id_formation_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".formation_id_formation_seq', 1, false);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 228
-- Name: fuel_id_fuel_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".fuel_id_fuel_seq', 1, false);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 231
-- Name: notif_config_id_notif_config_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".notif_config_id_notif_config_seq', 1, false);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 233
-- Name: notification_id_notification_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".notification_id_notification_seq', 1, false);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 236
-- Name: partner_id_partner_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".partner_id_partner_seq', 1, false);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 238
-- Name: person_id_person_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".person_id_person_seq', 1, false);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 241
-- Name: ride_id_ride_seq; Type: SEQUENCE SET; Schema: CovoiturAFPA; Owner: postgres
--

SELECT pg_catalog.setval('"CovoiturAFPA".ride_id_ride_seq', 1, false);


--
-- TOC entry 3281 (class 2606 OID 18554)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car
    ADD CONSTRAINT car_pkey PRIMARY KEY (id_car);


--
-- TOC entry 3283 (class 2606 OID 18556)
-- Name: car_type car_type_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car_type
    ADD CONSTRAINT car_type_pkey PRIMARY KEY (id_car_type);


--
-- TOC entry 3285 (class 2606 OID 18558)
-- Name: centre centre_id_notif_config_key; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".centre
    ADD CONSTRAINT centre_id_notif_config_key UNIQUE (id_notif_config);


--
-- TOC entry 3287 (class 2606 OID 18560)
-- Name: centre centre_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".centre
    ADD CONSTRAINT centre_pkey PRIMARY KEY (id_centre);


--
-- TOC entry 3289 (class 2606 OID 18562)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id_city);


--
-- TOC entry 3291 (class 2606 OID 18564)
-- Name: day_timetable day_timetable_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".day_timetable
    ADD CONSTRAINT day_timetable_pkey PRIMARY KEY (id_day_timetable);


--
-- TOC entry 3293 (class 2606 OID 18566)
-- Name: day_week day_week_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".day_week
    ADD CONSTRAINT day_week_pkey PRIMARY KEY (id_day_week);


--
-- TOC entry 3295 (class 2606 OID 18568)
-- Name: destination destination_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".destination
    ADD CONSTRAINT destination_pkey PRIMARY KEY (id_destination);


--
-- TOC entry 3297 (class 2606 OID 18570)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_person);


--
-- TOC entry 3299 (class 2606 OID 18572)
-- Name: formation formation_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".formation
    ADD CONSTRAINT formation_pkey PRIMARY KEY (id_formation);


--
-- TOC entry 3301 (class 2606 OID 18574)
-- Name: fuel fuel_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".fuel
    ADD CONSTRAINT fuel_pkey PRIMARY KEY (id_fuel);


--
-- TOC entry 3303 (class 2606 OID 18576)
-- Name: happen happen_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".happen
    ADD CONSTRAINT happen_pkey PRIMARY KEY (id_ride, id_day_week);


--
-- TOC entry 3305 (class 2606 OID 18578)
-- Name: notif_config notif_config_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".notif_config
    ADD CONSTRAINT notif_config_pkey PRIMARY KEY (id_notif_config);


--
-- TOC entry 3307 (class 2606 OID 18580)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id_notification);


--
-- TOC entry 3309 (class 2606 OID 18582)
-- Name: one_time one_time_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".one_time
    ADD CONSTRAINT one_time_pkey PRIMARY KEY (id_ride);


--
-- TOC entry 3311 (class 2606 OID 18584)
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id_partner);


--
-- TOC entry 3313 (class 2606 OID 18586)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id_person);


--
-- TOC entry 3315 (class 2606 OID 18588)
-- Name: recurring recurring_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".recurring
    ADD CONSTRAINT recurring_pkey PRIMARY KEY (id_ride);


--
-- TOC entry 3319 (class 2606 OID 18590)
-- Name: ride_passenger ride_passenger_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride_passenger
    ADD CONSTRAINT ride_passenger_pkey PRIMARY KEY (id_person, id_ride);


--
-- TOC entry 3317 (class 2606 OID 18592)
-- Name: ride ride_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride
    ADD CONSTRAINT ride_pkey PRIMARY KEY (id_ride);


--
-- TOC entry 3321 (class 2606 OID 18594)
-- Name: trainee trainee_pkey; Type: CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".trainee
    ADD CONSTRAINT trainee_pkey PRIMARY KEY (id_person);


--
-- TOC entry 3322 (class 2606 OID 18595)
-- Name: car car_id_car_type_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car
    ADD CONSTRAINT car_id_car_type_fkey FOREIGN KEY (id_car_type) REFERENCES "CovoiturAFPA".car_type(id_car_type);


--
-- TOC entry 3323 (class 2606 OID 18600)
-- Name: car car_id_person_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car
    ADD CONSTRAINT car_id_person_fkey FOREIGN KEY (id_person) REFERENCES "CovoiturAFPA".person(id_person);


--
-- TOC entry 3324 (class 2606 OID 18605)
-- Name: car_type car_type_id_fuel_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".car_type
    ADD CONSTRAINT car_type_id_fuel_fkey FOREIGN KEY (id_fuel) REFERENCES "CovoiturAFPA".fuel(id_fuel);


--
-- TOC entry 3325 (class 2606 OID 18610)
-- Name: centre centre_id_notif_config_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".centre
    ADD CONSTRAINT centre_id_notif_config_fkey FOREIGN KEY (id_notif_config) REFERENCES "CovoiturAFPA".notif_config(id_notif_config);


--
-- TOC entry 3326 (class 2606 OID 18615)
-- Name: day_timetable day_timetable_id_centre_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".day_timetable
    ADD CONSTRAINT day_timetable_id_centre_fkey FOREIGN KEY (id_centre) REFERENCES "CovoiturAFPA".centre(id_centre);


--
-- TOC entry 3327 (class 2606 OID 18620)
-- Name: destination destination_id_city_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".destination
    ADD CONSTRAINT destination_id_city_fkey FOREIGN KEY (id_city) REFERENCES "CovoiturAFPA".city(id_city);


--
-- TOC entry 3328 (class 2606 OID 18625)
-- Name: employee employee_id_centre_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".employee
    ADD CONSTRAINT employee_id_centre_fkey FOREIGN KEY (id_centre) REFERENCES "CovoiturAFPA".centre(id_centre);


--
-- TOC entry 3329 (class 2606 OID 18630)
-- Name: employee employee_id_person_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".employee
    ADD CONSTRAINT employee_id_person_fkey FOREIGN KEY (id_person) REFERENCES "CovoiturAFPA".person(id_person);


--
-- TOC entry 3330 (class 2606 OID 18635)
-- Name: formation formation_id_centre_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".formation
    ADD CONSTRAINT formation_id_centre_fkey FOREIGN KEY (id_centre) REFERENCES "CovoiturAFPA".centre(id_centre);


--
-- TOC entry 3331 (class 2606 OID 18640)
-- Name: happen happen_id_day_week_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".happen
    ADD CONSTRAINT happen_id_day_week_fkey FOREIGN KEY (id_day_week) REFERENCES "CovoiturAFPA".day_week(id_day_week);


--
-- TOC entry 3332 (class 2606 OID 18645)
-- Name: happen happen_id_ride_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".happen
    ADD CONSTRAINT happen_id_ride_fkey FOREIGN KEY (id_ride) REFERENCES "CovoiturAFPA".recurring(id_ride);


--
-- TOC entry 3333 (class 2606 OID 18650)
-- Name: notification notification_id_person_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".notification
    ADD CONSTRAINT notification_id_person_fkey FOREIGN KEY (id_person) REFERENCES "CovoiturAFPA".person(id_person);


--
-- TOC entry 3334 (class 2606 OID 18655)
-- Name: one_time one_time_id_ride_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".one_time
    ADD CONSTRAINT one_time_id_ride_fkey FOREIGN KEY (id_ride) REFERENCES "CovoiturAFPA".ride(id_ride);


--
-- TOC entry 3335 (class 2606 OID 18660)
-- Name: partner partner_id_centre_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".partner
    ADD CONSTRAINT partner_id_centre_fkey FOREIGN KEY (id_centre) REFERENCES "CovoiturAFPA".centre(id_centre);


--
-- TOC entry 3336 (class 2606 OID 18665)
-- Name: recurring recurring_id_ride_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".recurring
    ADD CONSTRAINT recurring_id_ride_fkey FOREIGN KEY (id_ride) REFERENCES "CovoiturAFPA".ride(id_ride);


--
-- TOC entry 3337 (class 2606 OID 18670)
-- Name: ride ride_id_car_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride
    ADD CONSTRAINT ride_id_car_fkey FOREIGN KEY (id_car) REFERENCES "CovoiturAFPA".car(id_car);


--
-- TOC entry 3338 (class 2606 OID 18675)
-- Name: ride ride_id_destination_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride
    ADD CONSTRAINT ride_id_destination_fkey FOREIGN KEY (id_destination) REFERENCES "CovoiturAFPA".destination(id_destination);


--
-- TOC entry 3339 (class 2606 OID 18680)
-- Name: ride_passenger ride_passenger_id_person_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride_passenger
    ADD CONSTRAINT ride_passenger_id_person_fkey FOREIGN KEY (id_person) REFERENCES "CovoiturAFPA".person(id_person);


--
-- TOC entry 3340 (class 2606 OID 18685)
-- Name: ride_passenger ride_passenger_id_ride_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".ride_passenger
    ADD CONSTRAINT ride_passenger_id_ride_fkey FOREIGN KEY (id_ride) REFERENCES "CovoiturAFPA".ride(id_ride);


--
-- TOC entry 3341 (class 2606 OID 18690)
-- Name: trainee trainee_id_formation_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".trainee
    ADD CONSTRAINT trainee_id_formation_fkey FOREIGN KEY (id_formation) REFERENCES "CovoiturAFPA".formation(id_formation);


--
-- TOC entry 3342 (class 2606 OID 18695)
-- Name: trainee trainee_id_person_fkey; Type: FK CONSTRAINT; Schema: CovoiturAFPA; Owner: postgres
--

ALTER TABLE ONLY "CovoiturAFPA".trainee
    ADD CONSTRAINT trainee_id_person_fkey FOREIGN KEY (id_person) REFERENCES "CovoiturAFPA".person(id_person);


-- Completed on 2022-09-07 16:41:52

--
-- PostgreSQL database dump complete
--

