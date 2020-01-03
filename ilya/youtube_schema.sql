-- MySQL Script generated by MySQL Workbench
-- Thu May 16 15:25:41 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube-app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube-app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube-app` DEFAULT CHARACTER SET utf8 ;
USE `youtube-app` ;

-- -----------------------------------------------------
-- Table `youtube-app`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`user` ;

CREATE TABLE IF NOT EXISTS `youtube-app`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube-app`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`video` ;

CREATE TABLE IF NOT EXISTS `youtube-app`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `link` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube-app`.`voteFor_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`voteFor_video` ;

CREATE TABLE IF NOT EXISTS `youtube-app`.`voteFor_video` (
  `video_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `mark` INT NULL,
  PRIMARY KEY (`video_id`, `user_id`),
  INDEX `fk_vote_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_vote_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube-app`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vote_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube-app`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube-app`.`counter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`counter` ;

CREATE TABLE IF NOT EXISTS `youtube-app`.`counter` (
  `type` VARCHAR(45) NOT NULL,
  `fun` VARCHAR(45) NOT NULL,
  `id` INT NOT NULL,
  `value` INT NULL,
  PRIMARY KEY (`type`, `id`, `fun`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube-app`.`itemIn_videosFor_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`itemIn_videosFor_user` ;

CREATE TABLE IF NOT EXISTS `youtube-app`.`itemIn_videosFor_user` (
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `video_id`),
  INDEX `fk_itemIn_videosFor_user_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_itemIn_videosFor_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube-app`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itemIn_videosFor_user_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube-app`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `youtube-app` ;

-- -----------------------------------------------------
-- Placeholder table for view `youtube-app`.`avgFor_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube-app`.`avgFor_video` (`id` INT, `avg` INT);

-- -----------------------------------------------------
-- Placeholder table for view `youtube-app`.`vote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube-app`.`vote` (`video_id` INT, `user_id` INT, `mark` INT);

-- -----------------------------------------------------
-- Placeholder table for view `youtube-app`.`avg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube-app`.`avg` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `youtube-app`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube-app`.`item` (`user_id` INT, `video_id` INT);

-- -----------------------------------------------------
-- procedure init
-- -----------------------------------------------------

USE `youtube-app`;
DROP procedure IF EXISTS `youtube-app`.`init`;

DELIMITER $$
USE `youtube-app`$$
CREATE PROCEDURE `init` ()
BEGIN	insert ignore into user (username, password) values ('admin', 'test');
	insert ignore into user (username, password) values ('admin1', 'test');
	insert ignore into user (username, password) values ('admin2', 'test');
	insert ignore into user (username, password) values ('admin3', 'test');
    
	-- insert into video (title, link, description) values ('Video title 2', 'http://youtube.com/?watch=d3d3', 'Test decription');
	insert into video (title, link, description) values ('Video title 2', 'http://youtube.com/?watch=d3d3', 'Test decription');
	insert into video (title, link, description) values ('Video title 2', 'http://youtube.com/?watch=d3d3', 'Test decription');
	insert into video (title, link, description) values ('Video title 2', 'http://youtube.com/?watch=d3d3', 'Test decription');

	insert ignore into vote (user_id, video_id, mark) values (1, 1, 5);
	insert ignore into vote (user_id, video_id, mark) values (1, 2, 4);
	insert ignore into vote (user_id, video_id, mark) values (2, 1, 3);
	-- This line must ignore on first time
	insert ignore into vote (user_id, video_id, mark) values (1, 1, 3);
	insert ignore into vote (user_id, video_id, mark) values (3, 1, 3);
    
    select * from `avg`;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `youtube-app`.`avgFor_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`avgFor_video`;
DROP VIEW IF EXISTS `youtube-app`.`avgFor_video` ;
USE `youtube-app`;
-- Find average mark of video with id
CREATE  OR REPLACE VIEW `avgFor_video` AS
select id, sum/count as avg from (
	select
		a.value as sum ,
        b.value as count,
        a.id as id
	from
		counter a, counter b
	where 
		-- Type
		a.type = 'vote' AND b.type = 'vote'
        AND
        -- Function
        a.fun = 'sum' AND b.fun = 'count' AND
        -- ID equality
        a.id = b.id
) as select_result;

-- -----------------------------------------------------
-- View `youtube-app`.`vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`vote`;
DROP VIEW IF EXISTS `youtube-app`.`vote` ;
USE `youtube-app`;
-- Rename
CREATE  OR REPLACE VIEW `vote` AS
select * from voteFor_video;

-- -----------------------------------------------------
-- View `youtube-app`.`avg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`avg`;
DROP VIEW IF EXISTS `youtube-app`.`avg` ;
USE `youtube-app`;
CREATE  OR REPLACE VIEW `avg` AS
select * from avgFor_video;

-- -----------------------------------------------------
-- View `youtube-app`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youtube-app`.`item`;
DROP VIEW IF EXISTS `youtube-app`.`item` ;
USE `youtube-app`;
CREATE  OR REPLACE VIEW `item` AS
select * from itemIn_videosFor_user;
USE `youtube-app`;

DELIMITER $$

USE `youtube-app`$$
DROP TRIGGER IF EXISTS `youtube-app`.`vote_AFTER_INSERT` $$
USE `youtube-app`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `vote_AFTER_INSERT` AFTER INSERT ON `voteFor_video` FOR EACH ROW 
BEGIN
	-- Sum (counter)
	INSERT IGNORE INTO counter VALUES ('vote', 'sum', NEW.video_id, 0);
    UPDATE counter SET value = value + NEW.mark WHERE id = NEW.video_id AND type = 'vote' AND fun='sum';
	-- Count (counter)
	INSERT IGNORE INTO counter VALUES ('vote', 'count', NEW.video_id, 0);
    UPDATE counter SET value = value+1 WHERE id = NEW.video_id AND type = 'vote' AND fun='count';
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;