-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Thu Nov  4 14:34:31 2010
-- 

BEGIN TRANSACTION;

--
-- Table: antena
--
DROP TABLE antena;

CREATE TABLE antena (
  antena_id INTEGER PRIMARY KEY NOT NULL,
  serie integer NOT NULL,
  leitor_id integer NOT NULL,
  porta smallint
);

CREATE INDEX antena_idx_leitor_id ON antena (leitor_id);

--
-- Table: evento
--
DROP TABLE evento;

CREATE TABLE evento (
  evento_id INTEGER PRIMARY KEY NOT NULL,
  descricao varchar(250) NOT NULL,
  dia smallint,
  palestrante varchar(200),
  sala_id integer,
  tema varchar(100),
  inicio time,
  fim time
);

--
-- Table: evento_sala
--
DROP TABLE evento_sala;

CREATE TABLE evento_sala (
  evento_id smallint NOT NULL,
  sala_id integer NOT NULL,
  PRIMARY KEY (evento_id, sala_id)
);

CREATE INDEX evento_sala_idx_evento_id ON evento_sala (evento_id);

CREATE INDEX evento_sala_idx_sala_id ON evento_sala (sala_id);

--
-- Table: leitor
--
DROP TABLE leitor;

CREATE TABLE leitor (
  leitor_id INTEGER PRIMARY KEY NOT NULL,
  serie integer NOT NULL,
  ip varchar(15)
);

--
-- Table: leitura
--
DROP TABLE leitura;

CREATE TABLE leitura (
  dia smallint NOT NULL,
  registro time NOT NULL,
  leitura_id bigint NOT NULL,
  tag varchar(70) NOT NULL,
  participante_id integer NOT NULL,
  antena_id integer NOT NULL,
  qtd integer NOT NULL,
  PRIMARY KEY (leitura_id, participante_id, antena_id)
);

CREATE INDEX leitura_idx_antena_id ON leitura (antena_id);

CREATE INDEX leitura_idx_participante_id ON leitura (participante_id);

--
-- Table: participante
--
DROP TABLE participante;

CREATE TABLE participante (
  participante_id INTEGER PRIMARY KEY NOT NULL,
  nome varchar(200),
  tipo varchar(100),
  tipoinsc varchar(5),
  profissao varchar(50)
);

--
-- Table: role
--
DROP TABLE role;

CREATE TABLE role (
  role_id INTEGER PRIMARY KEY NOT NULL,
  role varchar(45) NOT NULL
);

--
-- Table: sala
--
DROP TABLE sala;

CREATE TABLE sala (
  sala_id INTEGER PRIMARY KEY NOT NULL,
  descricao varchar(50) NOT NULL,
  image varchar(40)
);

--
-- Table: sala_antena
--
DROP TABLE sala_antena;

CREATE TABLE sala_antena (
  sala_id integer NOT NULL,
  antena_id integer NOT NULL,
  inicio time NOT NULL,
  fim time,
  dia smallint NOT NULL,
  PRIMARY KEY (sala_id, antena_id, inicio, dia)
);

CREATE INDEX sala_antena_idx_antena_id ON sala_antena (antena_id);

CREATE INDEX sala_antena_idx_sala_id ON sala_antena (sala_id);

--
-- Table: user
--
DROP TABLE user;

CREATE TABLE user (
  user_id INTEGER PRIMARY KEY NOT NULL,
  user_name varchar(100) NOT NULL,
  user_login varchar(45) NOT NULL,
  user_email varchar(100) NOT NULL,
  user_password VARCHAR(45) NOT NULL
);

--
-- Table: user_role
--
DROP TABLE user_role;

CREATE TABLE user_role (
  user_user_id integer NOT NULL,
  role_role_id integer NOT NULL,
  PRIMARY KEY (user_user_id, role_role_id)
);

CREATE INDEX user_role_idx_role_role_id ON user_role (role_role_id);

CREATE INDEX user_role_idx_user_user_id ON user_role (user_user_id);

COMMIT;
