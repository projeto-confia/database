--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

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
-- Name: get_news_shared_by_users_with_params_ics(); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.get_news_shared_by_users_with_params_ics() RETURNS TABLE(id_social_media_account bigint, probalphan double precision, probbetan double precision, probumalphan double precision, probumbetan double precision, id_post bigint, id_news bigint, classification_outcome boolean, ground_truth_label boolean)
    LANGUAGE plpgsql
    AS $$























begin























	return query























	select q.id_social_media_account, q.probalphan, q.probbetan, q.probumalphan, q.probumbetan, post.id_post, news.id_news, news.classification_outcome, news.ground_truth_label from 























	(select * from detectenv.social_media_account as sma























	where (sma.probalphan != 0.5 or sma.probbetan != 0.5 or sma.probumalphan != 0.5 or sma.probumbetan != 0.5)























	order by id_social_media_account asc) as q, detectenv.news as news, detectenv.post as post























	where q.id_social_media_account = post.id_social_media_account and post.id_news = news.id_news and news.classification_outcome is null;























end	























$$;


ALTER FUNCTION detectenv.get_news_shared_by_users_with_params_ics() OWNER TO admin;

--
-- Name: get_top_users_which_shared_most_fake_news_ics(integer); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.get_top_users_which_shared_most_fake_news_ics(numusers integer) RETURNS TABLE(id_account_social_media bigint, screen_name character varying, total_fake_news bigint)
    LANGUAGE plpgsql
    AS $$





BEGIN





	return query





	select * from





	(select detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name, count(detectenv.news.classification_outcome) as total_fake_news





	from detectenv.post





	inner join detectenv.social_media_account





	 	on detectenv.post.id_social_media_account = detectenv.social_media_account.id_social_media_account





	inner join detectenv.news





	 	on detectenv.post.id_news = detectenv.news.id_news





	where detectenv.news.classification_outcome = true





	group by





		detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name) tbl





    order by tbl.total_fake_news desc limit numUsers;





END $$;


ALTER FUNCTION detectenv.get_top_users_which_shared_most_fake_news_ics(numusers integer) OWNER TO admin;

--
-- Name: get_top_users_which_shared_news_ics(); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.get_top_users_which_shared_news_ics() RETURNS TABLE(id_account_social_media bigint, screen_name character varying, total_news bigint, total_fake_news bigint, total_not_fake_news bigint, rate_fake_news numeric, rate_not_fake_news numeric)
    LANGUAGE plpgsql
    AS $$





BEGIN





	return query





	with tabela as (





		(select * from





			(select detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name, 





			 count(detectenv.news.classification_outcome) as total_news,





			 count(detectenv.news.classification_outcome) filter (where detectenv.news.classification_outcome = true) as total_fake_news,





			 count(detectenv.news.classification_outcome) filter (where detectenv.news.classification_outcome = false) as total_not_fake_news





			from detectenv.post





			inner join detectenv.social_media_account





				on detectenv.post.id_social_media_account = detectenv.social_media_account.id_social_media_account





			inner join detectenv.news





				on detectenv.post.id_news = detectenv.news.id_news





			group by





				detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name) tbl





			where tbl.total_news > 0))





		select *, ((tabela.total_fake_news::decimal) / (tabela.total_news::decimal)) as rate_fake_news, ((tabela.total_not_fake_news::decimal) / (tabela.total_news::decimal)) as rate_not_fake_news 





		from tabela;





END $$;


ALTER FUNCTION detectenv.get_top_users_which_shared_news_ics() OWNER TO admin;

--
-- Name: get_top_users_which_shared_news_ics(integer); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.get_top_users_which_shared_news_ics(numusers integer) RETURNS TABLE(id_account_social_media bigint, screen_name character varying, total_news bigint, total_fake_news bigint, total_not_fake_news bigint, rate_fake_news numeric, rate_not_fake_news numeric)
    LANGUAGE plpgsql
    AS $$





