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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: days; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE days (
    id integer NOT NULL,
    game_date timestamp without time zone,
    umpire character varying(255),
    home_team character varying(255),
    away_team character varying(255),
    total_distance_missed double precision,
    umpire_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    inning character varying(255),
    ball_count integer,
    strike_count integer,
    outs integer,
    inning_half character varying(255),
    pitch_id integer,
    play character varying(255),
    img_date character varying(255)
);


--
-- Name: days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE days_id_seq OWNED BY days.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE favorites (
    id integer NOT NULL,
    user_id integer,
    team_id integer,
    pitcher_id integer,
    umpire_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE favorites_id_seq OWNED BY favorites.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE games (
    id integer NOT NULL,
    home_team_id integer,
    away_team_id integer,
    gid character varying(255),
    mlb_umpire_id integer,
    umpire_id integer,
    game_date timestamp without time zone,
    total_calls integer DEFAULT 0,
    correct_calls integer DEFAULT 0,
    incorrect_calls integer DEFAULT 0,
    home_team_abbrev character varying(255),
    away_team_abbrev character varying(255),
    percent_correct double precision DEFAULT 0,
    umpire_name character varying(255),
    game_type character varying(255),
    home_full_name character varying(255),
    away_full_name character varying(255)
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: games_teams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE games_teams (
    id integer NOT NULL,
    game_id integer,
    team_id integer
);


--
-- Name: games_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_teams_id_seq OWNED BY games_teams.id;


--
-- Name: pitchers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pitchers (
    id integer NOT NULL,
    name character varying(255),
    team character varying(255),
    pid integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pitchers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pitchers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pitchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pitchers_id_seq OWNED BY pitchers.id;


--
-- Name: pitches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pitches (
    id integer NOT NULL,
    gid character varying(255),
    date_string timestamp without time zone,
    description character varying(255),
    pid integer,
    x_location double precision,
    y_location double precision,
    sz_top double precision,
    sz_bottom double precision,
    sv_id character varying(255),
    type_id character varying(255),
    missing_data boolean,
    correct_call boolean,
    distance_missed_x double precision DEFAULT 0,
    distance_missed_y double precision DEFAULT 0,
    total_distance_missed double precision DEFAULT 0,
    pitcher_id integer,
    mlb_umpire_id integer,
    batter_id integer,
    game_id integer,
    ball_count integer,
    strike_count integer,
    outs integer,
    inning_half character varying(255),
    inning integer,
    play text
);


--
-- Name: pitches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pitches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pitches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pitches_id_seq OWNED BY pitches.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    team_id integer,
    abbreviation character varying(255),
    full_name character varying(255),
    division_id integer,
    league_id integer,
    code character varying(255),
    city character varying(255),
    name_brief character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255)
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: umpires; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE umpires (
    id integer NOT NULL,
    name character varying(255),
    mlb_umpire_id integer
);


--
-- Name: umpires_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE umpires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umpires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE umpires_id_seq OWNED BY umpires.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY days ALTER COLUMN id SET DEFAULT nextval('days_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY favorites ALTER COLUMN id SET DEFAULT nextval('favorites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY games_teams ALTER COLUMN id SET DEFAULT nextval('games_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pitchers ALTER COLUMN id SET DEFAULT nextval('pitchers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pitches ALTER COLUMN id SET DEFAULT nextval('pitches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY umpires ALTER COLUMN id SET DEFAULT nextval('umpires_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: days_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY days
    ADD CONSTRAINT days_pkey PRIMARY KEY (id);


--
-- Name: favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: games_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY games_teams
    ADD CONSTRAINT games_teams_pkey PRIMARY KEY (id);


--
-- Name: pitchers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pitchers
    ADD CONSTRAINT pitchers_pkey PRIMARY KEY (id);


--
-- Name: pitches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pitches
    ADD CONSTRAINT pitches_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: umpires_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY umpires
    ADD CONSTRAINT umpires_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_games_on_umpire_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_games_on_umpire_id ON games USING btree (umpire_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: my_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX my_index ON umpires USING btree (mlb_umpire_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140113194046');

INSERT INTO schema_migrations (version) VALUES ('20140113215948');

INSERT INTO schema_migrations (version) VALUES ('20140113223414');

INSERT INTO schema_migrations (version) VALUES ('20140113223704');

INSERT INTO schema_migrations (version) VALUES ('20140113223810');

INSERT INTO schema_migrations (version) VALUES ('20140113224509');

INSERT INTO schema_migrations (version) VALUES ('20140114234722');

INSERT INTO schema_migrations (version) VALUES ('20140422001331');

INSERT INTO schema_migrations (version) VALUES ('20140426054823');

INSERT INTO schema_migrations (version) VALUES ('20140708195112');

INSERT INTO schema_migrations (version) VALUES ('20140710131145');

INSERT INTO schema_migrations (version) VALUES ('20140710204443');

INSERT INTO schema_migrations (version) VALUES ('20140711144841');

INSERT INTO schema_migrations (version) VALUES ('20140711152326');

INSERT INTO schema_migrations (version) VALUES ('20140711181801');

INSERT INTO schema_migrations (version) VALUES ('20140711201211');

INSERT INTO schema_migrations (version) VALUES ('20140711211029');

INSERT INTO schema_migrations (version) VALUES ('20140715144329');

INSERT INTO schema_migrations (version) VALUES ('20140716175113');

INSERT INTO schema_migrations (version) VALUES ('20140719175537');

INSERT INTO schema_migrations (version) VALUES ('20150220194921');

