-- MySQL Script generated by MySQL Workbench
-- Sat Feb  8 18:44:10 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pakchoi
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pakchoi` ;

-- -----------------------------------------------------
-- Schema pakchoi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pakchoi` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `pakchoi` ;

-- -----------------------------------------------------
-- Table `user_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_roles` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` INT NOT NULL COMMENT '角色枚举值',
  `role_name` VARCHAR(64) NOT NULL COMMENT '角色名称',
  `note` MEDIUMTEXT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '用户角色';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `resources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resources` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `resources` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` INT NOT NULL COMMENT 'file type enum values [for upload folder]\n\n0 photo\n1 audio\n2 video\n3 pdf content',
  `filename` VARCHAR(128) NOT NULL COMMENT 'The original file name',
  `upload_time` DATETIME NOT NULL,
  `size` INT NOT NULL COMMENT 'size in bytes',
  `description` MEDIUMTEXT NULL,
  `uploader` INT NOT NULL COMMENT 'upload user',
  `resource` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '用于存储上传的相片，声音，视频等文件';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `resources` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `messages` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `send_from` INT NOT NULL,
  `message_time` DATETIME NOT NULL,
  `message` LONGTEXT NOT NULL,
  `mentions` INT NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `messages` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(512) NOT NULL,
  `nickname` VARCHAR(128) NOT NULL,
  `role` INT NOT NULL DEFAULT 0,
  `avatar` TINYTEXT NULL,
  `fullname` VARCHAR(64) NOT NULL,
  `whats_up` VARCHAR(1024) NULL,
  `activities` INT NOT NULL DEFAULT 0,
  `photos` INT NOT NULL DEFAULT 0,
  `posts` INT NOT NULL DEFAULT 0,
  `message_read` INT NOT NULL DEFAULT 0 COMMENT '消息读取的最新编号',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `users` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pageview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pageview` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `pageview` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NOT NULL DEFAULT NOW(),
  `code` INT NOT NULL DEFAULT 200 COMMENT '访问的结果代码\n\n200 正常\n403 被拒绝\n500 服务器错误',
  `page_url` VARCHAR(2048) NOT NULL,
  `user_id` INT NOT NULL,
  `ip` VARCHAR(32) NOT NULL,
  `location` VARCHAR(45) NULL,
  `session_id` VARCHAR(64) NULL,
  `user_agent` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `pageview` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `blogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blogs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author` INT NOT NULL,
  `title` VARCHAR(64) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT NOW(),
  `last_modify` DATETIME NOT NULL DEFAULT NOW(),
  `content_resource` MEDIUMTEXT NOT NULL COMMENT '博客文档的路径',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `blogs` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `activity` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '动静编号',
  `type` INT NOT NULL DEFAULT 0 COMMENT '动静类型枚举值，默认值为0\n\n0 用户登录\n1 用户发表日志记录\n2 用户上传相片\n3 用户上传音频',
  `content` MEDIUMTEXT NOT NULL COMMENT '动静的内容，在首页的显示文本',
  `create_time` DATETIME NOT NULL COMMENT '动静的创建时间',
  `user` INT NOT NULL COMMENT '创建这条动静的用户',
  `resource` INT NOT NULL COMMENT '动静相关联的资源：例如相片，音乐，视频等资源编号',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '显示在首页的用户动静信息';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `activity` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `anniversary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `anniversary` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `anniversary` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `description` TINYTEXT NOT NULL,
  `add_user` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `anniversary` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `goals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `goals` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `goals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(64) NOT NULL,
  `description` VARCHAR(512) NULL,
  `target` DOUBLE NOT NULL DEFAULT -1,
  `type` INT NOT NULL DEFAULT 0 COMMENT 'enum value for target type:\n\n-1 lt\n1 gt\n0 equals',
  `create_time` DATETIME NOT NULL DEFAULT Now(),
  `user` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `goals` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `goal_progress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `goal_progress` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `goal_progress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `target` INT NOT NULL,
  `user` INT NOT NULL,
  `time` DATETIME NOT NULL DEFAULT NOW(),
  `progress` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `goal_progress` (`id` ASC);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
