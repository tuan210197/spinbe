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

    -- Table: sp.dept

    -- DROP TABLE IF EXISTS sp.dept;

    CREATE TABLE IF NOT EXISTS sp.dept
    (
        name character varying(255) COLLATE pg_catalog."default",
        "number" integer
    )

    TABLESPACE pg_default;

    ALTER TABLE IF EXISTS sp.dept
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
            receive bigint,
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

                -- Table: sp.on_delete

                -- DROP TABLE IF EXISTS sp.on_delete;

                CREATE TABLE IF NOT EXISTS sp.on_delete
                (
                    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
                    code character varying COLLATE pg_catalog."default",
                    name character varying COLLATE pg_catalog."default",
                    prize character varying COLLATE pg_catalog."default",
                    CONSTRAINT on_delete_pkey PRIMARY KEY (id)
                )

                TABLESPACE pg_default;

                ALTER TABLE IF EXISTS sp.on_delete
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
                        receive bigint,
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
                            receive bigint,
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
                                receive bigint,
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