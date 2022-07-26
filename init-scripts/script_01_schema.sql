--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-1.pgdg100+1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-1.pgdg100+1)

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
-- Name: admin_panel; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA admin_panel;


ALTER SCHEMA admin_panel OWNER TO admin;

--
-- Name: detectenv; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA detectenv;


ALTER SCHEMA detectenv OWNER TO admin;

--
-- Name: strapi; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA strapi;


ALTER SCHEMA strapi OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_log; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.action_log (
    id_action_log integer NOT NULL,
    id_action integer NOT NULL,
    id_news integer NOT NULL,
    datetime_log timestamp without time zone NOT NULL,
    description_log character varying(100) NOT NULL
);


ALTER TABLE detectenv.action_log OWNER TO admin;

--
-- Name: action_log_id_action_log_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.action_log_id_action_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.action_log_id_action_log_seq OWNER TO admin;

--
-- Name: action_log_id_action_log_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.action_log_id_action_log_seq OWNED BY detectenv.action_log.id_action_log;


--
-- Name: action_type; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.action_type (
    id_action integer NOT NULL,
    name_action character varying(20) NOT NULL
);


ALTER TABLE detectenv.action_type OWNER TO admin;

--
-- Name: TABLE action_type; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.action_type IS 'Ações possíveis que uma notícia pode sofrer';


--
-- Name: COLUMN action_type.name_action; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.action_type.name_action IS 'Exemplos: coleta, avaliação, em_checagem';


--
-- Name: action_type_id_action_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.action_type_id_action_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.action_type_id_action_seq OWNER TO admin;

--
-- Name: action_type_id_action_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.action_type_id_action_seq OWNED BY detectenv.action_type.id_action;


--
-- Name: agency_news_checked; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.agency_news_checked (
    id_news_checked bigint NOT NULL,
    publication_title character varying NOT NULL,
    publication_url character varying,
    publication_datetime timestamp without time zone,
    publication_tags character varying,
    publication_external_id bigint,
    id_trusted_agency integer NOT NULL
);


ALTER TABLE detectenv.agency_news_checked OWNER TO admin;

--
-- Name: COLUMN agency_news_checked.publication_title; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.publication_title IS 'Título do artigo publicado no site da agência de checagem fonte';


--
-- Name: COLUMN agency_news_checked.publication_url; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.publication_url IS 'URL para o artigo completo no site da agência de checagem fonte';


--
-- Name: COLUMN agency_news_checked.publication_datetime; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.publication_datetime IS 'Data/hora de publicação do artigo no site da agência de checagem fonte';


--
-- Name: COLUMN agency_news_checked.publication_tags; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.publication_tags IS 'Tags associadas pela agência de checagem fonte';


--
-- Name: COLUMN agency_news_checked.publication_external_id; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.publication_external_id IS 'ID da publicação atribuído pela agência de checagem fonte';


--
-- Name: COLUMN agency_news_checked.id_trusted_agency; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.agency_news_checked.id_trusted_agency IS 'Agência de checagem fonte';


--
-- Name: agency_news_checked_id_news_checked_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.agency_news_checked_id_news_checked_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.agency_news_checked_id_news_checked_seq OWNER TO admin;

--
-- Name: agency_news_checked_id_news_checked_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.agency_news_checked_id_news_checked_seq OWNED BY detectenv.agency_news_checked.id_news_checked;


--
-- Name: checking_outcome; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.checking_outcome (
    id_checking_outcome integer NOT NULL,
    id_news bigint NOT NULL,
    id_trusted_agency integer NOT NULL,
    datetime_outcome timestamp without time zone,
    datetime_sent_for_checking timestamp without time zone,
    is_fake boolean,
    trusted_agency_link character varying(5000)
);


ALTER TABLE detectenv.checking_outcome OWNER TO admin;

--
-- Name: TABLE checking_outcome; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.checking_outcome IS 'Dados de verificação de uma notícia em uma determinada agência de checagem';


--
-- Name: COLUMN checking_outcome.trusted_agency_link; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.checking_outcome.trusted_agency_link IS 'Link para a página ou artigo da agência de checagem que apresenta informações sobre a fake news.';


