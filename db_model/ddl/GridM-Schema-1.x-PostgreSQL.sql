-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Thu Nov  4 14:34:31 2010
-- 
--
-- Table: antena
--
DROP TABLE "antena" CASCADE;
CREATE TABLE "antena" (
  "antena_id" serial NOT NULL,
  "serie" integer NOT NULL,
  "leitor_id" integer NOT NULL,
  "porta" smallint,
  PRIMARY KEY ("antena_id")
);
CREATE INDEX "antena_idx_leitor_id" on "antena" ("leitor_id");

--
-- Table: evento
--
DROP TABLE "evento" CASCADE;
CREATE TABLE "evento" (
  "evento_id" serial NOT NULL,
  "descricao" character varying(250) NOT NULL,
  "dia" smallint,
  "palestrante" character varying(200),
  "sala_id" integer,
  "tema" character varying(100),
  "inicio" time,
  "fim" time,
  PRIMARY KEY ("evento_id")
);

--
-- Table: evento_sala
--
DROP TABLE "evento_sala" CASCADE;
CREATE TABLE "evento_sala" (
  "evento_id" smallint NOT NULL,
  "sala_id" integer NOT NULL,
  PRIMARY KEY ("evento_id", "sala_id")
);
CREATE INDEX "evento_sala_idx_evento_id" on "evento_sala" ("evento_id");
CREATE INDEX "evento_sala_idx_sala_id" on "evento_sala" ("sala_id");

--
-- Table: leitor
--
DROP TABLE "leitor" CASCADE;
CREATE TABLE "leitor" (
  "leitor_id" serial NOT NULL,
  "serie" integer NOT NULL,
  "ip" character varying(15),
  PRIMARY KEY ("leitor_id")
);

--
-- Table: leitura
--
DROP TABLE "leitura" CASCADE;
CREATE TABLE "leitura" (
  "dia" smallint NOT NULL,
  "registro" time NOT NULL,
  "leitura_id" serial NOT NULL,
  "tag" character varying(70) NOT NULL,
  "participante_id" integer NOT NULL,
  "antena_id" integer NOT NULL,
  "qtd" integer NOT NULL,
  PRIMARY KEY ("leitura_id", "participante_id", "antena_id")
);
CREATE INDEX "leitura_idx_antena_id" on "leitura" ("antena_id");
CREATE INDEX "leitura_idx_participante_id" on "leitura" ("participante_id");

--
-- Table: participante
--
DROP TABLE "participante" CASCADE;
CREATE TABLE "participante" (
  "participante_id" integer NOT NULL,
  "nome" character varying(200),
  "tipo" character varying(100),
  "tipoinsc" character varying(5),
  "profissao" character varying(50),
  PRIMARY KEY ("participante_id")
);

--
-- Table: role
--
DROP TABLE "role" CASCADE;
CREATE TABLE "role" (
  "role_id" integer NOT NULL,
  "role" character varying(45) NOT NULL,
  PRIMARY KEY ("role_id")
);

--
-- Table: sala
--
DROP TABLE "sala" CASCADE;
CREATE TABLE "sala" (
  "sala_id" serial NOT NULL,
  "descricao" character varying(50) NOT NULL,
  "image" character varying(40),
  PRIMARY KEY ("sala_id")
);

--
-- Table: sala_antena
--
DROP TABLE "sala_antena" CASCADE;
CREATE TABLE "sala_antena" (
  "sala_id" integer NOT NULL,
  "antena_id" integer NOT NULL,
  "inicio" time NOT NULL,
  "fim" time,
  "dia" smallint NOT NULL,
  PRIMARY KEY ("sala_id", "antena_id", "inicio", "dia")
);
CREATE INDEX "sala_antena_idx_antena_id" on "sala_antena" ("antena_id");
CREATE INDEX "sala_antena_idx_sala_id" on "sala_antena" ("sala_id");

--
-- Table: user
--
DROP TABLE "user" CASCADE;
CREATE TABLE "user" (
  "user_id" serial NOT NULL,
  "user_name" character varying(100) NOT NULL,
  "user_login" character varying(45) NOT NULL,
  "user_email" character varying(100) NOT NULL,
  "user_password" character varying(45) NOT NULL,
  PRIMARY KEY ("user_id")
);

--
-- Table: user_role
--
DROP TABLE "user_role" CASCADE;
CREATE TABLE "user_role" (
  "user_user_id" integer NOT NULL,
  "role_role_id" integer NOT NULL,
  PRIMARY KEY ("user_user_id", "role_role_id")
);
CREATE INDEX "user_role_idx_role_role_id" on "user_role" ("role_role_id");
CREATE INDEX "user_role_idx_user_user_id" on "user_role" ("user_user_id");

--
-- Foreign Key Definitions
--

ALTER TABLE "antena" ADD FOREIGN KEY ("leitor_id")
  REFERENCES "leitor" ("leitor_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "evento_sala" ADD FOREIGN KEY ("evento_id")
  REFERENCES "evento" ("evento_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "evento_sala" ADD FOREIGN KEY ("sala_id")
  REFERENCES "sala" ("sala_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "leitura" ADD FOREIGN KEY ("antena_id")
  REFERENCES "antena" ("antena_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "leitura" ADD FOREIGN KEY ("participante_id")
  REFERENCES "participante" ("participante_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "sala_antena" ADD FOREIGN KEY ("antena_id")
  REFERENCES "antena" ("antena_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "sala_antena" ADD FOREIGN KEY ("sala_id")
  REFERENCES "sala" ("sala_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "user_role" ADD FOREIGN KEY ("role_role_id")
  REFERENCES "role" ("role_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "user_role" ADD FOREIGN KEY ("user_user_id")
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

