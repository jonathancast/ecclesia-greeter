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
-- Name: members; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE members (
    id integer NOT NULL,
    phone text NOT NULL
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY dbix_class_deploymenthandler_versions ALTER COLUMN id SET DEFAULT nextval('dbix_class_deploymenthandler_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY members ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: dbix_class_deploymenthandler_versions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY dbix_class_deploymenthandler_versions (id, version, ddl, upgrade_sql) FROM stdin;
1	2	CREATE TABLE "dbix_class_deploymenthandler_versions" ( "id" serial NOT NULL, "version" character varying(50) NOT NULL, "ddl" text, "upgrade_sql" text, PRIMARY KEY ("id"), CONSTRAINT "dbix_class_deploymenthandler_versions_version" UNIQUE ("version") )CREATE TABLE "members" ( "id" serial NOT NULL, "phone" text NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "members_phone" UNIQUE ("phone") )\nCREATE TABLE "users" ( "id" serial NOT NULL, "login_id" text NOT NULL, "password" text NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "users_login_id" UNIQUE ("login_id") )	\N
\.


--
-- Name: dbix_class_deploymenthandler_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('dbix_class_deploymenthandler_versions_id_seq', 1, true);


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY members (id, phone) FROM stdin;
1	5551112222
\.


--
-- Name: members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('members_id_seq', 1, true);


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
-- Name: members_phone; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_phone UNIQUE (phone);


--
-- Name: members_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