--
-- Name: checking_outcome_id_checking_outcome_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.checking_outcome_id_checking_outcome_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.checking_outcome_id_checking_outcome_seq OWNER TO admin;

--
-- Name: checking_outcome_id_checking_outcome_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.checking_outcome_id_checking_outcome_seq OWNED BY detectenv.checking_outcome.id_checking_outcome;


--
-- Name: curatorship; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.curatorship (
    id_curatorship integer NOT NULL,
    id_news bigint NOT NULL,
    id_news_checked bigint,
    is_news boolean,
    is_similar boolean,
    is_fake_news boolean,
    text_note character varying,
    is_curated boolean DEFAULT false NOT NULL,
    is_processed boolean DEFAULT false NOT NULL
);


ALTER TABLE detectenv.curatorship OWNER TO admin;

--
-- Name: COLUMN curatorship.is_news; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.curatorship.is_news IS 'true se o texto da publicação configura uma notícia, false caso contrário.';


--
-- Name: COLUMN curatorship.is_similar; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.curatorship.is_similar IS 'Se id_news_checked não for nulo, o campo torna-se obrigatório';


--
-- Name: COLUMN curatorship.text_note; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.curatorship.text_note IS 'Anotações relevantes sobre a curadoria';


--
-- Name: COLUMN curatorship.is_curated; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.curatorship.is_curated IS 'true se registro já foi curado, false caso contrário. Valor padrão: false';


--
-- Name: COLUMN curatorship.is_processed; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.curatorship.is_processed IS 'true se registro foi persistido nas tabelas similarity_checking_outcome e checking_outcome, false caso contrário.';


--
-- Name: curatorship_id_curatorship_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.curatorship_id_curatorship_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.curatorship_id_curatorship_seq OWNER TO admin;

--
-- Name: curatorship_id_curatorship_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.curatorship_id_curatorship_seq OWNED BY detectenv.curatorship.id_curatorship;


--
-- Name: failed_job; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.failed_job (
    id_failed_job integer NOT NULL,
    id_job integer NOT NULL,
    queue character varying(50) NOT NULL,
    payload text NOT NULL,
    attempts integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    error_message text NOT NULL
);


ALTER TABLE detectenv.failed_job OWNER TO admin;

--
-- Name: failed_job_id_failed_job_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.failed_job_id_failed_job_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.failed_job_id_failed_job_seq OWNER TO admin;

--
-- Name: failed_job_id_failed_job_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.failed_job_id_failed_job_seq OWNED BY detectenv.failed_job.id_failed_job;


