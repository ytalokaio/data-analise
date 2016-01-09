SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `defender`.`player_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`player_type` ;

CREATE TABLE IF NOT EXISTS `defender`.`player_type` (
  `id_player_type` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `player_type_name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id_player_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`player` ;

CREATE TABLE IF NOT EXISTS `defender`.`player` (
  `id_player` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `player_name` VARCHAR(45) NOT NULL COMMENT '',
  `player_picture` VARCHAR(45) NULL COMMENT '',
  `player_exp` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '',
  `id_player_type` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id_player`)  COMMENT ''
  CONSTRAINT `fk_player_player_type1`
    FOREIGN KEY (`id_player_type`)
    REFERENCES `defender`.`player_type` (`id_player_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`client` ;

CREATE TABLE IF NOT EXISTS `defender`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `client_name` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`id_client`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`client_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`client_unit` ;

CREATE TABLE IF NOT EXISTS `defender`.`client_unit` (
  `id_client_unit` INT NOT NULL COMMENT '',
  `client_uni_name` VARCHAR(45) NULL COMMENT '',
  `id_client` INT NOT NULL COMMENT '',
  PRIMARY KEY (`id_client_unit`)  COMMENT '',
  INDEX `fk_client_unit_client1_idx` (`id_client` ASC)  COMMENT '',
  CONSTRAINT `fk_client_unit_client1`
    FOREIGN KEY (`id_client`)
    REFERENCES `defender`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`team` ;

CREATE TABLE IF NOT EXISTS `defender`.`team` (
  `id_team` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `team_name` VARCHAR(45) NOT NULL COMMENT '',
  `team_picture` VARCHAR(45) NULL COMMENT '',
  `id_client_unit` INT NOT NULL COMMENT '',
  PRIMARY KEY (`id_team`)  COMMENT '',
  INDEX `fk_team_client_unit1_idx` (`id_client_unit` ASC)  COMMENT '',
  CONSTRAINT `fk_team_client_unit1`
    FOREIGN KEY (`id_client_unit`)
    REFERENCES `defender`.`client_unit` (`id_client_unit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`weapon_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`weapon_type` ;

CREATE TABLE IF NOT EXISTS `defender`.`weapon_type` (
  `id_weapon_type` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `weapon_type_desc` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id_weapon_type`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`weapon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`weapon` ;

CREATE TABLE IF NOT EXISTS `defender`.`weapon` (
  `id_weapon` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `weapon_name` VARCHAR(45) NOT NULL COMMENT '',
  `weapon_desc` VARCHAR(45) NOT NULL COMMENT '',
  `weapon_picture` VARCHAR(45) NULL COMMENT '',
  `id_weapon_type` INT NOT NULL COMMENT '',
  PRIMARY KEY (`id_weapon`)  COMMENT '',
  INDEX `fk_weapon_weapon_type1_idx` (`id_weapon_type` ASC)  COMMENT '',
  CONSTRAINT `fk_weapon_weapon_type1`
    FOREIGN KEY (`id_weapon_type`)
    REFERENCES `defender`.`weapon_type` (`id_weapon_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`weapon_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`weapon_player` ;

CREATE TABLE IF NOT EXISTS `defender`.`weapon_player` (
  `id_player` INT UNSIGNED NOT NULL COMMENT '',
  `id_weapon` INT UNSIGNED NOT NULL COMMENT '',
  `date_buy` DATETIME NOT NULL COMMENT '',
  `active_inactive` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  INDEX `fk_weapon_player_player1_idx` (`id_player` ASC)  COMMENT '',
  INDEX `fk_weapon_player_weapon1_idx` (`id_weapon` ASC)  COMMENT '',
  PRIMARY KEY (`id_player`, `id_weapon`)  COMMENT '',
  CONSTRAINT `fk_weapon_player_player1`
    FOREIGN KEY (`id_player`)
    REFERENCES `defender`.`player` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weapon_player_weapon1`
    FOREIGN KEY (`id_weapon`)
    REFERENCES `defender`.`weapon` (`id_weapon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`exercise_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`exercise_type` ;

CREATE TABLE IF NOT EXISTS `defender`.`exercise_type` (
  `id_exercise_type` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `exercise_type_name` VARCHAR(45) NOT NULL COMMENT '',
  `exercise_type_desc` VARCHAR(200) NOT NULL COMMENT '',
  `exercise_type_duration` SMALLINT(3) NOT NULL COMMENT '',
  PRIMARY KEY (`id_exercise_type`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`exercise_place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`exercise_place` ;

CREATE TABLE IF NOT EXISTS `defender`.`exercise_place` (
  `id_exercise_place` INT NOT NULL COMMENT '',
  `exercise_place_name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id_exercise_place`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`exercise` ;

CREATE TABLE IF NOT EXISTS `defender`.`exercise` (
  `id_exercise` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `id_exercise_type` INT NOT NULL COMMENT '',
  `id_exercise_place` INT NOT NULL COMMENT '',
  `exercise_datebegin` DATETIME NOT NULL COMMENT '',
  `exercise_dateend` DATETIME NULL COMMENT '',
  PRIMARY KEY (`id_exercise`)  COMMENT '',
  INDEX `fk_exercise_exercise_type1_idx` (`id_exercise_type` ASC)  COMMENT '',
  INDEX `fk_exercise_exercise_place1_idx` (`id_exercise_place` ASC)  COMMENT '',
  CONSTRAINT `fk_exercise_exercise_type1`
    FOREIGN KEY (`id_exercise_type`)
    REFERENCES `defender`.`exercise_type` (`id_exercise_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exercise_exercise_place1`
    FOREIGN KEY (`id_exercise_place`)
    REFERENCES `defender`.`exercise_place` (`id_exercise_place`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`hit_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`hit_member` ;

CREATE TABLE IF NOT EXISTS `defender`.`hit_member` (
  `id_hit_member` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `hit_member_desc` VARCHAR(45) NOT NULL COMMENT '',
  `hit_member_score` INT(4) NOT NULL COMMENT '',
  PRIMARY KEY (`id_hit_member`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`shot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`shot` ;

CREATE TABLE IF NOT EXISTS `defender`.`shot` (
  `id_player` INT UNSIGNED NOT NULL COMMENT '',
  `id_weapon` INT UNSIGNED NOT NULL COMMENT '',
  `id_exercise` INT UNSIGNED NOT NULL COMMENT '',
  `shot_date` DATETIME NOT NULL COMMENT '',
  `nothit_hit` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  `kill_player` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  `id_player_target` INT UNSIGNED NULL COMMENT '',
  `id_hit_member` INT UNSIGNED NULL COMMENT '',
  INDEX `fk_shoot_player1_idx` (`id_player` ASC)  COMMENT '',
  INDEX `fk_shoot_weapon1_idx` (`id_weapon` ASC)  COMMENT '',
  INDEX `fk_shot_player1_idx` (`id_player_target` ASC)  COMMENT '',
  INDEX `fk_shot_exercise1_idx` (`id_exercise` ASC)  COMMENT '',
  INDEX `fk_shot_hit_member1_idx` (`id_hit_member` ASC)  COMMENT '',
  PRIMARY KEY (`id_player`, `id_weapon`, `id_exercise`, `shot_date`)  COMMENT '',
  CONSTRAINT `fk_shoot_player1`
    FOREIGN KEY (`id_player`)
    REFERENCES `defender`.`player` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shoot_weapon1`
    FOREIGN KEY (`id_weapon`)
    REFERENCES `defender`.`weapon` (`id_weapon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shot_player1`
    FOREIGN KEY (`id_player_target`)
    REFERENCES `defender`.`player` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shot_exercise1`
    FOREIGN KEY (`id_exercise`)
    REFERENCES `defender`.`exercise` (`id_exercise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shot_hit_member1`
    FOREIGN KEY (`id_hit_member`)
    REFERENCES `defender`.`hit_member` (`id_hit_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`player_exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`player_exercise` ;

CREATE TABLE IF NOT EXISTS `defender`.`player_exercise` (
  `id_exercise` INT UNSIGNED NOT NULL COMMENT '',
  `id_player` INT UNSIGNED NOT NULL COMMENT '',
  `alive_dead` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  `total_shots` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `total_hits` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `total_eliminations` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  INDEX `fk_player_exercise_exercise1_idx` (`id_exercise` ASC)  COMMENT '',
  INDEX `fk_player_exercise_player1_idx` (`id_player` ASC)  COMMENT '',
  PRIMARY KEY (`id_exercise`, `id_player`)  COMMENT '',
  CONSTRAINT `fk_player_exercise_exercise1`
    FOREIGN KEY (`id_exercise`)
    REFERENCES `defender`.`exercise` (`id_exercise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_exercise_player1`
    FOREIGN KEY (`id_player`)
    REFERENCES `defender`.`player` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`team_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`team_player` ;

CREATE TABLE IF NOT EXISTS `defender`.`team_player` (
  `team_id_team` INT UNSIGNED NOT NULL COMMENT '',
  `player_id_player` INT UNSIGNED NOT NULL COMMENT '',
  `date_atributte` DATETIME NOT NULL COMMENT '',
  INDEX `fk_team_player_team1_idx` (`team_id_team` ASC)  COMMENT '',
  INDEX `fk_team_player_player1_idx` (`player_id_player` ASC)  COMMENT '',
  PRIMARY KEY (`team_id_team`, `player_id_player`)  COMMENT '',
  CONSTRAINT `fk_team_player_team1`
    FOREIGN KEY (`team_id_team`)
    REFERENCES `defender`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_player_player1`
    FOREIGN KEY (`player_id_player`)
    REFERENCES `defender`.`player` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defender`.`team_exercise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defender`.`team_exercise` ;

CREATE TABLE IF NOT EXISTS `defender`.`team_exercise` (
  `exercise_id_exercise` INT UNSIGNED NOT NULL COMMENT '',
  `team_id_team` INT UNSIGNED NOT NULL COMMENT '',
  `failure_sucess` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  INDEX `fk_team_exercise_exercise1_idx` (`exercise_id_exercise` ASC)  COMMENT '',
  INDEX `fk_team_exercise_team1_idx` (`team_id_team` ASC)  COMMENT '',
  PRIMARY KEY (`exercise_id_exercise`, `team_id_team`)  COMMENT '',
  CONSTRAINT `fk_team_exercise_exercise1`
    FOREIGN KEY (`exercise_id_exercise`)
    REFERENCES `defender`.`exercise` (`id_exercise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_exercise_team1`
    FOREIGN KEY (`team_id_team`)
    REFERENCES `defender`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `defender` ;

-- -----------------------------------------------------
-- procedure add_shot
-- -----------------------------------------------------

USE `defender`;
DROP procedure IF EXISTS `defender`.`add_shot`;

DELIMITER $$
USE `defender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shot`(exercise int(11),player int(11),weapon int(11),datahora datetime,target int(11),member int(11))
begin

declare nshots int(11) default 0;
declare tshots int(11) default 0;
declare thits int(11) default 0;
declare telimi int(11) default 0;
declare nhit_hit boolean default 0;
declare killplayer boolean default 0;

set nshots = (select count(*) from shot where id_exercise = exercise and id_player_target = target and nothit_hit = 1);

select total_shots, total_hits, total_eliminations into tshots, thits, telimi from player_exercise where id_exercise = exercise and id_player = player;

if target = 0 then
set target = null, nhit_hit = 0, killplayer = 0, member = null;
else
set nhit_hit = 1, nshots = nshots+1, thits = thits+1;
end if;

if nshots = 3 then update player_exercise set alive_dead = 1 where id_exercise = exercise and id_player = target;
set telimi = telimi + 1;
set killplayer = 1;
else set telimi = telimi;
end if;

update player_exercise set total_shots = (tshots+1), total_hits = thits, total_eliminations = telimi  where id_exercise = exercise and id_player = player;
insert into shot values (player,weapon,exercise,datahora,nhit_hit,killplayer,target,member);
end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
