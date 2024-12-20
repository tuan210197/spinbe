-- Table: sp.congra

-- DROP TABLE IF EXISTS sp.congra;

CREATE TABLE IF NOT EXISTS sp.congra
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "number" bigint,
    count bigint,
    CONSTRAINT congra_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS sp.congra
    OWNER to postgres;


    -- Table: sp.first

    -- DROP TABLE IF EXISTS sp.first;

    CREATE TABLE IF NOT EXISTS sp.first
    (
        id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
        code character varying COLLATE pg_catalog."default" NOT NULL,
        vn_name character varying COLLATE pg_catalog."default" NOT NULL,
        joins character varying COLLATE pg_catalog."default",
        bu character varying COLLATE pg_catalog."default",
        CONSTRAINT first_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

    ALTER TABLE IF EXISTS sp.first
        OWNER to postgres;

        -- Table: sp.four

        -- DROP TABLE IF EXISTS sp.four;

        CREATE TABLE IF NOT EXISTS sp.four
        (
            id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
            code character varying COLLATE pg_catalog."default" NOT NULL,
            vn_name character varying COLLATE pg_catalog."default" NOT NULL,
            cn_name character varying COLLATE pg_catalog."default",
            bu character varying COLLATE pg_catalog."default",
            working_time character varying COLLATE pg_catalog."default",
            CONSTRAINT four_pkey PRIMARY KEY (id)
        )

        TABLESPACE pg_default;

        ALTER TABLE IF EXISTS sp.four
            OWNER to postgres;


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
                CONSTRAINT prize_pkey PRIMARY KEY (id)
            )

            TABLESPACE pg_default;

            ALTER TABLE IF EXISTS sp.prize
                OWNER to postgres;


                -- Table: sp.second

                -- DROP TABLE IF EXISTS sp.second;

                CREATE TABLE IF NOT EXISTS sp.second
                (
                    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
                    code character varying COLLATE pg_catalog."default" NOT NULL,
                    vn_name character varying COLLATE pg_catalog."default" NOT NULL,
                    joins character varying COLLATE pg_catalog."default",
                    bu character varying COLLATE pg_catalog."default",
                    working_time character varying COLLATE pg_catalog."default",
                    CONSTRAINT second_pkey PRIMARY KEY (id)
                )

                TABLESPACE pg_default;

                ALTER TABLE IF EXISTS sp.second
                    OWNER to postgres;


                    -- Table: sp.special

                    -- DROP TABLE IF EXISTS sp.special;

                    CREATE TABLE IF NOT EXISTS sp.special
                    (
                        id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
                        code character varying COLLATE pg_catalog."default" NOT NULL,
                        vn_name character varying COLLATE pg_catalog."default" NOT NULL,
                        joins character varying COLLATE pg_catalog."default",
                        bu character varying COLLATE pg_catalog."default",
                        CONSTRAINT special_pkey PRIMARY KEY (id)
                    )

                    TABLESPACE pg_default;

                    ALTER TABLE IF EXISTS sp.special
                        OWNER to postgres;


                        -- Table: sp.third

                        -- DROP TABLE IF EXISTS sp.third;

                        CREATE TABLE IF NOT EXISTS sp.third
                        (
                            id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
                            code character varying COLLATE pg_catalog."default" NOT NULL,
                            vn_name character varying COLLATE pg_catalog."default" NOT NULL,
                            cn_name character varying COLLATE pg_catalog."default",
                            bu character varying COLLATE pg_catalog."default",
                            working_time character varying COLLATE pg_catalog."default",
                            CONSTRAINT third_pkey PRIMARY KEY (id)
                        )

                        TABLESPACE pg_default;

                        ALTER TABLE IF EXISTS sp.third
                            OWNER to postgres;



                            -- Table: sp.user

                            -- DROP TABLE IF EXISTS sp."user";

                            CREATE TABLE IF NOT EXISTS sp."user"
                            (
                                code character varying COLLATE pg_catalog."default" NOT NULL,
                                vn_name character varying COLLATE pg_catalog."default" NOT NULL,
                                dept character varying COLLATE pg_catalog."default" NOT NULL,
                                bu character varying COLLATE pg_catalog."default" NOT NULL,
                                working_time character varying COLLATE pg_catalog."default" NOT NULL,
                                joins character varying COLLATE pg_catalog."default",
                                mdd character varying COLLATE pg_catalog."default",
                                CONSTRAINT user_pkey PRIMARY KEY (code)
                            )

                            TABLESPACE pg_default;

                            ALTER TABLE IF EXISTS sp."user"
                                OWNER to postgres;



                                -- PROCEDURE: sp.update_prize(character varying)

                                -- DROP PROCEDURE IF EXISTS sp.update_prize(character varying);

                                CREATE OR REPLACE PROCEDURE sp.update_prize(
                                	IN bu_choose character varying)
                                LANGUAGE 'sql'
                                AS $BODY$
                                update sp.prize  set
                                 actual = actual + 1
                                 where bu = bu_choose;

                                $BODY$;
                                ALTER PROCEDURE sp.update_prize(character varying)
                                    OWNER TO postgres;
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
bu_choose = (select * from sp.random_bu());
joinable = (select count(*) from sp.first f where f.joins = 'Y');
total = (select count(*) from sp.first);

if (joinable < 2 and total <12) then

insert into sp.first (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.bu from sp.user u
where u.working_time = 'B' and u.joins = 'Y' and u.bu = bu_choose --'JBD'
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
select u.code, u.vn_name, u.joins, u.bu from sp.user u
where u.working_time = 'B'  and u.bu = bu_choose
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
			CALL sp.update_prize(bu_choose);

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

bu_choose = (select * from sp.random_bu());

joinable = (select count(*) from sp.special s where s.joins = 'Y');

total = (select count(*) from sp.special);



if (joinable <1 and total < 6) then
raise notice 'đã vào 0';

insert into sp.special (code, vn_name, joins, bu)
select u.code, u.vn_name, u.joins, u.bu from sp.user u
where u.working_time = 'B' and u.joins = 'Y' and u.bu = bu_choose
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
select u.code, u.vn_name, u.joins, u.bu from sp.user u
where u.working_time = 'B' and u.bu = bu_choose
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
			CALL sp.update_prize(bu_choose);
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
