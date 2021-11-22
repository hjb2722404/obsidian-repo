/*
Navicat MySQL Data Transfer

Source Server         : 本机测试
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : trswcmv7plugins

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-10-23 22:15:34
*/
use trswcmv7plugins;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `emailuser`
-- ----------------------------
DROP TABLE IF EXISTS `emailuser`;
CREATE TABLE `emailuser` (
  `ID` int(11) DEFAULT NULL,
  `EMAILADDRESS` varchar(200) NOT NULL,
  `STATUS` smallint(6) DEFAULT '3',
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EMAILADDRESS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emailuser
-- ----------------------------

-- ----------------------------
-- Table structure for `ncacl`
-- ----------------------------
DROP TABLE IF EXISTS `ncacl`;
CREATE TABLE `ncacl` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(11) DEFAULT NULL,
  `SITEID` int(11) DEFAULT NULL,
  `CHANNELID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncacl
-- ----------------------------

-- ----------------------------
-- Table structure for `ncchannel`
-- ----------------------------
DROP TABLE IF EXISTS `ncchannel`;
CREATE TABLE `ncchannel` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(256) DEFAULT NULL,
  `SITEID` int(11) NOT NULL,
  `READLIMIT` int(11) NOT NULL DEFAULT '0',
  `WRITLIMIT` int(11) NOT NULL DEFAULT '1',
  `NEWSCOUNT` int(11) NOT NULL DEFAULT '0',
  `COMMENTCOUNT` int(11) NOT NULL DEFAULT '0',
  `MESSAGECOUNT` int(11) NOT NULL DEFAULT '0',
  `RUBBISHCOUNT` int(11) NOT NULL DEFAULT '0',
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncchannel
-- ----------------------------

-- ----------------------------
-- Table structure for `nccomment`
-- ----------------------------
DROP TABLE IF EXISTS `nccomment`;
CREATE TABLE `nccomment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITEID` int(11) NOT NULL,
  `NEWSID` int(11) NOT NULL DEFAULT '0',
  `CHANNELID` int(11) NOT NULL DEFAULT '0',
  `CONTENT` varchar(4000) NOT NULL,
  `NEWSURL` varchar(1024) NOT NULL,
  `NEWSTITLE` varchar(1024) NOT NULL,
  `USERID` int(11) NOT NULL DEFAULT '0',
  `USERNAME` varchar(32) DEFAULT NULL,
  `NICKNAME` varchar(32) DEFAULT NULL,
  `POSTADDR` varchar(32) NOT NULL,
  `POSTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ANONYMOUS` int(11) NOT NULL DEFAULT '0',
  `CONFIRMUSER` int(11) DEFAULT NULL,
  `CONFIRMTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TOPICID` int(11) NOT NULL,
  `TOPICTITLE` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nccomment
-- ----------------------------

-- ----------------------------
-- Table structure for `ncdaylog`
-- ----------------------------
DROP TABLE IF EXISTS `ncdaylog`;
CREATE TABLE `ncdaylog` (
  `LOGDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NEWSCOUNT` int(11) NOT NULL DEFAULT '0',
  `PAGEVIEWS` int(11) NOT NULL DEFAULT '0',
  `COMMENTCOUNT` int(11) NOT NULL DEFAULT '0',
  `MESSAGECOUNT` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LOGDATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncdaylog
-- ----------------------------

-- ----------------------------
-- Table structure for `ncmanager`
-- ----------------------------
DROP TABLE IF EXISTS `ncmanager`;
CREATE TABLE `ncmanager` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(32) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LASTTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LASTPAGE` varchar(512) DEFAULT NULL,
  `SUPERFLAG` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncmanager
-- ----------------------------
INSERT INTO `ncmanager` VALUES ('1', 'root', 'root', '2009-04-22 15:09:31', '2020-10-15 14:58:12', null, '1');

-- ----------------------------
-- Table structure for `ncmessage`
-- ----------------------------
DROP TABLE IF EXISTS `ncmessage`;
CREATE TABLE `ncmessage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITEID` int(11) NOT NULL,
  `NEWSID` int(11) NOT NULL DEFAULT '0',
  `CHANNELID` int(11) NOT NULL DEFAULT '0',
  `NEWSURL` varchar(1024) NOT NULL,
  `NEWSTITLE` varchar(1024) NOT NULL,
  `CONTENT` varchar(4000) NOT NULL,
  `USERID` int(11) NOT NULL DEFAULT '0',
  `USERNAME` varchar(32) DEFAULT NULL,
  `NICKNAME` varchar(32) DEFAULT NULL,
  `POSTADDR` varchar(32) NOT NULL,
  `POSTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ANONYMOUS` int(11) NOT NULL DEFAULT '0',
  `TOPICID` int(11) NOT NULL,
  `TOPICTITLE` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncmessage
-- ----------------------------

-- ----------------------------
-- Table structure for `ncnews`
-- ----------------------------
DROP TABLE IF EXISTS `ncnews`;
CREATE TABLE `ncnews` (
  `ID` int(11) NOT NULL,
  `SITEID` int(11) NOT NULL,
  `CHANNELID` int(11) NOT NULL DEFAULT '0',
  `NEWSURL` varchar(1024) NOT NULL,
  `NEWSTITLE` varchar(1024) NOT NULL,
  `COMMENTCOUNT` int(11) NOT NULL DEFAULT '0',
  `MESSAGECOUNT` int(11) NOT NULL DEFAULT '0',
  `RUBBISHCOUNT` int(11) NOT NULL DEFAULT '0',
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `READLIMIT` int(11) NOT NULL DEFAULT '1',
  `WRITLIMIT` int(11) NOT NULL DEFAULT '1',
  `TOPICID` int(11) NOT NULL,
  `TOPICTITLE` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncnews
-- ----------------------------

-- ----------------------------
-- Table structure for `ncproperty`
-- ----------------------------
DROP TABLE IF EXISTS `ncproperty`;
CREATE TABLE `ncproperty` (
  `ID` int(11) NOT NULL,
  `PROPERTYKEY` varchar(256) DEFAULT NULL,
  `STRINGVALUE` varchar(256) DEFAULT NULL,
  `NUMBERVALUE` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncproperty
-- ----------------------------

-- ----------------------------
-- Table structure for `ncrubbish`
-- ----------------------------
DROP TABLE IF EXISTS `ncrubbish`;
CREATE TABLE `ncrubbish` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITEID` int(11) NOT NULL,
  `NEWSID` int(11) NOT NULL DEFAULT '0',
  `CHANNELID` int(11) NOT NULL DEFAULT '0',
  `CONTENT` varchar(4000) NOT NULL,
  `NEWSURL` varchar(1024) NOT NULL,
  `NEWSTITLE` varchar(1024) NOT NULL,
  `USERID` int(11) NOT NULL DEFAULT '0',
  `USERNAME` varchar(32) DEFAULT NULL,
  `NICKNAME` varchar(32) DEFAULT NULL,
  `POSTADDR` varchar(32) NOT NULL,
  `POSTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ANONYMOUS` int(11) NOT NULL DEFAULT '0',
  `CONFIRMUSER` int(11) DEFAULT NULL,
  `CONFIRMTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TOPICID` int(11) NOT NULL,
  `TOPICTITLE` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncrubbish
-- ----------------------------

-- ----------------------------
-- Table structure for `ncsite`
-- ----------------------------
DROP TABLE IF EXISTS `ncsite`;
CREATE TABLE `ncsite` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(256) NOT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NEWSCOUNT` int(11) NOT NULL DEFAULT '0',
  `CHANNELCOUNT` int(11) NOT NULL DEFAULT '0',
  `COMMENTCOUNT` int(11) NOT NULL DEFAULT '0',
  `MESSAGECOUNT` int(11) NOT NULL DEFAULT '0',
  `RUBBISHCOUNT` int(11) NOT NULL DEFAULT '0',
  `READLIMIT` int(11) NOT NULL DEFAULT '1',
  `WRITLIMIT` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ncsite
-- ----------------------------

-- ----------------------------
-- Table structure for `sclog`
-- ----------------------------
DROP TABLE IF EXISTS `sclog`;
CREATE TABLE `sclog` (
  `ID` int(11) NOT NULL,
  `USERNAME` varchar(100) NOT NULL,
  `DOACTION` varchar(100) DEFAULT NULL,
  `SITENAME` varchar(100) DEFAULT NULL,
  `TYPE` smallint(6) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sclog
-- ----------------------------

-- ----------------------------
-- Table structure for `tbbanemail`
-- ----------------------------
DROP TABLE IF EXISTS `tbbanemail`;
CREATE TABLE `tbbanemail` (
  `ID` bigint(20) NOT NULL,
  `EMAIL` varchar(256) DEFAULT NULL,
  `EMAILDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbbanemail
-- ----------------------------

-- ----------------------------
-- Table structure for `tbbanip`
-- ----------------------------
DROP TABLE IF EXISTS `tbbanip`;
CREATE TABLE `tbbanip` (
  `ID` bigint(20) NOT NULL,
  `IP` varchar(256) DEFAULT NULL,
  `IPDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbbanip
-- ----------------------------

-- ----------------------------
-- Table structure for `tbbanusername`
-- ----------------------------
DROP TABLE IF EXISTS `tbbanusername`;
CREATE TABLE `tbbanusername` (
  `ID` bigint(20) NOT NULL,
  `BANUSERNAME` varchar(256) NOT NULL,
  `BANUSERNAMEDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbbanusername
-- ----------------------------

-- ----------------------------
-- Table structure for `tbfword`
-- ----------------------------
DROP TABLE IF EXISTS `tbfword`;
CREATE TABLE `tbfword` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FWORD` varchar(50) DEFAULT NULL,
  `DESCRIPTION` varchar(500) DEFAULT NULL,
  `CATEGORY` int(11) DEFAULT NULL,
  `DISABLED` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbfword
-- ----------------------------

-- ----------------------------
-- Table structure for `tbgroup`
-- ----------------------------
DROP TABLE IF EXISTS `tbgroup`;
CREATE TABLE `tbgroup` (
  `ID` bigint(20) NOT NULL,
  `GROUPNAME` varchar(200) NOT NULL,
  `GROUPUSERNUM` bigint(20) DEFAULT '0',
  `GROUPMEMO` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_UQ_TBGROUP_NAME` (`GROUPNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbgroup
-- ----------------------------
INSERT INTO `tbgroup` VALUES ('1', '普通用户组', '0', '所有普通用户所在用户组');
INSERT INTO `tbgroup` VALUES ('2', '普通管理员组', '0', '所有系统普通管理员所在用户组');

-- ----------------------------
-- Table structure for `tbgroupuser`
-- ----------------------------
DROP TABLE IF EXISTS `tbgroupuser`;
CREATE TABLE `tbgroupuser` (
  `ID` bigint(20) NOT NULL,
  `GROUPID` bigint(20) DEFAULT NULL,
  `USERID` varchar(256) DEFAULT NULL,
  `USERNAME` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbgroupuser
-- ----------------------------

-- ----------------------------
-- Table structure for `tbids`
-- ----------------------------
DROP TABLE IF EXISTS `tbids`;
CREATE TABLE `tbids` (
  `ID` bigint(20) NOT NULL,
  `TABLENAME` varchar(256) DEFAULT NULL,
  `CURRENTID` bigint(20) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbids
-- ----------------------------
INSERT INTO `tbids` VALUES ('1', 'tbids', '1000');
INSERT INTO `tbids` VALUES ('2', 'tbjsppagesettings', '1000');
INSERT INTO `tbids` VALUES ('3', 'tbsysconfig', '1000');
INSERT INTO `tbids` VALUES ('4', 'tbvipstyleconfig', '1000');
INSERT INTO `tbids` VALUES ('5', 'tbvipuserinfo', '1000');
INSERT INTO `tbids` VALUES ('6', 'tbvip', '1000');
INSERT INTO `tbids` VALUES ('7', 'tbvipnotice', '1000');
INSERT INTO `tbids` VALUES ('8', 'tbvipbookorder', '1000');
INSERT INTO `tbids` VALUES ('9', 'tbviporder', '1000');
INSERT INTO `tbids` VALUES ('10', 'tbgroup', '1000');
INSERT INTO `tbids` VALUES ('11', 'tbgroupuser', '1000');
INSERT INTO `tbids` VALUES ('12', 'tbpower', '1000');
INSERT INTO `tbids` VALUES ('13', 'tbvipuserpower', '1000');
INSERT INTO `tbids` VALUES ('14', 'tbvipgrouppower', '1000');
INSERT INTO `tbids` VALUES ('15', 'tbbanemail', '1000');
INSERT INTO `tbids` VALUES ('16', 'tbbanip', '1000');
INSERT INTO `tbids` VALUES ('17', 'tbvisit', '1000');
INSERT INTO `tbids` VALUES ('18', 'tbvipvisit', '1000');
INSERT INTO `tbids` VALUES ('19', 'tbbanusername', '1000');
INSERT INTO `tbids` VALUES ('20', 'tbsword', '1000');
INSERT INTO `tbids` VALUES ('21', 'tbfword', '1000');
INSERT INTO `tbids` VALUES ('22', 'tbvipbook_vip1', '1000');
INSERT INTO `tbids` VALUES ('23', 'tbviptopbook_vip1', '1000');
INSERT INTO `tbids` VALUES ('24', 'tbmaterial', '1000');
INSERT INTO `tbids` VALUES ('25', 'tboperationlog', '1000');
INSERT INTO `tbids` VALUES ('26', 'tbvipfword', '1000');

-- ----------------------------
-- Table structure for `tbjsppagesettings`
-- ----------------------------
DROP TABLE IF EXISTS `tbjsppagesettings`;
CREATE TABLE `tbjsppagesettings` (
  `ID` bigint(20) NOT NULL,
  `PAGENAME` varchar(200) NOT NULL,
  `PAGESHOWNAME` varchar(500) NOT NULL,
  `PAGEFILE` varchar(500) NOT NULL DEFAULT '',
  `RELATIONURL` varchar(500) NOT NULL DEFAULT '',
  `ABSOLUTEURL` varchar(500) NOT NULL DEFAULT '',
  `PAGEPARAMETERS` varchar(4000) NOT NULL DEFAULT '',
  `PAGEPARAMETERTYPES` varchar(4000) NOT NULL DEFAULT '',
  `PAGEPARAMETERVALUES` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `IX_UQ_TBJSP_PAGENAME` (`PAGENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbjsppagesettings
-- ----------------------------
INSERT INTO `tbjsppagesettings` VALUES ('1', 'vip1client', '访谈:测试访谈 的客户端', ' ', 'vip1/client.jsp', 'http://www.cs.com.cn/louyan/vip1/client.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('2', 'vip1index', '访谈:测试访谈 的索引页', ' ', 'vip1/index.jsp', 'http://www.cs.com.cn/louyan/vip1/index.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('3', 'vip1vip', '访谈:测试访谈 的首页', ' ', 'vip1/vip.jsp', 'http://www.cs.com.cn/louyan/vip1/vip.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('4', 'vip1left', '访谈:测试访谈 的发布内容页', ' ', 'vip1/vip_left.jsp', 'http://www.cs.com.cn/louyan/vip1/vip_left.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('5', 'vip1right', '访谈:测试访谈 的待答问题页', ' ', 'vip1/vip_right.jsp', 'http://www.cs.com.cn/louyan/vip1/vip_right.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('6', 'vip1detail', '访谈:测试访谈 的查看帖子详细内容页', ' ', 'vip1/detail.jsp', 'http://www.cs.com.cn/louyan/vip1/detail.jsp', ' ', ' ', ' ');
INSERT INTO `tbjsppagesettings` VALUES ('7', 'vip1answer', '访谈:测试访谈 的帖子回复页', ' ', 'vip1/answer.jsp', 'http://www.cs.com.cn/louyan/vip1/answer.jsp', ' ', ' ', ' ');

-- ----------------------------
-- Table structure for `tbmaterial`
-- ----------------------------
DROP TABLE IF EXISTS `tbmaterial`;
CREATE TABLE `tbmaterial` (
  `ID` bigint(20) NOT NULL,
  `TITLE` varchar(4000) DEFAULT NULL,
  `CONTENT` text,
  `USERID` varchar(256) DEFAULT NULL,
  `USERNAME` varchar(256) DEFAULT NULL,
  `CREATEUSERID` varchar(256) DEFAULT NULL,
  `CREATEUSERNAME` varchar(256) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFYUSERID` varchar(256) DEFAULT NULL,
  `MODIFYUSERNAME` varchar(256) DEFAULT NULL,
  `MODIFYTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `VIPID` bigint(20) DEFAULT NULL,
  `VIPNAME` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbmaterial
-- ----------------------------

-- ----------------------------
-- Table structure for `tboperationlog`
-- ----------------------------
DROP TABLE IF EXISTS `tboperationlog`;
CREATE TABLE `tboperationlog` (
  `ID` int(11) NOT NULL,
  `LOGTYPE` varchar(500) NOT NULL,
  `LOGOPERATION` varchar(500) DEFAULT '',
  `LOGCONTENT` varchar(4000) DEFAULT '',
  `LOGSERVERLIST` varchar(500) DEFAULT '',
  `LOGSERVERTYPE` int(11) DEFAULT '0',
  `LOGTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tboperationlog
-- ----------------------------

-- ----------------------------
-- Table structure for `tbpingsql`
-- ----------------------------
DROP TABLE IF EXISTS `tbpingsql`;
CREATE TABLE `tbpingsql` (
  `ID` char(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbpingsql
-- ----------------------------

-- ----------------------------
-- Table structure for `tbpower`
-- ----------------------------
DROP TABLE IF EXISTS `tbpower`;
CREATE TABLE `tbpower` (
  `ID` bigint(20) NOT NULL,
  `POWERNAME` varchar(200) NOT NULL,
  `POWERDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_UQ_TBPOWER_NAME` (`POWERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbpower
-- ----------------------------
INSERT INTO `tbpower` VALUES ('1', '能够浏览', '能够浏览指定访谈上面的发言');
INSERT INTO `tbpower` VALUES ('2', '能够发言', '能够在指定的访谈上面发言');
INSERT INTO `tbpower` VALUES ('3', '能够回复', '能够在指定的访谈上面回复');
INSERT INTO `tbpower` VALUES ('4', '能够管理', '能够管理指定访谈上面的内容');

-- ----------------------------
-- Table structure for `tbsword`
-- ----------------------------
DROP TABLE IF EXISTS `tbsword`;
CREATE TABLE `tbsword` (
  `ID` bigint(20) NOT NULL,
  `SWORD` varchar(200) NOT NULL,
  `SWORDDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_UQ_TBSWORD_WORD` (`SWORD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbsword
-- ----------------------------

-- ----------------------------
-- Table structure for `tbsysconfig`
-- ----------------------------
DROP TABLE IF EXISTS `tbsysconfig`;
CREATE TABLE `tbsysconfig` (
  `ID` bigint(20) NOT NULL,
  `ITEM` varchar(200) NOT NULL,
  `ITEMNAME` varchar(200) NOT NULL,
  `ITEMVALUE` varchar(256) NOT NULL DEFAULT '',
  `ITEMMEMO` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_UQ_TBSSYSCONF_ITEM` (`ITEM`),
  UNIQUE KEY `IX_UQ_TBSSYSCONF_NAME` (`ITEMNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbsysconfig
-- ----------------------------
INSERT INTO `tbsysconfig` VALUES ('1', 'systempath', '系统安装路径', 'd:\\\\TRS\\\\Tomcat\\\\webapps\\\\interview', '访谈系统的安装配置路经');
INSERT INTO `tbsysconfig` VALUES ('2', 'visiturl', '系统访问路径', 'http://127.0.0.1：8080/interview/', '访谈系统在外网上用户访问的URL地址');
INSERT INTO `tbsysconfig` VALUES ('3', 'webname', '系统所属网站名称', '北京拓尔思信息技术股份有限公司', '访谈系统所属的网站名称');
INSERT INTO `tbsysconfig` VALUES ('4', 'systemname', '系统所属网站内栏目名称', '访谈系统', '访谈系统对应的在网站内的栏目名称');
INSERT INTO `tbsysconfig` VALUES ('5', 'smtpserver', '系统使用SMTP服务器', 'mail.yourcompany.com', '访谈系统在发送邮件时使用的SMTP服务器');
INSERT INTO `tbsysconfig` VALUES ('6', 'mailusername', '系统登录SMTP服务器账号', 'webmaster', '访谈系统发送邮件时登录SMTP服务器的用户名');
INSERT INTO `tbsysconfig` VALUES ('7', 'mailuserpassword', '系统登录SMTP服务器账号对应密码', 'webmaster', '访谈系统发送邮件时登录SMTP服务器的用户对应的口令');
INSERT INTO `tbsysconfig` VALUES ('8', 'fileencoding', '系统文件操作编码方式', 'GBK', '访谈系统在进行文件操作时的使用的编码方式');
INSERT INTO `tbsysconfig` VALUES ('9', 'adminemail', '系统管理员邮箱', 'webmaster@yourcompany.com', '访谈系统的管理员邮箱，需要和SMTP账号对应');
INSERT INTO `tbsysconfig` VALUES ('10', 'appservertype', '应用服务器类型', 'Tomcat', '访谈系统的应用服务器类型');
INSERT INTO `tbsysconfig` VALUES ('11', 'appserveredition', '应用服务器版本', '5.0.19', '访谈系统的应用服务器的版本');
INSERT INTO `tbsysconfig` VALUES ('12', 'os', '操作系统类型', 'WINDOWS', '访谈系统所在服务器的类型');
INSERT INTO `tbsysconfig` VALUES ('14', 'wcmurl', 'WCM访问路径', 'http://localhost/wcm', 'WCM系统访问的URL地址');
INSERT INTO `tbsysconfig` VALUES ('15', 'defaultwcmsite', 'WCM默认站点', '1', 'WCM中默认的访问站点');
INSERT INTO `tbsysconfig` VALUES ('16', 'anwsered', '不包含未回答的问题', 'false', '发布内容不包含未回答的问题');
INSERT INTO `tbsysconfig` VALUES ('17', 'pagesize', '分页大小', '300', '发布内容时的分页大小');
INSERT INTO `tbsysconfig` VALUES ('18', 'withwcm', '同步wcm', 'true', '是否自动与wcm同步');

-- ----------------------------
-- Table structure for `tbuserinfo`
-- ----------------------------
DROP TABLE IF EXISTS `tbuserinfo`;
CREATE TABLE `tbuserinfo` (
  `USERID` varchar(40) DEFAULT NULL,
  `USERNAME` varchar(64) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `LEV` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbuserinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvip`
-- ----------------------------
DROP TABLE IF EXISTS `tbvip`;
CREATE TABLE `tbvip` (
  `ID` bigint(20) NOT NULL,
  `VIPNAME` varchar(255) NOT NULL,
  `VIPBOOKTABLENAME` varchar(255) NOT NULL,
  `VIPTOPBOOKTABLENAME` varchar(255) NOT NULL,
  `COMMONUSERSTARTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `COMMONUSERENDTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `COMMENTSTARTTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `COMMENTENDTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ISTOPVIP` bigint(20) DEFAULT '0',
  `QUESTIONMAXLENGTH` bigint(20) DEFAULT '100',
  `QUESTIONMAXSHOWLENGTH` bigint(20) DEFAULT '100',
  `ANSWERMAXLENGTH` bigint(20) DEFAULT '500',
  `ANSWERMAXSHOWLENGTH` bigint(20) DEFAULT '500',
  `PUBENCODING` varchar(40) DEFAULT 'UTF-8',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_UQ_TBVIP_NAME` (`VIPNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvip
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipbookorder`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipbookorder`;
CREATE TABLE `tbvipbookorder` (
  `ID` bigint(20) NOT NULL,
  `VIPBOOKID` bigint(20) NOT NULL,
  `USERID` varchar(256) DEFAULT NULL,
  `USERNAME` varchar(256) DEFAULT NULL,
  `MAIL` varchar(256) DEFAULT NULL,
  `TRANSFLAG` bigint(20) NOT NULL DEFAULT '0',
  `VIPID` bigint(20) DEFAULT NULL,
  `LASTSENDTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipbookorder
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipbook_vip1`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipbook_vip1`;
CREATE TABLE `tbvipbook_vip1` (
  `ID` bigint(20) NOT NULL,
  `TITLE` varchar(4000) DEFAULT NULL,
  `CONTENT` text,
  `REPLYTOTAL` bigint(20) DEFAULT '0',
  `REPLYNUM` bigint(20) DEFAULT '0',
  `LEVELNUM` bigint(20) DEFAULT '0',
  `USERID` varchar(256) NOT NULL,
  `USERNAME` varchar(256) NOT NULL,
  `ROOTID` bigint(20) DEFAULT '0',
  `ORDERID` varchar(8) NOT NULL,
  `SORTID` bigint(20) NOT NULL DEFAULT '0',
  `COLOR` varchar(20) NOT NULL DEFAULT '#000000',
  `BGCOLOR` varchar(20) NOT NULL DEFAULT '#FFFFFF',
  `ISTOP` bigint(20) DEFAULT '0',
  `CONFIRM` bigint(20) DEFAULT '0',
  `POSTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFYUSERID` varchar(256) NOT NULL,
  `MODIFYUSERNAME` varchar(256) NOT NULL,
  `MODIFYTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ISQUESTION` bigint(20) DEFAULT '0',
  `PARENTID` bigint(20) DEFAULT '0',
  `IP` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipbook_vip1
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipfword`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipfword`;
CREATE TABLE `tbvipfword` (
  `ID` bigint(20) NOT NULL,
  `FWORD` varchar(200) NOT NULL,
  `FWORDDSCP` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_UQ_TBVIPFWORD_WORD` (`FWORD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipfword
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipgrouppower`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipgrouppower`;
CREATE TABLE `tbvipgrouppower` (
  `ID` bigint(20) NOT NULL,
  `GROUPID` bigint(20) DEFAULT NULL,
  `GROUPNAME` varchar(256) DEFAULT NULL,
  `VIPID` bigint(20) DEFAULT NULL,
  `POWERID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipgrouppower
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipnotice`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipnotice`;
CREATE TABLE `tbvipnotice` (
  `ID` bigint(20) NOT NULL,
  `VIPID` bigint(20) NOT NULL,
  `NOTICE` varchar(4000) NOT NULL DEFAULT '0',
  `POSTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ISUSE` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipnotice
-- ----------------------------

-- ----------------------------
-- Table structure for `tbviporder`
-- ----------------------------
DROP TABLE IF EXISTS `tbviporder`;
CREATE TABLE `tbviporder` (
  `ID` bigint(20) NOT NULL,
  `VIPID` bigint(20) NOT NULL,
  `USERID` varchar(256) DEFAULT NULL,
  `USERNAME` varchar(256) DEFAULT NULL,
  `MAIL` varchar(256) DEFAULT NULL,
  `TRANSFLAG` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbviporder
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipstyleconfig`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipstyleconfig`;
CREATE TABLE `tbvipstyleconfig` (
  `ID` bigint(20) NOT NULL,
  `VIPID` bigint(20) NOT NULL,
  `STYLENAME` varchar(256) NOT NULL,
  `TITLEBACKGROUND` varchar(256) NOT NULL,
  `TITLEFONT` varchar(256) NOT NULL,
  `NAVIGATEBACKGROUND` varchar(256) NOT NULL,
  `NAVIGATEFONT` varchar(256) NOT NULL,
  `QUESTIONBACKGROUND` varchar(256) NOT NULL,
  `ANSWERBACKGROUND` varchar(256) NOT NULL,
  `COMPERESHOWCOLOR` varchar(40) NOT NULL,
  `COMMENTSHOWCOLOR` varchar(40) NOT NULL,
  `BODYBACKGROUND` varchar(256) NOT NULL,
  `POSTTABLEBACKGROUND` varchar(256) NOT NULL,
  `POSTTABLETDBACKGROUND` varchar(256) NOT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipstyleconfig
-- ----------------------------

-- ----------------------------
-- Table structure for `tbviptopbook_vip1`
-- ----------------------------
DROP TABLE IF EXISTS `tbviptopbook_vip1`;
CREATE TABLE `tbviptopbook_vip1` (
  `ID` bigint(20) NOT NULL,
  `VIPBOOKID` bigint(20) NOT NULL,
  `TITLE` varchar(4000) DEFAULT NULL,
  `CONTENT` text,
  `REPLYTOTAL` bigint(20) DEFAULT '0',
  `REPLYNUM` bigint(20) DEFAULT '0',
  `LEVELNUM` bigint(20) DEFAULT '0',
  `USERID` varchar(256) NOT NULL,
  `USERNAME` varchar(256) NOT NULL,
  `ROOTID` bigint(20) NOT NULL DEFAULT '0',
  `ORDERID` varchar(8) NOT NULL,
  `SORTID` bigint(20) NOT NULL DEFAULT '0',
  `MODIFYUSERID` varchar(256) NOT NULL,
  `MODIFYUSERNAME` varchar(256) NOT NULL,
  `MODIFYTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ISQUESTION` bigint(20) DEFAULT '0',
  `PARENTID` bigint(20) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbviptopbook_vip1
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipuserinfo`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipuserinfo`;
CREATE TABLE `tbvipuserinfo` (
  `ID` bigint(20) NOT NULL,
  `USERID` varchar(200) NOT NULL,
  `USERNAME` varchar(256) NOT NULL,
  `MAIL` varchar(256) NOT NULL,
  `TEL` varchar(50) DEFAULT NULL,
  `SEX` bigint(20) DEFAULT '0',
  `AGE` bigint(20) DEFAULT '18',
  `PHOTO` varchar(255) DEFAULT '',
  `LEV` bigint(20) DEFAULT '1',
  `VISIT` bigint(20) NOT NULL DEFAULT '1',
  `BOOKS` bigint(20) DEFAULT '0',
  `LASTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CREDIT` bigint(20) DEFAULT NULL,
  `CARDID` varchar(256) DEFAULT NULL,
  `EXPERIENCE` bigint(20) NOT NULL DEFAULT '0',
  `SIGN` varchar(255) DEFAULT NULL,
  `HOMEPAGE` varchar(255) DEFAULT NULL,
  `ICQNUM` varchar(255) DEFAULT NULL,
  `OICQNUM` varchar(255) DEFAULT NULL,
  `DSCP` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `COUNTRY` varchar(255) DEFAULT NULL,
  `PROVINCE` varchar(255) DEFAULT NULL,
  `CITY` varchar(255) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `BOOKINTERVAL` bigint(20) NOT NULL DEFAULT '120',
  `MSGINTERVAL` bigint(20) NOT NULL DEFAULT '120',
  `REGTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `FONTSIZE` bigint(20) DEFAULT NULL,
  `BOOKCNT` bigint(20) DEFAULT NULL,
  `COLOR` varchar(20) NOT NULL DEFAULT '#000000',
  `SORTTYPE` bigint(20) NOT NULL DEFAULT '1',
  `DESCTYPE` bigint(20) NOT NULL DEFAULT '1',
  `EXPAND` bigint(20) NOT NULL DEFAULT '1',
  `REMINDERQUESTION` varchar(100) NOT NULL,
  `REMINDERANSWER` varchar(100) NOT NULL,
  `ISCOMMENT` bigint(20) NOT NULL DEFAULT '0',
  `FORUMTOPNUM` bigint(20) NOT NULL DEFAULT '25',
  `BOARDTOPNUM` bigint(20) NOT NULL DEFAULT '25',
  `FOLBOOKNUM` bigint(20) NOT NULL DEFAULT '0',
  `OPENFLAG` bigint(20) NOT NULL DEFAULT '1',
  `READMSG` bigint(20) NOT NULL DEFAULT '0',
  `CONFIRM` bigint(20) DEFAULT '0',
  `STYLEID` bigint(20) DEFAULT NULL,
  `DETAILLISTTYPE` bigint(20) DEFAULT NULL,
  `BOARDLISTTYPE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_UQ_TBVIPUSERINFO` (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipuserinfo
-- ----------------------------
INSERT INTO `tbvipuserinfo` VALUES ('1', 'admin', '管理员', 'webmaster@yourcompany.com', null, '0', '18', '', '3', '1', '0', '2009-06-05 10:01:48', null, null, '0', null, null, null, null, null, 'trsadmin', null, null, null, null, '120', '120', '2009-06-05 10:01:48', null, null, '#000000', '1', '1', '1', 'my userid is', 'admin', '0', '25', '25', '0', '1', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for `tbvipuserpower`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipuserpower`;
CREATE TABLE `tbvipuserpower` (
  `ID` bigint(20) NOT NULL,
  `USERID` varchar(256) DEFAULT NULL,
  `USERNAME` varchar(256) DEFAULT NULL,
  `VIPID` bigint(20) DEFAULT NULL,
  `POWERID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipuserpower
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvipvisit`
-- ----------------------------
DROP TABLE IF EXISTS `tbvipvisit`;
CREATE TABLE `tbvipvisit` (
  `ID` bigint(20) NOT NULL,
  `VIPID` bigint(20) NOT NULL,
  `VISITS` bigint(20) DEFAULT '0',
  `GUEST` bigint(20) DEFAULT '0',
  `USERS` bigint(20) DEFAULT '0',
  `TOPTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TOPUSERS` bigint(20) DEFAULT '0',
  `BOOKS` bigint(20) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvipvisit
-- ----------------------------

-- ----------------------------
-- Table structure for `tbvisit`
-- ----------------------------
DROP TABLE IF EXISTS `tbvisit`;
CREATE TABLE `tbvisit` (
  `ID` bigint(20) NOT NULL,
  `VISIT` bigint(20) DEFAULT '0',
  `GUESTS` bigint(20) DEFAULT '0',
  `BOOKS` bigint(20) DEFAULT '0',
  `USERS` bigint(20) DEFAULT '0',
  `TOPTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TOPUSERS` bigint(20) DEFAULT '0',
  `REGUSER` bigint(20) DEFAULT '0',
  `LOGTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbvisit
-- ----------------------------

-- ----------------------------
-- Table structure for `tempapply`
-- ----------------------------
DROP TABLE IF EXISTS `tempapply`;
CREATE TABLE `tempapply` (
  `ID` int(11) NOT NULL,
  `EMAILUSERID` int(11) DEFAULT '0',
  `WEBSITEID` int(11) NOT NULL,
  `EMAILADDRESS` varchar(100) NOT NULL,
  `STATUS` int(11) NOT NULL,
  `SCCYCLE` int(11) DEFAULT NULL,
  `CHANNELIDS` varchar(200) DEFAULT NULL,
  `LASTCHANNELIDS` varchar(200) DEFAULT NULL,
  `BOLDUSER` smallint(6) DEFAULT '0',
  `SENDSTATUS` int(11) DEFAULT '1',
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tempapply
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmchannelforcomment`
-- ----------------------------
DROP TABLE IF EXISTS `wcmchannelforcomment`;
CREATE TABLE `wcmchannelforcomment` (
  `CHANNELID` int(11) NOT NULL,
  `CHNLNAME` varchar(400) DEFAULT NULL,
  `PARENTID` int(11) DEFAULT NULL,
  `SITEID` int(11) DEFAULT NULL,
  PRIMARY KEY (`CHANNELID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmchannelforcomment
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmconfig`
-- ----------------------------
DROP TABLE IF EXISTS `wcmconfig`;
CREATE TABLE `wcmconfig` (
  `CONFIGID` int(11) NOT NULL,
  `CTYPE` smallint(6) NOT NULL,
  `CKEY` varchar(50) NOT NULL,
  `CVALUE` varchar(500) DEFAULT NULL,
  `CDESC` varchar(100) DEFAULT NULL,
  `ENCRYPTED` int(11) NOT NULL,
  `SITEID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmconfig
-- ----------------------------
INSERT INTO `wcmconfig` VALUES ('1', '10', 'N0', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\norm;/norm/;/norm/', '普通文件数据存放路径', '0', '0');
INSERT INTO `wcmconfig` VALUES ('2', '10', 'P0', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\protect;/protect/;/protect/', '受保护文件数据存放路径', '0', '0');
INSERT INTO `wcmconfig` VALUES ('3', '10', 'U0', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\upload;/upload/;/upload/', '上传文件临时存放路径...', '0', '0');
INSERT INTO `wcmconfig` VALUES ('4', '10', 'ST', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\systemp;/systemp/;/systemp/', '系统用临时文件存放目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('5', '10', 'UT', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\usertemp;/usertemp/;/usertemp/', '用户用临时文件存放目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('6', '10', 'TM', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\template;/template/;/template/', '模板文件数据存放目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('7', '10', 'LP', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\pub;/pub/;/pub/', '发布文件在本地的存放路径', '0', '0');
INSERT INTO `wcmconfig` VALUES ('9', '17', 'SMS_SENDURL_PRE', 'uggc://210.83.137.173/freivprf/vafgnagpnyy/fraqPnyy_pyvrag.nfc?HVQ=138650&Cnffjbeq=020201&ZftGlcr=FZF', '发送手机短信息的URL前半部分', '1', '0');
INSERT INTO `wcmconfig` VALUES ('10', '17', 'SMS_PARAM_NAME_TO', 'Addr', '发送手机信息的URL中参数To的名称', '0', '0');
INSERT INTO `wcmconfig` VALUES ('11', '17', 'SMS_PARAM_NAME_CONTENT', 'Content', '发送手机短信息的URL中参数Content的名称', '0', '0');
INSERT INTO `wcmconfig` VALUES ('14', '0', 'WCM_PATH', 'E:\\TRS\\TRSWCMV7Plugins\\Tomcat\\webapps\\poll\\', 'WCM源代码放置目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('15', '10', 'LV', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\preview;/preview/;/preview/', '预览页面在本地的存放路径', '0', '0');
INSERT INTO `wcmconfig` VALUES ('18', '0', 'DEF_LOCKTIMEOUT', '30', '锁定时间', '0', '0');
INSERT INTO `wcmconfig` VALUES ('30', '0', 'DOC_COPY_TITLE_PRE', '[复制]', '复制文档后在标题前增加的前缀', '0', '0');
INSERT INTO `wcmconfig` VALUES ('90', '10', 'W0', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\webpic;/webpic/;/webpic/', '可以通过HTTP协议查看的路径', '0', '0');
INSERT INTO `wcmconfig` VALUES ('96', '1', 'PROXY_HOST', '', '代理服务器地址', '0', '0');
INSERT INTO `wcmconfig` VALUES ('97', '1', 'PROXY_PORT', '', '代理服务器端口', '0', '0');
INSERT INTO `wcmconfig` VALUES ('98', '1', 'PROXY_USER', '', '代理服务器用户名', '0', '0');
INSERT INTO `wcmconfig` VALUES ('99', '1', 'PROXY_PASSWORD', '', '代理服务器密码', '0', '0');
INSERT INTO `wcmconfig` VALUES ('100', '10', 'DS', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\documentsrc;/documentsrc/;/documentsrc/', '文档导出导入相关资源存放目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('101', '10', 'SF', 'E:\\TRS\\TRSWCMV7Plugins\\WCMData\\sitefrom;/sitefrom/;/sitefrom/', '智能建站数据存放目录', '0', '0');
INSERT INTO `wcmconfig` VALUES ('102', '0', 'adencode', 'UTF-8', '广告生成脚本的编码', '0', '0');

-- ----------------------------
-- Table structure for `wcmdbupdate`
-- ----------------------------
DROP TABLE IF EXISTS `wcmdbupdate`;
CREATE TABLE `wcmdbupdate` (
  `UPDVERSION` int(11) NOT NULL,
  `UPDINFO` varchar(2000) NOT NULL,
  `UPDUSER` char(10) NOT NULL,
  `UPDTIME` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmdbupdate
-- ----------------------------
INSERT INTO `wcmdbupdate` VALUES ('1016', 'WCMWEBSITE表增加PUBSTATUSES字段', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1021', '增加扩展字段WCMEXTFIELD表；增加视图WCM_ViewCOLUMNS；修改配置表WCMCONFIG结构并且增加新的的配置选项', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1022', '工作流表WCMFLOW增加站点属性字段SITEID', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1027', '日志WCMLOG表增加新的字段并增加新的日志类型；增加新的替换内容WCMREPLACE表；文档WCMDOCUMENT表和文档表增加模板编号字段TEMPID和标题颜色TITLECOLOR;', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1029', '配置WCMCONFIG表增加新的配置选项；文档WCMDOCUMENT表和文档备份WCMDOCBAK表增加模板编号；增加文档引用表WCMCHNLDOC；增加内容超链接表WCMCONTENTLINK；站点表WCMWEBSITE增加属性字段SITEPROP；增加新的置标及解析组件_TRSREPLACE', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1030', '站点表WCMWEBSITE增加属性字段SCHEDULE', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1031', '文档附件表WCMAPPENDIX增加字段SRCFILE和FILEEXT；联系人表WCMCONTACT增加新的字段USERNAME，并删除FIRSTNAME和LASTNAME；', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1033', '公告表WCMBULLETIN更新BODY字段属性；增加站点扩展字段表WCMSITEEXTFIELD；站点表WCMWEBSITE增加字段STATUS和修改站点名属性；频道表WCMCHANNEL增加字段STATUS和头条/图片新闻类型；', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1035', '修改文档表WCMDOCUMENT和文档备份表WCMDOCBAK的定时发布属性SCHEDULE；用户表WCMUSER增加稿酬字段PRICE；重新设置解析组件WCMTAGBEANS表；增加新的网络会议管理员角色；', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1036', '置标解析组件WCMTAGBEANS表增加新的置标及解析组件_TRSRECPATH；', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1037', '系统配置表WCMCONFIG增加新字段SITEID；', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1038', '由于频道的排序算法更新，因此更新WCMCHANNEL的Order属性', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1040', '更新权限列表', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1041', '工作流节点增加会签属性', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1042', '更新删除临时文件的Schedule', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1043', '增加托管设置', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1044', '增加代理服务器配置', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1045', '实现WCMResultSet;分发记录', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1047', '增加DOCFLAG;增加回复类型REPLYTYPE;增加个人字典库', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1049', '频道名称唯一性限制更新原有数据', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1050', '1.	HTML内容中图片的显示', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1055', 'WCMSCHEDULE表增加记录104', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1058', 'WCMCHANNELSYN表增加ATTRIBUTE属性', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1067', '增加WCMOBJTRIGGER表', 'fangxiang', null);
INSERT INTO `wcmdbupdate` VALUES ('1030', 'WCM52的数据库脚本完全更新', 'WCM Team', '2005-07-07 13:46:51');
INSERT INTO `wcmdbupdate` VALUES ('1030', 'WCM52的数据库脚本完全更新', 'WCM Team', '2005-08-03 12:02:05');
INSERT INTO `wcmdbupdate` VALUES ('1030', 'WCM52的数据库脚本完全更新', 'WCM Team', '2005-08-29 15:02:03');
INSERT INTO `wcmdbupdate` VALUES ('1030', 'WCM52的数据库脚本完全更新', 'WCM Team', '2005-09-05 17:10:06');
INSERT INTO `wcmdbupdate` VALUES ('1030', 'WCM52的数据库脚本完全更新', 'WCM Team', '2005-10-17 11:12:56');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-04-07 15:20:16');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-05-04 10:55:18');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-05-25 10:07:08');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-06-07 19:30:09');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-06-23 13:25:30');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-07-05 11:32:50');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-07-08 16:56:50');
INSERT INTO `wcmdbupdate` VALUES ('1095', 'WCMPlugins', 'WCM Team', '2011-07-12 14:05:35');
INSERT INTO `wcmdbupdate` VALUES ('6612', 'WCM7Plugins', 'WCM Team', '2013-06-26 16:37:35');

-- ----------------------------
-- Table structure for `wcmdbupdatelog`
-- ----------------------------
DROP TABLE IF EXISTS `wcmdbupdatelog`;
CREATE TABLE `wcmdbupdatelog` (
  `DBUPDATELOGID` int(11) NOT NULL,
  `LOGTITLE` varchar(100) NOT NULL,
  `LOGMEMO` varchar(2000) DEFAULT NULL,
  `SUBMITOR` varchar(50) NOT NULL,
  `TABLENAME` varchar(50) NOT NULL,
  `LOGTYPE` int(11) NOT NULL,
  `SQLSERVER` text NOT NULL,
  `ORACLESQL` text,
  `DB2SQL` text,
  `SYSBASESQL` text,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmdbupdatelog
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmextfield`
-- ----------------------------
DROP TABLE IF EXISTS `wcmextfield`;
CREATE TABLE `wcmextfield` (
  `EXTFIELDID` int(11) NOT NULL,
  `TABLENAME` varchar(50) NOT NULL,
  `FIELDNAME` varchar(50) NOT NULL,
  `FIELDTYPE` varchar(10) NOT NULL,
  `FIELDMAXLEN` int(11) DEFAULT NULL,
  `FIELDNULLABLE` smallint(6) NOT NULL,
  `FIELDDEFAULT` varchar(50) DEFAULT NULL,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FIELDSCALE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmextfield
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmfiletype`
-- ----------------------------
DROP TABLE IF EXISTS `wcmfiletype`;
CREATE TABLE `wcmfiletype` (
  `FILETYPEID` int(11) NOT NULL,
  `TYPENAME` varchar(50) NOT NULL,
  `TYPEDESC` varchar(200) DEFAULT NULL,
  `TYPEEXT` varchar(50) DEFAULT NULL,
  `TYPEFORM` varchar(200) DEFAULT NULL,
  `TYPETAG` varchar(1000) DEFAULT NULL,
  `TYPEOPENWITH` varchar(100) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmfiletype
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmfolderpublishconfig`
-- ----------------------------
DROP TABLE IF EXISTS `wcmfolderpublishconfig`;
CREATE TABLE `wcmfolderpublishconfig` (
  `FOLDERPUBLISHCONFIGID` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `OUTLINEFILE` varchar(100) DEFAULT NULL,
  `DETAILFILEEXT` varchar(10) DEFAULT NULL,
  `DATAPATH` varchar(100) NOT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ROOTDOMAIN` varchar(200) DEFAULT NULL,
  `SITELANGUAGE` int(11) DEFAULT NULL,
  `PAGEENCODING` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmfolderpublishconfig
-- ----------------------------
INSERT INTO `wcmfolderpublishconfig` VALUES ('100000', '20000', '1', null, null, 'trspoll', 'admin', '2005-06-20 09:20:23', 'http://localhost:8080/', null, 'GBK');

-- ----------------------------
-- Table structure for `wcmfolderpublishinfo`
-- ----------------------------
DROP TABLE IF EXISTS `wcmfolderpublishinfo`;
CREATE TABLE `wcmfolderpublishinfo` (
  `WCMFOLDERPUBLISHCONFIGID` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `OUTLINEFILENAME` varchar(100) DEFAULT NULL,
  `DETAILFILEEXT` varchar(100) DEFAULT NULL,
  `DATAPATH` varchar(100) NOT NULL,
  `ROOTDOMAIN` varchar(200) DEFAULT NULL,
  `OUTLINETEMPLATEID` varchar(50) NOT NULL,
  `DETAILTEMPLATEID` int(11) NOT NULL,
  `STATUSESCANDOPUB` varchar(50) DEFAULT NULL,
  `STATUSIDAFTERMODIFY` int(11) DEFAULT NULL,
  `SCHEDULEMODE` int(11) DEFAULT NULL,
  `STARTTIME` varchar(10) DEFAULT NULL,
  `ENDTIME` varchar(10) DEFAULT NULL,
  `INTERVAL` int(11) DEFAULT NULL,
  `EXECTIME` varchar(10) DEFAULT NULL,
  `DEFINEFILERULE` smallint(6) NOT NULL,
  `DEFINESCHEDULE` smallint(6) NOT NULL,
  `DEFINESTATUS` smallint(6) NOT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DEFAULTOUTLINETEMPLATEID` int(11) DEFAULT NULL,
  `SITELANGUAGE` int(11) DEFAULT NULL,
  `PAGEENCODING` varchar(50) DEFAULT NULL,
  `ISRESETCHILDRENTEMPLATES` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmfolderpublishinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmgroup`
-- ----------------------------
DROP TABLE IF EXISTS `wcmgroup`;
CREATE TABLE `wcmgroup` (
  `GROUPID` int(11) NOT NULL,
  `GNAME` varchar(50) NOT NULL,
  `GDESC` varchar(200) DEFAULT NULL,
  `PARENTID` int(11) DEFAULT NULL,
  `EMAIL` char(200) DEFAULT NULL,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmgroup
-- ----------------------------
INSERT INTO `wcmgroup` VALUES ('6', 'WCM开发小组', 'Web Content Management 项目开发小组。', '0', null, null, 'admin', '2002-08-12 00:00:00');
INSERT INTO `wcmgroup` VALUES ('7', '设计小组', '专门负责WCM项目的设计工作。', '6', null, null, 'admin', '2002-08-12 00:00:00');
INSERT INTO `wcmgroup` VALUES ('8', '编码小组', '负责WCM项目的编码实施', '6', null, null, 'admin', '2002-08-12 00:00:00');
INSERT INTO `wcmgroup` VALUES ('9', '测试小组', '全面负责WCM项目的测试工作', '6', null, null, 'admin', '2002-08-12 00:00:00');
INSERT INTO `wcmgroup` VALUES ('10', '文档小组', '负责WCM项目中各类文档的建立、整合和管理。', '6', null, null, 'admin', '2002-08-12 00:00:00');
INSERT INTO `wcmgroup` VALUES ('11', 'test', 'test', '0', null, null, 'admin', '2005-09-06 10:11:29');

-- ----------------------------
-- Table structure for `wcmgrpuser`
-- ----------------------------
DROP TABLE IF EXISTS `wcmgrpuser`;
CREATE TABLE `wcmgrpuser` (
  `GROUPID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ISADMINISTRATOR` smallint(6) NOT NULL,
  `GRPUSERID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmgrpuser
-- ----------------------------
INSERT INTO `wcmgrpuser` VALUES ('7', '2', 'admin', '2002-08-12 14:37:49', '0', '1');
INSERT INTO `wcmgrpuser` VALUES ('7', '3', 'admin', '2002-08-12 14:37:49', '0', '2');
INSERT INTO `wcmgrpuser` VALUES ('7', '4', 'admin', '2002-08-12 14:37:49', '0', '3');
INSERT INTO `wcmgrpuser` VALUES ('8', '3', 'admin', '2002-08-12 14:38:04', '0', '4');
INSERT INTO `wcmgrpuser` VALUES ('8', '4', 'admin', '2002-08-12 14:38:04', '0', '5');
INSERT INTO `wcmgrpuser` VALUES ('8', '5', 'admin', '2002-08-12 14:38:04', '0', '6');
INSERT INTO `wcmgrpuser` VALUES ('8', '6', 'admin', '2002-08-12 14:38:04', '0', '7');
INSERT INTO `wcmgrpuser` VALUES ('8', '7', 'admin', '2002-08-12 14:38:04', '0', '8');
INSERT INTO `wcmgrpuser` VALUES ('9', '8', 'admin', '2002-09-04 08:44:54', '0', '9');
INSERT INTO `wcmgrpuser` VALUES ('9', '9', 'admin', '2002-09-04 08:44:54', '0', '10');
INSERT INTO `wcmgrpuser` VALUES ('9', '10', 'admin', '2002-09-04 08:44:54', '0', '11');
INSERT INTO `wcmgrpuser` VALUES ('10', '3', 'admin', '2002-08-12 14:38:28', '0', '12');
INSERT INTO `wcmgrpuser` VALUES ('10', '6', 'admin', '2002-08-12 14:38:28', '0', '13');
INSERT INTO `wcmgrpuser` VALUES ('7', '13', 'admin', '2005-08-11 10:43:53', '0', '14');
INSERT INTO `wcmgrpuser` VALUES ('11', '2', 'admin', '2005-09-06 10:11:39', '0', '15');
INSERT INTO `wcmgrpuser` VALUES ('6', '1', 'admin', '2005-10-24 16:40:03', '0', '16');
INSERT INTO `wcmgrpuser` VALUES ('6', '2', 'admin', '2005-10-24 16:40:03', '1', '17');
INSERT INTO `wcmgrpuser` VALUES ('6', '3', 'admin', '2005-10-24 16:40:03', '0', '18');
INSERT INTO `wcmgrpuser` VALUES ('6', '4', 'admin', '2005-10-24 16:40:03', '0', '19');
INSERT INTO `wcmgrpuser` VALUES ('6', '5', 'admin', '2005-10-24 16:40:03', '0', '20');
INSERT INTO `wcmgrpuser` VALUES ('6', '6', 'admin', '2005-10-24 16:40:03', '0', '21');
INSERT INTO `wcmgrpuser` VALUES ('6', '7', 'admin', '2005-10-24 16:40:03', '0', '22');
INSERT INTO `wcmgrpuser` VALUES ('6', '8', 'admin', '2005-10-24 16:40:03', '0', '23');
INSERT INTO `wcmgrpuser` VALUES ('6', '9', 'admin', '2005-10-24 16:40:04', '0', '24');
INSERT INTO `wcmgrpuser` VALUES ('6', '10', 'admin', '2005-10-24 16:40:04', '0', '25');
INSERT INTO `wcmgrpuser` VALUES ('6', '11', 'admin', '2005-10-24 16:40:04', '0', '26');
INSERT INTO `wcmgrpuser` VALUES ('6', '12', 'admin', '2005-10-24 16:40:04', '0', '27');
INSERT INTO `wcmgrpuser` VALUES ('6', '13', 'admin', '2005-10-24 16:40:04', '0', '28');
INSERT INTO `wcmgrpuser` VALUES ('11', '14', 'admin', '2005-10-28 16:06:14', '0', '29');

-- ----------------------------
-- Table structure for `wcmid`
-- ----------------------------
DROP TABLE IF EXISTS `wcmid`;
CREATE TABLE `wcmid` (
  `TABLENAME` varchar(50) NOT NULL,
  `NEXTID` int(11) NOT NULL,
  `CACHESIZE` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmid
-- ----------------------------
INSERT INTO `wcmid` VALUES ('WCMADDRESS', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMADDRGROUP', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMAPPENDIX', '0', '10');
INSERT INTO `wcmid` VALUES ('WCMBOOKMARK', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMBULLETIN', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCHANNEL', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCHANNELSYN', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCHNLDOC', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCHNLFLOW', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCONFIG', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCONTACT', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCONTENTEXTFIELD', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCONTENTLINK', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMCONTGRP', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMDOCBAK', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMDOCKIND', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMDOCREPLY', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMDOCSYN', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMDOCUMENT', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMEVENT', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMEVENTSHARE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMEVENTTYPE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMEXPIRATION', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMEXTFIELD', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFILETYPE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFLOW', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFLOWACTION', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFLOWBRANCH', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFLOWDOC', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMFLOWDOCBAK', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFLOWEMPLOY', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMFLOWNODE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMFOLDERPUBLISHCONFIG', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMGROUP', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMGRPUSER', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMID', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMJOB', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMLOG', '5963', '10');
INSERT INTO `wcmid` VALUES ('WCMLOGTYPE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMMARKKIND', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMMARKSHARE', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMMEETINGCONT', '0', '10');
INSERT INTO `wcmid` VALUES ('WCMMEETINGROOM', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMMEETINGUSER', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMMESSAGE', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMMSGQUEUE', '0', '10');
INSERT INTO `wcmid` VALUES ('WCMMSGRECEIVER', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMOPER', '0', '1');
INSERT INTO `wcmid` VALUES ('wcmopertype', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMPUBLISHDISTRIBUTION', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMPUBLISHERRORLOG', '99', '1');
INSERT INTO `wcmid` VALUES ('WCMPUBLISHTASK', '21', '1');
INSERT INTO `wcmid` VALUES ('WCMPUBSTATUSCONFIG', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMRECENT', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMRELATION', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMREPLACE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMRIGHT', '0', '5');
INSERT INTO `wcmid` VALUES ('WCMRIGHTDEF', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMROLE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMROLEUSER', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMSCHEDULE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMSECURITY', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMSITEUSER', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMSOURCE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMSTATUS', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMTAGBEANS', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMTASK', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMTASKPOOL', '0', '2');
INSERT INTO `wcmid` VALUES ('WCMTEMPAPDREL', '31', '1');
INSERT INTO `wcmid` VALUES ('WCMTEMPAPPENDIX', '20', '1');
INSERT INTO `wcmid` VALUES ('WCMTEMPLATE', '46', '1');
INSERT INTO `wcmid` VALUES ('WCMTEMPLATEEMPLOY', '74', '2');
INSERT INTO `wcmid` VALUES ('WCMTEMPLATEQUOTE', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMTRUSTEEINFO', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMUSER', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMUSERSETTING', '0', '1');
INSERT INTO `wcmid` VALUES ('WCMWEBSITE', '0', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLL', '0', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLLBLOCK', '0', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLLCFG', '3', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLLINGDATA', '0', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLLINGLOG', '0', '1');
INSERT INTO `wcmid` VALUES ('XWCMPOLLITEM', '0', '1');

-- ----------------------------
-- Table structure for `wcmjob`
-- ----------------------------
DROP TABLE IF EXISTS `wcmjob`;
CREATE TABLE `wcmjob` (
  `JOBID` int(11) NOT NULL,
  `OPERTYPE` int(11) NOT NULL,
  `PARAMS` varchar(200) DEFAULT NULL,
  `STATUS` smallint(6) NOT NULL,
  `STARTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EXPIRETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LASTEXETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `FAILCOUNT` smallint(6) NOT NULL,
  `TIMEUSED` int(11) NOT NULL,
  `PRIORITY` smallint(6) NOT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SENDERTYPE` int(11) NOT NULL,
  `SENDERID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmjob
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmjobexeresult`
-- ----------------------------
DROP TABLE IF EXISTS `wcmjobexeresult`;
CREATE TABLE `wcmjobexeresult` (
  `RESULTID` int(11) NOT NULL,
  `JOBSCHEDULEID` int(11) NOT NULL,
  `JOBFAIELDROOTCAUSE` varchar(500) NOT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmjobexeresult
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmlog`
-- ----------------------------
DROP TABLE IF EXISTS `wcmlog`;
CREATE TABLE `wcmlog` (
  `LOGID` int(11) NOT NULL,
  `LOGTYPE` int(11) NOT NULL,
  `LOGDESC` varchar(3000) DEFAULT NULL,
  `LOGOBJNAME` varchar(3000) DEFAULT NULL,
  `LOGOBJTYPE` int(11) DEFAULT NULL,
  `LOGOBJID` int(11) DEFAULT NULL,
  `LOGOPTYPE` int(11) DEFAULT NULL,
  `LOGOPARGS` varchar(1000) DEFAULT NULL,
  `LOGRESULT` smallint(6) DEFAULT NULL,
  `LOGUSER` varchar(50) DEFAULT NULL,
  `LOGOPTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ATTRIBUTE` varchar(1000) DEFAULT NULL,
  `PARENTID` int(11) NOT NULL DEFAULT '0',
  `STIMEMILLIS` decimal(30,0) DEFAULT NULL,
  `ETIMEMILLIS` decimal(30,0) DEFAULT NULL,
  `EXECTIME` decimal(30,0) DEFAULT NULL,
  `LOGUSERIP` varchar(50) DEFAULT NULL,
  `TOPID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmlog
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmlogbak`
-- ----------------------------
DROP TABLE IF EXISTS `wcmlogbak`;
CREATE TABLE `wcmlogbak` (
  `LOGBAKID` int(11) NOT NULL,
  `BAKUSER` varchar(50) DEFAULT NULL,
  `BAKTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LOGUSERIP` varchar(50) DEFAULT NULL,
  `TOPID` int(11) DEFAULT NULL,
  `LOGID` int(11) NOT NULL,
  `LOGTYPE` int(11) NOT NULL,
  `LOGDESC` varchar(3000) DEFAULT NULL,
  `LOGOBJNAME` varchar(3000) DEFAULT NULL,
  `LOGOBJTYPE` int(11) DEFAULT NULL,
  `LOGOBJID` int(11) DEFAULT NULL,
  `LOGOPTYPE` int(11) DEFAULT NULL,
  `LOGOPARGS` varchar(1000) DEFAULT NULL,
  `LOGRESULT` smallint(6) DEFAULT NULL,
  `LOGUSER` varchar(50) DEFAULT NULL,
  `LOGOPTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ATTRIBUTE` varchar(1000) DEFAULT NULL,
  `PARENTID` int(11) NOT NULL,
  `STIMEMILLIS` decimal(30,0) DEFAULT NULL,
  `ETIMEMILLIS` decimal(30,0) DEFAULT NULL,
  `EXECTIME` decimal(30,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmlogbak
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmlogtype`
-- ----------------------------
DROP TABLE IF EXISTS `wcmlogtype`;
CREATE TABLE `wcmlogtype` (
  `LOGTYPEID` smallint(6) NOT NULL,
  `TYPENAME` varchar(50) NOT NULL,
  `TYPEDISP` varchar(50) DEFAULT NULL,
  `TYPEDESC` varchar(200) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmlogtype
-- ----------------------------
INSERT INTO `wcmlogtype` VALUES ('1', '系统日志', '系统日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('2', '安全日志', '安全日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('3', '工作流日志', '工作流日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('4', '发布日志', '发布日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('5', 'Jobserver日志', 'Jobserver日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('6', '操作异常日志', '操作异常日志', '', 'admin', '2002-01-01 00:00:00');
INSERT INTO `wcmlogtype` VALUES ('7', '其他应用日志', '其他应用日志', '', 'admin', '2002-01-01 00:00:00');

-- ----------------------------
-- Table structure for `wcmoper`
-- ----------------------------
DROP TABLE IF EXISTS `wcmoper`;
CREATE TABLE `wcmoper` (
  `OPERID` int(11) NOT NULL,
  `PARAM` varchar(200) DEFAULT NULL,
  `OPNAME` varchar(50) DEFAULT NULL,
  `OPDESC` varchar(200) DEFAULT NULL,
  `OPBEAN` varchar(200) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmoper
-- ----------------------------
INSERT INTO `wcmoper` VALUES ('1', 'REMINDTYPE=提醒类型', '信息提醒', '用于执行提醒的Job Worker', 'com.trs.components.common.reminder.Reminder', 'admin', '2002-06-21 00:00:00');
INSERT INTO `wcmoper` VALUES ('2', 'FLAG=文件类型&EXPIRE=删除第几天前的文件', '临时目录计划清理', '用于临时目录的清理', 'com.trs.components.common.job.TempPathCleaner', 'admin', '2002-06-21 00:00:00');
INSERT INTO `wcmoper` VALUES ('4', '对象类型=ObjType&对象ID=ObjId', '计划发布', '用于站点、频道以及文档的计划发布', 'com.trs.components.wcm.publish.domain.job.PublishJobWorker', 'admin', '2002-06-21 00:00:00');
INSERT INTO `wcmoper` VALUES ('5', '', '频道分发', '频道向设定的源频道分发文档', 'com.trs.components.wcm.content.domain.ChnlSynWorker', 'admin', '2002-06-21 00:00:00');
INSERT INTO `wcmoper` VALUES ('6', 'CHNLDOCID=频道文档ID', '撤销文档的置顶', '在定义的时间点上将文档从置顶状态撤下来', 'com.trs.components.wcm.content.domain.DocPriDisableWorker', 'admin', '2005-04-04 00:00:00');
INSERT INTO `wcmoper` VALUES ('7', '', '统计数据的自动执行', '每天将需要进行统计的数据自动产生到临时表中', 'com.trs.components.wcm.stat.StatAutoRunWorker', 'admin', '2005-04-24 00:00:00');
INSERT INTO `wcmoper` VALUES ('10', '', '系统定时优化', '用于维护系统的冗余数据', 'com.trs.components.common.job.OptimizeSystemWorker', 'system', '2003-06-18 15:10:51');
INSERT INTO `wcmoper` VALUES ('100', '', '自定义JOB WORKER的起始', '', '', null, '2020-10-15 14:58:13');
INSERT INTO `wcmoper` VALUES ('101', 'PATHTYPE=目录类型\\&EXPIRE=删除第几天前', '定时清理广告临时目录', '仅用于广告临时目录的清理', 'com.trs.components.adintrs.helper.AdTempPathCleaner', null, '2020-10-15 14:58:13');
INSERT INTO `wcmoper` VALUES ('102', null, '生成广告位脚本', '仅用于广告脚本的生成', 'com.trs.components.adintrs.helper.AdPublishJobWorker', null, '2020-10-15 14:58:13');

-- ----------------------------
-- Table structure for `wcmoperationbean`
-- ----------------------------
DROP TABLE IF EXISTS `wcmoperationbean`;
CREATE TABLE `wcmoperationbean` (
  `OPERATIONBEANID` int(11) NOT NULL,
  `BEANNAME` varchar(50) NOT NULL,
  `BEANPATH` varchar(60) NOT NULL,
  `OPERATIONDESC` varchar(200) DEFAULT NULL,
  `PARAMETERS` varchar(1000) NOT NULL,
  `SETURL` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmoperationbean
-- ----------------------------
INSERT INTO `wcmoperationbean` VALUES ('16', '消息通知指定的人员', 'com.trs.components.wcm.process.OperNotifyUsers', '系统自动发送消息通知指定的人员', '<operation version=\"1.0\">\n	<parameters>\n		<parameter>\n			<name>TOUSERS</name>\n			<type>1</type>\n			<typedesc>文本</typedesc>\n			<maxlength>300</maxlength>\n			<SETURL>../test/select_user.jsp</SETURL>\n			<desc>指定的用户</desc>\n		</parameter>\n		<parameter>\n			<name>NOTIFYTYPE</name>\n			<type>1</type>\n			<typedesc>数字</typedesc>\n			<maxlength></maxlength>\n			<SETURL>select_notify_type.html</SETURL>\n			<desc>通知的方式</desc>\n		</parameter>\n		<parameter>\n			<name>MESSAGETEMPLATE</name>\n			<type>1</type>\n			<typedesc>文本</typedesc>\n			<maxlength>400</maxlength>\n			<SETURL>select_message_template.html</SETURL>\n			<desc>消息的格式</desc>\n		</parameter>\n	</parameters></operation>', '/wcm/flowserver/default_set_operation.html');
INSERT INTO `wcmoperationbean` VALUES ('17', '消息通知处理人', 'com.trs.components.wcm.process.OperNotifyHandler', '系统自动发送消息通知文档的当前处理人', '<operation version=\"1.0\">\n	<parameters>\n		<parameter>\n			<name>NOTIFYTYPE</name>\n			<type>1</type>\n			<typedesc>数字</typedesc>\n			<maxlength></maxlength>\n			<SETURL>select_notify_type.html</SETURL>\n			<desc>通知方式</desc>\n		</parameter>\n		<parameter>\n			<name>MESSAGETEMPLATE</name>\n			<type>1</type>\n			<typedesc>文本</typedesc>\n			<maxlength></maxlength>\n			<SETURL>select_message_template.html</SETURL>\n			<desc>消息的模板</desc>\n		</parameter>\n	</parameters></operation>', '/wcm/flowserver/default_set_operation.html');
INSERT INTO `wcmoperationbean` VALUES ('18', '移交到其它栏目', 'com.trs.components.wcm.process.OperTransmitToChannel', '移交到其它栏目', '<operation version=\"1.0\">\n	<parameters>\n		<parameter>\n			<name>CHANNELID</name>\n			<type>1</type>\n			<typedesc>数字</typedesc>\n			<maxlength></maxlength>\n			<SETURL>../test/select_channel.jsp?Single=1&amp;Norm=1</SETURL>\n			<desc>移交的栏目</desc>\n		</parameter>\n	</parameters></operation>', '/wcm/flowserver/default_set_operation.html');
INSERT INTO `wcmoperationbean` VALUES ('19', '强制结束', 'com.trs.cms.process.operation.ForceDocToEnd', '强制结束', '<operation version=\"1.0\">\n<parameters>\n</parameters></operation>', '/wcm/flowserver/default_set_operation.html');
INSERT INTO `wcmoperationbean` VALUES ('20', '自动呈送到下一个节点', 'com.trs.cms.process.operation.OperAutoToNextNode', '自动呈送到下一个节点', '<operation version=\"1.0\">\n	<parameters>\n		<parameter>\n			<name>TOUSERS</name>\n			<type>1</type>\n			<typedesc>文本</typedesc>\n			<maxlength>100</maxlength>\n			<SETURL>test/select_user.jsp</SETURL>\n			<desc>处理人</desc>\n		</parameter>\n		<parameter>\n			<name>NODENAME</name>\n			<type>1</type>\n			<typedesc>文本</typedesc>\n			<maxlength>100</maxlength>\n			<SETURL>select_node.html</SETURL>\n			<desc>下一节点</desc>\n		</parameter>\n	</parameters></operation>', '/wcm/flowserver/default_set_operation.html');

-- ----------------------------
-- Table structure for `wcmopertype`
-- ----------------------------
DROP TABLE IF EXISTS `wcmopertype`;
CREATE TABLE `wcmopertype` (
  `OPERTYPEID` int(11) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `OPERTYPEDESC` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CRUSER` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmopertype
-- ----------------------------
INSERT INTO `wcmopertype` VALUES ('1', 'SITE_ADD', '新建站点', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('2', 'SITE_DEL', '删除站点', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('3', 'SITE_EDIT', '修改站点属性', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('4', 'CHANNEL_ADD', '新建频道', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('5', 'CHANNEL_DEL', '删除频道', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('6', 'CHANNEL_EDIT', '修改频道属性', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('7', 'DOCUMENT_ADD', '新建文档', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('8', 'DOCUMENT_DEL', '删除文档', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('9', 'DOCUMENT_EDIT', '编辑文档', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('10', 'CONTENTLINK_ADD', '新建内容超链接', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('11', 'CONTENTLINK_DEL', '删除内容超链接', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('12', 'CONTENTLINK_EDIT', '修改内容超链接', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('13', 'EXTENTEDFIELD_DEL', '删除扩展字段', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('14', 'EXTENTEDFIELD_EDIT', '修改扩展字段', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('15', 'REPLACE_ADD', '新建替换内容', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('16', 'REPLACE_DEL', '删除替换内容', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('17', 'REPLACE_EDIT', '修改替换内容', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('18', 'CHANNEL_RESTORE', '恢复频道', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('19', 'CHANNEL_MOVE', '移动频道', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('20', 'DOCUMENT_COPY', '文档复制', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('21', 'USER_EDIT', '修改用户信息', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('22', 'USER_MOVE', '用户组织变更', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('23', 'ROLEUSER_DEL', '取消用户担任的角色', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('24', 'GROUPUSER_ADD', '新建组织中的用户', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('25', 'GROUPUSER_DEL', '删除组织中的用户', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('26', 'GROUP_ADD', '新建组织', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('27', 'GROUP_DEL', '删除组织', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('28', 'ROLEUSR_ADD', '新建用户担任的角色', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('29', 'ROLE_ADD', '新建角色', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('30', 'ROLE_DEL', '删除角色', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('31', 'USER_DISABLE', '停用用户', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('32', 'USER_RESTORE', '恢复用户', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('33', 'USER_DEL', '用户删除', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('34', 'ROLEUSER_ADD', '添加用户担任的角色', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('35', 'CMSOBJ_ADD', '新建替换内容', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('36', 'CMSOBJ_ADD', '新增CMSObj', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('37', 'CMSOBJ_UPDATE', '修改更新CMSObj', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('38', 'CMSOBJ_DEL', '删除CMSObj', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('39', 'USER_LOGIN', '用户登录', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('40', 'USER_LOGOUT', '用户退出', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('41', 'SITE_RESTORE', '恢复站点', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('42', 'FLOW_START', '开始流转', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('43', 'DISTRIBUTION_DELETE', '删除分发', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('44', 'DISTRIBUTION_ENABLE', '启用分发', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('45', 'DISTRIBUTION_DISABLE', '禁用分发', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('46', 'DISTRIBUTION_SAVE', '保存分发', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('47', 'PUBLISH_SETTING', '发布配置', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('48', 'SCHEDULE_DELETE', '删除计划', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('49', 'SCHEDULE_FIND', '查找计划', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('50', 'SCHEDULE_SAVE', '保存计划', '2005-07-07 13:47:17', 'admin');
INSERT INTO `wcmopertype` VALUES ('51', 'GROUPUSER_ADMINADD', '指定组管理员', '2005-10-17 11:16:27', 'admin');
INSERT INTO `wcmopertype` VALUES ('52', 'GROUPUSER_ADMINDEL', '取消组管理员', '2005-10-17 11:16:27', 'admin');
INSERT INTO `wcmopertype` VALUES ('53', 'USER_ADD', '新建用户', '2005-10-17 11:16:27', 'admin');
INSERT INTO `wcmopertype` VALUES ('54', 'USER_ENABLE', '开通帐号', '2005-10-17 11:16:27', 'admin');

-- ----------------------------
-- Table structure for `wcmpublishconfig`
-- ----------------------------
DROP TABLE IF EXISTS `wcmpublishconfig`;
CREATE TABLE `wcmpublishconfig` (
  `PUBLISHCONFIGID` int(11) NOT NULL,
  `OBJTYPE` int(11) NOT NULL,
  `OBJID` int(11) NOT NULL,
  `OUTLINEPREFIX` varchar(100) DEFAULT NULL,
  `OUTLINEEXT` varchar(50) DEFAULT NULL,
  `DETAILEXT` varchar(50) DEFAULT NULL,
  `STATUSAFTERUPDATE` int(11) NOT NULL,
  `STATUSIDSALLOWPUB` varchar(200) DEFAULT NULL,
  `SCHEDULEID` int(11) DEFAULT NULL,
  `OUTLINETEMPLATEID` int(11) DEFAULT NULL,
  `DETAILTEMPLATEID` int(11) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmpublishconfig
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmpublishdistribution`
-- ----------------------------
DROP TABLE IF EXISTS `wcmpublishdistribution`;
CREATE TABLE `wcmpublishdistribution` (
  `PUBLISHDISTRIBUTIONID` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `TARGETTYPE` varchar(50) NOT NULL,
  `TARGETSERVER` varchar(200) DEFAULT NULL,
  `LOGINUSER` varchar(50) DEFAULT NULL,
  `LOGINPASSWORD` varchar(20) DEFAULT NULL,
  `DATAPATH` varchar(200) NOT NULL,
  `ENABLED` tinyint(4) NOT NULL,
  `CRUSER` varchar(30) NOT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmpublishdistribution
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmpublisherrorlog`
-- ----------------------------
DROP TABLE IF EXISTS `wcmpublisherrorlog`;
CREATE TABLE `wcmpublisherrorlog` (
  `PUBLISHERRORLOGID` int(11) NOT NULL,
  `PUBLISHTASKID` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `CONTENTTYPE` int(11) NOT NULL,
  `CONTENTID` int(11) NOT NULL,
  `PAGETASKDESC` varchar(400) DEFAULT NULL,
  `EXERESULT` int(11) NOT NULL,
  `ERRORDETAIL` varchar(4000) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmpublisherrorlog
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmpublishtask`
-- ----------------------------
DROP TABLE IF EXISTS `wcmpublishtask`;
CREATE TABLE `wcmpublishtask` (
  `PUBLISHTASKID` int(11) NOT NULL,
  `PUBLISHTYPE` int(11) NOT NULL,
  `TASKPRIORITY` int(11) NOT NULL,
  `TASKSTATUS` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `CONTENTIDS` varchar(400) DEFAULT NULL,
  `TASKTITLE` varchar(400) NOT NULL,
  `TASKDESC` varchar(3000) DEFAULT NULL,
  `STARTTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ENDTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIMEUSED` int(11) NOT NULL,
  `PAGETASKCOUNT` int(11) NOT NULL,
  `HASWARNINGS` smallint(6) DEFAULT NULL,
  `ANALYZEERROR` varchar(2000) DEFAULT NULL,
  `CRUSER` varchar(30) NOT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CONTENTTYPE` int(11) NOT NULL,
  `TASKURL` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmpublishtask
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmpubstatusconfig`
-- ----------------------------
DROP TABLE IF EXISTS `wcmpubstatusconfig`;
CREATE TABLE `wcmpubstatusconfig` (
  `WCMPUBSTATUSCONFIGID` int(11) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `STATUSESCANDOPUB` varchar(50) DEFAULT NULL,
  `STATUSIDAFTERMODIFY` int(11) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmpubstatusconfig
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmright`
-- ----------------------------
DROP TABLE IF EXISTS `wcmright`;
CREATE TABLE `wcmright` (
  `RIGHTID` int(11) NOT NULL,
  `OBJTYPE` int(11) NOT NULL,
  `OBJID` int(11) NOT NULL,
  `OPRTYPE` int(11) NOT NULL,
  `OPRID` int(11) NOT NULL,
  `RIGHTVALUE` decimal(30,0) DEFAULT NULL,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmright
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmrightdef`
-- ----------------------------
DROP TABLE IF EXISTS `wcmrightdef`;
CREATE TABLE `wcmrightdef` (
  `RIGHTDEFID` int(11) NOT NULL,
  `OBJTYPE` int(11) NOT NULL,
  `RIGHTINDEX` tinyint(4) NOT NULL,
  `RIGHTNAME` varchar(50) NOT NULL,
  `RIGHTDESC` varchar(200) DEFAULT NULL,
  `SYSDEFINED` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmrightdef
-- ----------------------------
INSERT INTO `wcmrightdef` VALUES ('1', '101', '30', '查看文档列表', '可以在频道上设置浏览文档权限', '1');
INSERT INTO `wcmrightdef` VALUES ('2', '103', '30', '查看文档列表', '可以在站点上设置浏览文档权限', '1');
INSERT INTO `wcmrightdef` VALUES ('3', '101', '21', '新建模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('4', '101', '22', '删除模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('5', '101', '23', '编辑模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('6', '101', '24', '导入模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('7', '101', '25', '导出模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('10', '101', '29', '预览模板', '', '1');
INSERT INTO `wcmrightdef` VALUES ('145', '103', '1', '修改站点', null, '1');
INSERT INTO `wcmrightdef` VALUES ('146', '103', '2', '删除站点', null, '1');
INSERT INTO `wcmrightdef` VALUES ('147', '103', '3', '预览站点', null, '1');
INSERT INTO `wcmrightdef` VALUES ('148', '103', '4', '高级发布站点', null, '1');
INSERT INTO `wcmrightdef` VALUES ('149', '103', '5', '快速发布站点', null, '1');
INSERT INTO `wcmrightdef` VALUES ('150', '103', '6', '设定站点用户', null, '1');
INSERT INTO `wcmrightdef` VALUES ('151', '101', '11', '新建频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('152', '101', '12', '删除频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('153', '101', '13', '修改频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('154', '101', '14', '浏览频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('155', '101', '15', '预览频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('156', '101', '16', '高级发布频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('157', '101', '17', '快速发布频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('166', '605', '31', '新建文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('167', '605', '32', '编辑文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('168', '605', '33', '删除文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('169', '605', '34', '查看文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('170', '605', '35', '置为新稿或已编', null, '1');
INSERT INTO `wcmrightdef` VALUES ('171', '605', '36', '置为已否或返工', null, '1');
INSERT INTO `wcmrightdef` VALUES ('172', '605', '37', '置为已签或正审', null, '1');
INSERT INTO `wcmrightdef` VALUES ('173', '605', '38', '预览文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('174', '605', '39', '发布文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('179', '103', '11', '新建频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('180', '103', '12', '删除频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('181', '103', '13', '修改频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('182', '103', '14', '浏览频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('183', '103', '15', '预览频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('184', '103', '16', '高级发布频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('185', '103', '17', '快速发布频道', null, '1');
INSERT INTO `wcmrightdef` VALUES ('186', '103', '21', '新建模板', null, '1');
INSERT INTO `wcmrightdef` VALUES ('187', '103', '22', '删除模板', null, '1');
INSERT INTO `wcmrightdef` VALUES ('188', '103', '23', '编辑模板', null, '1');
INSERT INTO `wcmrightdef` VALUES ('189', '103', '24', '导入模板', null, '1');
INSERT INTO `wcmrightdef` VALUES ('190', '103', '25', '导出模板', null, '1');
INSERT INTO `wcmrightdef` VALUES ('194', '103', '31', '新建文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('195', '103', '32', '编辑文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('196', '103', '33', '删除文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('197', '103', '34', '查看文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('198', '103', '35', '置为新稿或已编', null, '1');
INSERT INTO `wcmrightdef` VALUES ('199', '103', '36', '置为已否或返工', null, '1');
INSERT INTO `wcmrightdef` VALUES ('200', '103', '37', '置为已签或正审', null, '1');
INSERT INTO `wcmrightdef` VALUES ('201', '103', '38', '预览文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('202', '103', '39', '发布文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('204', '103', '41', '新建工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('205', '103', '42', '编辑工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('206', '103', '43', '删除工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('207', '101', '31', '新建文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('208', '101', '32', '编辑文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('209', '101', '33', '删除文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('210', '101', '34', '查看文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('211', '101', '35', '置为新稿或已编', null, '1');
INSERT INTO `wcmrightdef` VALUES ('212', '101', '36', '置为已否或返工', null, '1');
INSERT INTO `wcmrightdef` VALUES ('213', '101', '37', '置为已签或正审', null, '1');
INSERT INTO `wcmrightdef` VALUES ('214', '101', '38', '预览文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('215', '101', '39', '发布文档', null, '1');
INSERT INTO `wcmrightdef` VALUES ('216', '103', '18', '管理回收站', null, '1');
INSERT INTO `wcmrightdef` VALUES ('217', '101', '41', '新建工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('218', '101', '42', '编辑工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('219', '101', '43', '删除工作流', null, '1');
INSERT INTO `wcmrightdef` VALUES ('222', '103', '29', '模板预览', null, '1');
INSERT INTO `wcmrightdef` VALUES ('223', '101', '19', '扩展字段', '', '1');
INSERT INTO `wcmrightdef` VALUES ('224', '101', '18', '管理回收站', '', '1');
INSERT INTO `wcmrightdef` VALUES ('225', '103', '44', '导出工作流', '', '1');
INSERT INTO `wcmrightdef` VALUES ('226', '103', '45', '导入工作流', '', '1');
INSERT INTO `wcmrightdef` VALUES ('229', '103', '19', '扩展字段', '', '1');
INSERT INTO `wcmrightdef` VALUES ('230', '1', '46', '维护文档来源', '维护文档来源', '1');
INSERT INTO `wcmrightdef` VALUES ('231', '1', '47', '维护文档状态', '维护文档状态', '1');
INSERT INTO `wcmrightdef` VALUES ('232', '1', '48', '管理发布组件', '管理发布组件', '1');
INSERT INTO `wcmrightdef` VALUES ('233', '1', '49', '管理日程类型', '管理日程类型', '1');
INSERT INTO `wcmrightdef` VALUES ('234', '1', '50', '管理安全级别', '管理安全级别', '1');
INSERT INTO `wcmrightdef` VALUES ('235', '1', '51', '维护权限定义', '维护权限定义', '1');
INSERT INTO `wcmrightdef` VALUES ('236', '1', '52', '维护操作类型', '维护操作类型', '1');

-- ----------------------------
-- Table structure for `wcmrole`
-- ----------------------------
DROP TABLE IF EXISTS `wcmrole`;
CREATE TABLE `wcmrole` (
  `ROLEID` int(11) NOT NULL,
  `ROLENAME` varchar(50) NOT NULL,
  `ROLEDESC` varchar(200) DEFAULT NULL,
  `EMAIL` varchar(200) DEFAULT NULL,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SYSDEFINED` int(11) NOT NULL,
  `VIEWABLE` smallint(6) NOT NULL,
  `REMOVEABLE` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmrole
-- ----------------------------
INSERT INTO `wcmrole` VALUES ('1', 'Administrators', '系统管理员', '', null, 'admin', '2002-08-12 00:00:00', '1', '1', '0');
INSERT INTO `wcmrole` VALUES ('2', 'Everyone', '系统中每个成员', null, null, 'admin', '2002-08-12 00:00:00', '1', '0', '0');
INSERT INTO `wcmrole` VALUES ('3', '网络会议管理员', '', '', '', 'admin', '2002-08-12 00:00:00', '1', '1', '1');
INSERT INTO `wcmrole` VALUES ('4', '站点管理员', '管理WCM的站点及站点下所有的频道', '', null, 'admin', '2002-08-13 15:12:48', '0', '1', '1');
INSERT INTO `wcmrole` VALUES ('5', '频道管理员', '管理指定频道及所属的子频道', '', null, 'admin', '2002-08-13 15:13:47', '0', '1', '1');

-- ----------------------------
-- Table structure for `wcmroleuser`
-- ----------------------------
DROP TABLE IF EXISTS `wcmroleuser`;
CREATE TABLE `wcmroleuser` (
  `ROLEID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ROLEUSERID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmroleuser
-- ----------------------------
INSERT INTO `wcmroleuser` VALUES ('1', '1', 'system', '2002-01-11 14:56:45', '1');
INSERT INTO `wcmroleuser` VALUES ('4', '2', 'admin', '2002-08-13 15:13:08', '2');
INSERT INTO `wcmroleuser` VALUES ('5', '4', 'admin', '2002-08-13 15:14:00', '3');
INSERT INTO `wcmroleuser` VALUES ('5', '3', 'admin', '2002-08-13 15:14:00', '4');
INSERT INTO `wcmroleuser` VALUES ('5', '5', 'admin', '2002-08-13 15:14:01', '5');
INSERT INTO `wcmroleuser` VALUES ('5', '6', 'admin', '2002-08-13 15:14:01', '6');
INSERT INTO `wcmroleuser` VALUES ('5', '7', 'admin', '2002-08-13 15:14:01', '7');
INSERT INTO `wcmroleuser` VALUES ('1', '4', 'admin', '2005-08-30 11:04:49', '8');

-- ----------------------------
-- Table structure for `wcmschedule`
-- ----------------------------
DROP TABLE IF EXISTS `wcmschedule`;
CREATE TABLE `wcmschedule` (
  `SCHID` int(11) NOT NULL,
  `SCHNAME` varchar(50) NOT NULL,
  `SCHDESC` varchar(200) DEFAULT NULL,
  `OPTYPE` int(11) NOT NULL,
  `OPARGS` varchar(1000) DEFAULT NULL,
  `SCHMODE` smallint(6) NOT NULL,
  `SDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EDATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PARAM` int(11) DEFAULT NULL,
  `ATTRIBUTE` varchar(1000) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LASTEXETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LASTEXERES` smallint(6) DEFAULT NULL,
  `LASTTIMEUSED` int(11) NOT NULL,
  `SENDERTYPE` int(11) NOT NULL,
  `SENDERID` int(11) NOT NULL,
  `SCHSTATUS` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmschedule
-- ----------------------------
INSERT INTO `wcmschedule` VALUES ('1', '清除广告上传目录', 'NULL', '101', 'PATHTYPE=3&EXPIRE=1', '1', '2005-11-18 02:10:00', '2005-11-18 23:00:00', '2005-11-17 16:15:00', '6', null, null, '2020-10-15 14:58:13', '2020-10-15 14:58:13', null, '0', '0', '0', '1');
INSERT INTO `wcmschedule` VALUES ('2', '清除广告预览目录', 'NULL', '101', 'PATHTYPE=1&EXPIRE=1', '1', '2005-11-18 02:10:00', '2005-11-18 23:00:00', '2005-11-17 16:15:00', '6', null, null, '2020-10-15 14:58:13', '2020-10-15 14:58:13', null, '0', '0', '0', '1');
INSERT INTO `wcmschedule` VALUES ('3', '生成广告发布脚本', 'NULL', '102', 'http://localhost:8080/adintrs/adintrs/', '2', '2005-11-18 00:10:00', '2005-11-18 23:00:00', '2005-11-18 23:59:00', '360', null, null, '2020-10-15 14:58:13', '2005-11-18 12:59:00', null, '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `wcmsecurity`
-- ----------------------------
DROP TABLE IF EXISTS `wcmsecurity`;
CREATE TABLE `wcmsecurity` (
  `SECURITYID` int(11) NOT NULL,
  `SNAME` varchar(50) NOT NULL,
  `SDESC` varchar(200) DEFAULT NULL,
  `SDISP` varchar(200) DEFAULT NULL,
  `SVALUE` smallint(6) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmsecurity
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmtagbeans`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtagbeans`;
CREATE TABLE `wcmtagbeans` (
  `TAGBEANID` int(11) NOT NULL,
  `TAGNAME` varchar(50) NOT NULL,
  `TAGBEAN` varchar(400) NOT NULL,
  `TAGDESC` varchar(200) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ENABLED` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtagbeans
-- ----------------------------
INSERT INTO `wcmtagbeans` VALUES ('1000', 'TRS_POLLPROP', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollProperty', 'Property for poll', 'admin', '2005-06-20 00:00:00', '1');
INSERT INTO `wcmtagbeans` VALUES ('1001', 'TRS_POLL', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPolls', 'Collection for polls', 'admin', '2005-06-20 00:00:00', '1');
INSERT INTO `wcmtagbeans` VALUES ('1002', 'TRS_POLLBLOCK', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollBlock', 'Shell for poll block', 'admin', '2005-06-22 09:27:33', '1');
INSERT INTO `wcmtagbeans` VALUES ('1003', 'TRS_POLLBLOCKS', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollBlocks', 'Collection for poll blocks', 'admin', '2005-06-22 09:27:34', '1');
INSERT INTO `wcmtagbeans` VALUES ('1004', 'TRS_POLLITEM', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollItem', 'Shell and property for poll item', 'admin', '2005-06-22 09:27:34', '1');
INSERT INTO `wcmtagbeans` VALUES ('1005', 'TRS_POLLITEMS', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollItems', 'Collection for poll item', 'admin', '2005-06-23 17:26:35', '1');
INSERT INTO `wcmtagbeans` VALUES ('1006', 'TRS_POLLCOMMAND', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollCommand', 'Shell and property for poll command', 'admin', '2005-06-30 17:41:13', '1');
INSERT INTO `wcmtagbeans` VALUES ('1007', 'TRS_POLLBLOCKGROUP', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollBlockGroup', 'Shell for poll block group', 'admin', '2005-07-22 09:27:33', '1');
INSERT INTO `wcmtagbeans` VALUES ('1008', 'TRS_POLLBLOCKGROUPPROP', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollBlockGroupProperty', 'Property for poll block group', 'admin', '2005-07-22 09:27:33', '1');
INSERT INTO `wcmtagbeans` VALUES ('1009', 'TRS_POLLBLOCKPROP', 'com.trs.components.poll.publish.tagparser.XWCMTagParserPollBlockProperty', 'Property for poll block', 'admin', '2005-07-22 09:27:33', '1');

-- ----------------------------
-- Table structure for `wcmtempapdrel`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtempapdrel`;
CREATE TABLE `wcmtempapdrel` (
  `TEMPID` int(11) NOT NULL,
  `APPENDIXID` int(11) NOT NULL,
  `RECID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtempapdrel
-- ----------------------------
INSERT INTO `wcmtempapdrel` VALUES ('2', '3', '1');
INSERT INTO `wcmtempapdrel` VALUES ('4', '2', '3');
INSERT INTO `wcmtempapdrel` VALUES ('5', '5', '4');
INSERT INTO `wcmtempapdrel` VALUES ('6', '3', '5');
INSERT INTO `wcmtempapdrel` VALUES ('6', '4', '6');
INSERT INTO `wcmtempapdrel` VALUES ('7', '1', '7');
INSERT INTO `wcmtempapdrel` VALUES ('7', '3', '8');
INSERT INTO `wcmtempapdrel` VALUES ('7', '6', '9');
INSERT INTO `wcmtempapdrel` VALUES ('7', '7', '10');
INSERT INTO `wcmtempapdrel` VALUES ('8', '3', '11');
INSERT INTO `wcmtempapdrel` VALUES ('9', '2', '12');
INSERT INTO `wcmtempapdrel` VALUES ('37', '12', '19');
INSERT INTO `wcmtempapdrel` VALUES ('37', '13', '20');
INSERT INTO `wcmtempapdrel` VALUES ('37', '14', '21');
INSERT INTO `wcmtempapdrel` VALUES ('39', '12', '22');
INSERT INTO `wcmtempapdrel` VALUES ('39', '15', '23');
INSERT INTO `wcmtempapdrel` VALUES ('39', '14', '24');
INSERT INTO `wcmtempapdrel` VALUES ('42', '16', '25');
INSERT INTO `wcmtempapdrel` VALUES ('42', '17', '26');
INSERT INTO `wcmtempapdrel` VALUES ('42', '18', '27');
INSERT INTO `wcmtempapdrel` VALUES ('44', '16', '28');
INSERT INTO `wcmtempapdrel` VALUES ('44', '19', '29');
INSERT INTO `wcmtempapdrel` VALUES ('44', '18', '30');

-- ----------------------------
-- Table structure for `wcmtempappendix`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtempappendix`;
CREATE TABLE `wcmtempappendix` (
  `TEMPAPPENDIXID` int(11) NOT NULL,
  `APDFILE` varchar(256) NOT NULL,
  `APDFLAG` int(11) NOT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ROOTTYPE` int(11) NOT NULL,
  `ROOTID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtempappendix
-- ----------------------------
INSERT INTO `wcmtempappendix` VALUES ('1', 'top1.gif', '3', 'admin', '2002-11-28 11:59:39', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('2', 'logo.gif', '3', 'admin', '2002-11-28 11:59:39', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('3', 'banner2002.gif', '3', 'admin', '2002-11-28 11:59:39', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('4', 'snow1127.gif', '3', 'admin', '2002-11-28 11:59:39', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('5', 'banner2002(1).gif', '3', 'admin', '2002-11-28 11:59:39', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('6', 'topphoto.gif', '3', 'admin', '2002-11-28 11:59:40', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('7', 'title1.gif', '3', 'admin', '2002-11-28 11:59:40', '103', '1');
INSERT INTO `wcmtempappendix` VALUES ('16', 'fil_151x61.gif', '3', 'admin', '2020-10-15 14:58:13', '20000', '1');
INSERT INTO `wcmtempappendix` VALUES ('17', 'graymarket_97x72.jpg', '3', 'admin', '2020-10-15 14:58:13', '20000', '1');
INSERT INTO `wcmtempappendix` VALUES ('18', 'bite-yellow.gif', '3', 'admin', '2020-10-15 14:58:13', '20000', '1');
INSERT INTO `wcmtempappendix` VALUES ('19', 'apple_video.jpg', '3', 'admin', '2020-10-15 14:58:13', '20000', '1');

-- ----------------------------
-- Table structure for `wcmtemplate`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtemplate`;
CREATE TABLE `wcmtemplate` (
  `TEMPID` int(11) NOT NULL,
  `TEMPNAME` varchar(50) NOT NULL,
  `TEMPDESC` varchar(200) DEFAULT NULL,
  `TEMPEXT` varchar(50) DEFAULT NULL,
  `TEMPTEXT` text,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `APDMODIFIED` smallint(6) NOT NULL,
  `TEMPTYPE` smallint(6) NOT NULL,
  `TEMPFORMID` int(11) DEFAULT NULL,
  `ISPARSED` smallint(6) NOT NULL,
  `FOLDERTYPE` int(11) NOT NULL,
  `ROOTID` int(11) NOT NULL,
  `FOLDERID` int(11) NOT NULL,
  `ROOTTYPE` int(11) NOT NULL,
  `OUTPUTFILENAME` varchar(50) DEFAULT NULL,
  `USERNAME` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtemplate
-- ----------------------------
INSERT INTO `wcmtemplate` VALUES ('1', '多媒体细览', null, '', '<HTML>\n<HEAD>\n<META http-equiv=\"Content-Language\" content=\"zh-cn\">\n<META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">\n<TITLE>-[ <TRS_DOCUMENT FIELD=\"docTitle\">标题</TRS_DOCUMENT>]-</TITLE>\n<STYLE type=text/css>.unnamed1 {\n FONT-SIZE: 9pt; COLOR: #ffffff; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\n.sstable {\n BORDER-RIGHT: 1px dotted; BORDER-TOP: #cccccc 1px dotted; FONT-SIZE: 9pt; BORDER-LEFT: 1px dotted; BORDER-BOTTOM: 1px dotted; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\n.ss2 {\n BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-SIZE: 9pt; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\n.s3 {\n BORDER-RIGHT: 1px dotted; BORDER-TOP: #cccccc 0px dotted; FONT-SIZE: 9pt; BORDER-LEFT: 1px dotted; BORDER-BOTTOM: 1px dotted; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\nA:link {\n FONT-SIZE: 9pt; COLOR: #ffffff; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\nA:hover {\n  FONT-SIZE: 9pt; COLOR: #ffcc66; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: underline\n}\nA:visited {\n FONT-SIZE: 9pt; COLOR: darkgray; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none\n}\n</STYLE>\n<SCRIPT language=javascript> \nfunction setUrl(){\n var arrAttaches = id_attaches.getElementsByTagName(\"a\");\n if( arrAttaches.length==0 ) return;\n var objMedia = arrAttaches[0];\n var str = objMedia.href;\n //alert( str );\n \n str = str.replace( /9000/g , \"9001\" );\n //alert ( str ); \n videoie.Open( str );\n}\n</SCRIPT>\n</HEAD>\n<BODY text=#ffffff vLink=#ffffff aLink=#cc9933 link=#ffffff bgColor=#000000 \nleftMargin=0 topMargin=0 onload=\"setUrl();\">\n\n<DIV class=unnamed1 align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=344 border=0 height=\"802\">\n  <TBODY>\n  <TR>\n    <TD valign=\"top\" align=\"right\">\n      <DIV align=right>　</DIV>\n      <DIV align=right>　</DIV>\n      <DIV align=right>　</DIV></TD>\n    <TD valign=\"top\"></TD></TR>\n  <TR>\n    <TD width=500 height=\"628\">\n      <DIV align=center style=\"width: 493; height: 748\">\n      <TABLE width=\"100%\" border=0>\n        <TBODY>\n        <TR align=middle>\n              <TD vAlign=top colSpan=2 height=\"356\"> \n                <DIV align=center style=\"width: 483; height: 2\">\n            <TABLE class=unnamed1 cellSpacing=0 cellPadding=0 \n            width=\"100%\" bordercolor=\"#CC9933\">\n              <TBODY>\n              <TR vAlign=center>\n                <TD class=sstable  bgColor=#cc9933 bordercolor=\"#CC9933\">\n                  <DIV class=unnamed1 align=center>\n                    <p align=\"left\"> <TRS_CURPAGE VALUE=\" -&gt; \"> 首页-〉栏目 </TRS_CURPAGE></p></DIV></TD>\n              </TR>\n              </TBODY></TABLE><BR></DIV>                 \n            <TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=\"481\">                 \n              <TBODY>                 \n              <TR vAlign=center>                 \n                <TD class=sstable align=center bgColor=#cc9933 >                 \n                  <DIV align=center width=\"481\">       \n                    <p align=\"center\">-[ <TRS_DOCUMENT FIELD=\"docTitle\">标题</TRS_DOCUMENT>]-</DIV></TD>                  \n              </TR>                \n              <TR class=unnamed1 >                \n                  <DIV align=center width=\"481\">       \n                <TD class=s3 width=\"481\" align=center>  \n<div align=left>\n<BR><BR>\n<TRS_DOCUMENT AUTOFORMAT=\"True\" FIELD=\"docContent\">DocContent</TRS_DOCUMENT> \n</div>\n<BR><BR>\n<span id=\"id_attaches\">\n<TRS_APPENDIX EXTRA=\"ID=objMedia\">文档附件</TRS_APPENDIX> </SPAN>\n\n<table width=\"320\" border=\"0\" height=\"286\" cellpadding=\"0\" cellspacing=\"0\">\n<tr><td align=\"center\">\n<object id=\"videoie\" width=\"320\" height=\"286\" classid=\"CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95\" \n  codebase=\"http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701\" \n  standby=\"Loading Microsoft?Windows?Media Player components...\" \n  type=\"application/x-oleobject\">\n <param name=\"ShowStatusBar\" value=\"False\">\n <param name=\"AutoSize\" VALUE=\"0\">\n <param name=\"DisplaySize\" value=\"0\">\n <param name=\"ShowAudioControls\" value=\"True\">\n embed type=\"application/x-mplayer2\" pluginspage = \"http://www.microsoft.com/Windows/MediaPlayer/\" name=\"videoNN\" width=\"320\" height=\"286\" showstatusbar=\"0\" showaudiocontrols=\"true\" autosize=\"false\" displaysize=\"false\">\n </embed>\n</object> \n</td>\n</tr>\n</table>\n<BR><BR>\n<p align=left>\n<font color=gray>\n注：WMV格式可能需要下载解码插件，下载需要时间，可能会出现暂停现象。\n请安装新插件完毕后，刷新本页。\n</font>\n</p>\n                  </TD>            \n        </DIV>\n              </TR></TBODY></TABLE>\n                <br>\n                <br>\n              </TD>     \n            </TR></TBODY></TABLE>\n      <p><BR> <BR><BR><!-- BEGIN CHINA BPATH BANNER EXCHANGE CODE -->                 \n      <CENTER>                 \n      </p>\n      <TABLE cellSpacing=1 cellPadding=0 border=0>                 \n        <TBODY>                 \n        <TR>                 \n          <TD bgColor=#0000ff>&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>                \n        <TR>                \n          <TD><font face=\"宋体\" size=\"2\">本站采用TRS WCM 生成</font></TD></TR></TBODY></TABLE></CENTER>\n      <P><SPAN class=unnamed1><SPAN class=unnamed1>               \n      </SPAN></SPAN></P>               \n      <P>&nbsp;</P></DIV></TD>               \n    <TD vAlign=top width=180 background=\"../../backimages/rbar_bg.gif\" >               \n <BR>\n<table border=\"0\" width=\"100%\">\n        <tr class=unnamed1>\n          <td width=\"100\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n          <td width=\"280\">\n            <p align=\"left\">\n<font color=white>\n   <TRS_OUTLINE NUM=\"8\">\n    ◆<TRS_DOCUMENT FIELD=\"docTitle\"> DocTitle </TRS_DOCUMENT><BR>\n   </TRS_OUTLINE>\n</font>\n   </p>\n  </td>\n        </tr>\n      </table>\n \n      <table border=\"0\" width=\"100%\">\n        <tr class=unnamed1>\n          <td width=\"100\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n          <td width=\"143%\">\n            <p align=\"left\">\n <TRS_RELNEWS>  \n  ■<TRS_DOCUMENT FIELD=\"docTitle\">标题</TRS_DOCUMENT></li><BR>  \n </TRS_RELNEWS>  \n </p>\n </td>\n        </tr>\n      </table>\n      <P align=left></P>       \n      <table border=\"0\" width=\"100%\">\n        <tr class=unnamed1>\n          <td width=\"100\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n          <td width=\"143%\">\n          </td>\n        </tr>\n      </table></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '2', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('2', '通用细览(多语种)', '', 'htm', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><TITLE></TITLE></HEAD><BODY><DIV align=center><IMG height=\'60\' src=\'/wcmdemo/images/banner2002.gif\' width=\'468\' OLDSRC=\'banner2002.gif\' OLDID=\'3\' RELATED=\'1\'></DIV>\n<DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE height=80 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE style=\"BACKGROUND-IMAGE: url(/images/table_bgcolor.gif); BACKGROUND-REPEAT: repeat-y; BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top>\n<TABLE class=tablebg1 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=612>\n<TABLE cellSpacing=0 cellPadding=0 width=\"100%\" border=0>\n<TBODY>\n<TR>\n<TD class=font1 style=\"HEIGHT: 23px\" bgColor=#dcdcdc height=23><FONT color=#ffff00>&nbsp; <FONT style=\"COLOR: blue\"><TRS_CURPAGE VALUE=\"->\">当前位置</TRS_CURPAGE></FONT></FONT></TD></TR></TBODY></TABLE>\n<P>&nbsp;</P>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=10 cellPadding=5 width=\"100%\" border=0>\n<TBODY>\n<TR>\n<TD vAlign=top align=middle>\n<CENTER><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></CENTER><BR>&nbsp; \n<HR color=#009efd SIZE=1>\n<TRS_DOCUMENT FIELD=\"DOCPUBTIME\">发布时间</TRS_DOCUMENT><FONT style=\"FONT-SIZE: 10.8pt; LINE-HEIGHT: 150%\"><!--enpcontent--><FONT face=宋体>\n<P align=left><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCHTMLCON\">HTML文本</TRS_DOCUMENT></FONT></P></FONT><!--/enpcontent--><BR></FONT></TD></TR>\n<TR>\n<TD align=right><SPAN class=font3><FONT face=宋体 size=2>【</FONT><A class=texthotline href=\"<TRS_COMMENT POSTTARGET=\"http://sina.com.cn\"></TRS_COMMENT>\"><FONT face=宋体 color=#0099cc size=2>发表评论</FONT></A><FONT face=宋体 size=2>】</FONT></SPAN><SPAN class=font3><FONT face=宋体 size=2>【</FONT><A class=texthotline onclick=self.close() href=\"http://www.southcn.com/news/hktwma/hot/200208130187.htm#\"><FONT face=宋体 color=#0099cc size=2>关闭窗口</FONT></A><FONT face=宋体 size=2>】</FONT></SPAN></TD></TR></TBODY></TABLE>\n<TABLE class=NOBORDER cellSpacing=2 cellPadding=1 width=600>\n<TBODY>\n<TR>\n<TD bgColor=#edf0f5>&nbsp;<SPAN class=font1><FONT face=宋体 color=#000000 size=2>相关新闻</FONT></SPAN></TD></TR>\n<TR>\n<TD bgColor=#edf0f5>&nbsp; <TRS_RELNEWS>\n<LI><FONT style=\"COLOR: blue; FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT><FONT style=\"FONT-SIZE: 9pt\"><TRS_DOCUMENT FIELD=\"DOCPUBTIME\">[发布时间]</TRS_DOCUMENT></FONT></LI></TRS_RELNEWS></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>\n<TABLE class=NOBORDER style=\"WIDTH: 602px; HEIGHT: 30px\" cellSpacing=2 cellPadding=1 width=602>\n<TBODY>\n<TR>\n<TD align=middle bgColor=#dcdcdc>\n<P align=center><FONT color=#0066ff><FONT color=#0066ff>&nbsp;<STRONG><FONT color=#0033ff>&copy; 2001 TRS&nbsp;All rights reserved</FONT></STRONG>&nbsp;&nbsp;</FONT>&nbsp;</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '2', '0', '1', '103', '1', '1', '103', '', null);
INSERT INTO `wcmtemplate` VALUES ('4', '通用概览(多语种)', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><STYLE type=\'text/css\'>\na\n{\nFONT-FAMILY: Courier New;\nfont-size:9pt;\n}\ntd\n{\nfont-size:9pt;\n}\n</STYLE>\n<TITLE></TITLE></HEAD><BODY><DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE height=80 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=160 bgColor=#dbf0f4>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=160 bgColor=#dbf0f4 border=0>\n<TBODY>\n<TR>\n<TD class=font1 align=middle bgColor=#668fbd height=23>频道列表</TD></TR>\n<TR>\n<TD align=middle></TD></TR></TBODY></TABLE></DIV><TRS_CHANNELS ID=\"PARENT\">\n<LI><FONT color=#a52a2a size=2><TRS_CHANNEL FIELD=\"CHNLNAME\" AUTOLINK=\"true\"></TRS_CHANNEL></FONT></LI></TRS_CHANNELS></TD>\n<TD vAlign=top align=right width=610>\n<TABLE cellSpacing=0 cellPadding=0 width=590 border=0>\n<TBODY>\n<TR>\n<TD class=font1 style=\"HEIGHT: 23px\" bgColor=#dcdcdc colSpan=2 height=23><FONT color=#ffff00>&nbsp; <FONT style=\"COLOR: blue\"><TRS_CURPAGE>当前位置</TRS_CURPAGE></FONT></FONT></TD></TR>\n<TR>\n<TD vAlign=top width=550 height=12>\n<P>&nbsp;</P>\n<P><IMG src=\'/wcmdemo/images/logo.gif\' OLDSRC=\'logo.gif\' OLDID=\'2\' RELATED=\'1\'><HR>\n</TD>\n<TD width=75 height=12></TD></TR>\n<TR>\n<TD vAlign=top><TRS_OUTLINE MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"COLOR: blue\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT><FONT style=\"FONT-SIZE: 9pt\"><TRS_DOCUMENT FIELD=\"DOCPUBTIME\">[发布时间]</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE>\n<P>&nbsp;</P>\n<P>&nbsp;</P></TD></TR>\n<TR>\n<TD width=550 height=20></TD>\n<TD width=75 height=20></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>\n<TABLE id=AutoNumber1 style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=0 cellPadding=0 width=770 border=1>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<HR style=\"WIDTH: 775px; HEIGHT: 2px\" SIZE=2>\n</DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 778px; HEIGHT: 30px\" cellSpacing=2 cellPadding=1 width=778>\n<TBODY>\n<TR>\n<TD align=middle bgColor=#dcdcdc>\n<P align=center><FONT color=#0066ff><FONT color=#0066ff>&nbsp;<STRONG><FONT color=#0033ff>&copy; 2001 TRS&nbsp;All rights reserved</FONT></STRONG>&nbsp;&nbsp;</FONT>&nbsp;</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P></TD></TR></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '1', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('5', '通用细览(2)', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><TITLE></TITLE></HEAD><BODY><DIV align=center><IMG height=\'60\' src=\'/wcmdemo/images/banner2002(1).gif\' width=\'460\' OLDSRC=\'banner2002(1).gif\' OLDID=\'5\' RELATED=\'1\'><TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE height=80 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE style=\"BACKGROUND-IMAGE: url(/images/table_bgcolor.gif); BACKGROUND-REPEAT: repeat-y; BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top>\n<TABLE class=tablebg1 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=612>\n<TABLE cellSpacing=0 cellPadding=0 width=\"100%\" border=0>\n<TBODY>\n<TR>\n<TD class=font1 bgColor=#838181 height=23><FONT color=#ffff00>&nbsp;<FONT style=\"COLOR: blue\"><TRS_CURPAGE VALUE=\"->\">当前位置</TRS_CURPAGE></FONT></FONT></TD></TR></TBODY></TABLE>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=10 cellPadding=5 width=\"100%\" bgColor=#ffffcc border=0>\n<TBODY>\n<TR>\n<TD vAlign=top>\n<CENTER><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></CENTER>\n<HR color=#009efd SIZE=1>\n&nbsp;<BR>&nbsp; <TRS_DOCUMENT FIELD=\"DOCPUBTIME\">发布时间</TRS_DOCUMENT><FONT style=\"FONT-SIZE: 10.8pt; LINE-HEIGHT: 150%\"><!--enpcontent-->\n<P><FONT face=宋体><FONT face=宋体><TRS_DOCUMENT FIELD=\"DOCHTMLCON\">HTML文本</TRS_DOCUMENT></FONT></FONT></P><!--/enpcontent--><BR></FONT></TD></TR>\n<TR>\n<TD align=right><SPAN class=font3><FONT face=宋体 size=2>【</FONT><A class=texthotline onclick=self.close() href=\"http://www.southcn.com/news/hktwma/hot/200208130187.htm#\"><FONT face=宋体 color=#0066ff size=2>关闭窗口</FONT></A><FONT face=宋体 size=2>】</FONT></SPAN></TD></TR>\n<TR>\n<TD>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#6699cc cellSpacing=0 cellPadding=0 width=\"100%\" border=1>\n<TBODY>\n<TR>\n<TD width=\"100%\" bgColor=#6699cc><SPAN class=font1><FONT face=宋体 color=#ffffff size=2>相关新闻</FONT></SPAN></TD></TR></TBODY></TABLE><TRS_RELNEWS>\n<LI><FONT style=\"COLOR: blue\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT><FONT style=\"FONT-SIZE: 9pt\"><TRS_DOCUMENT FIELD=\"DOCPUBTIME\">发布时间</TRS_DOCUMENT></FONT></LI></TRS_RELNEWS></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>\n<TABLE cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD class=tablebg2 height=21>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><IMG height=\'0\' src=\'./200208130187.htm&amp;class_id=新闻\' width=\'0\'></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '2', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('6', '演示站点首页', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><META name=\"GENERATOR\" content=\"Microsoft FrontPage 4.0\"><META name=\"ProgId\" content=\"FrontPage.Editor.Document\"><TITLE></TITLE></HEAD><BODY><DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 bgColor=#ffffff border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY>\n<TR>\n<TD><FONT face=宋体 size=2></FONT></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY>\n<TR>\n<TD style=\"WIDTH: 130px\" vAlign=top align=middle width=218 bgColor=#ffcf60>&nbsp;&nbsp;&nbsp; \n<TABLE cellSpacing=0 cellPadding=0 width=140 border=0>\n<TBODY>\n<TR>\n<TD width=10 bgColor=#a30909 height=21><IMG height=\'21\' src=\'/wcmdemo/images/snow1127.gif\' width=\'10\' OLDSRC=\'snow1127.gif\' OLDID=\'4\' RELATED=\'1\'></TD>\n<TD align=middle width=130 bgColor=#a30909><A href=\"http://www.sina.com.cn/corp/intr-event.html\" target=_blank><FONT color=#ffffff>频道列表</FONT></A></TD></TR></TBODY></TABLE>\n<P><TRS_CHANNELS ID=\"PARENT\">\n<LI><FONT color=#0000ff size=2><TRS_CHANNEL FIELD=\"CHNLNAME\" AUTOLINK=\"true\"></TRS_CHANNEL></FONT></LI></TRS_CHANNELS>\n<P></P></TD>\n<TD class=font3 style=\"WIDTH: 555px\" vAlign=top width=555 bgColor=white>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=555 bgColor=#ffffff background=images/bg2.gif border=0>\n<TBODY>\n<TR>\n<TD></TD>\n<TD vAlign=top bgColor=white>\n<P><SPAN class=font2><STRONG><IMG style=\'WIDTH: 432px; HEIGHT: 60px\' height=\'60\' src=\'/wcmdemo/images/banner2002.gif\' width=\'518\' OLDSRC=\'banner2002.gif\' OLDID=\'3\' RELATED=\'1\'></STRONG></SPAN></P></TD></TR></TBODY></TABLE></DIV>\n<P><SPAN class=font2><STRONG></STRONG></SPAN><SPAN class=font2><STRONG>\n<TABLE class=NOBORDER style=\"WIDTH: 442px; HEIGHT: 231px\" cellSpacing=2 cellPadding=1 width=442>\n<TBODY>\n<TR>\n<TD>&nbsp; \n<TABLE class=NOBORDER style=\"WIDTH: 305px; HEIGHT: 97px\" cellSpacing=2 cellPadding=1 align=left>\n<TBODY>\n<TR>\n<TD bgColor=#cc0101><SPAN class=font2><STRONG><FONT color=#ffffff>头条新闻</FONT></STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE CHANNELTYPE=\"2\">\n<LI><FONT color=#0000ff size=2><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></TD></TR>\n<TR>\n<TD>\n<DIV align=left>\n<TABLE class=NOBORDER style=\"WIDTH: 307px; HEIGHT: 97px\" cellSpacing=2 cellPadding=1 width=307 align=left>\n<TBODY>\n<TR>\n<TD bgColor=#cc0101><SPAN class=font2><STRONG><FONT color=#ffffff>外文稿件</FONT></STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE ID=\"混合频道\" MORETEXT=\"更多内容...\" NUM=\"5\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT face=Arial color=#0000ff size=2><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></DIV></TD></TR></TBODY></TABLE></P>\n<P>\n<TABLE cellSpacing=0 cellPadding=0 width=306 bgColor=#e7ebf7 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE class=NOBORDER style=\"WIDTH: 529px; HEIGHT: 154px\" cellSpacing=2 cellPadding=1 width=529>\n<TBODY>\n<TR>\n<TD borderColor=#abb6db bgColor=#e7ebf7>&nbsp; <TRS_OUTLINE CHANNELTYPE=\"1\" NUM=\"1\">\n<TABLE id=TRS_OUTLINE style=\"WIDTH: 522px; HEIGHT: 108px\" borderColor=#ffffff cellSpacing=0 cellPadding=0 border=1 type=\"_TRSPICNEWS\" styleType=\"1\" bFontSize=\"FALSE\">\n<TBODY>\n<TR>\n<TD id=td0 colSpan=2></TD></TR>\n<TR>\n<TD id=td1 rowSpan=2><TRS_APPENDIX BEGINMEMO=\"<BR>\" MODE=\"PIC\">概览图片</TRS_APPENDIX></TD></TR>\n<TR>\n<TD><FONT style=\"COLOR: red\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT><TRS_DOCUMENT FIELD=\"DOCABSTRACT\">摘要</TRS_DOCUMENT></TD></TR></TBODY></TABLE></TRS_OUTLINE></TD></TR></TBODY></TABLE><!--结束第5块_图文--><!--开始第5块_图文2--></P></STRONG></SPAN></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<HR style=\"WIDTH: 773px; HEIGHT: 2px\" SIZE=2>\n</DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 778px; HEIGHT: 30px\" cellSpacing=2 cellPadding=1 width=778>\n<TBODY>\n<TR>\n<TD align=middle bgColor=#dcdcdc>\n<P align=left><FONT color=#0066ff><FONT color=#0066ff>&nbsp;<STRONG><FONT color=#0033ff>&copy; 2001 TRS&nbsp;All rights reserved</FONT></STRONG>&nbsp;&nbsp;</FONT>&nbsp;</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P></TD></TR></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '1', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('7', '新闻中心首页', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><TITLE></TITLE>\n<STYLE type=\'text/css\'>\na\n{\nfont-size:9pt;\n}\ntd\n{\nfont-size:9pt;\n}\n</STYLE>\n</HEAD><BODY><DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 bgColor=#ffffff border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY>\n<TR>\n<TD><FONT face=宋体 size=2><IMG height=\'18\' src=\'/wcmdemo/images/top1.gif\' width=\'773\' OLDSRC=\'top1.gif\' OLDID=\'1\' RELATED=\'1\'></FONT></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=218 bgColor=#f1fafc>\n<TABLE cellSpacing=0 cellPadding=0 width=218 border=0>\n<TBODY>\n<TR>\n<TD><FONT face=宋体 size=2><IMG height=\'128\' src=\'/wcmdemo/images/topphoto.gif\' width=\'218\' OLDSRC=\'topphoto.gif\' OLDID=\'6\' RELATED=\'1\'></FONT></TD></TR>\n<TR>\n<TD bgColor=#ffffff><FONT face=宋体 size=2><IMG height=\'41\' src=\'/wcmdemo/images/title1.gif\' width=\'205\' OLDSRC=\'title1.gif\' OLDID=\'7\' RELATED=\'1\'></FONT></TD></TR></TBODY></TABLE><TRS_OUTLINE ID=\"滚动新闻\" MORETEXT=\"更多内容...\" NUM=\"10\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"COLOR: brown; FONT-FAMILY: Arial\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT>[<FONT style=\"FONT-SIZE: 9pt\"><TRS_DOCUMENT FIELD=\"DOCPUBTIME\" DATEFORMAT=\"HH:MM\">发布时间</TRS_DOCUMENT></FONT>]</LI></TRS_OUTLINE></TD>\n<TD class=font3 vAlign=top width=555 bgColor=#ffffff>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=555 bgColor=#ffffff background=images/bg2.gif border=0>\n<TBODY>\n<TR>\n<TD></TD>\n<TD vAlign=top bgColor=white>\n<P><SPAN class=font2><STRONG><IMG style=\'WIDTH: 432px; HEIGHT: 60px\' height=\'60\' src=\'/wcmdemo/images/banner2002.gif\' width=\'518\' OLDSRC=\'banner2002.gif\' OLDID=\'3\' RELATED=\'1\'></STRONG></SPAN></P></TD></TR></TBODY></TABLE></DIV>\n<P><SPAN class=font2><STRONG></STRONG></SPAN><SPAN class=font2><STRONG>\n<TABLE class=NOBORDER style=\"WIDTH: 442px; HEIGHT: 604px\" cellSpacing=2 cellPadding=1 width=442>\n<TBODY>\n<TR>\n<TD>&nbsp; \n<TABLE class=NOBORDER style=\"WIDTH: 305px; HEIGHT: 136px\" cellSpacing=2 cellPadding=1 align=left>\n<TBODY>\n<TR>\n<TD bgColor=#999999><SPAN class=font2><STRONG>［<A href=\"ITxw/\">IT新闻</A>］</STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE ID=\"IT新闻\" MORETEXT=\"更多内容...\" AUTOMORE=\"TRUE\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></TD></TR>\n<TR>\n<TD>\n<DIV align=left>\n<TABLE class=NOBORDER style=\"WIDTH: 307px; HEIGHT: 135px\" cellSpacing=2 cellPadding=1 width=307 align=left>\n<TBODY>\n<TR>\n<TD bgColor=#999999><SPAN class=font2><STRONG>［<A href=\"tyxw/\">体育新闻</A>］</STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE ID=\"体育新闻\" MORETEXT=\"更多内容...\" AUTOMORE=\"TRUE\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></DIV></TD></TR>\n<TR>\n<TD>\n<DIV align=left>\n<TABLE class=NOBORDER style=\"WIDTH: 309px; HEIGHT: 115px\" cellSpacing=2 cellPadding=1 align=left>\n<TBODY>\n<TR>\n<TD bgColor=#999999><SPAN class=font2><STRONG>［<A href=\"cjxw/\">财经新闻</A>］</STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE ID=\"财经新闻\" MORETEXT=\"更多内容...\" AUTOMORE=\"TRUE\" NUM=\"6\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></DIV></TD></TR>\n<TR>\n<TD>&nbsp; \n<DIV align=left>\n<TABLE class=NOBORDER style=\"WIDTH: 310px; HEIGHT: 135px\" cellSpacing=2 cellPadding=1 width=310>\n<TBODY>\n<TR>\n<TD align=left bgColor=#999999>&nbsp;<SPAN class=font2><STRONG>［<A href=\"ylxw\">娱乐新闻</A>］</STRONG></SPAN></TD></TR>\n<TR>\n<TD align=left><TRS_OUTLINE ID=\"娱乐新闻\" MORETEXT=\"更多内容...\" AUTOMORE=\"TRUE\" NUM=\"6\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></LI></TRS_OUTLINE></TD></TR></TBODY></TABLE></DIV></TD></TR></TBODY></TABLE></P>\n<P>&nbsp;</P></STRONG></SPAN></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<HR style=\"WIDTH: 777px; HEIGHT: 2px\" SIZE=2>\n</DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 778px; HEIGHT: 30px\" cellSpacing=2 cellPadding=1 width=778>\n<TBODY>\n<TR>\n<TD align=middle bgColor=#dcdcdc>\n<P align=center><FONT color=#0066ff><FONT color=#0066ff>&nbsp;<STRONG><FONT color=#0033ff>&copy; 2001 TRS&nbsp;All rights reserved</FONT></STRONG>&nbsp;&nbsp;</FONT>&nbsp;</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P></TD></TR></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '1', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('8', '外文稿件首页(2)', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><STYLE type=\'text/css\'>\na\n{\nfont-size:9pt;\n}\ntd\n{\nfont-size:9pt;\n}\n</STYLE>\n<TITLE></TITLE></HEAD><BODY><DIV align=center>\n<TABLE class=NOBORDER cellSpacing=2 cellPadding=1 align=center>\n<TBODY>\n<TR></TR>\n<TR></TR>\n<TR>\n<TD><IMG style=\'WIDTH: 588px; HEIGHT: 60px\' height=\'60\' src=\'/wcmdemo/images/banner2002.gif\' width=\'594\' OLDSRC=\'banner2002.gif\' OLDID=\'3\' RELATED=\'1\'>&nbsp;</TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 600px; HEIGHT: 77px\" cellSpacing=2 cellPadding=1 width=600>\n<TBODY>\n<TR>\n<TD>&nbsp; \n<TABLE cellSpacing=0 cellPadding=0 width=590 border=0>\n<TBODY>\n<TR>\n<TD class=font1 style=\"HEIGHT: 23px\" bgColor=#dcdcdc colSpan=2 height=23><FONT color=#ffff00>&nbsp;<FONT style=\"COLOR: blue\"><TRS_CURPAGE>当前位置</TRS_CURPAGE></FONT></FONT></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE class=NOBORDER cellSpacing=2 cellPadding=1 width=600>\n<TBODY>\n<TR></TR>\n<TR></TR>\n<TR>\n<TD><STRONG>[<FONT color=#0033ff>混合频道</FONT>]</STRONG> <FONT face=宋体 size=2><TRS_OUTLINE ID=\"混合频道\" MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></FONT></TD></TR>\n<TR>\n<TD><STRONG><FONT color=#0033ff><FONT color=#000000>[</FONT>韩文</FONT><FONT color=#000000>]</FONT></STRONG><FONT face=宋体 size=2><TRS_OUTLINE ID=\"韩文\" MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></FONT></TD></TR>\n<TR>\n<TD><STRONG>[<FONT color=#0033ff>日本语</FONT>]&nbsp; </STRONG><FONT face=宋体 size=2><TRS_OUTLINE ID=\"日本语\" MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></FONT></TD></TR>\n<TR></TR>\n<TR>\n<TD><STRONG>[<FONT color=#0033ff>阿拉伯文</FONT>]</STRONG> <FONT face=宋体 size=2><TRS_OUTLINE ID=\"阿拉伯文\" MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"FONT-FAMILY: Courier New\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE></FONT></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>&nbsp;</DIV>\n<DIV align=center>\n<HR width=600 height=\"1\">\n</DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 600px\" cellSpacing=2 cellPadding=1 bgColor=#dcdcdc>\n<TBODY>\n<TR>\n<TD align=middle>\n<P align=center>&nbsp;<STRONG>由TRS WCM生成</STRONG></P></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY>\n<TR>\n<TD><FONT face=宋体 size=2>\n<DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE height=80 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top align=right width=610>&nbsp; \n<TABLE cellSpacing=0 cellPadding=0 width=590 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=550 height=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TD>\n<TD width=75 height=12></TD></TR>\n<TR>\n<TD vAlign=top></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE id=AutoNumber1 style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=0 cellPadding=0 width=770 border=1>\n<TBODY></TBODY></TABLE></DIV></FONT><FONT face=宋体 size=2>\n<DIV align=left>&nbsp; \n<TABLE cellSpacing=0 cellPadding=0 width=773 align=left bgColor=#ffffff border=0>\n<TBODY><STRONG></STRONG></TBODY></TABLE></DIV></FONT></TD></TR></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=773 border=0>\n<TBODY></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '1', '0', '1', '103', '1', '1', '103', null, null);
INSERT INTO `wcmtemplate` VALUES ('9', '通用概览', null, '', '<HTML><HEAD><META http-equiv=\"Content-Language\" content=\"zh-cn\"><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><STYLE type=\'text/css\'>\na\n{\nfont-size:9pt;\n}\ntd\n{\nfont-size:9pt;\n}\n</STYLE>\n<TITLE></TITLE></HEAD><BODY><DIV align=center>\n<TABLE style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 height=20 cellSpacing=0 cellPadding=0 width=770 bgColor=#3d4371 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE height=80 cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY></TBODY></TABLE>\n<TABLE cellSpacing=0 cellPadding=0 width=770 border=0>\n<TBODY>\n<TR>\n<TD vAlign=top width=160 bgColor=#dbf0f4>\n<DIV align=center>\n<TABLE cellSpacing=0 cellPadding=0 width=160 bgColor=#dbf0f4 border=0>\n<TBODY>\n<TR>\n<TD class=font1 align=middle bgColor=#668fbd height=23>滚动新闻</TD></TR>\n<TR>\n<TD align=middle></TD></TR></TBODY></TABLE></DIV><FONT style=\"FONT-SIZE: 9pt\"><TRS_OUTLINE ID=\"滚动新闻\" MORETEXT=\"更多内容...\" NUM=\"10\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></LI></TRS_OUTLINE></FONT></TD>\n<TD vAlign=top align=right width=610>\n<TABLE cellSpacing=0 cellPadding=0 width=590 border=0>\n<TBODY>\n<TR>\n<TD class=font1 style=\"HEIGHT: 23px\" bgColor=#dbf0f4 colSpan=2 height=23><FONT color=#ffff00><IMG src=\'/wcmdemo/images/logo.gif\' OLDSRC=\'logo.gif\' OLDID=\'2\' RELATED=\'1\'>&nbsp; </FONT></TD></TR>\n<TR>\n<TD style=\"WIDTH: 550px; HEIGHT: 12px\" vAlign=top width=550 bgColor=white height=12>\n<P>&nbsp;<FONT style=\"COLOR: blue\"><TRS_CURPAGE>当前位置</TRS_CURPAGE></FONT></P>\n<HR>\n</TD>\n<TD width=75 height=12></TD></TR>\n<TR>\n<TD vAlign=top bgColor=white><TRS_OUTLINE MORETEXT=\"更多内容...\" BEGINMORE=\"<P ALIGN=RIGHT>\">\n<LI><FONT style=\"COLOR: blue\"><TRS_DOCUMENT FIELD=\"DOCTITLE\">标题</TRS_DOCUMENT></FONT><FONT style=\"FONT-SIZE: 9pt\"><TRS_DOCUMENT FIELD=\"DOCPUBTIME\">发布时间</TRS_DOCUMENT></FONT></LI></TRS_OUTLINE>\n<P>&nbsp;</P>\n<P>&nbsp;</P></TD></TR>\n<TR>\n<TD width=550 height=20></TD>\n<TD width=75 height=20></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>\n<TABLE id=AutoNumber1 style=\"BORDER-COLLAPSE: collapse\" borderColor=#111111 cellSpacing=0 cellPadding=0 width=770 border=1>\n<TBODY></TBODY></TABLE></DIV>\n<DIV align=center>\n<HR style=\"WIDTH: 801px; HEIGHT: 2px\" SIZE=2>\n</DIV>\n<DIV align=center>\n<TABLE class=NOBORDER style=\"WIDTH: 806px; HEIGHT: 30px\" cellSpacing=2 cellPadding=1 width=806>\n<TBODY>\n<TR>\n<TD align=middle bgColor=#dcdcdc>\n<P align=center><FONT color=#0066ff><FONT color=#0066ff><FONT color=#0000cc>&nbsp;<STRONG>&copy; 2001 TRS&nbsp;All rights reserved</STRONG></FONT>&nbsp;&nbsp;</FONT>&nbsp;</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P></TD></TR></TBODY></TABLE></DIV></BODY>\n</HTML>', null, 'admin', '2020-10-15 15:00:02', '0', '1', '0', '1', '103', '1', '1', '103', null, null);

-- ----------------------------
-- Table structure for `wcmtemplateemploy`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtemplateemploy`;
CREATE TABLE `wcmtemplateemploy` (
  `TEMPLATEEMPLOYID` int(11) NOT NULL,
  `EMPLOYERTYPE` int(11) NOT NULL,
  `EMPLOYERID` int(11) NOT NULL,
  `TEMPLATEID` int(11) NOT NULL,
  `TEMPLATETYPE` smallint(6) NOT NULL,
  `ISDEFAULT` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtemplateemploy
-- ----------------------------
INSERT INTO `wcmtemplateemploy` VALUES ('1', '103', '1', '6', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('2', '101', '1', '8', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('3', '101', '4', '7', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('4', '101', '7', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('6', '101', '8', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('8', '101', '9', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('10', '101', '10', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('11', '101', '10', '2', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('12', '101', '22', '4', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('13', '101', '22', '2', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('14', '101', '23', '4', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('15', '101', '23', '2', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('16', '101', '24', '4', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('17', '101', '24', '2', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('18', '101', '25', '4', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('19', '101', '25', '2', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('20', '101', '26', '8', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('21', '101', '27', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('22', '101', '28', '9', '1', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('23', '101', '28', '5', '2', '1');
INSERT INTO `wcmtemplateemploy` VALUES ('24', '101', '7', '2', '2', '1');

-- ----------------------------
-- Table structure for `wcmtemplatenest`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtemplatenest`;
CREATE TABLE `wcmtemplatenest` (
  `TEMPLATEID` int(11) NOT NULL,
  `NESTEDTEMPLATEID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtemplatenest
-- ----------------------------

-- ----------------------------
-- Table structure for `wcmtemplatequote`
-- ----------------------------
DROP TABLE IF EXISTS `wcmtemplatequote`;
CREATE TABLE `wcmtemplatequote` (
  `TEMPLATEQUOTEID` int(11) NOT NULL,
  `TEMPLATEID` int(11) NOT NULL,
  `TEMPLATETYPE` smallint(6) NOT NULL,
  `QUOTEDFOLDERTYPE` int(11) NOT NULL,
  `QUOTEDFOLDERID` int(11) NOT NULL,
  `FAMILYINDEX` smallint(6) NOT NULL,
  `QUOTETYPE` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmtemplatequote
-- ----------------------------
INSERT INTO `wcmtemplatequote` VALUES ('1', '1', '2', '0', '0', '-2', '5');
INSERT INTO `wcmtemplatequote` VALUES ('5', '4', '1', '0', '0', '-2', '5');
INSERT INTO `wcmtemplatequote` VALUES ('6', '5', '2', '0', '0', '-2', '5');
INSERT INTO `wcmtemplatequote` VALUES ('7', '6', '1', '101', '22', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('8', '7', '1', '101', '27', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('9', '7', '1', '101', '10', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('10', '7', '1', '101', '8', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('11', '7', '1', '101', '7', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('12', '7', '1', '101', '9', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('13', '8', '1', '0', '0', '-2', '5');
INSERT INTO `wcmtemplatequote` VALUES ('14', '8', '1', '101', '22', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('15', '8', '1', '101', '23', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('16', '8', '1', '101', '24', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('17', '8', '1', '101', '25', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('18', '9', '1', '101', '27', '-1', '1');
INSERT INTO `wcmtemplatequote` VALUES ('19', '9', '1', '0', '0', '-2', '5');
INSERT INTO `wcmtemplatequote` VALUES ('25', '2', '2', '0', '0', '-2', '5');

-- ----------------------------
-- Table structure for `wcmuser`
-- ----------------------------
DROP TABLE IF EXISTS `wcmuser`;
CREATE TABLE `wcmuser` (
  `USERID` int(11) NOT NULL,
  `STATUS` tinyint(4) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `NICKNAME` varchar(50) DEFAULT NULL,
  `TRUENAME` varchar(64) DEFAULT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `TEL` varchar(50) DEFAULT NULL,
  `MOBILE` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(1000) DEFAULT NULL,
  `REMINDERQUESTION` varchar(100) DEFAULT NULL,
  `REMINDERANSWER` varchar(100) DEFAULT NULL,
  `IFPUBMYINFO` tinyint(4) DEFAULT NULL,
  `APPLYTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `REGTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LOGINTIMES` int(11) NOT NULL,
  `LOGINTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LOGOUTTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `MSGINTERVAL` smallint(6) DEFAULT NULL,
  `VIEWINTERVAL` smallint(6) DEFAULT NULL,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PRICE` int(11) NOT NULL,
  `ISDELETED` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmuser
-- ----------------------------
INSERT INTO `wcmuser` VALUES ('1', '30', 'admin', 'E79CB0FFE3B66CB', '系统管理员\'', ']系统管理员\'[', 'BEIJING,CHINA', '010-64859900', '', 'wcm@trs.com.cn', 'Who r u?', 'admin', '0', '2020-10-15 14:58:13', '2002-08-12 00:00:00', '269', '2005-11-22 20:27:02', '2020-10-15 14:58:13', null, null, 'LoginIP=127.0.0.1', null, '2002-08-12 00:00:00', '0', '0');

-- ----------------------------
-- Table structure for `wcmusersetting`
-- ----------------------------
DROP TABLE IF EXISTS `wcmusersetting`;
CREATE TABLE `wcmusersetting` (
  `SETTINGID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `OBJTYPE` int(11) NOT NULL,
  `OBJID` int(11) NOT NULL,
  `ATTRIBUTE` varchar(50) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `RANGEINDEX` int(11) DEFAULT NULL,
  `CVALUE` varchar(50) DEFAULT NULL,
  `CRGION` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wcmusersetting
-- ----------------------------

-- ----------------------------
-- Table structure for `websiteconfig`
-- ----------------------------
DROP TABLE IF EXISTS `websiteconfig`;
CREATE TABLE `websiteconfig` (
  `ID` int(11) NOT NULL,
  `WEBNAME` varchar(200) DEFAULT NULL,
  `RSSCONFIGPATH` varchar(200) DEFAULT NULL,
  `WEBURL` varchar(200) DEFAULT NULL,
  `SERVERNAME` varchar(200) NOT NULL,
  `USERNAME` varchar(200) NOT NULL,
  `USERPASSWORD` varchar(50) DEFAULT NULL,
  `FROMADDRESS` varchar(50) NOT NULL,
  `ISAUTH` smallint(6) DEFAULT NULL,
  `ISSSLSERVER` smallint(6) DEFAULT NULL,
  `PORT` int(11) DEFAULT NULL,
  `SENDTIME` int(11) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TEMPLATECONTENT` varchar(4000) DEFAULT NULL,
  `USERDESC` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of websiteconfig
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmadlocation`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadlocation`;
CREATE TABLE `xwcmadlocation` (
  `ADLOCATIONID` int(11) NOT NULL,
  `LOCATION` varchar(50) NOT NULL,
  `CHANNEL` varchar(50) DEFAULT NULL,
  `SIZEDESC` varchar(100) DEFAULT NULL,
  `CPDAY` int(11) DEFAULT NULL,
  `CPWEEK` int(11) DEFAULT NULL,
  `CPMON` int(11) DEFAULT NULL,
  `CPM` int(11) DEFAULT NULL,
  `CPC` int(11) DEFAULT NULL,
  `CFORALL` int(11) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `HEIGHT` int(11) DEFAULT NULL,
  `WIDTH` int(11) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `ADTYPEID` int(11) DEFAULT NULL,
  `USERNAME` varchar(60) NOT NULL DEFAULT 'admin',
  `ISADMIN` int(11) DEFAULT '0',
  PRIMARY KEY (`ADLOCATIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadlocation
-- ----------------------------
INSERT INTO `xwcmadlocation` VALUES ('63', '首页上方', '新闻首页', '', '100', '500', '2000', '100', '100', null, 'admin', '2005-11-18 10:27:55', '200', '500', '网幅广告', '12', 'admin', '1');
INSERT INTO `xwcmadlocation` VALUES ('64', '频道两边', '新闻评论', 'px', '200', '4000', '1000', '200', '300', null, 'admin', '2005-11-18 10:28:34', '300', '200', '网幅广告', '10', 'admin', '1');
INSERT INTO `xwcmadlocation` VALUES ('65', '文档正中', 'IT新闻', 'px', '100', '600', '2500', '100', '100', null, 'admin', '2005-11-18 12:51:25', '100', '100', '弹出插播', '14', 'admin', '1');
INSERT INTO `xwcmadlocation` VALUES ('66', '顶部', '演示站点', 'px', null, null, null, null, null, null, 'admin', '2005-11-18 13:03:31', '100', '100', '网幅广告', '16', 'admin', '1');
INSERT INTO `xwcmadlocation` VALUES ('67', '频道左边', '新闻', '', '200', '500', '2000', '100', '100', null, 'admin', '2005-11-18 13:52:29', '300', '400', '文本链接', '15', 'admin', '1');

-- ----------------------------
-- Table structure for `xwcmadmark`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadmark`;
CREATE TABLE `xwcmadmark` (
  `ADMARKID` int(11) NOT NULL,
  `MARKNAME` varchar(100) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `DATAFIELD` varchar(100) DEFAULT NULL,
  `MARKDESC` varchar(100) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ADMARKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadmark
-- ----------------------------
INSERT INTO `xwcmadmark` VALUES ('1', '${Ads_FileName}', '单个素材', 'adsfilename', '上传文件名', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('2', '${Ads_Ext}', '单个素材', 'adsfileext', '上传文件后缀名', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('3', '${Ads_ShowText}', '单个素材', 'text', '页面显示文字', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('4', '${Ads_ActionUrl}', '单个素材', 'url', '链接路径', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('5', '${Ads_Name}', '单个素材', 'adname', '素材名称', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('6', '${Ads_ID}', '单个素材', 'advertiseId', '素材ID', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('7', '${Array_FileName}', '多个素材', 'adsfilename', '上传文件名数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('8', '${Array_Ext}', '多个素材', 'adsfileext', '上传文件后缀名数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('9', '${Array_ShowText}', '多个素材', 'text', '页面显示文字数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('10', '${Array_ActionUrl}', '多个素材', 'url', '链接路径数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('11', '${Array_Name}', '多个素材', 'adname', '素材名称数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('12', '${Array_ID}', '多个素材', 'advertiseId', '素材ID数组', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('13', '${Adl_Width}', '广告位', 'width', '广告位宽度', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('14', '${Adl_Height}', '广告位', 'height', '广告位高度', null, '2020-10-15 14:58:13');
INSERT INTO `xwcmadmark` VALUES ('15', '${Ads_Num}', '广告位', 'AdsNum', '素材ID数组', null, '2020-10-15 14:58:13');

-- ----------------------------
-- Table structure for `xwcmadtype`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadtype`;
CREATE TABLE `xwcmadtype` (
  `ADTYPEID` int(11) NOT NULL,
  `ADSNAME` varchar(50) DEFAULT NULL,
  `ECODE` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(500) DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIONCODE` text,
  `ISMULTIPLE` smallint(6) DEFAULT '0',
  `USERNAME` varchar(60) NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`ADTYPEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadtype
-- ----------------------------
INSERT INTO `xwcmadtype` VALUES ('5', '弹出窗口广告', 'Pop-up Windows', '在访问网页时，主动弹出的广告窗口', '弹出插播', 'admin', '2005-10-20 11:26:58', '   \n window.open(\'${Ads_ActionUrl}\',\'Advertise\',\'width=${Adl_Width},height=${Adl_Height}\');\n', null, 'admin');
INSERT INTO `xwcmadtype` VALUES ('10', '点击消失的漂浮广告图片', '', '点击消失的漂浮广告图片', '网幅广告', 'admin', '2005-11-10 13:02:21', 'var Ymax=8;                                //MAX # OF PIXEL STEPS IN THE \"X\" DIRECTION\nvar Xmax=8;                                //MAX # OF PIXEL STEPS IN THE \"Y\" DIRECTION\nvar Tmax=10000;                        //MAX # OF MILLISECONDS BETWEEN PARAMETER CHANGES\n\nvar adsfile=${Array_FileName};\n\n//*********DO NOT EDIT BELOW***********\nvar NS4 = (navigator.appName.indexOf(\"Netscape\")>=0 && parseFloat(navigator.appVersion) >= 4 && parseFloat(navigator.appVersion) < 5)? true : false;\nvar IE4 = (document.all)? true : false;\nvar NS6 = (parseFloat(navigator.appVersion) >= 5 && navigator.appName.indexOf(\"Netscape\")>=0 )? true: false;\nvar wind_w, wind_h, t=\'\', IDs=new Array();\nfor(i=0; i<${Ads_Num}; i++){\nt+=(NS4)?\'<layer name=\"pic\'+i+\'\" visibility=\"hide\" width=\"10\" height=\"10\"><a href=\"javascript:hidebutterfly()\">\' : \'<div id=\"pic\'+i+\'\" style=\"position:absolute; visibility:hidden;width:10px; height:10px\"><a href=\"javascript:hidebutterfly()\">\';\nt+=\'<img src=\"\'+adsfile[i]+\'\" name=\"p\'+i+\'\" border=\"0\">\';\nt+=(NS4)? \'</a></layer>\':\'</a></div>\';\n}\ndocument.write(t);\n\nfunction moveimage(num){\nif(getidleft(num)+IDs[num].W+IDs[num].Xstep >= wind_w+getscrollx())IDs[num].Xdir=false;\nif(getidleft(num)-IDs[num].Xstep<=getscrollx())IDs[num].Xdir=true;\nif(getidtop(num)+IDs[num].H+IDs[num].Ystep >= wind_h+getscrolly())IDs[num].Ydir=false;\nif(getidtop(num)-IDs[num].Ystep<=getscrolly())IDs[num].Ydir=true;\nmoveidby(num, (IDs[num].Xdir)? IDs[num].Xstep :  -IDs[num].Xstep , (IDs[num].Ydir)?  IDs[num].Ystep:  -IDs[num].Ystep);\n}\n\nfunction getnewprops(num){\nIDs[num].Ydir=Math.floor(Math.random()*2)>0;\nIDs[num].Xdir=Math.floor(Math.random()*2)>0;\nIDs[num].Ystep=Math.ceil(Math.random()*Ymax);\nIDs[num].Xstep=Math.ceil(Math.random()*Xmax)\nsetTimeout(\'getnewprops(\'+num+\')\', Math.floor(Math.random()*Tmax));\n}\n\nfunction getscrollx(){\nif(NS4 || NS6)return window.pageXOffset;\nif(IE4)return document.body.scrollLeft;\n}\n\nfunction getscrolly(){\nif(NS4 || NS6)return window.pageYOffset;\nif(IE4)return document.body.scrollTop;\n}\n\nfunction getid(name){\nif(NS4)return document.layers[name];\nif(IE4)return document.all[name];\nif(NS6)return document.getElementById(name);\n}\n\nfunction moveidto(num,x,y){\nif(NS4)IDs[num].moveTo(x,y);\nif(IE4 || NS6){\nIDs[num].style.left=x+\'px\';\nIDs[num].style.top=y+\'px\';\n}}\n\nfunction getidleft(num){\nif(NS4)return IDs[num].left;\nif(IE4 || NS6)return parseInt(IDs[num].style.left);\n}\n\nfunction getidtop(num){\nif(NS4)return IDs[num].top;\nif(IE4 || NS6)return parseInt(IDs[num].style.top);\n}\n\nfunction moveidby(num,dx,dy){\nif(NS4)IDs[num].moveBy(dx, dy);\nif(IE4 || NS6){\nIDs[num].style.left=(getidleft(num)+dx)+\'px\';\nIDs[num].style.top=(getidtop(num)+dy)+\'px\';\n}}\n\nfunction getwindowwidth(){\nif(NS4 || NS6)return window.innerWidth;\nif(IE4)return document.body.clientWidth;\n}\n\nfunction getwindowheight(){\nif(NS4 || NS6)return window.innerHeight;\nif(IE4)return document.body.clientHeight;\n}\n\nfunction init(){\nwind_w=getwindowwidth();\nwind_h=getwindowheight();\nfor(i=0; i<${Ads_Num};  i++){\nIDs[i]=getid(\'pic\'+i);\nif(NS4){\nIDs[i].W=IDs[i].document.images[\"p\"+i].width;\nIDs[i].H=IDs[i].document.images[\"p\"+i].height;\n}\nif(NS6 || IE4){\nIDs[i].W=document.images[\"p\"+i].width;\nIDs[i].H=document.images[\"p\"+i].height;\n}\ngetnewprops(i);\nmoveidto(i , Math.floor(Math.random()*(wind_w-IDs[i].W)), Math.floor(Math.random()*(wind_h-IDs[i].H)));\nif(NS4)IDs[i].visibility = \"show\";\nif(IE4 || NS6)IDs[i].style.visibility = \"visible\";\nstartfly=setInterval(\'moveimage(\'+i+\')\',Math.floor(Math.random()*100)+100);\n}}\n\nfunction hidebutterfly(){\nfor(i=0; i<${Ads_Num};  i++){\nif (IE4)\neval(\"document.all.pic\"+i+\".style.visibility=\'hidden\'\")\nelse if (NS6)\ndocument.getElementById(\"pic\"+i).style.visibility=\'hidden\'\nelse if (NS4)\neval(\"document.pic\"+i+\".visibility=\'hide\'\")\nclearInterval(startfly)\n}\n}\n//more javascript from http://www.webjx.com\nif (NS4||NS6||IE4){\nwindow.onload=init;\nwindow.onresize=function(){ wind_w=getwindowwidth(); wind_h=getwindowheight(); }\n}', '1', 'admin');
INSERT INTO `xwcmadtype` VALUES ('12', '弹性效果的运动图片', '', '仅适用于图片类型', '网幅广告', 'admin', '2005-11-10 13:58:57', '  var stringcolor=\"white\"\nvar ballsrc=\"${Ads_FileName}\" //改为自己的图片路径及名称 \ndocument.write(\'<STYLE>v\\:* { BEHAVIOR: url(#default#VML)}</STYLE>\');\nif (document.all&&window.print){\ndocument.write(\'<IMG id=Om style=\"LEFT: -10px; POSITION: absolute\" src=\"\'+ballsrc+\'\">\')\nddx=0;ddy=0;PX=0;PY=0;xm=0;ym=0\nOmW=Om.width/2;OmH=Om.height/2\n}\nfunction Ouille(){\n x=Math.round(PX+=(ddx+=((xm-PX-ddx)*3)/100))\n y=Math.round(PY+=(ddy+=((ym-PY-ddy)*3-300)/100))\n Om.style.left=x-OmW\n Om.style.top=y-OmH\n elastoc.to=x+\",\"+y\nelastoc.strokecolor=stringcolor\n setTimeout(\"Ouille()\",1)   \n}\nfunction momouse(){\n xm=window.event.x+5\n ym=window.event.y+document.body.scrollTop+15\n elastoc.from=xm+\",\"+ym\n}\nif(document.all&&window.print){\ncode=\"<v:line id=elastoc style=\'LEFT:0;POSITION:absolute;TOP:0\' strokeweight=\'1.5pt\'></v:line>\"} else {\ncode=\"<v:group style=\'LEFT:-10;WIDTH:100pt;POSITION:absolute;TOP:0;HEIGHT:100pt\' coordsize=\'21600,21600\'><v:line id=elastoc style=\'LEFT:0;WIDTH:100pt;POSITION:absolute;TOP:0;HEIGHT:100pt\' strokeweight=\'1.5pt\'></v:line></v:group>\"}\nif(document.all&&window.print){\ndocument.body.insertAdjacentHTML(\"afterBegin\",code)\ndocument.onmousemove=momouse\nOuille()\n}', null, 'admin');
INSERT INTO `xwcmadtype` VALUES ('13', '左右浮动的广告', '', '左右浮动', '网幅广告', 'admin', '2005-11-17 13:58:51', ' window.onload=sohuactivebutton;\nvar brOK=false;\nvar mie=false;\nvar aver=parseInt(navigator.appVersion.substring(0,1));\nvar aname=navigator.appName;\nfunction checkbrOK(){\nif(aname.indexOf(\"Internet Explorer\")!=-1){\nif(aver>=4) brOK=navigator.javaEnabled();\nmie=true;\n}\nif(aname.indexOf(\"Netscape\")!=-1){\nif(aver>=4) brOK=navigator.javaEnabled();\n}\n}\nvar vmin=2;\nvar vmax=5;\nvar vr=2;\nvar timer1;\nfunction Chip(chipname,width,height){\nthis.named=chipname;\nthis.vx=vmin+vmax*Math.random();\nthis.vy=vmin+vmax*Math.random();\nthis.w=width;\nthis.h=height;\nthis.xx=0;\nthis.yy=0;\nthis.timer1=null;  }\nfunction movechip(chipname){\nif(brOK){\neval(\"chip=\"+chipname);\nif(!mie){\npageX=window.pageXOffset;\npageW=window.innerWidth;\npageY=window.pageYOffset+300;\npageH=0;  }\nelse{\npageX=window.document.body.scrollLeft;\npageW=window.document.body.offsetWidth;\npageY=window.document.body.scrollTop+300;\npageH=0; }\nchip.xx=chip.xx+chip.vx;\nchip.yy=chip.yy+chip.vy;\nchip.vx+=vr*(Math.random()-0.5);\nchip.vy+=vr*(Math.random()-0.5);\nif(chip.vx>(vmax+vmin))  chip.vx=(vmax+vmin)*2-chip.vx;\nif(chip.vx<(-vmax-vmin)) chip.vx=(-vmax-vmin)*2-chip.vx;\nif(chip.vy>(vmax+vmin))  chip.vy=(vmax+vmin)*2-chip.vy;\nif(chip.vy<(-vmax-vmin)) chip.vy=(-vmax-vmin)*2-chip.vy;\nif(chip.xx<=pageX){\nchip.xx=pageX;\nchip.vx=vmin+vmax*Math.random();  }\nif(chip.xx>=pageX+pageW-chip.w){\nchip.xx=pageX+pageW-chip.w;\nchip.vx=-vmin-vmax*Math.random(); }\nif(chip.yy<=pageY){\nchip.yy=pageY;\nchip.vy=vmin+vmax*Math.random(); }\nif(chip.yy>=pageY+pageH-chip.h){\nchip.yy=pageY+pageH-chip.h;\nchip.vy=-vmin-vmax*Math.random(); }\nif(!mie){\neval(\'document.\'+chip.named+\'.top =\'+chip.yy);\neval(\'document.\'+chip.named+\'.left=\'+chip.xx); }\nelse{\neval(\'document.all.\'+chip.named+\'.style.pixelLeft=\'+chip.xx);\neval(\'document.all.\'+chip.named+\'.style.pixelTop =\'+chip.yy);}\nchip.timer1=setTimeout(\"movechip(\'\"+chip.named+\"\')\",100);\n}\n}\nfunction stopme(chipname){\nif(brOK){\neval(\"chip=\"+chipname);\nif(chip.timer1!=null){clearTimeout(chip.timer1)}\n}\n}\nvar sohuactivebutton;\nvar chip;\nfunction sohuactivebutton(){\ncheckbrOK();\nsohuactivebutton=new Chip(\"sohuactivebutton\",60,80);\nif(brOK){ movechip(\"sohuactivebutton\"); }\n}\nvar IMG_FILE_TYPES = \"bmp,gif,ico,jpg,jpeg,png\";\nvar VIDIO_FILE_TYPES = \"wav,mid,midi,mp3,mpa,mp2,ra,ram,rm,wma,wmv\";\nvar FLASH_FILE_TYPES = \"SWF\";\nfunction getFileType(_sFileName){\n	var sFileName = _sFileName || \"\";\n	if(!sFileName || sFileName == \"\"){\n		alert(\"文件名为空！\");\n		return false;\n	}\n	var nPointIndex = sFileName.lastIndexOf(\".\");\n	if(nPointIndex < 0){\n		alert(\"无法识别文件类型！\");\n		return false;\n	}\n	return sFileName.substring(nPointIndex+1);\n}\nfunction isValidFileType(_sFileType,_sListTypes){\n	if(!_sFileType) return false;\n	if(!_sListTypes || _sListTypes == \"\") return true;\n	if(_sListTypes.indexOf(\",\") < 0){\n		return (_sListTypes.toUpperCase() == _sFileType.toUpperCase());\n	}\n	var arFileTypes = (_sListTypes.toUpperCase()).split(\",\");\n	for(var i=0; i<arFileTypes.length; i++){\n		if(_sFileType.toUpperCase() == arFileTypes[i]) return true;\n	}\n	return false;\n}\nfunction getHtml(){\n	var sFileType = getFileType(\"${Ads_FileName}\");\n	if(isValidFileType(sFileType,IMG_FILE_TYPES)){\n		sHtml= \"<IMG border=0 src=\\\"${Ads_FileName}\\\">\";\n		\n	}else if(isValidFileType(sFileType,FLASH_FILE_TYPES)){\n		 sHtml=\"<embed name=\\\"flash\\\" width=\\\"200\\\" height=\\\"200\\\" src=\\\"${Ads_FileName}\\\" quality=\\\"autohigh\\\" wmode=\\\"opaque\\\" type=\\\"application/x-shockwave-flash\\\">\";\n	}else if(isValidFileType(sFileType,VIDIO_FILE_TYPES)){\n		sHtml = \"\"\n			+\"<embed name=\\\"sound\\\" filename src=\\\"${Ads_FileName}\\\"  autostart=\\\"true\\\"\"; \n		if(sFileType == \"ram\" || sFileType == \"rm\"){\n			sHtml += \"type=\\\"audio/x-pn-realaudio-plugin\\\"\";\n		} else {\n			sHtml += \"type=\\\"application/x-mplayer2\\\" pluginspage=\\\"http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/\\\"\";\n		}\n		sHtml += \"enablecontextmenu=\\\"false\\\" clicktoplay=\\\"false\\\" enablepositioncontrols=\\\"false\\\" showcontrols=\\\"1\\\" showstatusbar=\\\"0\\\" showdisplay=\\\"0\\\" width=\\\"200\\\" height=\\\"200\\\">\";  \n	}\n	return sHtml;\n}\nvar showHtml = \"<DIV id=sohuactivebutton style=\\\"POSITION: absolute; left: 54px; top: 192px\\\"><A href=${Ads_ActionUrl} target=_blank>\"+getHtml()+\"</A> </DIV>\";\ndocument.write(showHtml);', null, 'admin');
INSERT INTO `xwcmadtype` VALUES ('14', '弹出广告特效', '', '一个IP只弹出一次', '弹出插播', 'admin', '2005-11-18 13:34:38', ' var cookieString = new String(document.cookie);\n	var cookieHeader = \'happy_pop=\' ;//更换happy_pop为任意名称\n	var beginPosition = cookieString.indexOf(cookieHeader);\n	if (beginPosition <0){\n	window.open(\"${Ads_ActionUrl}\",\"Adveritse\",\"top=0,left=0,width=${Adl_Width},height=${Adl_Height},toolbar=yes,menubar=yes,scrollbars=yes,resizable=yes,location=yes,status=yes\");\n		var Then = new Date();　　　　\n		Then.setTime(Then.getTime() + 12*60*60*1000 ); //同一ip设置过期时间，即多长间隔跳出一次\n		document.cookie = \'happy_pop=yes;expires=\'+ Then.toGMTString();//更换happy_pop和第4行一样的名称\n	}', null, 'admin');
INSERT INTO `xwcmadtype` VALUES ('15', '滚动公告', '', '滚动公告，文字形式', '文本链接', 'admin', '2005-11-18 13:50:00', 'document.write(\'<marquee direction=\"UP\" width=\"95%\" height=\"98\" scrolldelay=\"150\" scrollamount=\"1\" onMouseOver=\"this.stop();\" onMouseOut=\"this.start();\"><span class=\"jm\"><a href=\"${Ads_ActionUrl}\" target=\"_blank\"><font color=\"#000000\">${Ads_ShowText}</font></a><marquee>\');', null, 'admin');
INSERT INTO `xwcmadtype` VALUES ('16', '网页两边对联广告', '', '网页两边对联广告效果,可随滚动条的位置而进行上下移动', '网幅广告', 'admin', '2005-11-18 14:04:15', '     //more javascript from http://www.smallrain.net\nvar adsfile=${Array_FileName};\nfunction initEcAd() {\ndocument.all.AdLayer1.style.posTop = -200;\ndocument.all.AdLayer1.style.visibility = \'visible\'\ndocument.all.AdLayer2.style.posTop = -200;\ndocument.all.AdLayer2.style.visibility = \'visible\'\nMoveLeftLayer(\'AdLayer1\');\nMoveRightLayer(\'AdLayer2\');\n}\nfunction MoveLeftLayer(layerName) {\nvar x = 5;\nvar y = 340;\nvar diff = (document.body.scrollTop + y - document.all.AdLayer1.style.posTop)*.40;\nvar y = document.body.scrollTop + y - diff;\neval(\"document.all.\" + layerName + \".style.posTop = parseInt(y)\");\neval(\"document.all.\" + layerName + \".style.posLeft = x\");\nsetTimeout(\"MoveLeftLayer(\'AdLayer1\');\", 20);\n}\nfunction MoveRightLayer(layerName) {\nvar x = 5;\nvar y = 340;\nvar diff = (document.body.scrollTop + y - document.all.AdLayer2.style.posTop)*.40;\nvar y = document.body.scrollTop + y - diff;\neval(\"document.all.\" + layerName + \".style.posTop = y\");\neval(\"document.all.\" + layerName + \".style.posRight = x\");\nsetTimeout(\"MoveRightLayer(\'AdLayer2\');\", 20);\n} \nvar leftImage=\"\";\nfor(var i=0;i<Math.round(${Ads_Num}/2);i++){\n   leftImage += \"<img src=\"+adsfile[i]+\">\";\n}\n\nvar rightImage=\"\";\nfor(var i=Math.round(${Ads_Num}/2);i<${Ads_Num};i++){\n   rightImage += \"<img src=\"+adsfile[i]+\">\";\n}\ndocument.write(\"<div id=AdLayer1 style=\'position: absolute;visibility:hidden;z-index:1\'>\"+leftImage+\"</div>\"\n+\"<div id=AdLayer2 style=\'position: absolute;visibility:hidden;z-index:1\'>\"+rightImage+\"</div>\");\ninitEcAd()', '1', 'admin');
INSERT INTO `xwcmadtype` VALUES ('17', '翻滚的图片', '', '翻滚的图片的广告代码，可以增加动感', '网幅广告', 'admin', '2005-11-18 15:01:38', '      //定义图片的宽度和高度，所有的图片要有相同的尺寸；\nvar imgwidth=150\nvar imgheight=200\n\n//下面定义了包含2个图片的数组，数组的下标从0开始，你可以增加任意的图片，按照顺序增加即可，注意相应增加数组下标。\nvar adsfile=${Array_FileName};\n//下面定义图片的url，如果不需要url，将连接值设置为\"#\"；\nvar actionurl=${Array_ActionUrl};\n// 先预读图片，不要修改这里；\nvar imgpreload=new Array()\nfor (i=0;i<adsfile.length;i++) {\n	imgpreload[i]=new Image()\n	imgpreload[i].src=adsfile[i]\n}\n\n\nvar pause=2000\n\n//图片的显示速度，数值小速度快；\nvar speed=20\n\n//下面的参数也会影响图片显示的速度，数值小速度快；代表2个图片的显示间隔。\nvar step=10\n\n//不要修改下面的代码；\nvar i_loop=0\nvar i_image=0\n\nfunction stretchimage() {\n	if (i_loop<=imgwidth) {\n		if (document.all) {\n			imgcontainer.innerHTML=\"<a href=\'\"+actionurl[i_image]+\"\' target=\'_blank\'><img width=\'\"+i_loop+\"\' height=\'\"+imgheight+\"\' src=\'\"+actionurl[i_image]+\"\' border=\'0\'></a>\"\n		}\n		i_loop=i_loop+step\n		var timer=setTimeout(\"stretchimage()\",speed)\n  	}\n	else {\n		i_loop=imgwidth\n		clearTimeout(timer)\n		imgcontainer.innerHTML=\"<a href=\'\"+actionurl[i_image]+\"\' target=\'_blank\'><img src=\'\"+adsfile[i_image]+\"\' border=\'0\'></a>\"\n		var timer=setTimeout(\"shrinkimage()\",pause)\n	}\n}\n\nfunction shrinkimage() {\n	if (i_loop>=0) {\n		if (document.all) {\n			imgcontainer.innerHTML=\"<a href=\'\"+actionurl[i_image]+\"\' target=\'_blank\'><img width=\'\"+i_loop+\"\' height=\'\"+imgheight+\"\' src=\'\"+adsfile[i_image]+\"\' border=\'0\'></a>\"\n		}\n		i_loop=i_loop-step\n		var timer=setTimeout(\"shrinkimage()\",speed)\n  	}\n	else {\n		i_loop=0\n		clearTimeout(timer)\n		changeimage()\n	}\n}\n\nfunction changeimage() {\n	i_image++\n	if (i_image>=adsfile.length) {i_image=0}\n	if (document.layers) {\n		document.imgcontainer.document.write(\"<a href=\'\"+actionurl[i_image]+\"\' target=\'_blank\'><img src=\'\"+adsfile[i_image]+\"\' border=\'0\'></a>\")	\n		document.imgcontainer.document.close()\n	}		\n   	stretchimage()\n}\n\n//more javascript from http://www.webjx.com\nvar sStyle=\'<style> .containerstyle {position:absolute;}</style>\';\ndocument.write(sStyle);\nvar sShow=\'<span id=\"imgcontainer\" class=\"containerstyle\"></span>\';\ndocument.write(sShow);\nstretchimage();', '1', 'admin');

-- ----------------------------
-- Table structure for `xwcmadvendor`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadvendor`;
CREATE TABLE `xwcmadvendor` (
  `ADVENDORID` int(11) NOT NULL,
  `ZIPCODE` varchar(10) DEFAULT NULL,
  `VENDORNAME` varchar(50) DEFAULT NULL,
  `LINKMAN` varchar(50) DEFAULT NULL,
  `TELEPHONE` varchar(20) DEFAULT NULL,
  `CELLPHONE` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `ADDRESS` varchar(150) DEFAULT NULL,
  `FAX` varchar(20) DEFAULT NULL,
  `LINKMANPOST` varchar(20) DEFAULT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `VENDORSITE` varchar(200) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USERNAME` varchar(60) NOT NULL DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadvendor
-- ----------------------------
INSERT INTO `xwcmadvendor` VALUES ('1', '', 'xx公司1', '李先生', '', '', '', '', null, '经理', '常驻客户', '', 'admin', '2005-10-19 16:40:40', 'admin');
INSERT INTO `xwcmadvendor` VALUES ('2', '', 'xx公司2', '王先生', '', '', '', '', null, '', '', '', 'admin', '2005-10-26 09:46:32', 'admin');
INSERT INTO `xwcmadvendor` VALUES ('3', '', 'xx公司3', '王先生', '', '', '', '', null, '', '', '', 'admin', '2005-10-26 09:46:42', 'admin');
INSERT INTO `xwcmadvendor` VALUES ('4', '', 'xx公司4', '李小姐', '', '', '', '', null, '', '', '', 'admin', '2005-10-26 09:46:53', 'admin');
INSERT INTO `xwcmadvendor` VALUES ('22', '', 'xx集团', '王先生', '', '', '', '', null, '', '', '', 'admin', '2005-11-09 09:40:24', 'admin');

-- ----------------------------
-- Table structure for `xwcmadvendorad`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadvendorad`;
CREATE TABLE `xwcmadvendorad` (
  `ADVENDORADID` int(11) NOT NULL,
  `ADVENDORID` int(11) NOT NULL DEFAULT '0',
  `ADVERTISEID` int(11) NOT NULL DEFAULT '0',
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ADVENDORADID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadvendorad
-- ----------------------------
INSERT INTO `xwcmadvendorad` VALUES ('84', '4', '26', 'admin', '2005-11-09 10:12:12');
INSERT INTO `xwcmadvendorad` VALUES ('85', '4', '27', 'admin', '2005-11-09 10:12:58');
INSERT INTO `xwcmadvendorad` VALUES ('86', '4', '28', 'admin', '2005-11-09 10:13:44');
INSERT INTO `xwcmadvendorad` VALUES ('87', '4', '29', 'admin', '2005-11-09 10:14:07');
INSERT INTO `xwcmadvendorad` VALUES ('88', '1', '30', 'admin', '2005-11-09 10:14:52');
INSERT INTO `xwcmadvendorad` VALUES ('89', '1', '31', 'admin', '2005-11-09 10:15:15');
INSERT INTO `xwcmadvendorad` VALUES ('90', '22', '32', 'admin', '2005-11-09 10:16:05');
INSERT INTO `xwcmadvendorad` VALUES ('91', '3', '33', 'admin', '2005-11-09 10:16:42');
INSERT INTO `xwcmadvendorad` VALUES ('94', '2', '36', 'admin', '2005-11-10 16:29:19');

-- ----------------------------
-- Table structure for `xwcmadvertise`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmadvertise`;
CREATE TABLE `xwcmadvertise` (
  `ADVERTISEID` int(11) NOT NULL,
  `ADNAME` varchar(50) NOT NULL,
  `URL` varchar(500) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ADSFILENAME` varchar(100) DEFAULT NULL,
  `TEXT` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ADVERTISEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmadvertise
-- ----------------------------
INSERT INTO `xwcmadvertise` VALUES ('15', 'xx冰箱', '', 'admin', '2005-11-03 09:32:19', 'gg20051104390089533997.jpg', '真诚到永远');
INSERT INTO `xwcmadvertise` VALUES ('18', 'xx元旦优惠', '', 'admin', '2005-11-04 09:25:07', 'gg20051104454343597200.jpg', 'xx元旦优惠，真情大放松');
INSERT INTO `xwcmadvertise` VALUES ('19', 'xx打印', '', 'admin', '2005-11-04 10:58:33', 'gg20051104395022659844.htm', 'xx激光打印');
INSERT INTO `xwcmadvertise` VALUES ('26', '新xx，新形象', '', 'admin', '2005-11-09 10:12:12', 'gg20051110491099373750.gif', '新xx，新形象');
INSERT INTO `xwcmadvertise` VALUES ('27', 'xx宾馆', '', 'admin', '2005-11-09 10:12:58', 'gg20051110491221569691.gif', 'xx宾馆');
INSERT INTO `xwcmadvertise` VALUES ('28', 'xx教育', '', 'admin', '2005-11-09 10:13:44', 'gg20051110491012651591.gif', '');
INSERT INTO `xwcmadvertise` VALUES ('29', 'xx大厦', '', 'admin', '2005-11-09 10:14:07', 'gg20051110491099373750.gif', 'xx大厦');
INSERT INTO `xwcmadvertise` VALUES ('30', 'xx19大液晶一元换', '', 'admin', '2005-11-09 10:14:52', 'gg20051110481429066024.gif', 'xx19大液晶一元换');
INSERT INTO `xwcmadvertise` VALUES ('31', 'xx打印机', '', 'admin', '2005-11-09 10:15:15', 'gg20051110481264372178.gif', 'xx打印机');
INSERT INTO `xwcmadvertise` VALUES ('32', 'xx置业', '', 'admin', '2005-11-09 10:16:05', 'gg20051110594997508500.jpg', 'xx置业');
INSERT INTO `xwcmadvertise` VALUES ('33', 'xx扫描仪', '', 'admin', '2005-11-09 10:16:42', 'gg20051110594556092155.jpg', 'xx扫描仪');
INSERT INTO `xwcmadvertise` VALUES ('36', 'xx企业搜索', '', 'admin', '2005-11-10 16:29:19', 'gg20051110593329069541.jpg', 'xx竞搜');

-- ----------------------------
-- Table structure for `xwcmcachedinfoview`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmcachedinfoview`;
CREATE TABLE `xwcmcachedinfoview` (
  `CACHEDINFOVIEWID` int(11) NOT NULL,
  `CHANNELID` varchar(150) NOT NULL DEFAULT '0',
  `INFOVIEWID` varchar(150) NOT NULL DEFAULT '0',
  `CUSTOMERUSERID` varchar(150) NOT NULL DEFAULT '0',
  `INFOVIEWTITLE` varchar(500) NOT NULL,
  `INFOVIEWDESC` varchar(1000) DEFAULT NULL,
  `CACHEDFORMDATA` text,
  `LASTMODIFYTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ATTRIBUTE` varchar(1000) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `RANDOMSERIAL` varchar(100) DEFAULT NULL,
  `REMOTEHOST` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CACHEDINFOVIEWID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmcachedinfoview
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmcustomergroup`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmcustomergroup`;
CREATE TABLE `xwcmcustomergroup` (
  `CUSTOMERGROUPID` int(11) NOT NULL,
  `GROUPNAME` varchar(150) DEFAULT NULL,
  `GROUPDESC` varchar(200) DEFAULT NULL,
  `ATTRIBUTE` varchar(1000) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CUSTOMERGROUPID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmcustomergroup
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmcustomerquery`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmcustomerquery`;
CREATE TABLE `xwcmcustomerquery` (
  `CUSTOMERQUERYID` int(11) NOT NULL,
  `PUBLICED` smallint(6) DEFAULT NULL,
  `WHEREFILTER` varchar(2000) DEFAULT NULL,
  `ORDERBYFILTER` varchar(500) DEFAULT NULL,
  `CUSTOMERUSERID` varchar(150) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CUSTOMERQUERYID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmcustomerquery
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmcustomeruser`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmcustomeruser`;
CREATE TABLE `xwcmcustomeruser` (
  `CUSTOMERUSERID` int(11) NOT NULL,
  `ISADMIN` smallint(6) DEFAULT NULL,
  `USERSTATUS` smallint(6) DEFAULT '0',
  `SEARCHMODE` smallint(6) DEFAULT '0',
  `USERNAME` varchar(150) DEFAULT NULL,
  `NICKNAME` varchar(150) DEFAULT NULL,
  `REALNAME` varchar(150) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  `SEX` int(11) DEFAULT NULL,
  `BIRTHDAY` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `COMEFROM` varchar(150) DEFAULT NULL,
  `VOCATION` varchar(150) DEFAULT NULL,
  `MYSIGN` varchar(500) DEFAULT NULL,
  `MYPHOTO` varchar(250) DEFAULT NULL,
  `REGISTERTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GROUPID` int(11) DEFAULT NULL,
  `LASTLOGINTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LOGINTIMES` int(11) DEFAULT NULL,
  `IDSNAME` varchar(200) DEFAULT NULL,
  `ATTRIBUTE` varchar(3000) DEFAULT NULL,
  `TELEPHONE` varchar(50) DEFAULT NULL,
  `AGE` int(11) DEFAULT NULL,
  `IDENTITYNO` varchar(50) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`CUSTOMERUSERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmcustomeruser
-- ----------------------------
INSERT INTO `xwcmcustomeruser` VALUES ('1', '1', '1', '0', 'root', '默认管理员', null, '621EE7AEAFA2281', null, null, '2020-10-15 14:58:14', null, null, null, null, '2007-07-27 22:07:28', null, '2020-10-15 14:58:14', null, null, null, null, null, null, 'system', '2007-07-27 22:07:28');

-- ----------------------------
-- Table structure for `xwcminfogateclientuser`
-- ----------------------------
DROP TABLE IF EXISTS `xwcminfogateclientuser`;
CREATE TABLE `xwcminfogateclientuser` (
  `CLIENTUSERID` int(11) NOT NULL,
  `USERNAME` varchar(150) DEFAULT NULL,
  `NICKNAME` varchar(150) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ATTRIBUTE` varchar(500) DEFAULT NULL,
  `LASTLOGINTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LOGINTIMES` int(11) DEFAULT NULL,
  PRIMARY KEY (`CLIENTUSERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcminfogateclientuser
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcminfogateconfig`
-- ----------------------------
DROP TABLE IF EXISTS `xwcminfogateconfig`;
CREATE TABLE `xwcminfogateconfig` (
  `INFOGATECONFIGID` int(11) NOT NULL,
  `CKEY` varchar(50) DEFAULT NULL,
  `CVALUE` varchar(500) DEFAULT NULL,
  `CDESC` varchar(200) DEFAULT NULL,
  `DATATYPE` int(11) DEFAULT NULL,
  `NEEDRELOAD` smallint(6) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`INFOGATECONFIGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcminfogateconfig
-- ----------------------------
INSERT INTO `xwcminfogateconfig` VALUES ('1', 'WCM_POST_URL', 'http://localhost:8080/wcm/infoview.do', '提交表单的WCM目标地址', '0', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('2', 'DEFAULT_SYSTEM_EMAIL', 'wcm@trs.com.cn', '默认的系统邮件发送人', '0', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('3', 'CUSTOMER_GROUPS_SETTING', '普通用户:0,企业用户:1,海外归侨:2', '用户分组策略（形式为“普通用户:0,企业用户:1”）', '5', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('4', 'INFOGATE_URL', 'http://localhost:8081/infogate', '网关应用的访问地址', '0', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('5', 'SUBMIT_NEED_LOGIN', '1', '指定在填报表单前是否需要登录(填入1表示需要登录)', '0', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('6', 'SYSTEM_TEMP_DIR', 'D:\\TRS\\TRSWCMV6_Infoview\\temp', '系统临时文件目录(例如 E:\\TRS\\TRSWCM52_Infoview\\temp)', '0', '0', 'system', '2007-07-27 22:07:28');
INSERT INTO `xwcminfogateconfig` VALUES ('7', 'SHOW_SEARCH_SERIAL', '1', '是否显示查询编号(1表示显示，0表示不显示)', '0', '0', 'system', '2009-07-14 08:08:21');
INSERT INTO `xwcminfogateconfig` VALUES ('8', 'IMAGE_SIZE_LIMIT', '500', '外网表单上传图片大小限制(单位: K)', '0', '0', 'system', '2009-07-21 17:33:28');
INSERT INTO `xwcminfogateconfig` VALUES ('9', 'FILE_SIZE_LIMIT', '1000', '外网表单上传文件大小限制(单位: K)', '0', '0', 'system', '2009-07-21 17:33:28');
INSERT INTO `xwcminfogateconfig` VALUES ('10', 'SUBMIT_NEED_LOGIN_INFOVIEWIDS', '', '当SUBMIT_NEED_LOGIN参数为不需要登录的情况下，如果部分表单强制需要登录，可在此设置表单的id序列，以逗号分隔开', '0', '0', 'system', '2010-09-16 10:33:28');
INSERT INTO `xwcminfogateconfig` VALUES ('11', 'SEARCH_NEED_LOGIN', '1', '外网检索表单的需要登录，0:不登录，1：登录', '0', '0', 'system', '2011-04-18 10:33:28');
INSERT INTO `xwcminfogateconfig` VALUES ('12', 'PASS_USER_ATONCE', '0', '用户注册是否自动开通，0：不开通，1：开通', '0', '0', 'system', '2013-05-14 10:33:28');

-- ----------------------------
-- Table structure for `xwcmlocationorder`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmlocationorder`;
CREATE TABLE `xwcmlocationorder` (
  `LOCATIONORDERID` int(11) NOT NULL,
  `LOCATIONID` int(11) DEFAULT NULL,
  `OCCUPYTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ADVENDORID` int(11) DEFAULT NULL,
  `PRICEMODE` int(11) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ADVERTISEID` int(11) DEFAULT NULL,
  `COST` decimal(30,4) DEFAULT NULL,
  `UNITCOST` int(11) DEFAULT NULL,
  `LOCATIONNAME` varchar(100) DEFAULT NULL,
  `VENDORNAME` varchar(100) DEFAULT NULL,
  `USERNAME` varchar(60) NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`LOCATIONORDERID`),
  KEY `IX_ID_OCCUPYTIME` (`LOCATIONID`,`OCCUPYTIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmlocationorder
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmlocationstatus`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmlocationstatus`;
CREATE TABLE `xwcmlocationstatus` (
  `LOCATIONSTATUSID` int(11) NOT NULL,
  `LOCATIONID` int(11) NOT NULL,
  `OCCUPYTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `AVAILABLE` smallint(6) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ADTYPEID` int(11) DEFAULT '0',
  PRIMARY KEY (`LOCATIONSTATUSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmlocationstatus
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmpoll`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpoll`;
CREATE TABLE `xwcmpoll` (
  `POLLID` int(11) NOT NULL,
  `TITLE` varchar(250) NOT NULL,
  `SUMMARY` varchar(2000) DEFAULT NULL,
  `ITSVENDORID` int(11) DEFAULT NULL,
  `ARCHIVEINFO` text,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `CRUSER` varchar(30) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USERNAME` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpoll
-- ----------------------------
INSERT INTO `xwcmpoll` VALUES ('6', '北京人口膨胀该与建设节约型社会的建议', '<p><b>[思考1]</b>&nbsp;从理论上说，<font color=blue>北京</font>是中国的首都，不仅是北京人的北京。研究北京的问题，听取全国人民的意见，不仅是因为全国人民应该有发言权，也因为全国人民有责任为首都的更美好献计献策.<br></p> <p><b>[思考2]</b>&nbsp;加快建设节约型社会，是由我国<font color=red>基本国情</font>决定的。人口众多、资源相对不足、环境承载能力较弱，是中国的基本国情，今后一个时期，人口还要增长，人均资源占', '1', null, null, 'admin', '2005-12-30 16:59:56', null);
INSERT INTO `xwcmpoll` VALUES ('7', '华北油田工人突击离婚羞辱了谁？  ', '', '1', null, null, 'admin', '2005-12-30 17:09:30', null);
INSERT INTO `xwcmpoll` VALUES ('8', 'Test POLL', 'Test Summary', '1', null, null, 'admin', '2005-12-30 17:12:37', null);

-- ----------------------------
-- Table structure for `xwcmpollblock`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollblock`;
CREATE TABLE `xwcmpollblock` (
  `POLLBLOCKID` int(11) NOT NULL,
  `TITLE` varchar(250) NOT NULL,
  `ITSPOLLID` int(11) NOT NULL,
  `ORGERRING` int(11) DEFAULT NULL,
  `HASADDITIONALITEM` smallint(6) DEFAULT NULL,
  `ARCHIVEINFO` varchar(500) DEFAULT NULL,
  `SELECTIONALTYPE` int(11) DEFAULT NULL,
  `BLOCKGROUP` int(11) DEFAULT NULL,
  `DESCRIPTION` varchar(2000) DEFAULT NULL,
  `ADDITIONDESC` varchar(100) DEFAULT NULL,
  `RELATEBLOCKID` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollblock
-- ----------------------------
INSERT INTO `xwcmpollblock` VALUES ('20', '解决或者缓解人口膨胀带来的社会压力的建言', '6', '0', null, null, null, '-1', '', null, '0');
INSERT INTO `xwcmpollblock` VALUES ('21', '征集公民节约行为准则', '6', '0', null, null, null, '-1', '', null, '0');
INSERT INTO `xwcmpollblock` VALUES ('22', 'n条“节约金点子”，您最中意哪几条', '6', '0', '1', null, '1', '20', '', '更多节约金点子', '0');
INSERT INTO `xwcmpollblock` VALUES ('23', '您认为节约最有效的办法是什么？', '6', '0', '0', null, '0', '20', '', 'Other', '0');
INSERT INTO `xwcmpollblock` VALUES ('24', '您如何看待北京站迁郊区来缓解人口压力', '6', '0', '0', null, '0', '21', '', 'Other', '0');
INSERT INTO `xwcmpollblock` VALUES ('25', '您认为北京应该如何缓解外来人口进京压力？', '6', '0', '1', null, '0', '21', '', '补充', '0');
INSERT INTO `xwcmpollblock` VALUES ('26', '怎样看待华北油田工人突击离婚？', '7', '0', '0', null, '0', null, '', 'Other', '0');
INSERT INTO `xwcmpollblock` VALUES ('27', '您认为目前如何才能有效解决下岗问题？', '7', '1', '0', null, '0', null, '', 'Other', '0');

-- ----------------------------
-- Table structure for `xwcmpollcfg`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollcfg`;
CREATE TABLE `xwcmpollcfg` (
  `POLLCFGID` int(11) NOT NULL,
  `STARTDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EXPIREDDATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `STATUS` int(11) NOT NULL,
  `IPRANGE_START` varchar(50) DEFAULT NULL,
  `IPRANGE_END` varchar(50) DEFAULT NULL,
  `TIMESCONSTRAINT` int(11) DEFAULT NULL,
  `ISPUBLISHED` smallint(6) NOT NULL,
  `ISENABLEPOLLBLOCKSARCHIVE` smallint(6) NOT NULL,
  `PUBMEDIUMPATH` varchar(250) DEFAULT NULL,
  `PUBVIRTUALPATH` varchar(250) DEFAULT NULL,
  `POLLBLOCKTOKEN` int(11) NOT NULL,
  `POLLITEMTOKEN` int(11) NOT NULL,
  `ISEMBEDED` smallint(6) NOT NULL,
  `ISVERTICAL` smallint(6) NOT NULL,
  `ITSPOLLID` int(11) NOT NULL,
  `ISSIMPLE` smallint(6) DEFAULT NULL,
  `ISMUSTVOTEBEFOREVIEW` smallint(6) DEFAULT NULL,
  `ISMUSTRENDERBEFOREVOTE` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollcfg
-- ----------------------------
INSERT INTO `xwcmpollcfg` VALUES ('1', '2020-10-15 17:21:56', '2021-01-15 17:21:56', '0', null, null, '1', '0', '1', null, null, '0', '0', '0', '0', '8', '0', '1', '1');
INSERT INTO `xwcmpollcfg` VALUES ('2', '2020-10-15 17:22:03', '2021-01-15 17:22:03', '0', null, null, '1', '0', '1', null, null, '0', '0', '0', '0', '7', '0', '1', '1');

-- ----------------------------
-- Table structure for `xwcmpollingdata`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollingdata`;
CREATE TABLE `xwcmpollingdata` (
  `POLLINGITEMDATAID` int(11) NOT NULL,
  `ITSPOLLINGLOGID` int(11) NOT NULL,
  `ITSPOLLINGITEMORBLOCKID` int(11) NOT NULL,
  `ADDIONALCONTENT` varchar(250) DEFAULT NULL,
  `NEEDHIDE` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollingdata
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmpollinglog`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollinglog`;
CREATE TABLE `xwcmpollinglog` (
  `POLLINGLOGID` int(11) NOT NULL,
  `POLLERIP` varchar(50) DEFAULT NULL,
  `POLLERFULLNAME` varchar(20) DEFAULT NULL,
  `CRTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ITSPOLLID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollinglog
-- ----------------------------

-- ----------------------------
-- Table structure for `xwcmpollitem`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollitem`;
CREATE TABLE `xwcmpollitem` (
  `POLLITEMID` int(11) NOT NULL,
  `CONTENT` varchar(500) NOT NULL,
  `ITSPOLLBLOCKID` int(11) DEFAULT NULL,
  `ORDERRING` int(11) DEFAULT NULL,
  `POLLCOUNTER` int(11) NOT NULL,
  `DEFAULTCHECKED` smallint(6) DEFAULT NULL,
  `RELATEITEMID` varchar(200) DEFAULT NULL,
  `ATTRIBUTE` varchar(2000) DEFAULT NULL,
  `PICURL` varchar(30) DEFAULT NULL,
  `LINKURL` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollitem
-- ----------------------------
INSERT INTO `xwcmpollitem` VALUES ('36', '空调不低于26度 全国节电上亿度', '22', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('37', '多坐公交和地铁 既省能源又便捷', '22', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('38', '电脑不让空运行 两面用纸处处省', '22', '2', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('39', '灯泡换成节能灯 用电能省近八成', '22', '3', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('40', '从自己做起，从小事做起', '23', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('41', '国家和政府制定严厉的惩罚措施', '23', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('42', '加强公德教育，从思想上养成节约好习惯', '23', '2', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('43', '很荒唐，肯定没用', '24', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('44', '作为城市规划，会有作用', '24', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('45', '不置可否', '24', '2', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('46', '最根本的还是合理规划北京,比如人口迁郊区等', '25', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('47', '用强制手段，部分外地人遣返', '25', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('48', '提高进京门槛，比如学历等', '25', '2', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('49', '经济手段，购房等额外征税', '25', '3', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('50', '工人没有错，企业荒唐的规定导致丑剧上演', '26', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('51', ' 规定没错，企业是为照顾弱势，不想工人为利益扭曲了', '26', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('52', '银行放宽贷款政策，鼓励下岗工人贷款自主创业', '27', '0', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('53', '关键还是要完善失业保障制度，给与补助', '27', '1', '0', '0', null, null, null, null);
INSERT INTO `xwcmpollitem` VALUES ('54', '国家必须加强再培训使其有一技之长，从而再上岗', '27', '2', '0', '0', null, null, null, null);

-- ----------------------------
-- Table structure for `xwcmpollvendor`
-- ----------------------------
DROP TABLE IF EXISTS `xwcmpollvendor`;
CREATE TABLE `xwcmpollvendor` (
  `POLLVENDORID` int(11) NOT NULL,
  `PUBMEDIUMPATH` varchar(250) DEFAULT NULL,
  `PUBVIRTUALPATH` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xwcmpollvendor
-- ----------------------------
INSERT INTO `xwcmpollvendor` VALUES ('1', 'D:\\TRSWCMDATA', 'http://localhost:8080/wcm/poll');
DROP TRIGGER IF EXISTS `TRI_NcChannel_INS`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcChannel_INS` AFTER INSERT ON `ncchannel` FOR EACH ROW begin update NcSite set ChannelCount = ChannelCount+1 where id=new.SiteID;  end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcChannel_DEL`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcChannel_DEL` AFTER DELETE ON `ncchannel` FOR EACH ROW begin update NcSite set ChannelCount = ChannelCount-1 where id=old.SiteID;  end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcComment_INS`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcComment_INS` AFTER INSERT ON `nccomment` FOR EACH ROW begin update NcSite set CommentCount = CommentCount+1 where  id=new.SiteID; update NcChannel set CommentCount = CommentCount+1 where  id=new.ChannelID; update NcNews set CommentCount = CommentCount+1 where  id=new.NewsID; end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcComment_DEL`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcComment_DEL` AFTER DELETE ON `nccomment` FOR EACH ROW begin update NcSite set CommentCount = CommentCount-1 where id=old.SiteID; update NcChannel set CommentCount = CommentCount-1 where id=old.ChannelID; update NcNews set CommentCount = CommentCount-1 where id=old.NewsID;  end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcMessage_INS`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcMessage_INS` AFTER INSERT ON `ncmessage` FOR EACH ROW begin update NcSite set MessageCount = MessageCount+1 where  id=new.SiteID; update NcChannel set MessageCount = MessageCount+1 where  id=new.ChannelID; update NcNews set MessageCount = MessageCount+1 where  id=new.NewsID; end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcMessage_DEL`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcMessage_DEL` AFTER DELETE ON `ncmessage` FOR EACH ROW begin update NcSite set MessageCount = MessageCount-1 where  id=old.SiteID; update NcChannel set MessageCount = MessageCount-1 where  id=old.ChannelID; update NcNews set MessageCount = MessageCount-1 where  id=old.NewsID; end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcRubbish_INS`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcRubbish_INS` AFTER INSERT ON `ncrubbish` FOR EACH ROW begin update NcSite set RubbishCount = RubbishCount+1 where  id=new.SiteID; update NcChannel set RubbishCount = RubbishCount+1 where  id=new.ChannelID; update NcNews set RubbishCount = RubbishCount+1 where  id=new.NewsID; end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TRI_NcRubbish_DEL`;
DELIMITER ;;
CREATE TRIGGER `TRI_NcRubbish_DEL` AFTER DELETE ON `ncrubbish` FOR EACH ROW begin update NcSite set RubbishCount = RubbishCount-1 where  id=old.SiteID; update NcChannel set RubbishCount = RubbishCount-1 where  id=old.ChannelID; update NcNews set RubbishCount = RubbishCount-1 where  id=old.NewsID; end
;;
DELIMITER ;
