-- FUNCTION: sp.check_first()

-- DROP FUNCTION IF EXISTS sp.check_first();

CREATE OR REPLACE FUNCTION sp.check_first(
	)
    RETURNS TABLE(counts bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
counts bigint;
BEGIN

select count(*) into counts from sp.first where receive = 1;
return QUERY select counts;
END;
$BODY$;

ALTER FUNCTION sp.check_first()
    OWNER TO postgres;
-- FUNCTION: sp.check_four()

-- DROP FUNCTION IF EXISTS sp.check_four();

CREATE OR REPLACE FUNCTION sp.check_four(
	)
    RETURNS TABLE(counts bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
counts bigint;
BEGIN

select count(*) into counts from sp.four;
return QUERY select counts;
END;
$BODY$;

ALTER FUNCTION sp.check_four()
    OWNER TO postgres;
-- FUNCTION: sp.check_second()

-- DROP FUNCTION IF EXISTS sp.check_second();

CREATE OR REPLACE FUNCTION sp.check_second(
	)
    RETURNS TABLE(counts bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
counts bigint;
BEGIN

select count(*) into counts from sp.second where receive = 1;
return QUERY select counts;
END;
$BODY$;

ALTER FUNCTION sp.check_second()
    OWNER TO postgres;
-- FUNCTION: sp.check_third()

-- DROP FUNCTION IF EXISTS sp.check_third();

CREATE OR REPLACE FUNCTION sp.check_third(
	)
    RETURNS TABLE(counts bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
counts bigint;
BEGIN

select count(*) into counts from sp.third;
return QUERY select counts;
END;
$BODY$;

ALTER FUNCTION sp.check_third()
    OWNER TO postgres;
-- FUNCTION: sp.choose_1()

-- DROP FUNCTION IF EXISTS sp.choose_1();

CREATE OR REPLACE FUNCTION sp.choose_1(
	)
    RETURNS TABLE(id bigint, code character varying, vn_name character varying, bu character varying, joins character varying, receive bigint)
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
joinable = (select count(*) from sp.first f where f.joins = 'Y' and f.receive = 1);
total = (select count(*) from sp.first f where f.receive = 1);

if (joinable < 2 and total <12) then

insert into sp.first (code, vn_name, joins, bu, receive)
select u.code, u.vn_name, u.joins, u.dept, 1 from sp.user u
where u.working_time = 'B' and u.joins = 'Y' and u.dept = bu_choose
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

insert into sp.first (code, vn_name, joins, bu, receive)
select u.code, u.vn_name, u.joins, u.dept, 1 from sp.user u
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

			return query select f.id, f.code, f.vn_name, f.bu, f.joins, f.receive from sp.first f order by f.id desc limit 1;
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
-- FUNCTION: sp.choose_2()

-- DROP FUNCTION IF EXISTS sp.choose_2();

CREATE OR REPLACE FUNCTION sp.choose_2(
	)
    RETURNS TABLE(code character varying, vn_name character varying, joinables character varying, bu character varying)
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

working2 = (select count(*) from sp.second s where s.working_time = 'B');

bu_choose = (select * from sp.random_bu());
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

joinable = (select count(*) from sp.second f where f.joins = 'Y');

if(joinable <2) then
raise notice 'đã vào joinable <2';
	if (working1 < 6 and working2 < 6) then
	raise notice 'đã vào working1 < 6 and working2 < 6';

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.working_time = working_choose and u.joins = 'Y' and u.bu = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name, s.joins, s.bu from sp.second s order by s.id desc limit 1;

	elseif(working1 <6 and working2 >=6 ) then

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'A' and u.joins = 'Y' and u.bu = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name, s.joins, s.bu from sp.second s order by s.id desc limit 1;
	--	raise notice 'id: %',(select s.id from sp.second s order by s.id desc limit 1);

	elseif(working1 >= 6 and working2 <6) then

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.working_time = 'B' and u.joins = 'Y' and u.bu = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name, s.joins, s.bu from sp.second s order by s.id desc limit 1;
	END IF;
END IF;
IF(joinable >= 2) THEN
	if (working1 < 6 and working2 < 6) then
	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.working_time = working_choose  and u.bu = bu_choose
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name, s.joins, s.bu from sp.second s order by s.id desc limit 1;
	elseif(working1 <6 and working2 >=6 ) then

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.bu =bu_choose and u.working_time = 'A'
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name, s.joins, s.bu from sp.second s order by s.id desc limit 1;
	--	raise notice 'id: %',(select s.id from sp.second s order by s.id desc limit 1);

	elseif(working1 >= 6 and working2 <6) then

	insert into sp.second (code, vn_name, bu, joins, working_time)
	select u.code, u.vn_name,u.bu ,u.joins, u.working_time  from sp.user u
	where u.bu =bu_choose and u.working_time = 'B'
	and u.code not in (select s.code from sp.special s
							union select f.code from sp.first f
							union select se.code from sp.second se
							union select t.code from sp.third t
							union select f.code from sp.four f)
	order by random()
	limit 1;
	-- PERFORM pg_sleep(0.2);
	--CALL sp.update_prize(bu_choose);
	--return query select s.code, s.vn_name,  s.joins, s.bu from sp.second s order by s.id desc limit 1;
	--raise notice 'id: %',(select s.id from sp.second s order by s.id desc limit 1);

	END IF;
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose);
			return query select s.code, s.vn_name,  s.joins, s.bu from sp.second s order by s.id desc limit 1;
            EXIT;
        ELSE
		 	-- bu_choose = (select * from sp.random_bu());
            -- Không có bản ghi để chèn, tiếp tục lặp
            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;

END;
$BODY$;

ALTER FUNCTION sp.choose_2()
    OWNER TO postgres;
-- FUNCTION: sp.choose_2a()

-- DROP FUNCTION IF EXISTS sp.choose_2a();

CREATE OR REPLACE FUNCTION sp.choose_2a(
	)
    RETURNS TABLE(id bigint, code character varying, vn_name character varying, joins character varying, bu character varying, working_time character varying, receive bigint)
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
working1 = (select count(*) from sp.second s where s.working_time = 'A' and s.receive = 1);

bu_choose = (select * from sp.random_bu(2));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

joinable = (select count(*) from sp.second f where f.joins = 'Y' and f.working_time = 'A' and f.receive = 1);

if(joinable <1 ) then
raise notice 'đã vào joinable <1';
	if (working1 < 6) then
	raise notice 'đã vào working1 < 6';

	insert into sp.second (code, vn_name, bu, joins, working_time, receive)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time, 1  from sp.user u
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
	insert into sp.second (code, vn_name, bu, joins, working_time, receive)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time ,1 from sp.user u
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
			return query select s.id, s.code, s.vn_name,  s.joins, s.bu, s.working_time, s.receive from sp.second s order by s.id desc limit 1;
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
    RETURNS TABLE(id bigint, code character varying, vn_name character varying, joins character varying, bu character varying, working_time character varying, receive bigint)
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
working1 = (select count(*) from sp.second s where s.working_time = 'B' and s.receive = 1);

bu_choose = (select * from sp.random_bu(2));
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

joinable = (select count(*) from sp.second f where f.joins = 'Y' and f.working_time = 'B' and f.receive =1);

if(joinable <1 ) then
raise notice 'đã vào joinable <1';
	if (working1 < 6) then
	raise notice 'đã vào working1 < 6';

	insert into sp.second (code, vn_name, bu, joins, working_time,receive)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time , 1  from sp.user u
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
	insert into sp.second (code, vn_name, bu, joins, working_time, receive)
	select u.code, u.vn_name,u.dept ,u.joins, u.working_time, 1  from sp.user u
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
			return query select s.id, s.code, s.vn_name,  s.joins, s.bu, s.working_time, s.receive from sp.second s order by s.id desc limit 1;
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
-- FUNCTION: sp.choose_3()

-- DROP FUNCTION IF EXISTS sp.choose_3();

CREATE OR REPLACE FUNCTION sp.choose_3(
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

working2 = (select count(*) from sp.third s where s.working_time = 'B');

bu_choose = (select * from sp.random_bu());
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if (working1 < 35 and working2 < 35) then
insert into sp.third (code, vn_name, bu, working_time)
select u.code, u.vn_name, u.bu, u.working_time from sp.user u
where u.bu =bu_choose and u.working_time = working_choose
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
--CALL sp.update_prize(bu_choose);
--return query select t.code, t.vn_name, t.bu, t.working_time from sp.third t order by t.id desc limit 1;
--	raise notice 'working1 < 35 and working2 < 35: %',(select s.id from sp.third s order by s.id desc limit 1);

elseif(working1 <35 and working2 >=35 ) then
insert into sp.third (code, vn_name, bu, working_time)
select u.code, u.vn_name, u.bu, u.working_time from sp.user u
where u.bu =bu_choose and u.working_time = 'A'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
--CALL sp.update_prize(bu_choose);
--return query select t.code, t.vn_name,t.bu, t.working_time from sp.third t order by t.id desc limit 1;
--raise notice 'working1 <35 and working2 >=35: %',(select s.id from sp.third s order by s.id desc limit 1);

elseif (working1 >= 35 and working2 <35) then
insert into sp.third (code, vn_name, bu, working_time)
select u.code, u.vn_name, u.bu, u.working_time from sp.user u
where  u.bu =bu_choose and u.working_time = 'B'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
-- PERFORM pg_sleep(0.2);
--CALL sp.update_prize(bu_choose);
--return query select t.code, t.vn_name, t.bu, t.working_time from sp.third t order by t.id desc limit 1;
--raise notice 'working1 >= 35 and working2 <35: %',(select s.id from sp.third s order by s.id desc limit 1);
-- PERFORM pg_sleep(0.2);
end if;

GET DIAGNOSTICS inserted_count = ROW_COUNT;
        IF inserted_count > 0 THEN
            RAISE NOTICE 'Successfully inserted a record.';
			CALL sp.update_prize(bu_choose);

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

ALTER FUNCTION sp.choose_3()
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

if (working1 < 34 ) then
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
IF working1 >= 34 THEN
    RAISE NOTICE 'No more records to insert, exiting...';
    RETURN;
END IF;
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

if (working1 < 36 ) then
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
IF working1 >= 36 THEN
    RAISE NOTICE 'No more records to insert, exiting...';
    RETURN;
END IF;
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
-- FUNCTION: sp.choose_4()

-- DROP FUNCTION IF EXISTS sp.choose_4();

CREATE OR REPLACE FUNCTION sp.choose_4(
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

working2 = (select count(*) from sp.four s where s.working_time = 'B');

bu_choose = (select * from sp.random_bu());
working_choose = (select  u.working_time from sp.user u order by random() limit 1);

if(working1 < 68 and working2 < 67) then
raise notice 'working1: %', working1;
raise notice 'working2: %', working2;

insert into sp.four (code, vn_name,bu, working_time)
select u.code, u.vn_name,  u.bu, u.working_time from sp.user u
where  u.bu =bu_choose and u.working_time = working_choose
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;

elseif(working1 < 68 and working2 >= 67) then
raise notice 'working1: %', working1;
raise notice 'working2: %', working2;
insert into sp.four (code, vn_name,bu, working_time)
select u.code, u.vn_name,  u.bu, u.working_time from sp.user u
where  u.bu =bu_choose and u.working_time = 'A'
and u.code not in (select s.code from sp.special s
						union select f.code from sp.first f
						union select se.code from sp.second se
						union select t.code from sp.third t
						union select f.code from sp.four f)
order by random()
limit 1;
elseif (working1 >= 68 and working2 < 67) then
raise notice 'working1: %', working1;
raise notice 'working2: %', working2;
insert into sp.four (code, vn_name,bu, working_time)
select u.code, u.vn_name,  u.bu, u.working_time from sp.user u
where  u.bu =bu_choose and u.working_time = 'B'
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
			CALL sp.update_prize(bu_choose);
			return query select f.code, f.vn_name, f.bu, f.working_time from sp.four f order by f.id desc limit 1;
            EXIT;
        ELSE

            RAISE NOTICE 'No record found to insert, retrying...';
        END IF;
    END LOOP;
END;
$BODY$;

ALTER FUNCTION sp.choose_4()
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

if(working1 < 65 ) then
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
IF working1 >= 65 THEN
    RAISE NOTICE 'No more records to insert, exiting...';
    RETURN;
END IF;
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

if(working1 < 70 ) then
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
IF working1 >= 70 THEN
    RAISE NOTICE 'No more records to insert, exiting...';
    RETURN;
END IF;
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
    RETURNS TABLE(id bigint, code character varying, vn_name character varying, bu character varying, joins character varying, receive bigint)
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

joinable = (select count(*) from sp.special s where s.joins = 'Y' and s.receive = 1);

total = (select count(*) from sp.special s where s.receive = 1);

if (joinable <1 and total < 6) then
raise notice 'đã vào 0';

insert into sp.special (code, vn_name, joins, bu, receive)
select u.code, u.vn_name, u.joins, u.dept, 1 from sp.user u
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

insert into sp.special (code, vn_name, joins, bu, receive)
select u.code, u.vn_name, u.joins, u.dept, 1 from sp.user u
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
			return query select s.id, s.code, s.vn_name, s.bu, s.joins, s.receive from sp.special s order by s.id desc limit 1;
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
-- FUNCTION: sp.random_bu()

-- DROP FUNCTION IF EXISTS sp.random_bu();

CREATE OR REPLACE FUNCTION sp.random_bu(
	)
    RETURNS character varying
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
select bu from sp.prize
where actual <plan
order by random()
limit 1
$BODY$;

ALTER FUNCTION sp.random_bu()
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
if prize_in = 4 then
 WITH weight_calculation AS (
    SELECT
        bu,
        number,
        plan_four,
        act_four,
        (number::DECIMAL / (SELECT SUM(number) FROM sp.prize)) AS weight
    FROM sp.prize
),
random_weight AS (
    -- Tạo một số ngẫu nhiên trong khoảng từ 0 đến tổng trọng số
    SELECT random() * (SELECT SUM(weight) FROM weight_calculation) AS random_value
),
cumulative_weights AS (
    -- Tính tổng trọng số dần dần với ROW_NUMBER()
    SELECT
        bu,
        weight,
        SUM(weight) OVER (ORDER BY bu) AS cumulative_weight
    FROM weight_calculation
)
-- Lấy tên phòng ban với tổng trọng số dần dần vượt qua random_value và điều kiện thêm về act_four và plan_four
SELECT
    DISTINCT cw.bu
INTO selected_bu
FROM cumulative_weights cw
JOIN weight_calculation wc ON wc.bu = cw.bu
JOIN random_weight rw ON cw.cumulative_weight >= rw.random_value
WHERE wc.plan_four > wc.act_four
LIMIT 1;

    RETURN selected_bu;
end if;

if prize_in = 3 then
 WITH weight_calculation AS (
    SELECT
        bu,
        number,
        plan_four, plan_third,
        act_four, act_third,
        (number::DECIMAL / (SELECT SUM(number) FROM sp.prize)) AS weight
    FROM sp.prize
),
random_weight AS (
    -- Tạo một số ngẫu nhiên trong khoảng từ 0 đến tổng trọng số
    SELECT random() * (SELECT SUM(weight) FROM weight_calculation) AS random_value
),
cumulative_weights AS (
    -- Tính tổng trọng số dần dần với ROW_NUMBER()
    SELECT
        bu,
        weight,
        SUM(weight) OVER (ORDER BY bu) AS cumulative_weight
    FROM weight_calculation
)
-- Lấy tên phòng ban với tổng trọng số dần dần vượt qua random_value và điều kiện thêm về act_four và plan_four
SELECT
    DISTINCT cw.bu
INTO selected_bu
FROM cumulative_weights cw
JOIN weight_calculation wc ON wc.bu = cw.bu
JOIN random_weight rw ON cw.cumulative_weight >= rw.random_value
WHERE  --wc.plan_third > wc.act_third
(wc.plan_four + wc.plan_third) > (wc.act_four + wc.act_third)
LIMIT 1;

    RETURN selected_bu;
end if;

if prize_in = 2 then
 WITH weight_calculation AS (
    SELECT
        bu,
        number,
        plan_four, plan_third, plan_second,
        act_four, act_third,act_second,
        (number::DECIMAL / (SELECT SUM(number) FROM sp.prize)) AS weight
    FROM sp.prize
),
random_weight AS (
    -- Tạo một số ngẫu nhiên trong khoảng từ 0 đến tổng trọng số
    SELECT random() * (SELECT SUM(weight) FROM weight_calculation) AS random_value
),
cumulative_weights AS (
    -- Tính tổng trọng số dần dần với ROW_NUMBER()
    SELECT
        bu,
        weight,
        SUM(weight) OVER (ORDER BY bu) AS cumulative_weight
    FROM weight_calculation
)
-- Lấy tên phòng ban với tổng trọng số dần dần vượt qua random_value và điều kiện thêm về act_four và plan_four
SELECT
    DISTINCT cw.bu
INTO selected_bu
FROM cumulative_weights cw
JOIN weight_calculation wc ON wc.bu = cw.bu
JOIN random_weight rw ON cw.cumulative_weight >= rw.random_value
WHERE --wc.plan_second > wc.act_second
(wc.plan_four + wc.plan_third + wc.plan_second) > (wc.act_four + wc.act_third +wc.act_second)
LIMIT 1;

    RETURN selected_bu;
end if;

if prize_in = 1 then
 WITH weight_calculation AS (
    SELECT
        bu,
        number,
        plan_four, plan_third, plan_second, plan_first,
        act_four, act_third,act_second,act_first,
        (number::DECIMAL / (SELECT SUM(number) FROM sp.prize)) AS weight
    FROM sp.prize
),
random_weight AS (
    -- Tạo một số ngẫu nhiên trong khoảng từ 0 đến tổng trọng số
    SELECT random() * (SELECT SUM(weight) FROM weight_calculation) AS random_value
),
cumulative_weights AS (
    -- Tính tổng trọng số dần dần với ROW_NUMBER()
    SELECT
        bu,
        weight,
        SUM(weight) OVER (ORDER BY bu) AS cumulative_weight
    FROM weight_calculation
)
-- Lấy tên phòng ban với tổng trọng số dần dần vượt qua random_value và điều kiện thêm về act_four và plan_four
SELECT
    DISTINCT cw.bu
INTO selected_bu
FROM cumulative_weights cw
JOIN weight_calculation wc ON wc.bu = cw.bu
JOIN random_weight rw ON cw.cumulative_weight >= rw.random_value
WHERE --wc.plan_first > wc.act_first
(wc.plan_four + wc.plan_third + wc.plan_second + wc.plan_first) > (wc.act_four + wc.act_third +wc.act_second + wc.act_first)
LIMIT 1;

    RETURN selected_bu;
end if;
if prize_in = 0 then
 WITH weight_calculation AS (
    SELECT
        bu,
        number,
        plan_four, plan_third, plan_second, plan_first, plan_special,
        act_four, act_third,act_second,act_first, act_special,
        (number::DECIMAL / (SELECT SUM(number) FROM sp.prize)) AS weight
    FROM sp.prize
),
random_weight AS (
    -- Tạo một số ngẫu nhiên trong khoảng từ 0 đến tổng trọng số
    SELECT random() * (SELECT SUM(weight) FROM weight_calculation) AS random_value
),
cumulative_weights AS (
    -- Tính tổng trọng số dần dần với ROW_NUMBER()
    SELECT
        bu,
        weight,
        SUM(weight) OVER (ORDER BY bu) AS cumulative_weight
    FROM weight_calculation
)
-- Lấy tên phòng ban với tổng trọng số dần dần vượt qua random_value và điều kiện thêm về act_four và plan_four
SELECT
    DISTINCT cw.bu
INTO selected_bu
FROM cumulative_weights cw
JOIN weight_calculation wc ON wc.bu = cw.bu
JOIN random_weight rw ON cw.cumulative_weight >= rw.random_value
WHERE (wc.plan_four + wc.plan_third + wc.plan_second + wc.plan_first + wc.plan_special) > (wc.act_four + wc.act_third +wc.act_second + wc.act_first+ wc.act_special)
 LIMIT 1;

    RETURN selected_bu;
end if;
  --   -- Điều kiện để chọn BU dựa trên prize_in
  --   IF prize_in = 0 THEN
  --       SELECT bu INTO selected_bu
  --       FROM sp.prize
  --       WHERE /*act_special < plan_special
		-- or */checks > (act_special + act_first + act_second + act_third + act_four)
  --       ORDER BY random()
  --       LIMIT 1;

  --   ELSIF prize_in = 1 THEN
  --       SELECT bu INTO selected_bu
  --       FROM sp.prize
  --       WHERE /*act_first < plan_first or*/

		-- 		checks > (act_special + act_first + act_second + act_third + act_four)
  --       ORDER BY random()
  --       LIMIT 1;

  --   ELSIF prize_in = 2 THEN
  --       SELECT bu INTO selected_bu
  --       FROM sp.prize
  --       WHERE /*act_second < plan_second
		-- and */checks > (act_special + act_first + act_second + act_third + act_four)
  --       ORDER BY random()
  --       LIMIT 1;

  --   ELSIF prize_in = 3 THEN
  --       SELECT bu INTO selected_bu
  --       FROM sp.prize
  --       WHERE /*act_third < plan_third
		-- and */checks > (act_special + act_first + act_second + act_third + act_four)
  --       ORDER BY random()
  --       LIMIT 1;

  --   ELSIF prize_in = 4 THEN
  --       SELECT bu INTO selected_bu
  --       FROM sp.prize
  --       WHERE /*act_four < plan_four
		-- and*/ checks > (act_special + act_first + act_second + act_third + act_four)
  --       ORDER BY random()
  --       LIMIT 1;

  --   ELSE
  --       RAISE EXCEPTION 'Invalid prize_in value: %', prize_in;
  --   END IF;

  --   -- Trả về BU đã chọn
  --   RETURN selected_bu;

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
