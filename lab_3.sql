DROP SCHEMA demkovych_db;
CREATE SCHEMA demkovych_db DEFAULT CHARACTER SET utf8;

USE demkovych_db;

CREATE TABLE country (
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`name`));

CREATE TABLE library (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount_of_liked_songs` INT NULL,
  `amount_of_downloaded_songs` INT NULL,
  `amount_of_liked_albums` INT NULL,
  `amount_of_donwloaded_albums` INT NULL,
  `amount_of_susbscribed_artists` INT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE gender (
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`type`));

CREATE TABLE user (
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
    ON UPDATE NO ACTION);

CREATE TABLE security (
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_security_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `demkovych_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE singer (
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
    ON UPDATE NO ACTION);
    
CREATE TABLE album (
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
    ON UPDATE NO ACTION);

CREATE TABLE song (
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
    ON UPDATE NO ACTION);

CREATE TABLE playlist (
  `id` INT NOT NULL,
  `appointment` VARCHAR(45) NOT NULL,
  `some_text` VARCHAR(45) NOT NULL,
  `amount_of_songs` INT NULL,
  `total_time_of_listening` TIME NULL,
  PRIMARY KEY (`id`));

CREATE TABLE playlist_has_song (
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE library_has_playlist (
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
    ON UPDATE NO ACTION);

USE demkovych_db;

INSERT INTO country (`name`) VALUES ('Ukraine'), ('Poland'), ('Germany'), ('United States'),
('France'), ('Italy'), ('China'), ('Japan'), ('Spain'), ('Russia');

INSERT INTO library (`amount_of_liked_songs`, `amount_of_downloaded_songs`, `amount_of_liked_albums`, `amount_of_donwloaded_albums`, `amount_of_susbscribed_artists`) VALUES 
('10', '10', '10', '10', '10'), 
('20', '20', '20', '20', '20'), 
('30', '30', '30', '30', '30'), 
('40', '40', '40', '40', '40'),
('50', '50', '50', '50', '50'),
('60', '60', '60', '60', '60'),
('70', '70', '70', '70', '70'),
('80', '80', '80', '80', '80'),
('90', '90', '90', '90', '90'),
('100', '100', '100', '100', '100');


INSERT INTO gender (`type`) VALUES ('male'),('female'), ('group');

INSERT INTO user (`name`, `last_name`, `email`, `age`, `birthday`, `mobile_number`, `country_name`, `library_id`, `gender_type`) VALUES 
('Maks', 'Demkovych', 'maksdemkovych2003@gmail.com', '18', '2003-08-12', '0988172977', 'Ukraine', '1', 'male');
INSERT INTO user (`name`, `last_name`, `age`, `country_name`, `library_id`, `gender_type`) VALUES 
('Vlad', 'Demkovych', '22', 'Poland', '2', 'male'),
('Maria', 'Demkovych', '23', 'Ukraine', '3', 'female'),
('Sviat', 'Ivanovych', '22', 'France', '4', 'male'),
('Victoria', 'Zinko', '21', 'Ukraine', '5', 'female'),
('Kolya', 'Chepynets', '22', 'Ukraine', '6', 'male'),
('Victoria', 'Aleksevych', '18', 'United States', '7', 'female'),
('Solomia', 'Aleksevych', '16', 'Ukraine', '8', 'female'),
('Igor', 'Igorovych', '16', 'Italy', '9', 'male'),
('Solomia', 'Liber', '18', 'Spain', '10', 'male');

INSERT INTO security (`login`, `password`, `user_id`) VALUES 
('maks', 'demkovych', '1'),
('vlad', 'demkovych', '2'),
('maria', 'demkovych', '3'),
('sviat', 'ivanovych', '4'),
('victoria', 'zinko', '5'),
('kolya', 'chepynets', '6'),
('victoria', 'aleksevych', '7'),
('solomia', 'aleksevych', '8'),
('igor', 'igorovych', '9'),
('solomia', 'liber', '10');

INSERT INTO singer (`name`, `last_name`, `age`, `gender_type`, `country_name`, `amount_of_albums`, `mounthly_listeners`) VALUES ('Ariana', 'Grande', '28', 'female', 'United States', '8', '70 000 000');
INSERT INTO singer (`name`, `last_name`, `gender_type`, `country_name`, `mounthly_listeners`) VALUES 
('Tina', 'Karol', 'female', 'Ukraine', '10 000 000'),
('Justin', 'Bieber', 'male', 'United States', '20 000 000'),
('Dima', 'Monatic', 'male', 'Ukraine', '30 000 000'),
('Alisher', 'Morgenshtern', 'male', 'Russia', '40 000 000'),
('The', 'Maneskin', 'group', 'Italia', '50 000 000'),
('Billie', 'Eilish', 'female', 'United States', '60 000 000'),
('Twenty', 'One Pillots', 'group', 'United States', '80 000 000'),
('J.', 'Balvin', 'male', 'Spain', '90 000 000'),
('Demkovych', 'Maks', 'male', 'Ukraine', '100 000 000');

INSERT INTO album (`name`, `release_year`, `amount_of_song`, `total_time_of_listeting`, `singer_id`) VALUES ('Dangerous Woman', '2018', '8', '01:22:32', '1');
INSERT INTO album (`name`, `release_year`, `amount_of_song`, `singer_id`) VALUES
('Live', '2017', '12', '2'),
('Yummy', '2016', '10', '3'),
('Sova', '2020', '8', '4'),
('Dust', '2021', '11', '5'),
('I wanna be your slave', '2019', '7', '6'),
('Your Pover', '2020', '9', '7'),
('20 Pillots', '2019', '8', '8'),
('Dance', '2021', '10', '9'),
('THE BEST', '2016', '12', '10');

INSERT INTO song (`name`, `time`, `likes`, `downloaded`, `streaming`, `feat_singer_id`, `album_id`) VALUES ('God is a woman', '00:02:45', '4 456 768', '600 000', '665 125 676', '2', '1');
INSERT INTO song (`name`, `album_id`) VALUES 
('Live is good', '2'), ('Someone like you', '3'), ('Ok', '4'), ('Afternoon', '5'), ('Gussy', '6'),
('Hello, worls', '7'), ('Bloody party', '8'), ('Caroline', '9'), ('Poland', '10');

INSERT INTO playlist (`id`, `appointment`, `some_text`, `amount_of_songs`, `total_time_of_listening`) VALUES 
('1', 'Dancing', 'dancing', '60', '02:20:45'), ('2', 'Relax', 'relax', '43', '01:14:28'), ('3', 'Meditation', 'meditation', '20', '0:56:43');
INSERT INTO playlist (`id`, `appointment`, `some_text`) VALUES 
('4', 'Sad', 'for sad moments'), ('5', 'Techno', 'techno'), ('6', 'Electrical', 'electrical');

INSERT INTO playlist_has_song (`playlist_id`, `song_id`) VALUES
('1', '1'), ('2', '2'), ('3', '3'), ('4', '4'), ('5', '5'), ('6', '6'), ('7', '7'), ('8', '8'), ('9', '9'), ('10', '10');

INSERT INTO library_has_playlist (`library_id`, `playlist_id`) VALUES
('1', '1'), ('2', '3'), ('1', '6'), ('2', '5'), ('3', '2'), ('4', '4'), ('5', '1');