--
-- Name: job; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.job (
    id_job integer NOT NULL,
    queue character varying(50) NOT NULL,
    payload text NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE detectenv.job OWNER TO admin;

--
-- Name: job_id_job_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.job_id_job_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.job_id_job_seq OWNER TO admin;

--
-- Name: job_id_job_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.job_id_job_seq OWNED BY detectenv.job.id_job;


--
-- Name: news; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.news (
    id_news bigint NOT NULL,
    text_news character varying(5000) NOT NULL,
    datetime_publication timestamp without time zone,
    classification_outcome boolean,
    ground_truth_label boolean,
    prob_classification double precision,
    text_news_cleaned character varying
);


ALTER TABLE detectenv.news OWNER TO admin;

--
-- Name: TABLE news; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.news IS 'Uma notícia que circula nas redes sociais';


--
-- Name: COLUMN news.text_news_cleaned; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.news.text_news_cleaned IS 'Texto da notícia pré-processado (remove hyperlinks, nomes de usuário precedidos pelo @, pontuações e caracteres especiais)';


--
-- Name: news_id_news_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.news_id_news_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.news_id_news_seq OWNER TO admin;

--
-- Name: news_id_news_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.news_id_news_seq OWNED BY detectenv.news.id_news;


--
-- Name: owner; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.owner (
    id_owner integer NOT NULL,
    name_owner character varying(100) NOT NULL,
    location character varying(45),
    is_media boolean DEFAULT false NOT NULL,
    is_media_activated boolean DEFAULT true NOT NULL,
    is_reliable boolean DEFAULT true NOT NULL
);


ALTER TABLE detectenv.owner OWNER TO admin;

--
-- Name: TABLE owner; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.owner IS 'Uma pessoa do mundo real';


--
-- Name: COLUMN owner.is_media; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.owner.is_media IS 'Denota se o owner é um veículo de imprensa';


--
-- Name: COLUMN owner.is_media_activated; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.owner.is_media_activated IS 'Denota se o veículo de imprensa está ativo para coleta de notícias. Se true, o ambiente AUTOMATA irá coletar notícias publicadas em suas contas em redes sociais e armazená-las na tabela news.';


--
-- Name: owner_id_owner_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.owner_id_owner_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.owner_id_owner_seq OWNER TO admin;

--
-- Name: owner_id_owner_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.owner_id_owner_seq OWNED BY detectenv.owner.id_owner;


--
-- Name: post; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.post (
    id_post bigint NOT NULL,
    id_social_media_account bigint NOT NULL,
    id_news bigint NOT NULL,
    parent_id_post_social_media bigint,
    text_post character varying(5000) NOT NULL,
    num_likes integer,
    num_shares integer,
    datetime_post timestamp without time zone NOT NULL,
    id_post_social_media bigint
);


ALTER TABLE detectenv.post OWNER TO admin;

--
-- Name: TABLE post; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.post IS 'Postagem em uma rede social';


--
-- Name: COLUMN post.parent_id_post_social_media; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.post.parent_id_post_social_media IS 'Referencia id_post_social_media. Denota o post original que foi compartilhado.';


--
-- Name: COLUMN post.text_post; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.post.text_post IS 'Texto da postagem na rede social';


--
-- Name: COLUMN post.datetime_post; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.post.datetime_post IS 'Data e hora da postagem na rede social';


--
-- Name: COLUMN post.id_post_social_media; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.post.id_post_social_media IS 'Id único do post, oriundo da base de dados da rede social';


--
-- Name: post_id_post_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.post_id_post_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.post_id_post_seq OWNER TO admin;

--
-- Name: post_id_post_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.post_id_post_seq OWNED BY detectenv.post.id_post;


--
-- Name: similarity_checking_outcome; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.similarity_checking_outcome (
    id_similarity_checking_outcome integer NOT NULL,
    id_news bigint NOT NULL,
    id_news_checked integer NOT NULL
);


ALTER TABLE detectenv.similarity_checking_outcome OWNER TO admin;

--
-- Name: TABLE similarity_checking_outcome; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.similarity_checking_outcome IS 'Um registro nesta tabela denota a similaridade entre uma notícia coletada e uma notícia anteriormente checada pela agência de checagem de fatos.';


--
-- Name: similarity_checking_outcome_id_similarity_checking_outcome_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.similarity_checking_outcome_id_similarity_checking_outcome_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.similarity_checking_outcome_id_similarity_checking_outcome_seq OWNER TO admin;

--
-- Name: similarity_checking_outcome_id_similarity_checking_outcome_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.similarity_checking_outcome_id_similarity_checking_outcome_seq OWNED BY detectenv.similarity_checking_outcome.id_similarity_checking_outcome;


--
-- Name: social_media; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.social_media (
    id_social_media integer NOT NULL,
    name_social_media character varying(100) NOT NULL
);


ALTER TABLE detectenv.social_media OWNER TO admin;

--
-- Name: social_media_account; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.social_media_account (
    id_social_media_account bigint NOT NULL,
    id_social_media integer NOT NULL,
    id_owner integer,
    screen_name character varying(30),
    date_creation date,
    blue_badge boolean,
    probalphan double precision,
    probbetan double precision,
    probumalphan double precision,
    probumbetan double precision,
    id_account_social_media bigint
);


ALTER TABLE detectenv.social_media_account OWNER TO admin;

--
-- Name: TABLE social_media_account; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.social_media_account IS 'Conta de uma pessoa em uma rede social';


--
-- Name: COLUMN social_media_account.screen_name; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.social_media_account.screen_name IS 'Nome exibido na rede social';


--
-- Name: COLUMN social_media_account.blue_badge; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.social_media_account.blue_badge IS 'Denota se é ou não uma CONTA VERIFICADA na rede social';


--
-- Name: COLUMN social_media_account.id_account_social_media; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.social_media_account.id_account_social_media IS 'Id único da conta, oriundo da base de dados da rede social';


--
-- Name: social_media_account_id_social_media_account_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.social_media_account_id_social_media_account_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.social_media_account_id_social_media_account_seq OWNER TO admin;

--
-- Name: social_media_account_id_social_media_account_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.social_media_account_id_social_media_account_seq OWNED BY detectenv.social_media_account.id_social_media_account;


--
-- Name: social_media_id_social_media_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.social_media_id_social_media_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.social_media_id_social_media_seq OWNER TO admin;

--
-- Name: social_media_id_social_media_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.social_media_id_social_media_seq OWNED BY detectenv.social_media.id_social_media;


--
-- Name: trusted_agency; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.trusted_agency (
    id_trusted_agency integer NOT NULL,
    name_agency character varying(20) NOT NULL,
    email_agency character varying(255) NOT NULL,
    days_of_week character varying(255) NOT NULL
);


ALTER TABLE detectenv.trusted_agency OWNER TO admin;

--
-- Name: TABLE trusted_agency; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.trusted_agency IS 'Agência de checagem de fatos';


--
-- Name: COLUMN trusted_agency.email_agency; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.trusted_agency.email_agency IS 'E-mail da agência de checagem destinado ao envio de notícias para checagem.';


--
-- Name: COLUMN trusted_agency.days_of_week; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON COLUMN detectenv.trusted_agency.days_of_week IS 'Dias da semana destinados ao envio de e-mail. Os valores permitidos são: {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday e Sunday}. Os valores devem ser escritos sem espaços, separados por vírgula. Exemplo: Tuesday,Thursday,Saturday';


--
-- Name: trusted_agency_id_trusted_agency_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.trusted_agency_id_trusted_agency_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.trusted_agency_id_trusted_agency_seq OWNER TO admin;

--
-- Name: trusted_agency_id_trusted_agency_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.trusted_agency_id_trusted_agency_seq OWNED BY detectenv.trusted_agency.id_trusted_agency;


-- Table: admin_panel.env_variable

-- DROP TABLE IF EXISTS admin_panel.env_variable;

CREATE TABLE IF NOT EXISTS admin_panel.env_variable
(
    id bigint NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(5000) COLLATE pg_catalog."default" NOT NULL,
    type character varying(255) COLLATE pg_catalog."default" NOT NULL,
    default_value character varying(5000) COLLATE pg_catalog."default" NOT NULL,
    value character varying(5000) COLLATE pg_catalog."default" NOT NULL,
    updated boolean NOT NULL DEFAULT false,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT env_variable_pkey PRIMARY KEY (id),
    CONSTRAINT env_variable_name_unique UNIQUE (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS admin_panel.env_variable
    OWNER to admin;

--

-- SEQUENCE: admin_panel.env_variable_id_seq

-- DROP SEQUENCE IF EXISTS admin_panel.env_variable_id_seq;

CREATE SEQUENCE IF NOT EXISTS admin_panel.env_variable_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    OWNED BY admin_panel.env_variable.id;

ALTER SEQUENCE admin_panel.env_variable_id_seq
    OWNER TO admin;

ALTER TABLE ONLY admin_panel.env_variable ALTER COLUMN id SET DEFAULT nextval('admin_panel.env_variable_id_seq'::regclass);


--
-- Name: action_log id_action_log; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_log ALTER COLUMN id_action_log SET DEFAULT nextval('detectenv.action_log_id_action_log_seq'::regclass);


--
-- Name: action_type id_action; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_type ALTER COLUMN id_action SET DEFAULT nextval('detectenv.action_type_id_action_seq'::regclass);


--
-- Name: agency_news_checked id_news_checked; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.agency_news_checked ALTER COLUMN id_news_checked SET DEFAULT nextval('detectenv.agency_news_checked_id_news_checked_seq'::regclass);


--
-- Name: checking_outcome id_checking_outcome; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.checking_outcome ALTER COLUMN id_checking_outcome SET DEFAULT nextval('detectenv.checking_outcome_id_checking_outcome_seq'::regclass);


--
-- Name: curatorship id_curatorship; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.curatorship ALTER COLUMN id_curatorship SET DEFAULT nextval('detectenv.curatorship_id_curatorship_seq'::regclass);


--
-- Name: failed_job id_failed_job; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.failed_job ALTER COLUMN id_failed_job SET DEFAULT nextval('detectenv.failed_job_id_failed_job_seq'::regclass);


--
-- Name: job id_job; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.job ALTER COLUMN id_job SET DEFAULT nextval('detectenv.job_id_job_seq'::regclass);


--
-- Name: news id_news; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.news ALTER COLUMN id_news SET DEFAULT nextval('detectenv.news_id_news_seq'::regclass);


--
-- Name: owner id_owner; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.owner ALTER COLUMN id_owner SET DEFAULT nextval('detectenv.owner_id_owner_seq'::regclass);


--
-- Name: post id_post; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post ALTER COLUMN id_post SET DEFAULT nextval('detectenv.post_id_post_seq'::regclass);


--
-- Name: similarity_checking_outcome id_similarity_checking_outcome; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.similarity_checking_outcome ALTER COLUMN id_similarity_checking_outcome SET DEFAULT nextval('detectenv.similarity_checking_outcome_id_similarity_checking_outcome_seq'::regclass);


--
-- Name: social_media id_social_media; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media ALTER COLUMN id_social_media SET DEFAULT nextval('detectenv.social_media_id_social_media_seq'::regclass);


--
-- Name: social_media_account id_social_media_account; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media_account ALTER COLUMN id_social_media_account SET DEFAULT nextval('detectenv.social_media_account_id_social_media_account_seq'::regclass);


--
-- Name: trusted_agency id_trusted_agency; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.trusted_agency ALTER COLUMN id_trusted_agency SET DEFAULT nextval('detectenv.trusted_agency_id_trusted_agency_seq'::regclass);


--
-- Name: action_log action_log_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_log
    ADD CONSTRAINT action_log_pkey PRIMARY KEY (id_action_log);


--
-- Name: action_type action_type_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_type
    ADD CONSTRAINT action_type_pkey PRIMARY KEY (id_action);


--
-- Name: agency_news_checked agency_news_checked_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.agency_news_checked
    ADD CONSTRAINT agency_news_checked_pkey PRIMARY KEY (id_news_checked);


--
-- Name: checking_outcome checking_outcome_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.checking_outcome
    ADD CONSTRAINT checking_outcome_pkey PRIMARY KEY (id_checking_outcome);


--
-- Name: curatorship curatorship_id_news_uq; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.curatorship
    ADD CONSTRAINT curatorship_id_news_uq UNIQUE (id_news);


--
-- Name: curatorship curatorship_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.curatorship
    ADD CONSTRAINT curatorship_pkey PRIMARY KEY (id_curatorship);


--
-- Name: failed_job failed_job_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.failed_job
    ADD CONSTRAINT failed_job_pkey PRIMARY KEY (id_failed_job);


--
-- Name: failed_job id_job_unique; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.failed_job
    ADD CONSTRAINT id_job_unique UNIQUE (id_job);


--
-- Name: checking_outcome id_news_co_unique; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.checking_outcome
    ADD CONSTRAINT id_news_co_unique UNIQUE (id_news, id_trusted_agency);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id_job);


--
-- Name: job job_unique; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.job
    ADD CONSTRAINT job_unique UNIQUE (queue, payload);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id_news);


--
-- Name: owner owner_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.owner
    ADD CONSTRAINT owner_pkey PRIMARY KEY (id_owner);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id_post);


