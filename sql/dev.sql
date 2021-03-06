--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: checkins; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE checkins (
    id integer NOT NULL,
    date date NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE checkins OWNER TO vagrant;

--
-- Name: checkins_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE checkins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE checkins_id_seq OWNER TO vagrant;

--
-- Name: checkins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE checkins_id_seq OWNED BY checkins.id;


--
-- Name: dbix_class_deploymenthandler_versions; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE dbix_class_deploymenthandler_versions (
    id integer NOT NULL,
    version character varying(50) NOT NULL,
    ddl text,
    upgrade_sql text
);


ALTER TABLE dbix_class_deploymenthandler_versions OWNER TO vagrant;

--
-- Name: dbix_class_deploymenthandler_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE dbix_class_deploymenthandler_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbix_class_deploymenthandler_versions_id_seq OWNER TO vagrant;

--
-- Name: dbix_class_deploymenthandler_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE dbix_class_deploymenthandler_versions_id_seq OWNED BY dbix_class_deploymenthandler_versions.id;


--
-- Name: families; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE families (
    id integer NOT NULL
);


ALTER TABLE families OWNER TO vagrant;

--
-- Name: families_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE families_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE families_id_seq OWNER TO vagrant;

--
-- Name: families_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE families_id_seq OWNED BY families.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE members (
    id integer NOT NULL,
    full_name text NOT NULL,
    family_id integer NOT NULL
);


ALTER TABLE members OWNER TO vagrant;

--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members_id_seq OWNER TO vagrant;

--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE members_id_seq OWNED BY members.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE phones (
    id integer NOT NULL,
    number text NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE phones OWNER TO vagrant;

--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE phones_id_seq OWNER TO vagrant;

--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE phones_id_seq OWNED BY phones.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    login_id text NOT NULL,
    password text NOT NULL
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE visitors (
    id integer NOT NULL,
    date date NOT NULL,
    name text NOT NULL,
    phone text,
    email text,
    address text,
    address2 text,
    city text,
    state text,
    number integer NOT NULL,
    num_children integer NOT NULL
);


ALTER TABLE visitors OWNER TO vagrant;

--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE visitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visitors_id_seq OWNER TO vagrant;

--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE visitors_id_seq OWNED BY visitors.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY checkins ALTER COLUMN id SET DEFAULT nextval('checkins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dbix_class_deploymenthandler_versions ALTER COLUMN id SET DEFAULT nextval('dbix_class_deploymenthandler_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY families ALTER COLUMN id SET DEFAULT nextval('families_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY members ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY phones ALTER COLUMN id SET DEFAULT nextval('phones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY visitors ALTER COLUMN id SET DEFAULT nextval('visitors_id_seq'::regclass);


--
-- Data for Name: checkins; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY checkins (id, date, member_id) FROM stdin;
1	2018-05-28	2
2	2018-05-28	4
3	2018-05-31	2
4	2018-05-31	4
\.


--
-- Name: checkins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('checkins_id_seq', 4, true);


--
-- Data for Name: dbix_class_deploymenthandler_versions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dbix_class_deploymenthandler_versions (id, version, ddl, upgrade_sql) FROM stdin;
1	2	CREATE TABLE "dbix_class_deploymenthandler_versions" ( "id" serial NOT NULL, "version" character varying(50) NOT NULL, "ddl" text, "upgrade_sql" text, PRIMARY KEY ("id"), CONSTRAINT "dbix_class_deploymenthandler_versions_version" UNIQUE ("version") )CREATE TABLE "members" ( "id" serial NOT NULL, "phone" text NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "members_phone" UNIQUE ("phone") )\nCREATE TABLE "users" ( "id" serial NOT NULL, "login_id" text NOT NULL, "password" text NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "users_login_id" UNIQUE ("login_id") )	\N
3	3		CREATE TABLE "phones" ( "id" serial NOT NULL, "number" text NOT NULL, "member_id" integer NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "phones_number" UNIQUE ("number") )\nCREATE INDEX "phones_idx_member_id" on "phones" ("member_id")\nALTER TABLE "phones" ADD CONSTRAINT "phones_fk_member_id" FOREIGN KEY ("member_id") REFERENCES "members" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE\nALTER TABLE members DROP CONSTRAINT members_phone\ninsert into phones (member_id, number) select id, phone from members\nALTER TABLE members DROP COLUMN phone
4	4		ALTER TABLE members ADD COLUMN full_name text NULLALTER TABLE members ALTER COLUMN full_name SET NOT NULL
5	5		CREATE TABLE "families" ( "id" serial NOT NULL, PRIMARY KEY ("id") )\nALTER TABLE members ADD COLUMN family_id integer NULL\nCREATE INDEX members_idx_family_id on members (family_id)\nALTER TABLE members ADD CONSTRAINT members_fk_family_id FOREIGN KEY (family_id) REFERENCES families (id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLEalter table members alter column family_id set not null
7	6		CREATE TABLE "checkins" ( "id" serial NOT NULL, "date" timestamptz NOT NULL, "member_id" integer NOT NULL, PRIMARY KEY ("id") )\nCREATE INDEX "checkins_idx_member_id" on "checkins" ("member_id")\nALTER TABLE "checkins" ADD CONSTRAINT "checkins_fk_member_id" FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE
8	7		CREATE TABLE "visitors" ( "id" serial NOT NULL, "date" timestamptz NOT NULL, "name" text NOT NULL, "phone" text, "email" text, "address" text, "address2" text, "city" text, "state" text, "number" integer NOT NULL, "num_children" integer NOT NULL, PRIMARY KEY ("id") )
9	8		ALTER TABLE checkins ALTER COLUMN date TYPE date\nALTER TABLE visitors ALTER COLUMN date TYPE date
\.


--
-- Name: dbix_class_deploymenthandler_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dbix_class_deploymenthandler_versions_id_seq', 9, true);


--
-- Data for Name: families; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY families (id) FROM stdin;
2
\.


--
-- Name: families_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('families_id_seq', 2, true);


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY members (id, full_name, family_id) FROM stdin;
2	Ward Cleaver	2
3	June Cleaver	2
4	Beaver Cleaver	2
\.


--
-- Name: members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('members_id_seq', 4, true);


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY phones (id, number, member_id) FROM stdin;
2	5551112222	2
\.


--
-- Name: phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('phones_id_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (id, login_id, password) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Data for Name: visitors; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY visitors (id, date, name, phone, email, address, address2, city, state, number, num_children) FROM stdin;
1	2018-05-30	John Smith	\N	\N	\N	\N	\N	\N	1	0
\.


--
-- Name: visitors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('visitors_id_seq', 1, true);


--
-- Name: checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY checkins
    ADD CONSTRAINT checkins_pkey PRIMARY KEY (id);


--
-- Name: dbix_class_deploymenthandler_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY dbix_class_deploymenthandler_versions
    ADD CONSTRAINT dbix_class_deploymenthandler_versions_pkey PRIMARY KEY (id);


--
-- Name: dbix_class_deploymenthandler_versions_version; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY dbix_class_deploymenthandler_versions
    ADD CONSTRAINT dbix_class_deploymenthandler_versions_version UNIQUE (version);


--
-- Name: families_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY families
    ADD CONSTRAINT families_pkey PRIMARY KEY (id);


--
-- Name: members_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: phones_number; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_number UNIQUE (number);


--
-- Name: phones_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: users_login_id; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_login_id UNIQUE (login_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: checkins_idx_member_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX checkins_idx_member_id ON checkins USING btree (member_id);


--
-- Name: members_idx_family_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX members_idx_family_id ON members USING btree (family_id);


--
-- Name: phones_idx_member_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX phones_idx_member_id ON phones USING btree (member_id);


--
-- Name: checkins_fk_member_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY checkins
    ADD CONSTRAINT checkins_fk_member_id FOREIGN KEY (member_id) REFERENCES members(id) DEFERRABLE;


--
-- Name: members_fk_family_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_fk_family_id FOREIGN KEY (family_id) REFERENCES families(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- Name: phones_fk_member_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_fk_member_id FOREIGN KEY (member_id) REFERENCES members(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

