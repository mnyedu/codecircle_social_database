-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema social
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema social
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `social` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `social` ;

-- -----------------------------------------------------
-- Table `social`.`chats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`chats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(500) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `coverPic` VARCHAR(500) NULL DEFAULT NULL,
  `profilePic` VARCHAR(500) NULL DEFAULT NULL,
  `city` VARCHAR(100) NULL DEFAULT NULL,
  `website` VARCHAR(100) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT 'regular',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(500) NULL DEFAULT NULL,
  `img` VARCHAR(500) NULL DEFAULT NULL,
  `userId` INT NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `userId_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(500) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `userId` INT NOT NULL,
  `postId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `commentUserId_idx` (`userId` ASC) VISIBLE,
  INDEX `postId_idx` (`postId` ASC) VISIBLE,
  CONSTRAINT `commentUserId`
    FOREIGN KEY (`userId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `postId`
    FOREIGN KEY (`postId`)
    REFERENCES `social`.`posts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `postId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `likeUserId_idx` (`userId` ASC) VISIBLE,
  INDEX `likePostId_idx` (`postId` ASC) VISIBLE,
  CONSTRAINT `likePostId`
    FOREIGN KEY (`postId`)
    REFERENCES `social`.`posts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `likeUserId`
    FOREIGN KEY (`userId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 50
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `senderId` INT NOT NULL,
  `text` VARCHAR(100) NOT NULL,
  `img` VARCHAR(400) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `receipientId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `senderId_idx` (`senderId` ASC) VISIBLE,
  INDEX `receipientId_idx` (`receipientId` ASC) VISIBLE,
  CONSTRAINT `senderId`
    FOREIGN KEY (`senderId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`participants` (
  `userId` INT NOT NULL,
  `chatId` INT NOT NULL,
  PRIMARY KEY (`chatId`, `userId`),
  INDEX `participantId_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `chatId`
    FOREIGN KEY (`chatId`)
    REFERENCES `social`.`chats` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `participantId`
    FOREIGN KEY (`userId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `social`.`relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social`.`relationships` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `followerId` INT NOT NULL,
  `followedId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `followerUser_idx` (`followerId` ASC) VISIBLE,
  INDEX `followedUser_idx` (`followedId` ASC) VISIBLE,
  CONSTRAINT `followedUser`
    FOREIGN KEY (`followedId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `followerUser`
    FOREIGN KEY (`followerId`)
    REFERENCES `social`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
