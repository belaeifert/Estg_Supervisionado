-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema contrate_agora
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `contrate_agora` ;

-- -----------------------------------------------------
-- Schema contrate_agora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `contrate_agora` DEFAULT CHARACTER SET utf8 ;
USE `contrate_agora` ;

-- -----------------------------------------------------
-- Table `contrate_agora`.`tb_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tb_usuario` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tb_usuario` (
  `idt_usuario` INT NOT NULL,
  `nme_usuario` VARCHAR(255) NOT NULL,
  `email_usuario` VARCHAR(45) NOT NULL,
  `senha_usuario` VARCHAR(45) NOT NULL,
  `tel_usuario` INT NOT NULL,
  `cep_usuario` INT NOT NULL,
  `endereco_usuario` VARCHAR(255) NOT NULL,
  `complemento_endereco_usuario` VARCHAR(255) NOT NULL,
  `num_endereco_usuario` VARCHAR(45) NOT NULL,
  `tipo_usuario` ENUM('PS', 'CT') NOT NULL,
  PRIMARY KEY (`idt_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_tipo_prestador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_tipo_prestador` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_tipo_prestador` (
  `idt_tipo_prestador` INT NOT NULL AUTO_INCREMENT,
  `tipo_prestador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idt_tipo_prestador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tb_prestador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tb_prestador` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tb_prestador` (
  `idt_prestador` INT NOT NULL AUTO_INCREMENT,
  `endereco_empresa` VARCHAR(255) NOT NULL,
  `tel_comercial_prestador` INT NOT NULL,
  `tipo_prestador` ENUM('PF', 'PJ') NOT NULL,
  `cpf_prestador` INT NULL,
  `cnpj_prestador` INT NULL,
  `nme_fantasia_prestador` VARCHAR(255) NULL,
  `cod_usuario` INT NOT NULL,
  `cod_tipo_prestador` INT NOT NULL,
  PRIMARY KEY (`idt_prestador`),
  INDEX `fk_prestador_mei_tipo_prestador1_idx` (`cod_tipo_prestador` ASC),
  INDEX `fk_prestador_usuarios1_idx` (`cod_usuario` ASC),
  CONSTRAINT `fk_prestador_mei_tipo_prestador1`
    FOREIGN KEY (`cod_tipo_prestador`)
    REFERENCES `contrate_agora`.`tt_tipo_prestador` (`idt_tipo_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestador_usuarios1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `contrate_agora`.`tb_usuario` (`idt_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_categoria_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_categoria_servico` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_categoria_servico` (
  `idt_categoria_servico` INT NOT NULL AUTO_INCREMENT,
  `categoria_servico` ENUM('casa', 'construção', 'beleza') NOT NULL,
  PRIMARY KEY (`idt_categoria_servico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_tipo_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_tipo_servico` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_tipo_servico` (
  `idt_tipo_servico` INT NOT NULL AUTO_INCREMENT,
  `nme_tipo_servico` VARCHAR(255) NOT NULL,
  `cod_categoria_servico` INT NOT NULL,
  PRIMARY KEY (`idt_tipo_servico`),
  INDEX `fk_tipo_servico_categoria_servico1_idx` (`cod_categoria_servico` ASC),
  CONSTRAINT `fk_tipo_servico_categoria_servico1`
    FOREIGN KEY (`cod_categoria_servico`)
    REFERENCES `contrate_agora`.`tt_categoria_servico` (`idt_categoria_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tb_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tb_servico` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tb_servico` (
  `idt_serviço` INT NOT NULL AUTO_INCREMENT,
  `nme_servico` VARCHAR(255) NOT NULL,
  `preco_servico` DECIMAL(3,2) NOT NULL,
  `descricao_servico` VARCHAR(255) NOT NULL,
  `foto` VARCHAR(45) NOT NULL,
  `cod_prestador` INT NOT NULL,
  `cod_tipo_servico` INT NOT NULL,
  PRIMARY KEY (`idt_serviço`),
  INDEX `fk_servico_prestador_mei1_idx` (`cod_prestador` ASC),
  INDEX `fk_servico_tipo_servico1_idx` (`cod_tipo_servico` ASC),
  CONSTRAINT `fk_servico_prestador_mei1`
    FOREIGN KEY (`cod_prestador`)
    REFERENCES `contrate_agora`.`tb_prestador` (`idt_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_tipo_servico1`
    FOREIGN KEY (`cod_tipo_servico`)
    REFERENCES `contrate_agora`.`tt_tipo_servico` (`idt_tipo_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`ta_servico_prestado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`ta_servico_prestado` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`ta_servico_prestado` (
  `idt_servico_prestado` INT NOT NULL AUTO_INCREMENT,
  `cod_serviço` INT NOT NULL,
  `cod_usuario` INT NOT NULL,
  `hora_servico_prestado` VARCHAR(9) NOT NULL,
  `favorito_servico_prestado` TINYINT(0) NULL DEFAULT 0,
  `cep_servico_prestado` INT NULL,
  `endereco_servico_prestado` VARCHAR(255) NULL,
  `complemento_servico_prestado` VARCHAR(50) NULL,
  `numero` VARCHAR(45) NULL,
  `msg_recomendacao` VARCHAR(255) NULL,
  `dt_hr_recomendacao` VARCHAR(19) NULL,
  `nota_recomendacao` DOUBLE NULL,
  INDEX `fk_servico_has_usuarios_usuarios1_idx` (`cod_usuario` ASC),
  INDEX `fk_servico_has_usuarios_servico1_idx` (`cod_serviço` ASC),
  PRIMARY KEY (`idt_servico_prestado`),
  CONSTRAINT `fk_servico_has_usuarios_servico1`
    FOREIGN KEY (`cod_serviço`)
    REFERENCES `contrate_agora`.`tb_servico` (`idt_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_has_usuarios_usuarios1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `contrate_agora`.`tb_usuario` (`idt_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`ta_mensagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`ta_mensagem` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`ta_mensagem` (
  `idt_mensagem` INT NOT NULL AUTO_INCREMENT,
  `mensagens` VARCHAR(45) NOT NULL,
  `data_hora_mensagem` VARCHAR(19) NOT NULL,
  `cod_prestador` INT NOT NULL,
  `cod_usuario` INT NOT NULL,
  PRIMARY KEY (`idt_mensagem`),
  INDEX `fk_chat_prestador_mei1_idx` (`cod_prestador` ASC),
  INDEX `fk_chat_usuarios1_idx` (`cod_usuario` ASC),
  CONSTRAINT `fk_chat_prestador_mei1`
    FOREIGN KEY (`cod_prestador`)
    REFERENCES `contrate_agora`.`tb_prestador` (`idt_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_usuarios1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `contrate_agora`.`tb_usuario` (`idt_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_tipo_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_tipo_pagamento` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_tipo_pagamento` (
  `idt_tipo_pagamento` INT NOT NULL AUTO_INCREMENT,
  `tipo_pagamento` VARCHAR(45) NOT NULL,
  `cod_prestador` INT NOT NULL,
  PRIMARY KEY (`idt_tipo_pagamento`),
  INDEX `fk_tipo_pagamento_prestador1_idx` (`cod_prestador` ASC),
  CONSTRAINT `fk_tipo_pagamento_prestador1`
    FOREIGN KEY (`cod_prestador`)
    REFERENCES `contrate_agora`.`tb_prestador` (`idt_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_assinatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_assinatura` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_assinatura` (
  `idt_assinatura` INT NOT NULL AUTO_INCREMENT,
  `dt_ass_assinatura` DATE NOT NULL,
  `prazo_assinatura` DATE NOT NULL,
  `cod_tipo_pagamento` INT NOT NULL,
  PRIMARY KEY (`idt_assinatura`),
  INDEX `fk_assinatura_tipo_pagamento1_idx` (`cod_tipo_pagamento` ASC),
  CONSTRAINT `fk_assinatura_tipo_pagamento1`
    FOREIGN KEY (`cod_tipo_pagamento`)
    REFERENCES `contrate_agora`.`tt_tipo_pagamento` (`idt_tipo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_pagamento` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_pagamento` (
  `idt_pagamento` INT NOT NULL AUTO_INCREMENT,
  `periodo_pagamento` ENUM('1', '3', '6', '12') NOT NULL,
  `vlr_pagamento` DECIMAL(3,2) NOT NULL,
  `cod_assinatura` INT NOT NULL,
  PRIMARY KEY (`idt_pagamento`),
  INDEX `fk_pagamento_assinatura1_idx` (`cod_assinatura` ASC),
  CONSTRAINT `fk_pagamento_assinatura1`
    FOREIGN KEY (`cod_assinatura`)
    REFERENCES `contrate_agora`.`tt_assinatura` (`idt_assinatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrate_agora`.`tt_agenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrate_agora`.`tt_agenda` ;

CREATE TABLE IF NOT EXISTS `contrate_agora`.`tt_agenda` (
  `idt_agenda` INT NOT NULL AUTO_INCREMENT,
  `disponibilidade_agenda` ENUM('seg', 'ter', 'qua', 'qui', 'sex', 'sab', 'dom') NOT NULL,
  `hora_agenda` TIME NOT NULL,
  `cod_serviço` INT NOT NULL,
  PRIMARY KEY (`idt_agenda`),
  INDEX `fk_agenda_servico1_idx` (`cod_serviço` ASC),
  CONSTRAINT `fk_agenda_servico1`
    FOREIGN KEY (`cod_serviço`)
    REFERENCES `contrate_agora`.`tb_servico` (`idt_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