BEGIN





	return query





	with tabela as (





		(select * from





			(select detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name, 





			 count(detectenv.news.classification_outcome) as total_news,





			 count(detectenv.news.classification_outcome) filter (where detectenv.news.classification_outcome = true) as total_fake_news,





			 count(detectenv.news.classification_outcome) filter (where detectenv.news.classification_outcome = false) as total_not_fake_news





			from detectenv.post





			inner join detectenv.social_media_account





				on detectenv.post.id_social_media_account = detectenv.social_media_account.id_social_media_account





			inner join detectenv.news





				on detectenv.post.id_news = detectenv.news.id_news





			group by





				detectenv.social_media_account.id_account_social_media, detectenv.social_media_account.screen_name) tbl





			where tbl.total_news > 0) 





		limit numusers)





	select *, ((tabela.total_fake_news::decimal) / (tabela.total_news::decimal)) as rate_fake_news, ((tabela.total_not_fake_news::decimal) / (tabela.total_news::decimal)) as rate_not_fake_news 





	from tabela;





END $$;


ALTER FUNCTION detectenv.get_top_users_which_shared_news_ics(numusers integer) OWNER TO admin;

--
-- Name: get_users_which_shared_the_news(bigint); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.get_users_which_shared_the_news(id_searched_news bigint) RETURNS TABLE(id_social_media_account bigint, probalphan double precision, probbetan double precision, probumalphan double precision, probumbetan double precision)
    LANGUAGE plpgsql
    AS $$























BEGIN























	RETURN QUERY























	select detectenv.post.id_social_media_account AS id_social_media_account, detectenv.social_media_account.probalphan, detectenv.social_media_account.probbetan, detectenv.social_media_account.probumalphan, detectenv.social_media_account.probumbetan from detectenv.social_media_account, detectenv.post























	where detectenv.social_media_account.id_social_media_account = detectenv.post.id_social_media_account and detectenv.post.id_news = id_searched_news;























END























$$;


ALTER FUNCTION detectenv.get_users_which_shared_the_news(id_searched_news bigint) OWNER TO admin;

--
-- Name: insert_update_social_media_account(integer, integer, character varying, date, boolean, double precision, double precision, double precision, double precision, bigint); Type: FUNCTION; Schema: detectenv; Owner: admin
--

