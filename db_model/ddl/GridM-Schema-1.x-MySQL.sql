-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Thu Nov  4 14:34:31 2010
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `antena`;

--
-- Table: `antena`
--
CREATE TABLE `antena` (
  `antena_id` integer NOT NULL auto_increment,
  `serie` integer NOT NULL,
  `leitor_id` integer NOT NULL,
  `porta` smallint,
  INDEX `antena_idx_leitor_id` (`leitor_id`),
  PRIMARY KEY (`antena_id`),
  CONSTRAINT `antena_fk_leitor_id` FOREIGN KEY (`leitor_id`) REFERENCES `leitor` (`leitor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `evento`;

--
-- Table: `evento`
--
CREATE TABLE `evento` (
  `evento_id` smallint NOT NULL auto_increment,
  `descricao` varchar(250) NOT NULL,
  `dia` smallint,
  `palestrante` varchar(200),
  `sala_id` integer,
  `tema` varchar(100),
  `inicio` time,
  `fim` time,
  PRIMARY KEY (`evento_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `evento_sala`;

--
-- Table: `evento_sala`
--
CREATE TABLE `evento_sala` (
  `evento_id` smallint NOT NULL,
  `sala_id` integer NOT NULL,
  INDEX `evento_sala_idx_evento_id` (`evento_id`),
  INDEX `evento_sala_idx_sala_id` (`sala_id`),
  PRIMARY KEY (`evento_id`, `sala_id`),
  CONSTRAINT `evento_sala_fk_evento_id` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `evento_sala_fk_sala_id` FOREIGN KEY (`sala_id`) REFERENCES `sala` (`sala_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `leitor`;

--
-- Table: `leitor`
--
CREATE TABLE `leitor` (
  `leitor_id` integer NOT NULL auto_increment,
  `serie` integer NOT NULL,
  `ip` varchar(15),
  PRIMARY KEY (`leitor_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `leitura`;

--
-- Table: `leitura`
--
CREATE TABLE `leitura` (
  `dia` smallint NOT NULL,
  `registro` time NOT NULL,
  `leitura_id` bigint NOT NULL auto_increment,
  `tag` varchar(70) NOT NULL,
  `participante_id` integer NOT NULL,
  `antena_id` integer NOT NULL,
  `qtd` integer NOT NULL,
  INDEX `leitura_idx_antena_id` (`antena_id`),
  INDEX `leitura_idx_participante_id` (`participante_id`),
  PRIMARY KEY (`leitura_id`, `participante_id`, `antena_id`),
  CONSTRAINT `leitura_fk_antena_id` FOREIGN KEY (`antena_id`) REFERENCES `antena` (`antena_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leitura_fk_participante_id` FOREIGN KEY (`participante_id`) REFERENCES `participante` (`participante_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `participante`;

--
-- Table: `participante`
--
CREATE TABLE `participante` (
  `participante_id` integer NOT NULL,
  `nome` varchar(200),
  `tipo` varchar(100),
  `tipoinsc` varchar(5),
  `profissao` varchar(50),
  PRIMARY KEY (`participante_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `role`;

--
-- Table: `role`
--
CREATE TABLE `role` (
  `role_id` integer NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `sala`;

--
-- Table: `sala`
--
CREATE TABLE `sala` (
  `sala_id` integer NOT NULL auto_increment,
  `descricao` varchar(50) NOT NULL,
  `image` varchar(40),
  PRIMARY KEY (`sala_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `sala_antena`;

--
-- Table: `sala_antena`
--
CREATE TABLE `sala_antena` (
  `sala_id` integer NOT NULL,
  `antena_id` integer NOT NULL,
  `inicio` time NOT NULL,
  `fim` time,
  `dia` smallint NOT NULL,
  INDEX `sala_antena_idx_antena_id` (`antena_id`),
  INDEX `sala_antena_idx_sala_id` (`sala_id`),
  PRIMARY KEY (`sala_id`, `antena_id`, `inicio`, `dia`),
  CONSTRAINT `sala_antena_fk_antena_id` FOREIGN KEY (`antena_id`) REFERENCES `antena` (`antena_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sala_antena_fk_sala_id` FOREIGN KEY (`sala_id`) REFERENCES `sala` (`sala_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `user`;

--
-- Table: `user`
--
CREATE TABLE `user` (
  `user_id` integer NOT NULL auto_increment,
  `user_name` varchar(100) NOT NULL,
  `user_login` varchar(45) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `user_role`;

--
-- Table: `user_role`
--
CREATE TABLE `user_role` (
  `user_user_id` integer NOT NULL,
  `role_role_id` integer NOT NULL,
  INDEX `user_role_idx_role_role_id` (`role_role_id`),
  INDEX `user_role_idx_user_user_id` (`user_user_id`),
  PRIMARY KEY (`user_user_id`, `role_role_id`),
  CONSTRAINT `user_role_fk_role_role_id` FOREIGN KEY (`role_role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_fk_user_user_id` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks=1;

