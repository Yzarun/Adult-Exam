/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : adult_exam

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-03-20 21:14:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _about_us
-- ----------------------------
DROP TABLE IF EXISTS `_about_us`;
CREATE TABLE `_about_us` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `cont` text,
  `type` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _about_us
-- ----------------------------

-- ----------------------------
-- Table structure for _exam
-- ----------------------------
DROP TABLE IF EXISTS `_exam`;
CREATE TABLE `_exam` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `examTime` datetime DEFAULT NULL,
  `cont` varchar(255) DEFAULT NULL,
  `majorId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _exam
-- ----------------------------

-- ----------------------------
-- Table structure for _major
-- ----------------------------
DROP TABLE IF EXISTS `_major`;
CREATE TABLE `_major` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _major
-- ----------------------------

-- ----------------------------
-- Table structure for _notice
-- ----------------------------
DROP TABLE IF EXISTS `_notice`;
CREATE TABLE `_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `cont` text,
  `type` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _notice
-- ----------------------------

-- ----------------------------
-- Table structure for _registration
-- ----------------------------
DROP TABLE IF EXISTS `_registration`;
CREATE TABLE `_registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `applyTime` datetime DEFAULT NULL,
  `examNum` varchar(255) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `examId` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _registration
-- ----------------------------

-- ----------------------------
-- Table structure for _results
-- ----------------------------
DROP TABLE IF EXISTS `_results`;
CREATE TABLE `_results` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course` varchar(255) DEFAULT NULL,
  `score` double DEFAULT NULL,
  `registrationId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _results
-- ----------------------------

-- ----------------------------
-- Table structure for _users
-- ----------------------------
DROP TABLE IF EXISTS `_users`;
CREATE TABLE `_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _users
-- ----------------------------
INSERT INTO `_users` VALUES ('1', 'admin', null, '21232f297a57a5a743894a0e4a801fc3', null, '1', null, '1', '1', '2017-03-20 09:22:09');