CREATE FUNCTION detectenv.insert_update_social_media_account(idsocialmedia integer, idowner integer, screenname character varying, datecreation date, bluebadge boolean, prob_alphan double precision, prob_betan double precision, prob_umalphan double precision, prob_umbetan double precision, idaccountsocialmedia bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$ 























    DECLARE 























    BEGIN 























		INSERT INTO detectenv.social_media_account(id_social_media, id_owner, screen_name, date_creation, blue_badge, probalphan, probbetan, probumalphan, probumbetan, id_account_social_media) values (idSocialMedia, idOwner, screenName, dateCreation, blueBadge, prob_AlphaN, prob_BetaN, prob_UmAlphaN, prob_UmBetaN, idAccountSocialMedia) 























		ON CONFLICT (id_account_social_media) DO 























		UPDATE SET probalphan = prob_AlphaN, probbetan = prob_BetaN, probumalphan = prob_UmAlphaN, probumbetan = prob_UmBetaN WHERE social_media_account.id_account_social_media = idAccountSocialMedia;























    END;























    $$;


ALTER FUNCTION detectenv.insert_update_social_media_account(idsocialmedia integer, idowner integer, screenname character varying, datecreation date, bluebadge boolean, prob_alphan double precision, prob_betan double precision, prob_umalphan double precision, prob_umbetan double precision, idaccountsocialmedia bigint) OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: failed_jobs; Type: TABLE; Schema: admin_panel; Owner: admin
--

CREATE TABLE admin_panel.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE admin_panel.failed_jobs OWNER TO admin;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: admin_panel; Owner: admin
--

CREATE SEQUENCE admin_panel.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_panel.failed_jobs_id_seq OWNER TO admin;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: admin_panel; Owner: admin
--

ALTER SEQUENCE admin_panel.failed_jobs_id_seq OWNED BY admin_panel.failed_jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: admin_panel; Owner: admin
--

CREATE TABLE admin_panel.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE admin_panel.migrations OWNER TO admin;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: admin_panel; Owner: admin
--

CREATE SEQUENCE admin_panel.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_panel.migrations_id_seq OWNER TO admin;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: admin_panel; Owner: admin
--

ALTER SEQUENCE admin_panel.migrations_id_seq OWNED BY admin_panel.migrations.id;


--
-- Name: password_resets; Type: TABLE; Schema: admin_panel; Owner: admin
--

CREATE TABLE admin_panel.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE admin_panel.password_resets OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: admin_panel; Owner: admin
--

CREATE TABLE admin_panel.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE admin_panel.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: admin_panel; Owner: admin
--

CREATE SEQUENCE admin_panel.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_panel.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: admin_panel; Owner: admin
--

ALTER SEQUENCE admin_panel.users_id_seq OWNED BY admin_panel.users.id;


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
-- Name: news; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.news (
    id_news bigint NOT NULL,
    text_news character varying(5000) NOT NULL,
    datetime_publication timestamp without time zone,
    classification_outcome boolean,
    ground_truth_label boolean,
    prob_classification double precision
);


ALTER TABLE detectenv.news OWNER TO admin;

--
-- Name: TABLE news; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.news IS 'Uma notícia que circula nas redes sociais';


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
    is_media_activated boolean DEFAULT true NOT NULL
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
-- Name: permission; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.permission (
    id_permission integer NOT NULL,
    id_permission_type integer NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE detectenv.permission OWNER TO admin;

--
-- Name: TABLE permission; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.permission IS 'Permissões no Painel Administrativo associadas a um perfil';


--
-- Name: permission_id_permission_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.permission_id_permission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.permission_id_permission_seq OWNER TO admin;

--
-- Name: permission_id_permission_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.permission_id_permission_seq OWNED BY detectenv.permission.id_permission;


--
-- Name: permission_type; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.permission_type (
    id_permission_type integer NOT NULL,
    name_permission character varying(100) NOT NULL
);


ALTER TABLE detectenv.permission_type OWNER TO admin;

--
-- Name: TABLE permission_type; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.permission_type IS 'Tipos de permissões para o Painel Administrativo';


--
-- Name: permission_type_id_permission_type_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.permission_type_id_permission_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.permission_type_id_permission_type_seq OWNER TO admin;

--
-- Name: permission_type_id_permission_type_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.permission_type_id_permission_type_seq OWNED BY detectenv.permission_type.id_permission_type;


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
-- Name: role; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.role (
    id_role integer NOT NULL,
    name_role character varying(100) NOT NULL
);


ALTER TABLE detectenv.role OWNER TO admin;

--
-- Name: TABLE role; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.role IS 'Perfis de conta de usuário do Painel Administrativo';


--
-- Name: role_id_role_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.role_id_role_seq OWNER TO admin;

--
-- Name: role_id_role_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.role_id_role_seq OWNED BY detectenv.role.id_role;


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


--
-- Name: user_account; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.user_account (
    id_user_account integer NOT NULL,
    name_user_account character varying(100) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE detectenv.user_account OWNER TO admin;

--
-- Name: TABLE user_account; Type: COMMENT; Schema: detectenv; Owner: admin
--

COMMENT ON TABLE detectenv.user_account IS 'Conta de usuário do Painel Administrativo';


--
-- Name: user_account_id_user_account_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.user_account_id_user_account_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.user_account_id_user_account_seq OWNER TO admin;

--
-- Name: user_account_id_user_account_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.user_account_id_user_account_seq OWNED BY detectenv.user_account.id_user_account;


--
-- Name: user_role; Type: TABLE; Schema: detectenv; Owner: admin
--

CREATE TABLE detectenv.user_role (
    id_user_role integer NOT NULL,
    id_user_account integer NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE detectenv.user_role OWNER TO admin;

--
-- Name: user_role_id_user_role_seq; Type: SEQUENCE; Schema: detectenv; Owner: admin
--

CREATE SEQUENCE detectenv.user_role_id_user_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detectenv.user_role_id_user_role_seq OWNER TO admin;

--
-- Name: user_role_id_user_role_seq; Type: SEQUENCE OWNED BY; Schema: detectenv; Owner: admin
--

ALTER SEQUENCE detectenv.user_role_id_user_role_seq OWNED BY detectenv.user_role.id_user_role;


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.failed_jobs ALTER COLUMN id SET DEFAULT nextval('admin_panel.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.migrations ALTER COLUMN id SET DEFAULT nextval('admin_panel.migrations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.users ALTER COLUMN id SET DEFAULT nextval('admin_panel.users_id_seq'::regclass);


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
-- Name: news id_news; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.news ALTER COLUMN id_news SET DEFAULT nextval('detectenv.news_id_news_seq'::regclass);


--
-- Name: owner id_owner; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.owner ALTER COLUMN id_owner SET DEFAULT nextval('detectenv.owner_id_owner_seq'::regclass);


--
-- Name: permission id_permission; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission ALTER COLUMN id_permission SET DEFAULT nextval('detectenv.permission_id_permission_seq'::regclass);


--
-- Name: permission_type id_permission_type; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission_type ALTER COLUMN id_permission_type SET DEFAULT nextval('detectenv.permission_type_id_permission_type_seq'::regclass);


--
-- Name: post id_post; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post ALTER COLUMN id_post SET DEFAULT nextval('detectenv.post_id_post_seq'::regclass);


--
-- Name: role id_role; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.role ALTER COLUMN id_role SET DEFAULT nextval('detectenv.role_id_role_seq'::regclass);


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
-- Name: user_account id_user_account; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_account ALTER COLUMN id_user_account SET DEFAULT nextval('detectenv.user_account_id_user_account_seq'::regclass);


--
-- Name: user_role id_user_role; Type: DEFAULT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_role ALTER COLUMN id_user_role SET DEFAULT nextval('detectenv.user_role_id_user_role_seq'::regclass);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: admin_panel; Owner: admin
--

ALTER TABLE ONLY admin_panel.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id_permission);


--
-- Name: permission_type permission_type_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission_type
    ADD CONSTRAINT permission_type_pkey PRIMARY KEY (id_permission_type);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id_post);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);


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
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id_user_account);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id_user_role);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: admin_panel; Owner: admin
--