--
-- Name: similarity_checking_outcome similarity_checking_outcome_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.similarity_checking_outcome
    ADD CONSTRAINT similarity_checking_outcome_pkey PRIMARY KEY (id_similarity_checking_outcome);


--
-- Name: social_media_account social_media_account_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media_account
    ADD CONSTRAINT social_media_account_pkey PRIMARY KEY (id_social_media_account);


--
-- Name: social_media social_media_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media
    ADD CONSTRAINT social_media_pkey PRIMARY KEY (id_social_media);


--
-- Name: trusted_agency trusted_agency_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.trusted_agency
    ADD CONSTRAINT trusted_agency_pkey PRIMARY KEY (id_trusted_agency);


--
-- Name: id_social_id_owner_social_media_account_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX id_social_id_owner_social_media_account_idx ON detectenv.social_media_account USING btree (id_social_media, id_owner);


--
-- Name: idaccountsocialmedia_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX idaccountsocialmedia_idx ON detectenv.social_media_account USING btree (id_account_social_media);


--
-- Name: name_action_type_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_action_type_idx ON detectenv.action_type USING btree (name_action);


--
-- Name: name_owner_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_owner_idx ON detectenv.owner USING btree (name_owner);


--
-- Name: name_social_media_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_social_media_idx ON detectenv.social_media USING btree (name_social_media);


