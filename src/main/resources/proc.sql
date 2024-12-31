-- PROCEDURE: sp.delete_all()

-- DROP PROCEDURE IF EXISTS sp.delete_all();

CREATE OR REPLACE PROCEDURE sp.delete_all(
	)
LANGUAGE 'sql'
AS $BODY$
delete from sp.congra;
delete from sp.first;
delete from sp.four;
delete from sp.second;
delete from sp.third;
delete from sp.special;
delete from sp.on_delete;
update sp.prize set actual = 0;
update sp.prize set act_special =0,
act_first =0, act_second =0,act_third = 0, act_four = 0;
$BODY$;
ALTER PROCEDURE sp.delete_all()
    OWNER TO postgres;
-- PROCEDURE: sp.loop()

-- DROP PROCEDURE IF EXISTS sp.loop();

CREATE OR REPLACE PROCEDURE sp.loop(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
FOR i in 1..65 loop
PERFORM  * from sp.choose_4a();
end loop;
FOR i in 1..70 loop
PERFORM  * from sp.choose_4b();
end loop;
FOR j in 1..34 loop
PERFORM * from sp.choose_3a();
end loop;
FOR j in 1..36 loop
PERFORM * from sp.choose_3b();
end loop;
FOR k in 1..6 loop
PERFORM * from sp.choose_2a();
end loop;
FOR k in 1..6 loop
PERFORM * from sp.choose_2b();
end loop;
FOR m in 1..12 loop
PERFORM * from sp.choose_1();
end loop;

FOR n in 1..6 loop
PERFORM * from sp.choose_special();
end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_first()

-- DROP PROCEDURE IF EXISTS sp.loop_first();

CREATE OR REPLACE PROCEDURE sp.loop_first(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

FOR m in 1..12 loop
raise notice 'm: %', m;
PERFORM * from sp.choose_1();
end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_first()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_four()

-- DROP PROCEDURE IF EXISTS sp.loop_four();

CREATE OR REPLACE PROCEDURE sp.loop_four(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
-- FOR n in 1..6 loop
-- raise notice 'n: %', n;
-- PERFORM * from sp.choose_special();
-- end loop;

-- FOR m in 1..12 loop
-- raise notice 'm: %', m;
-- PERFORM * from sp.choose_1();
-- end loop;
-- FOR k in 1..12 loop
-- raise notice 'k: %', k;
-- PERFORM * from sp.choose_2();
-- end loop;

-- FOR j in 1..70 loop
-- raise notice 'j: %', j;
-- PERFORM * from sp.choose_3();
-- end loop;

FOR i in 1..135 loop
raise notice 'i: %', i;
PERFORM  * from sp.choose_4();
end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_four()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_four_a()

-- DROP PROCEDURE IF EXISTS sp.loop_four_a();

CREATE OR REPLACE PROCEDURE sp.loop_four_a(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

FOR i in 1..10 loop
raise notice 'i: %', i;
PERFORM  * from sp.choose_4a();
end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_four_a()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_four_b()

-- DROP PROCEDURE IF EXISTS sp.loop_four_b();

CREATE OR REPLACE PROCEDURE sp.loop_four_b(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

FOR i in 1..10 loop
raise notice 'i: %', i;
PERFORM  * from sp.choose_4b();
end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_four_b()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_second()

-- DROP PROCEDURE IF EXISTS sp.loop_second();

CREATE OR REPLACE PROCEDURE sp.loop_second(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
-- FOR n in 1..6 loop
-- raise notice 'n: %', n;
-- PERFORM * from sp.choose_special();
-- end loop;

-- FOR m in 1..12 loop
-- raise notice 'm: %', m;
-- PERFORM * from sp.choose_1();
-- end loop;
FOR k in 1..12 loop
raise notice 'k: %', k;
PERFORM * from sp.choose_2();
end loop;

-- FOR j in 1..70 loop
-- raise notice 'j: %', j;
-- PERFORM * from sp.choose_3();
-- end loop;

-- FOR i in 1..135 loop
-- raise notice 'i: %', i;
-- PERFORM  * from sp.choose_4();
-- end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_second()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_special()

-- DROP PROCEDURE IF EXISTS sp.loop_special();

CREATE OR REPLACE PROCEDURE sp.loop_special(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
FOR n in 1..6 loop
raise notice 'n: %', n;
PERFORM * from sp.choose_special();
end loop;

-- FOR m in 1..12 loop
-- raise notice 'm: %', m;
-- PERFORM * from sp.choose_1();
-- end loop;
-- FOR k in 1..12 loop
-- raise notice 'k: %', k;
-- PERFORM * from sp.choose_2();
-- end loop;

-- FOR j in 1..70 loop
-- raise notice 'j: %', j;
-- PERFORM * from sp.choose_3();
-- end loop;

-- FOR i in 1..135 loop
-- raise notice 'i: %', i;
-- PERFORM  * from sp.choose_4();
-- end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_special()
    OWNER TO postgres;
-- PROCEDURE: sp.loop_third()

-- DROP PROCEDURE IF EXISTS sp.loop_third();

CREATE OR REPLACE PROCEDURE sp.loop_third(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
-- FOR n in 1..6 loop
-- raise notice 'n: %', n;
-- PERFORM * from sp.choose_special();
-- end loop;

-- FOR m in 1..12 loop
-- raise notice 'm: %', m;
-- PERFORM * from sp.choose_1();
-- end loop;
-- FOR k in 1..12 loop
-- raise notice 'k: %', k;
-- PERFORM * from sp.choose_2();
-- end loop;

FOR j in 1..70 loop
raise notice 'j: %', j;
PERFORM * from sp.choose_3();
end loop;

-- FOR i in 1..135 loop
-- raise notice 'i: %', i;
-- PERFORM  * from sp.choose_4();
-- end loop;

END;

$BODY$;
ALTER PROCEDURE sp.loop_third()
    OWNER TO postgres;
-- PROCEDURE: sp.on_delete1(character varying)

-- DROP PROCEDURE IF EXISTS sp.on_delete1(character varying);

CREATE OR REPLACE PROCEDURE sp.on_delete1(
	IN bu_delete character varying)
LANGUAGE 'sql'
AS $BODY$

update sp.prize  set
 act_first = act_first - 1
 where bu = bu_delete;
$BODY$;
ALTER PROCEDURE sp.on_delete1(character varying)
    OWNER TO postgres;
-- PROCEDURE: sp.on_delete2(character varying)

-- DROP PROCEDURE IF EXISTS sp.on_delete2(character varying);

CREATE OR REPLACE PROCEDURE sp.on_delete2(
	IN bu_delete character varying)
LANGUAGE 'sql'
AS $BODY$

update sp.prize  set
 act_second = act_second - 1
 where bu = bu_delete;

$BODY$;
ALTER PROCEDURE sp.on_delete2(character varying)
    OWNER TO postgres;
-- PROCEDURE: sp.on_deletedb(character varying)

-- DROP PROCEDURE IF EXISTS sp.on_deletedb(character varying);

CREATE OR REPLACE PROCEDURE sp.on_deletedb(
	IN bu_delete character varying)
LANGUAGE 'sql'
AS $BODY$

update sp.prize  set
 act_special = act_special - 1
 where bu = bu_delete;
$BODY$;
ALTER PROCEDURE sp.on_deletedb(character varying)
    OWNER TO postgres;
-- PROCEDURE: sp.update_prize(character varying, integer)

-- DROP PROCEDURE IF EXISTS sp.update_prize(character varying, integer);

CREATE OR REPLACE PROCEDURE sp.update_prize(
	IN bu_choose character varying,
	IN prize_choose integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF prize_choose = 0 THEN
        UPDATE sp.prize
        SET act_special = act_special + 1
        WHERE bu = bu_choose;
    ELSIF prize_choose = 1 THEN
        UPDATE sp.prize
        SET act_first = act_first + 1
        WHERE bu = bu_choose;
    ELSIF prize_choose = 2 THEN
        UPDATE sp.prize
        SET act_second = act_second + 1
        WHERE bu = bu_choose;
    ELSIF prize_choose = 3 THEN
        UPDATE sp.prize
        SET act_third = act_third + 1
        WHERE bu = bu_choose;
    ELSIF prize_choose = 4 THEN
        UPDATE sp.prize
        SET act_four = act_four + 1
        WHERE bu = bu_choose;
    END IF;
END;
$BODY$;
ALTER PROCEDURE sp.update_prize(character varying, integer)
    OWNER TO postgres;
