-- Insert personAdmin/formation/employee/teacher_of/car pour l'admin et test
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
INSERT INTO covoiturafpa.car VALUES (1, 'Super Admin Car', 4, 7.3, 1, 1);
SELECT pg_catalog.setval('covoiturafpa.person_id_person_seq', 1, true);



--Function/Trigger pour qu'il soit impossible de supprimer l'admin (id=1)
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



-- Role user
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