--
-- Name: name_trusted_agency_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_trusted_agency_idx ON detectenv.trusted_agency USING btree (name_agency);


--
-- Name: action_log action_type_action_log_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_log
    ADD CONSTRAINT action_type_action_log_fk FOREIGN KEY (id_action) REFERENCES detectenv.action_type(id_action);


--
-- Name: curatorship agency_news_checked_curatorship_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.curatorship
    ADD CONSTRAINT agency_news_checked_curatorship_fk FOREIGN KEY (id_news_checked) REFERENCES detectenv.agency_news_checked(id_news_checked);


--
-- Name: similarity_checking_outcome agency_news_checked_similarity_checking_outcome_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.similarity_checking_outcome
    ADD CONSTRAINT agency_news_checked_similarity_checking_outcome_fk FOREIGN KEY (id_news_checked) REFERENCES detectenv.agency_news_checked(id_news_checked);


--
-- Name: action_log news_action_log_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_log
    ADD CONSTRAINT news_action_log_fk FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news);


--
-- Name: checking_outcome news_checking_outcome_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.checking_outcome
    ADD CONSTRAINT news_checking_outcome_fk FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news);


--
-- Name: curatorship news_curatorship_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.curatorship
    ADD CONSTRAINT news_curatorship_fk FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news);


