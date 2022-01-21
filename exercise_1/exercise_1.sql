--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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
-- Name: paymentstate; Type: TYPE; Schema: public;
--

CREATE TYPE public.paymentstate AS ENUM (
    'REFUSED',
    'IN PROGRESS',
    'PAID'
);

--
-- Name: paymenttype; Type: TYPE; Schema: public; 
--

CREATE TYPE public.paymenttype AS ENUM (
    'DIRECT_DEBIT',
    'DEFERRED',
    '3_TIMES',
    '4_TIMES'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: payment; Type: TABLE; Schema: public;
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    shop_id integer NOT NULL,
    type public.paymenttype,
    state public.paymentstate,
    created date NOT NULL,
    amount integer
);


--
-- Name: COLUMN payment.amount; Type: COMMENT; Schema: public;
--

COMMENT ON COLUMN public.payment.amount IS 'Stored in cents';

--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public;
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public;
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: payment_log; Type: TABLE; Schema: public;
--

CREATE TABLE public.payment_log (
    id integer NOT NULL,
    payment_id integer NOT NULL,
    log_content jsonb NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: payment_log_id_seq; Type: SEQUENCE; Schema: public;
--

CREATE SEQUENCE public.payment_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public;
--

ALTER SEQUENCE public.payment_log_id_seq OWNED BY public.payment_log.id;


--
-- Name: shop; Type: TABLE; Schema: public;
--

CREATE TABLE public.shop (
    id integer NOT NULL,
    name character varying(40) NOT NULL,
    activity character varying(10),
    created date NOT NULL,
    contact_email character varying(40) NOT NULL,
    contact_phone character varying(15) NOT NULL
);

--
-- Name: shop_id_seq; Type: SEQUENCE; Schema: public;
--

CREATE SEQUENCE public.shop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; 
--

ALTER SEQUENCE public.shop_id_seq OWNED BY public.shop.id;


--
-- Name: payment id; Type: DEFAULT; Schema: public;
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: payment_log id; Type: DEFAULT; Schema: public;
--

ALTER TABLE ONLY public.payment_log ALTER COLUMN id SET DEFAULT nextval('public.payment_log_id_seq'::regclass);


--
-- Name: shop id; Type: DEFAULT; Schema: public;
--

ALTER TABLE ONLY public.shop ALTER COLUMN id SET DEFAULT nextval('public.shop_id_seq'::regclass);


--
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public;
--

SELECT pg_catalog.setval('public.payment_id_seq', 1, false);


--
-- Name: payment_log_id_seq; Type: SEQUENCE SET; Schema: public;
--

SELECT pg_catalog.setval('public.payment_log_id_seq', 1, false);


--
-- Name: shop_id_seq; Type: SEQUENCE SET; Schema: public;
--

SELECT pg_catalog.setval('public.shop_id_seq', 1, false);


--
-- Name: payment_log payment_log_pkey; Type: CONSTRAINT; Schema: public;
--

ALTER TABLE ONLY public.payment_log
    ADD CONSTRAINT payment_log_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public;
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: shop shop_pkey; Type: CONSTRAINT; Schema: public;
--

ALTER TABLE ONLY public.shop
    ADD CONSTRAINT shop_pkey PRIMARY KEY (id);


--
-- Name: idx_log_payment_id; Type: INDEX; Schema: public;
--

CREATE INDEX idx_log_payment_id ON public.payment_log USING btree (payment_id);


--
-- Name: payment_log fk_payment; Type: FK CONSTRAINT; Schema: public;
--

ALTER TABLE ONLY public.payment_log
    ADD CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- Name: payment fk_shop; Type: FK CONSTRAINT; Schema: public;
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_shop FOREIGN KEY (shop_id) REFERENCES public.shop(id);


--
-- PostgreSQL database dump complete
--