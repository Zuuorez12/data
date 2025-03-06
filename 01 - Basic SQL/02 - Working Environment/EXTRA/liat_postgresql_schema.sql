--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

-- Started on 2019-09-15 13:52:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 24610)
-- Name: liat; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA liat;
CREATE SCHEMA public;


ALTER SCHEMA liat OWNER TO postgres;
ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2827 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA liat; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA liat IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2828 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 24611)
-- Name: t_depart; Type: TABLE; Schema: liat; Owner: postgres
--

CREATE TABLE liat.t_depart (
    deptno text NOT NULL,
    deptname text NOT NULL,
    mgrno text,
    admrdept text
);


ALTER TABLE liat.t_depart OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24617)
-- Name: t_empl; Type: TABLE; Schema: liat; Owner: postgres
--

CREATE TABLE liat.t_empl (
    empno text NOT NULL,
    firstname text NOT NULL,
    lastname text NOT NULL,
    deptno text,
    hiredate date,
    job text,
    edlevel integer,
    sex text,
    birthdate date,
    salary integer,
    bonus integer,
    comm integer
);


ALTER TABLE liat.t_empl OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 24623)
-- Name: t_proj; Type: TABLE; Schema: liat; Owner: postgres
--

CREATE TABLE liat.t_proj (
    projno text NOT NULL,
    projname text NOT NULL,
    deptno text,
    respemp text NOT NULL,
    prstaff double precision,
    prstdate date,
    prendate date,
    majproj text
);


ALTER TABLE liat.t_proj OWNER TO postgres;

--
-- TOC entry 2696 (class 2606 OID 24630)
-- Name: t_depart t_depart_pkey; Type: CONSTRAINT; Schema: liat; Owner: postgres
--

ALTER TABLE ONLY liat.t_depart
    ADD CONSTRAINT t_depart_pkey PRIMARY KEY (deptno);


--
-- TOC entry 2698 (class 2606 OID 24632)
-- Name: t_empl t_empl_pkey; Type: CONSTRAINT; Schema: liat; Owner: postgres
--

ALTER TABLE ONLY liat.t_empl
    ADD CONSTRAINT t_empl_pkey PRIMARY KEY (empno);


--
-- TOC entry 2700 (class 2606 OID 24634)
-- Name: t_proj t_proj_pkey; Type: CONSTRAINT; Schema: liat; Owner: postgres
--

ALTER TABLE ONLY liat.t_proj
    ADD CONSTRAINT t_proj_pkey PRIMARY KEY (projno);


-- Completed on 2019-09-15 13:52:42

--
-- PostgreSQL database dump complete
--

