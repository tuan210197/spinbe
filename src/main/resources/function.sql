-- FUNCTION: sp.choose_1()

-- DROP FUNCTION IF EXISTS sp.choose_1();

CREATE OR REPLACE FUNCTION sp.choose_1(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, joins character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
bu_choose character varying;
joinable numeric;
total numeric;
inserted_count INTEGER := 0;

BEGIN
LOOP
bu_choose = (select * from sp.random_bu(1));
joinable = (select count(*) from sp.first f where f.joins = 'Y');
total = (select count(*) from sp.first);

if (joinable < 2 and total <12) then

insert into sp.first (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.dept from sp.user u
where u.working_time = 'B' and u.joins = 'Y' and u.dept = bu_choose --'JBD'
AND u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
--CALL sp.update_prize(bu_choose);
--return query select f.code, f.vn_name, f.bu, f.joins from sp.first f order by f.id desc limit 1;

elseif (total <12 and joinable >= 2) then
raise notice 'total <12 and joinable >= 2';
raise notice 'INSERT1: %',(

select u.code from sp.user u
where u.working_time = 'B'  and u.bu = bu_choose
AND u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1
);
--raise notice 'bu: %', bu_choose;

insert into sp.first (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.dept from sp.user u
where u.working_time = 'B'  and u.dept = bu_choose
AND u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
--CALL sp.update_prize(bu_choose);
--return query select f.code, f.vn_name, f.bu, f.joins from sp.first f order by f.id desc limit 1;
end if;
GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,1);

			return query select f.code, f.vn_name, f.bu, f.joins from sp.first f order by f.id desc limit 1;
            EXIT;
        ELSE
		-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_1()
    OWNER TO postgres;


-- FUNCTION: sp.choose_2a()

-- DROP FUNCTION IF EXISTS sp.choose_2a();

CREATE OR REPLACE FUNCTION sp.choose_2a(
	)
    RETURNS TABLE(code character varying, vn_name character varying, joins character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
joinable bigint;
inserted_count INTEGER := 0;

BEGIN

 LOOP
working1 = (select count(*) from sp.second s where s.working_time = 'A');

bu_choose = (select * from sp.random_bu(2));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

joinable = (select count(*) from sp.second f where f.joins = 'Y' and f.working_time = 'A');

if(joinable <1 ) then
raise notice 'đã vào joinable <1';
	if (working1 < 6) then
	raise notice 'đã vào working1 < 6';

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'A' and u.joins = 'Y' and u.dept = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	END IF;
END IF;
IF(joinable >= 1) THEN
	if (working1 < 6 ) then
	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'A' and u.dept = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	END IF;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,2);
			return query select s.code, s.vn_name,  s.joins, s.bu, s.working_time from sp.second s order by s.id desc limit 1;
            EXIT;
        ELSE
		 	-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;

END;
$BODY$;

ALTER FUNCTION sp.choose_2a()
    OWNER TO postgres;

-- FUNCTION: sp.choose_2b()

-- DROP FUNCTION IF EXISTS sp.choose_2b();

CREATE OR REPLACE FUNCTION sp.choose_2b(
	)
    RETURNS TABLE(code character varying, vn_name character varying, joins character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
joinable bigint;
inserted_count INTEGER := 0;

BEGIN

 LOOP
working1 = (select count(*) from sp.second s where s.working_time = 'B');

bu_choose = (select * from sp.random_bu(2));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

joinable = (select count(*) from sp.second f where f.joins = 'Y' and f.working_time = 'B');

if(joinable <1 ) then
raise notice 'đã vào joinable <1';
	if (working1 < 6) then
	raise notice 'đã vào working1 < 6';

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'B' and u.joins = 'Y' and u.dept = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	END IF;
END IF;
IF(joinable >= 1) THEN
	if (working1 < 6 ) then
	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'B' and u.dept = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	END IF;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,2);
			return query select s.code, s.vn_name,  s.joins, s.bu, s.working_time from sp.second s order by s.id desc limit 1;
            EXIT;
        ELSE
		 	-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;

END;
$BODY$;

ALTER FUNCTION sp.choose_2b()
    OWNER TO postgres;


-- FUNCTION: sp.choose_3a()

-- DROP FUNCTION IF EXISTS sp.choose_3a();

CREATE OR REPLACE FUNCTION sp.choose_3a(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
inserted_count INTEGER := 0;

BEGIN
LOOP
working1 = (select count(*) from sp.third s where s.working_time = 'A');

bu_choose = (select * from sp.random_bu(3));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if (working1 < 35 ) then
insert into sp.third (code, vn_name, bu, working_time)
select u.code, u.vn_name, u.dept, u.working_time from sp.user u
where u.dept =bu_choose and u.working_time = 'A'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,3);

			return query select t.code, t.vn_name, t.bu, t.working_time from sp.third t order by t.id desc limit 1;
            EXIT;
        ELSE
		-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_3a()
    OWNER TO postgres;



-- FUNCTION: sp.choose_3b()

-- DROP FUNCTION IF EXISTS sp.choose_3b();

CREATE OR REPLACE FUNCTION sp.choose_3b(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
inserted_count INTEGER := 0;

BEGIN
LOOP
working1 = (select count(*) from sp.third s where s.working_time = 'B');

bu_choose = (select * from sp.random_bu(3));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if (working1 < 35 ) then
insert into sp.third (code, vn_name, bu, working_time)
select u.code, u.vn_name, u.dept, u.working_time from sp.user u
where u.dept =bu_choose and u.working_time = 'B'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,3);

			return query select t.code, t.vn_name, t.bu, t.working_time from sp.third t order by t.id desc limit 1;
            EXIT;
        ELSE
		-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_3b()
    OWNER TO postgres;


-- FUNCTION: sp.choose_4a()

-- DROP FUNCTION IF EXISTS sp.choose_4a();

CREATE OR REPLACE FUNCTION sp.choose_4a(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
inserted_count INTEGER := 0;

BEGIN
LOOP
working1 = (select count(*) from sp.four s where s.working_time = 'A');

bu_choose = (select * from sp.random_bu(4));
-- working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if(working1 < 68 ) then
raise notice 'working1: %', working1;
insert into sp.four (code, vn_name,bu, working_time)
select u.code, u.vn_name,  u.dept, u.working_time from sp.user u
where  u.dept = bu_choose and u.working_time = 'A'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN

            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,4);
			return query select f.code, f.vn_name, f.bu, f.working_time from sp.four f order by f.id desc limit 1;
            EXIT;
        ELSE

            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_4a()
    OWNER TO postgres;


-- FUNCTION: sp.choose_4b()

-- DROP FUNCTION IF EXISTS sp.choose_4b();

CREATE OR REPLACE FUNCTION sp.choose_4b(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, working_time character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
bu_choose character varying;
working1 numeric;
working2 numeric;
working_choose character varying;
inserted_count INTEGER := 0;

BEGIN

LOOP
working1 = (select count(*) from sp.four s where s.working_time = 'B');

-- working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if(working1 < 67 ) then
bu_choose = (select * from sp.random_bu(4));
raise notice 'working1: %', working1;
RAISE NOTICE 'BU: %', bu_choose;

insert into sp.four (code, vn_name,bu, working_time)
select u.code, u.vn_name,  u.dept, u.working_time from sp.user u
where  u.dept = bu_choose  and u.working_time = 'B'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN

            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,4);
			return query select f.code, f.vn_name, f.bu, f.working_time from sp.four f order by f.id desc limit 1;
            EXIT;
        ELSE

            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_4b()
    OWNER TO postgres;


-- FUNCTION: sp.choose_special()

-- DROP FUNCTION IF EXISTS sp.choose_special();

CREATE OR REPLACE FUNCTION sp.choose_special(
	)
    RETURNS TABLE(code character varying, vn_name character varying, bu character varying, joins character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare
bu_choose character varying;
joinable numeric;
total numeric;
inserted_count INTEGER := 0;
BEGIN

LOOP

bu_choose = (select * from sp.random_bu(0));

joinable = (select count(*) from sp.special s where s.joins = 'Y');

total = (select count(*) from sp.special);



if (joinable <1 and total < 6) then
raise notice 'đã vào 0';

insert into sp.special (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.dept from sp.user u
where u.working_time = 'B' and u.joins = 'Y' and u.dept = bu_choose
AND u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
-- CALL sp.update_prize(bu_choose);
-- return query select s.code, s.vn_name,s.bu, s.joins from sp.special s order by s.id desc limit 1;
-- raise notice 'id: %',(select s.id from sp.special s order by s.id desc limit 1);
elseif(joinable >=1 and total < 6) then

raise notice 'đã vào 1';

insert into sp.special (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.dept from sp.user u
where u.working_time = 'B' and u.dept = bu_choose
AND u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
-- CALL sp.update_prize(bu_choose);
-- return query select s.code, s.vn_name, s.bu, s.joins from sp.special s order by s.id desc limit 1;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose,0);
			return query select s.code, s.vn_name, s.bu, s.joins from sp.special s order by s.id desc limit 1;
            EXIT;
        ELSE
		-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_special()
    OWNER TO postgres;


-- FUNCTION: sp.random_bu(integer)

-- DROP FUNCTION IF EXISTS sp.random_bu(integer);

CREATE OR REPLACE FUNCTION sp.random_bu(
	prize_in integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    selected_bu VARCHAR;
BEGIN
    -- Điều kiện để chọn BU dựa trên prize_in
    IF prize_in = 0 THEN
        SELECT bu INTO selected_bu
        FROM sp.prize
        WHERE act_special < plan_special
        ORDER BY random()
        LIMIT 1;

    ELSIF prize_in = 1 THEN
        SELECT bu INTO selected_bu
        FROM sp.prize
        WHERE act_first < plan_first
        ORDER BY random()
        LIMIT 1;

    ELSIF prize_in = 2 THEN
        SELECT bu INTO selected_bu
        FROM sp.prize
        WHERE act_second < plan_second
        ORDER BY random()
        LIMIT 1;

    ELSIF prize_in = 3 THEN
        SELECT bu INTO selected_bu
        FROM sp.prize
        WHERE act_third < plan_third
        ORDER BY random()
        LIMIT 1;

    ELSIF prize_in = 4 THEN
        SELECT bu INTO selected_bu
        FROM sp.prize
        WHERE act_four < plan_four
        ORDER BY random()
        LIMIT 1;

    ELSE
        RAISE EXCEPTION 'Invalid prize_in value: %', prize_in;
    END IF;

    -- Trả về BU đã chọn
    RETURN selected_bu;
END;
$BODY$;

ALTER FUNCTION sp.random_bu(integer)
    OWNER TO postgres;

-- FUNCTION: sp.show_congra(bigint)

-- DROP FUNCTION IF EXISTS sp.show_congra(bigint);

CREATE OR REPLACE FUNCTION sp.show_congra(
	num bigint)
    RETURNS TABLE(id bigint, number bigint, count bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare
counts bigint;
checks bigint;
BEGIN
raise notice 'num: %',num;
counts =(select count(*) from sp.user
where right(code,2) = to_char(num,'FM00'));

raise notice 'sql: %','select count(*) from sp.user
where right(code,2) = to_char('||num||',''FM00'')';
checks = (select count(*) from sp.congra c where c.number = num);

if( checks = 0) then
insert into sp.congra(number, count) values (num, counts);
return query  select * from sp.congra c where c.number = num limit 1;
else
return query  select * from sp.congra c where c.number = num limit 1;

end if;
END;
$BODY$;

ALTER FUNCTION sp.show_congra(bigint)
    OWNER TO postgres;


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
-- Table: sp.prize

-- DROP TABLE IF EXISTS sp.prize;

CREATE TABLE IF NOT EXISTS sp.prize
(
    bu character varying COLLATE pg_catalog."default" NOT NULL,
    plan numeric,
    actual numeric,
    "number" bigint,
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    checks numeric,
    ratiodb numeric,
    ratio1 numeric,
    ratio2 numeric,
    ratio3 numeric,
    ratio4 numeric,
    act_special numeric,
    act_first numeric,
    act_second numeric,
    act_third numeric,
    act_four numeric,
    plan_special numeric,
    plan_first numeric,
    plan_second numeric,
    plan_third numeric,
    plan_four numeric,
    CONSTRAINT prize_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS sp.prize
    OWNER to postgres;