--
-- Name: similarity_checking_outcome news_similarity_checking_outcome_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.similarity_checking_outcome
    ADD CONSTRAINT news_similarity_checking_outcome_fk FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news);


--
-- Name: social_media_account owner_social_media_account_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media_account
    ADD CONSTRAINT owner_social_media_account_fk FOREIGN KEY (id_owner) REFERENCES detectenv.owner(id_owner);


--
-- Name: post post_id_news_fkey; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post
    ADD CONSTRAINT post_id_news_fkey FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news) NOT VALID;


--
-- Name: post social_media_account_post_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post
    ADD CONSTRAINT social_media_account_post_fk FOREIGN KEY (id_social_media_account) REFERENCES detectenv.social_media_account(id_social_media_account);


--
-- Name: social_media_account social_media_social_media_account_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media_account
    ADD CONSTRAINT social_media_social_media_account_fk FOREIGN KEY (id_social_media) REFERENCES detectenv.social_media(id_social_media);


--
-- Name: agency_news_checked trusted_agency_agency_news_checked_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.agency_news_checked
    ADD CONSTRAINT trusted_agency_agency_news_checked_fk FOREIGN KEY (id_trusted_agency) REFERENCES detectenv.trusted_agency(id_trusted_agency);


--
-- Name: checking_outcome trusted_agency_checking_outcome_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.checking_outcome
    ADD CONSTRAINT trusted_agency_checking_outcome_fk FOREIGN KEY (id_trusted_agency) REFERENCES detectenv.trusted_agency(id_trusted_agency);


--
-- PostgreSQL database dump complete
--

