SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema demkovych_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema demkovych_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `demkovych_db` DEFAULT CHARACTER SET utf8 ;
USE `demkovych_db` ;

-- -----------------------------------------------------
-- Table `demkovych_db`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`country` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`country` (
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`library` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`library` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount_of_liked_songs` INT NULL,
  `amount_of_downloaded_songs` INT NULL,
  `amount_of_liked_albums` INT NULL,
  `amount_of_donwloaded_albums` INT NULL,
  `amount_of_susbscribed_artists` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`gender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`gender` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`gender` (
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`user` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `age` INT NOT NULL,
  `birthday` DATETIME NULL,
  `mobile_number` VARCHAR(20) NULL,
  `country_name` VARCHAR(40) NOT NULL,
  `library_id` INT NOT NULL,
  `gender_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_country1_idx` (`country_name` ASC) VISIBLE,
  INDEX `fk_user_gender1_idx` (`gender_type` ASC) VISIBLE,
  INDEX `fk_user_library1_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_country1`
    FOREIGN KEY (`country_name`)
    REFERENCES `demkovych_db`.`country` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `demkovych_db`.`library` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_gender1`
    FOREIGN KEY (`gender_type`)
    REFERENCES `demkovych_db`.`gender` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`security`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`security` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`security` (
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_security_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `demkovych_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`singer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`singer` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`singer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `gender_type` VARCHAR(20) NOT NULL,
  `country_name` VARCHAR(40) NOT NULL,
  `amount_of_albums` INT NULL,
  `mounthly_listeners` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_singer_country1_idx` (`country_name` ASC) VISIBLE,
  INDEX `fk_singer_gender1_idx` (`gender_type` ASC) VISIBLE,
  CONSTRAINT `fk_singer_country1`
    FOREIGN KEY (`country_name`)
    REFERENCES `demkovych_db`.`country` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_singer_gender1`
    FOREIGN KEY (`gender_type`)
    REFERENCES `demkovych_db`.`gender` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`album` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `release_year` INT NOT NULL,
  `amount_of_song` INT NOT NULL,
  `total_time_of_listeting` TIME NULL,
  `singer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_singer1_idx` (`singer_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_singer1`
    FOREIGN KEY (`singer_id`)
    REFERENCES `demkovych_db`.`singer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `demkovych_db`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`song` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `time` TIME NULL,
  `likes` VARCHAR(45) NULL,
  `downloaded` VARCHAR(45) NULL,
  `streaming` VARCHAR(45) NULL,
  `feat_singer_id` INT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_song_singer1_idx` (`feat_singer_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `demkovych_db`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_singer1`
    FOREIGN KEY (`feat_singer_id`)
    REFERENCES `demkovych_db`.`singer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`playlist` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`playlist` (
  `id` INT NOT NULL,
  `appointment` VARCHAR(45) NOT NULL,
  `some_text` VARCHAR(45) NOT NULL,
  `amount_of_songs` INT NULL,
  `total_time_of_listening` TIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`playlist_has_song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`playlist_has_song` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`playlist_has_song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  INDEX `fk_playlist_has_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_song_song1_idx` (`song_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `song_id_UNIQUE` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `demkovych_db`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `demkovych_db`.`song` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demkovych_db`.`library_has_playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `demkovych_db`.`library_has_playlist` ;

CREATE TABLE IF NOT EXISTS `demkovych_db`.`library_has_playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `library_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  INDEX `fk_library_has_playlist_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_library_has_playlist_library1_idx` (`library_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_library_has_playlist_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `demkovych_db`.`library` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_library_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `demkovych_db`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `demkovych_db` ;

INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Ukraine');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Poland');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Germany');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('United States');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('France');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Italy');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('China');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Japan');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Spain');
INSERT INTO `demkovych_db`.`country` (`name`) VALUES ('Russia');

INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('10', '10', '10', '10', '10');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('20', '20', '20', '20', '20');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('30', '30', '30', '30', '30');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('40', '40', '40', '40', '40');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('50', '50', '50', '50', '50');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('60', '60', '60', '60', '60');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('70', '70', '70', '70', '70');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('80', '80', '80', '80', '80');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('90', '90', '90', '90', '90');
INSERT INTO `demkovych_db`.`library` (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES ('100', '100', '100', '100', '100');

INSERT INTO `demkovych_db`.`gender` (`type`) VALUES ('male');
INSERT INTO `demkovych_db`.`gender` (`type`) VALUES ('female');
INSERT INTO `demkovych_db`.`gender` (`type`) VALUES ('group');

INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `email`, `age`, `birthday`, `mobile_number`, `country_name`, `library_id`, `gender_type`) VALUES ('Maks', 'Demkovych', 'maksdemkovych2003@gmail.com', '18', '2003-08-12', '0988172977', 'Ukraine', '1', 'male');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Vlad', 'Demkovych', '22', 'Poland', '2', 'male');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Maria', 'Demkovych', '23', 'Ukraine', '3', 'female');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Sviat', 'Ivanovych', '22', 'France', '4', 'male');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Victoria', 'Zinko', '21', 'Ukraine', '5', 'female');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Kolya', 'Chepynets', '22', 'Ukraine', '6', 'male');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Victoria', 'Aleksevych', '18', 'United States', '7', 'female');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Solomia', 'Aleksevych', '16', 'Ukraine', '8', 'female');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Igor', 'Igorovych', '16', 'Italy', '9', 'male');
INSERT INTO `demkovych_db`.`user` (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES ('Solomia', 'Liber', '18', 'Spain', '10', 'male');

INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('maks', 'demkovych', '1');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('vlad', 'demkovych', '2');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('maria', 'demkovych', '3');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('sviat', 'ivanovych', '4');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('victoria', 'zinko', '5');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('kolya', 'chepynets', '6');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('victoria', 'aleksevych', '7');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('solomia', 'aleksevych', '8');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('igor', 'igorovych', '9');
INSERT INTO `demkovych_db`.`security` (`login`, `password`, `user_id`) VALUES ('solomia', 'liber', '10');

INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `age`, `gender_type`, `country_name`, `amount_of_albums`, `mounthly_listeners`) VALUES ('Ariana', 'Grande', '28', 'female', 'United States', '8', '70 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Tina', 'Karol', 'female', 'Ukraine', '10 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Justin', 'Bieber', 'male', 'United States', '20 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Dima', 'Monatic', 'male', 'Ukraine', '30 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Alisher', 'Morgenshtern', 'male', 'Russia', '40 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('The', 'Maneskin', 'group', 'Italia', '50 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Billie', 'Eilish', 'female', 'United States', '60 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Twenty', 'One Pillots', 'group', 'United States', '80 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('J.', 'Balvin', 'male', 'Spain', '90 000 000');
INSERT INTO `demkovych_db`.`singer` (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES ('Demkovych', 'Maks', 'male', 'Ukraine', '100 000 000');

INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `total_time_of_listeting`, `singer_id`) VALUES ('Dangerous Woman', '2018', '8', '01:22:32', '1');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Live', '2017', '12', '2');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Yummy', '2016', '10', '3');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Sova', '2020', '8', '4');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Dust', '2021', '11', '5');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('I wanna be your slave', '2019', '7', '6');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Your Pover', '2020', '9', '7');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('20 Pillots', '2019', '8', '8');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('Dance', '2021', '10', '9');
INSERT INTO `demkovych_db`.`album` (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES ('THE BEST', '2016', '12', '10');

INSERT INTO `demkovych_db`.`song` (`name`, `time`, `likes`, `downloaded`, `streaming`, `feat_singer_id`, `album_id`) VALUES ('God is a woman', '00:02:45', '4 456 768', '600 000', '665 125 676', '2', '1');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Live is good', '2');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Someone like you', '3');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Ok', '4');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Afternoon', '5');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Gussy', '6');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Hello, worls', '7');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Bloody party', '8');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Caroline', '9');
INSERT INTO `demkovych_db`.`song` (`name`, `album_id`) VALUES ('Poland', '10');

INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`, `amount_of_songs`, `total_time_of_listening`) VALUES ('1', 'Dancing', 'dancing', '60', '02:20:45');
INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`, `amount_of_songs`, `total_time_of_listening`) VALUES ('2', 'Relax', 'relax', '43', '01:14:28');
INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`, `amount_of_songs`, `total_time_of_listening`) VALUES ('3', 'Meditation', 'meditation', '20', '0:56:43');
INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`) VALUES ('4', 'Sad', 'for sad moments');
INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`) VALUES ('5', 'Techno', 'techno');
INSERT INTO `demkovych_db`.`playlist` (`id`, `appointment`, `some_text`) VALUES ('6', 'Electrical', 'electrical');

INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('1', '1');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('2', '2');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('3', '3');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('4', '4');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('5', '5');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('6', '6');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('7', '7');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('8', '8');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('9', '9');
INSERT INTO `demkovych_db`.`playlist_has_song` (`playlist_id`, `song_id`) VALUES ('10', '10');

INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('1', '1');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('2', '3');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('1', '6');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('2', '5');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('3', '2');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('4', '4');
INSERT INTO `demkovych_db`.`library_has_playlist` (`library_id`, `playlist_id`) VALUES ('5', '1');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