CREATE INDEX password_resets_email_index ON admin_panel.password_resets USING btree (email);


--
-- Name: id_permission_id_role_permission_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX id_permission_id_role_permission_idx ON detectenv.permission USING btree (id_permission_type, id_role);


--
-- Name: id_social_id_owner_social_media_account_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX id_social_id_owner_social_media_account_idx ON detectenv.social_media_account USING btree (id_social_media, id_owner);


--
-- Name: id_user_id_role_user_role_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX id_user_id_role_user_role_idx ON detectenv.user_role USING btree (id_user_account, id_role);


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
-- Name: name_permission_type_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_permission_type_idx ON detectenv.permission_type USING btree (name_permission);


--
-- Name: name_role_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_role_idx ON detectenv.role USING btree (name_role);


--
-- Name: name_social_media_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_social_media_idx ON detectenv.social_media USING btree (name_social_media);


--
-- Name: name_trusted_agency_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_trusted_agency_idx ON detectenv.trusted_agency USING btree (name_agency);


--
-- Name: name_user_account_idx; Type: INDEX; Schema: detectenv; Owner: admin
--

CREATE UNIQUE INDEX name_user_account_idx ON detectenv.user_account USING btree (name_user_account);


--
-- Name: action_log action_type_action_log_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.action_log
    ADD CONSTRAINT action_type_action_log_fk FOREIGN KEY (id_action) REFERENCES detectenv.action_type(id_action);


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
-- Name: social_media_account owner_social_media_account_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.social_media_account
    ADD CONSTRAINT owner_social_media_account_fk FOREIGN KEY (id_owner) REFERENCES detectenv.owner(id_owner);


--
-- Name: permission permission_type_permission_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission
    ADD CONSTRAINT permission_type_permission_fk FOREIGN KEY (id_permission_type) REFERENCES detectenv.permission_type(id_permission_type);


--
-- Name: post post_id_news_fkey; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.post
    ADD CONSTRAINT post_id_news_fkey FOREIGN KEY (id_news) REFERENCES detectenv.news(id_news) NOT VALID;


--
-- Name: permission role_permission_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.permission
    ADD CONSTRAINT role_permission_fk FOREIGN KEY (id_role) REFERENCES detectenv.role(id_role);


--
-- Name: user_role role_user_role_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_role
    ADD CONSTRAINT role_user_role_fk FOREIGN KEY (id_role) REFERENCES detectenv.role(id_role);


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
-- Name: user_role user_account_user_role_fk; Type: FK CONSTRAINT; Schema: detectenv; Owner: admin
--

ALTER TABLE ONLY detectenv.user_role
    ADD CONSTRAINT user_account_user_role_fk FOREIGN KEY (id_user_account) REFERENCES detectenv.user_account(id_user_account);


--
-- PostgreSQL database dump complete
--

