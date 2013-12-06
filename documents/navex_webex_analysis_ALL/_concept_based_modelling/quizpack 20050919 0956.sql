-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	4.0.24-debug-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema quizpack
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ quizpack;
USE quizpack;

--
-- Table structure for table `quizpack`.`concept`
--

DROP TABLE IF EXISTS `concept`;
CREATE TABLE `concept` (
  `id` int(11) NOT NULL default '0',
  `authorid` int(11) NOT NULL default '0',
  `typeid` int(11) NOT NULL default '0',
  `name` varchar(63) default '',
  `desc` varchar(255) default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`concept`
--

/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (1,3,0,'C_PROGRAMMING',''),
 (2,3,0,'Standard_Library',''),
 (3,3,0,'stdio_h',''),
 (4,3,0,'file_manipulation',''),
 (5,3,1,'fopen',''),
 (6,3,1,'fclose',''),
 (7,3,1,'fprintf',''),
 (8,3,1,'fscanf',''),
 (9,3,1,'fgets',''),
 (10,3,1,'fputs',''),
 (11,3,1,'fgetc',''),
 (12,3,1,'fputc',''),
 (13,3,0,'input',''),
 (14,3,1,'scanf',''),
 (15,3,1,'getchar',''),
 (16,3,1,'gets',''),
 (17,3,0,'output',''),
 (18,3,1,'printf',''),
 (19,3,1,'putchar',''),
 (20,3,1,'puts',''),
 (21,3,0,'format_string',''),
 (22,3,1,'i_format',''),
 (23,3,1,'f_format',''),
 (24,3,1,'c_format',''),
 (25,3,1,'s_format',''),
 (26,3,0,'string_h',''),
 (27,3,1,'strcat',''),
 (28,3,1,'strcmp',''),
 (29,3,1,'strcpy',''),
 (30,3,1,'strlen',''),
 (31,3,1,'strchr',''),
 (32,3,0,'stdlib_h',''),
 (33,3,1,'atof',''),
 (34,3,1,'atoi',''),
 (35,3,1,'rand',''),
 (36,3,1,'malloc',''),
 (37,3,1,'free',''),
 (38,3,1,'exit',''),
 (39,3,1,'getenv',''),
 (40,3,0,'math_h',''),
 (41,3,1,'sin','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (42,3,1,'cos',''),
 (43,3,1,'tan',''),
 (44,3,1,'exp',''),
 (45,3,1,'log',''),
 (46,3,1,'sqrt',''),
 (47,3,1,'assert_h',''),
 (48,3,1,'signal_h',''),
 (49,3,1,'limits_h',''),
 (50,3,0,'ctype_h',''),
 (51,3,1,'isalpha',''),
 (52,3,1,'isdigit',''),
 (53,3,1,'time_h',''),
 (54,3,0,'Programming_Techniques',''),
 (55,3,0,'Patterns',''),
 (56,3,0,'conditional_pattern',''),
 (57,3,1,'if_else_if',''),
 (58,3,1,'assign_min',''),
 (59,3,1,'assign_max',''),
 (60,3,0,'loop_pattern',''),
 (61,3,1,'sentinel_loop',''),
 (62,3,1,'flag_loop',''),
 (63,3,1,'pointer_pattern',''),
 (64,3,0,'function_pattern',''),
 (65,3,1,'power',''),
 (66,3,1,'recursive',''),
 (67,3,0,'array_pattern',''),
 (68,3,1,'search_array',''),
 (69,3,1,'sort_array',''),
 (70,3,1,'read_array',''),
 (71,3,1,'print_array',''),
 (72,3,1,'string_pattern',''),
 (73,3,0,'general_pattern',''),
 (74,3,1,'swap_numbers',''),
 (75,3,0,'STYLE',''),
 (76,3,1,'naming',''),
 (77,3,1,'code_structuring',''),
 (78,3,1,'comments','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (79,3,0,'Programming_Environment',''),
 (80,3,0,'Platform',''),
 (81,3,0,'Windows',''),
 (82,3,1,'ms_vs',''),
 (83,3,1,'bloodshed_dev_c',''),
 (84,3,1,'lcc_win',''),
 (85,3,0,'Unix',''),
 (86,3,1,'cc',''),
 (87,3,1,'gcc',''),
 (88,3,1,'Apple',''),
 (89,3,0,'Language_Components',''),
 (90,3,0,'compiler',''),
 (91,3,0,'compiler_error',''),
 (92,3,1,'linker',''),
 (93,3,0,'preprocessor',''),
 (94,3,1,'library',''),
 (95,3,0,'Syntax',''),
 (96,3,0,'Program_Structure',''),
 (97,3,1,'translation_unit',''),
 (98,3,0,'function',''),
 (99,3,1,'main_function',''),
 (100,3,1,'function_declaration',''),
 (101,3,1,'function_definition',''),
 (102,3,0,'function_parameter',''),
 (103,3,1,'parameter_by_value',''),
 (104,3,1,'parameter_by_reference',''),
 (105,3,1,'default_parameter',''),
 (106,3,1,'array_parameter',''),
 (107,3,1,'return_value',''),
 (108,3,1,'external_variable',''),
 (109,3,0,'preprocessor_directive',''),
 (110,3,1,'include',''),
 (111,3,1,'define','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (112,3,1,'assert',''),
 (113,3,1,'diagnostics',''),
 (114,3,1,'header_file',''),
 (115,3,0,'Data',''),
 (116,3,0,'variable',''),
 (117,3,0,'type',''),
 (118,3,0,'simple_type',''),
 (119,3,1,'char',''),
 (120,3,1,'int',''),
 (121,3,1,'long',''),
 (122,3,1,'float',''),
 (123,3,1,'double',''),
 (124,3,1,'signed',''),
 (125,3,1,'unsigned',''),
 (126,3,1,'void',''),
 (127,3,0,'user_defined_type',''),
 (128,3,1,'enum',''),
 (129,3,1,'struct',''),
 (130,3,1,'bit_field',''),
 (131,3,1,'typedef',''),
 (132,3,0,'structure_type',''),
 (133,3,0,'pointer',''),
 (134,3,1,'pointer_declaration',''),
 (135,3,1,'address_arithmetics',''),
 (136,3,1,'reference',''),
 (137,3,1,'dereference',''),
 (138,3,0,'array',''),
 (139,3,1,'base_address',''),
 (140,3,0,'index',''),
 (141,3,1,'zero_based_index',''),
 (142,3,0,'string',''),
 (143,3,1,'string_length',''),
 (144,3,1,'end_of_string',''),
 (145,3,1,'string_initialization',''),
 (146,3,1,'array_declaration',''),
 (147,3,1,'array_initialization','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (148,3,1,'string',''),
 (149,3,0,'type_cast',''),
 (150,3,1,'implicit_type_cast',''),
 (151,3,1,'explicit_type_cast',''),
 (152,3,0,'class_of_memory',''),
 (153,3,1,'automatic',''),
 (154,3,1,'register',''),
 (155,3,1,'static',''),
 (156,3,1,'extern',''),
 (157,3,1,'variable_declaration',''),
 (158,3,1,'variable_definition',''),
 (159,3,1,'variable_initialization',''),
 (160,3,0,'variable_name',''),
 (161,3,1,'name_scope',''),
 (162,3,1,'name_syntax',''),
 (163,3,0,'constant',''),
 (164,3,0,'char_literal',''),
 (165,3,1,'end_of_line',''),
 (166,3,1,'tab',''),
 (167,3,1,'carriage_return',''),
 (168,3,1,'zero_symbol',''),
 (169,3,1,'int_literal',''),
 (170,3,1,'long_literal',''),
 (171,3,1,'float_literal',''),
 (172,3,1,'double_literal',''),
 (173,3,1,'string_literal',''),
 (174,3,0,'numeration_system',''),
 (175,3,1,'decimal_value',''),
 (176,3,1,'hex_value',''),
 (177,3,1,'octal_value',''),
 (178,3,0,'Statement',''),
 (179,3,1,'expression','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (180,3,0,'selection',''),
 (181,3,1,'if',''),
 (182,3,1,'if_else',''),
 (183,3,1,'switch',''),
 (184,3,0,'iteration',''),
 (185,3,1,'while',''),
 (186,3,1,'do',''),
 (187,3,1,'for',''),
 (188,3,0,'jump',''),
 (189,3,1,'goto',''),
 (190,3,1,'break',''),
 (191,3,1,'continue',''),
 (192,3,1,'block',''),
 (193,3,0,'Expression',''),
 (194,3,0,'arithmetical_expression',''),
 (195,3,1,'add',''),
 (196,3,1,'sub',''),
 (197,3,1,'mul',''),
 (198,3,1,'div',''),
 (199,3,1,'mod',''),
 (200,3,0,'increment_decrement',''),
 (201,3,1,'pre_increment',''),
 (202,3,1,'pre_decrement',''),
 (203,3,1,'post_increment',''),
 (204,3,1,'post_decrement',''),
 (205,3,0,'assignment',''),
 (206,3,1,'simple_assignment',''),
 (207,3,1,'add_assignment',''),
 (208,3,1,'sub_assignment',''),
 (209,3,1,'mul_assignment',''),
 (210,3,1,'div_assignment',''),
 (211,3,1,'mod_assignment',''),
 (212,3,1,'and_assignment',''),
 (213,3,1,'or_assignment',''),
 (214,3,1,'xor_assignment',''),
 (215,3,0,'logical_expression','');
INSERT INTO `concept` (`id`,`authorid`,`typeid`,`name`,`desc`) VALUES 
 (216,3,1,'equal',''),
 (217,3,1,'not_equal',''),
 (218,3,1,'less',''),
 (219,3,1,'greater',''),
 (220,3,1,'less_equal',''),
 (221,3,1,'greater_equal',''),
 (222,3,1,'and',''),
 (223,3,1,'or',''),
 (224,3,1,'not',''),
 (225,3,0,'bitwise_expression',''),
 (226,3,1,'b_and',''),
 (227,3,1,'b_or',''),
 (228,3,1,'b_xor',''),
 (229,3,1,'b_left',''),
 (230,3,1,'b_right',''),
 (231,3,1,'conditional_operator',''),
 (232,3,1,'function_call',''),
 (235,3,1,'return',''),
 (233,3,1,'multi_dimensional_array',''),
 (234,3,1,'union','');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL default '0',
  `groupname` varchar(63) default NULL,
  `groupowner` int(11) NOT NULL default '0',
  `groupadmin` int(11) default NULL,
  `defaultrights` int(11) default NULL,
  `defaultpermissions` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`group`
--

/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` (`id`,`groupname`,`groupowner`,`groupadmin`,`defaultrights`,`defaultpermissions`) VALUES 
 (2,'guests',3,3,2,0),
 (1,'Admins',2,2,4,4);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`quesconcmap`
--

DROP TABLE IF EXISTS `quesconcmap`;
CREATE TABLE `quesconcmap` (
  `quesid` int(11) NOT NULL default '0',
  `concid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`quesid`,`concid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`quesconcmap`
--

/*!40000 ALTER TABLE `quesconcmap` DISABLE KEYS */;
INSERT INTO `quesconcmap` (`quesid`,`concid`) VALUES 
 (0,61),
 (0,107),
 (0,120),
 (0,146),
 (0,157),
 (0,159),
 (0,185),
 (0,195),
 (0,199),
 (0,203),
 (0,206),
 (0,218),
 (18,18),
 (18,100),
 (18,120),
 (18,157),
 (18,159),
 (20,99),
 (20,120),
 (20,146),
 (20,157),
 (20,159),
 (20,181),
 (20,187),
 (20,199),
 (20,203),
 (20,206),
 (20,218),
 (21,7),
 (21,99),
 (21,120),
 (21,146),
 (21,157),
 (21,159),
 (21,179),
 (21,185),
 (21,186),
 (21,187),
 (21,204),
 (21,206),
 (21,219),
 (22,12),
 (22,99),
 (22,120),
 (22,146),
 (22,157),
 (22,159),
 (22,185),
 (22,203),
 (22,206),
 (22,207),
 (22,218),
 (25,99),
 (25,120),
 (25,146),
 (25,157),
 (25,159),
 (25,185),
 (25,195),
 (25,199),
 (25,203),
 (25,206),
 (25,218),
 (28,99),
 (28,120),
 (28,146),
 (28,157),
 (28,159),
 (28,185),
 (28,195),
 (28,199),
 (28,203),
 (28,206),
 (28,218),
 (29,99),
 (29,120),
 (29,146),
 (29,157),
 (29,159),
 (29,185),
 (29,195),
 (29,199),
 (29,203),
 (29,206),
 (29,218);
/*!40000 ALTER TABLE `quesconcmap` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`quesgroupmap`
--

DROP TABLE IF EXISTS `quesgroupmap`;
CREATE TABLE `quesgroupmap` (
  `questionid` int(11) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0',
  `permission` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`groupid`,`questionid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`quesgroupmap`
--

/*!40000 ALTER TABLE `quesgroupmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `quesgroupmap` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`question`
--

DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL default '0',
  `authorid` int(11) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0',
  `permission` tinyint(4) default NULL,
  `title` varchar(31) default NULL,
  `desc` varchar(255) default NULL,
  `code` mediumblob,
  `minrandom` int(11) default NULL,
  `maxrandom` int(11) default NULL,
  `answertype` varchar(8) default NULL,
  `targetvariable` varchar(15) default NULL,
  `difficulty` float default NULL,
  `complexity` float default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`question`
--

/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`code`,`minrandom`,`maxrandom`,`answertype`,`targetvariable`,`difficulty`,`complexity`) VALUES 
 (18,3,1,0,'checkZ','to check Z highlighting',0x6D69616E28290D0A7B0D0A202020696E74205A31203D20303B0D0A202020696E74207A5A7A203D20313B0D0A202020696E74205F5A203D205A3B0D0A2020207072696E74662028,0,0,'printf','null',0,0),
 (4,3,1,0,'while1',NULL,0x6D61696E2028290D0A7B0D0A20202020696E742069203D20303B0D0A202020207768696C65202869202D205A290D0A2020202020202020692B2B3B0D0A7D0D0A,3,10,'int','i',0.2,0.2),
 (16,3,1,2,'ques1','Question1',0x6D61696E28290D0A7B0D0A202020696E742078203D20353B0D0A202020696E742079203D205A3B0D0A202020696E7420616E73776572203D202878203C2079293F2078203A20793B0D0A7D,0,10,'int','answer',0.1,0.1),
 (8,3,1,0,'qq','qqq',0x71717171,0,0,'printf','null',0,0),
 (9,3,1,0,'while1','null',0x6D61696E2028290D0A7B0D0A20202020696E742069203D20303B0D0A202020207768696C65202869202D205A290D0A2020202020202020692B2B3B0D0A7D0D0A,3,10,'int','i',0.2,0.2),
 (24,3,1,4,'array1',NULL,0x0D0A6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D205A3B200D0A20202020200D0A202020207768696C652869203C203629200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D200D0A,2,10,'int','res',0.5,0.5);
INSERT INTO `question` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`code`,`minrandom`,`maxrandom`,`answertype`,`targetvariable`,`difficulty`,`complexity`) VALUES 
 (23,3,1,4,'ex11',NULL,0x200D0A6D61696E2028290D0A7B0D0A20202020696E742076616C7565735B31305D203D207B302C20312C20322C20332C20342C20352C20362C20372C20382C20397D3B0D0A20202020696E742069203D20303B0D0A20202020696E74207265733B0D0A202020200D0A202020207768696C652869203C205A290D0A202020207B0D0A202020202020202076616C7565735B305D202B3D2076616C7565735B695D3B0D0A2020202020202020692B2B3B0D0A202020207D0D0A20202020726573203D2076616C7565735B305D3B0D0A7D20,1,10,'int','res',0.1,0.7),
 (13,3,1,0,'qwer',NULL,0x71776572,0,0,'printf','null',0.1,0.2),
 (14,3,1,0,'One_More',NULL,0x6E756C6C,0,0,'printf','null',0.1,0.1),
 (15,3,1,3,'asd123','sdfsdfsdf',0x6D61696E65737428290D0A7B7D0D0A736466736466736466,4,2,'int','xx',0.3,0.4),
 (19,3,1,3,'do-1(2)','simple do loop',0x6D61696E2028290D0A7B0D0A20202020696E742069203D20303B0D0A20202020646F0D0A2020202020202020692B2B3B0D0A202020207768696C65202869203C205A293B0D0A7D,5,10,'int','S',0.2,0.3),
 (22,2,1,4,'exq3','null',0x6D61696E2028290D0A7B0D0A20202020696E742076616C7565735B31305D203D207B302C20312C20322C20332C20342C20352C20362C20372C20382C20397D3B0D0A20202020696E7420693B0D0A20202020696E74207265733B0D0A202020200D0A202020207768696C652869203C205A290D0A202020207B0D0A202020202020202076616C7565735B305D202B3D2076616C7565735B695D3B0D0A2020202020202020692B2B3B0D0A202020207D0D0A20202020726573202D3D2076616C7565735B305D3B0D0A7D0D0A,4,10,'int','res',0.9,0.1);
INSERT INTO `question` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`code`,`minrandom`,`maxrandom`,`answertype`,`targetvariable`,`difficulty`,`complexity`) VALUES 
 (21,3,1,3,'exq2','null',0x6D61696E28290D0A7B0D0A20202020696E7420692C206A3B0D0A20202020696E742061725B5D203D207B312C20322C20332C20342C20352C20362C20372C20382C20392C2031302C2031317D3B0D0A0D0A20202020666F72286A203D205A202C2069203D2030203B206A203E20693B206A2D2D290D0A202020202020202069203D2061725B6A5D3B0D0A7D,5,10,'int','j',0,0),
 (20,3,1,4,'exq1','null',0x0D0A6D61696E28290D0A7B0D0A20202020696E74206A2C20693B0D0A20202020696E742061725B5D203D207B312C20322C20332C20342C20352C20362C20372C20382C20392C2031302C2031317D3B0D0A0D0A20202020666F72286A203D2069203D20303B206A203C205A203B206A2B2B290D0A20202020202020206966282061725B6A5D20252032290D0A202020202020202020202020692B2B3B0D0A7D0D0A,5,10,'int','i',0,0),
 (25,3,1,4,'array2','null',0x0D0A6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D2031303B200D0A20202020200D0A202020207768696C652869203C205A29200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D200D0A,1,10,'int','null',0.5,0.5),
 (26,3,1,4,'array',NULL,0x0D0A6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D2031303B200D0A20202020200D0A202020207768696C652869203C205A29200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D20,1,10,'int','res',0,0);
INSERT INTO `question` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`code`,`minrandom`,`maxrandom`,`answertype`,`targetvariable`,`difficulty`,`complexity`) VALUES 
 (27,2,1,4,'dfdf',NULL,0x0D0A6D616E28290D0A7B0D0A202020696E742069203D20313B0D0A202020666F722028693B2069203C20373B20692B2B290D0A202020202020207072696E746628222564222C2069293B0D0A7D,0,0,'printf','null',0,0),
 (28,3,1,4,'mvy_new','null',0x6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D2031303B200D0A20202020200D0A202020207768696C652869203C205A29200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D20,20,0,'int','res',2,2),
 (29,3,1,4,'mvy_new2','null',0x6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D2031303B200D0A20202020200D0A202020207768696C652869203C205A29200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D200D0A,20,0,'float','res',2,2),
 (30,2,1,4,'mvy_new3',NULL,0x6D61696E202829200D0A7B200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B200D0A20202020696E7420693B200D0A20202020696E74207265733B0D0A2020202069203D20303B0D0A20202020726573203D2031303B200D0A20202020200D0A202020207768696C652869203C205A29200D0A202020207B200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B0D0A2020202020202020692B2B3B200D0A202020207D200D0A7D200D0A,20,0,'float','res',2,2);
INSERT INTO `question` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`code`,`minrandom`,`maxrandom`,`answertype`,`targetvariable`,`difficulty`,`complexity`) VALUES 
 (31,3,1,4,'ques1',NULL,0x6D61696E20282920200D0A7B20200D0A20202020696E742076616C7565735B365D203D207B302C20312C20322C20332C20342C20357D3B20200D0A20202020696E7420693B20200D0A20202020696E74207265733B200D0A2020202069203D20303B200D0A20202020726573203D2031303B20200D0A2020202020200D0A202020207768696C652869203C205A2920200D0A202020207B20200D0A2020202020202020726573203D20726573202B2072657320252076616C7565735B695D3B200D0A2020202020202020692B2B3B20200D0A202020207D20200D0A7D2020,1,3,'int','i',0.5,0.7),
 (32,3,1,4,'null',NULL,0x6E756C6C,0,0,'printf','null',0,0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`quiz`
--

DROP TABLE IF EXISTS `quiz`;
CREATE TABLE `quiz` (
  `id` int(11) NOT NULL default '0',
  `authorid` int(11) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0',
  `permission` tinyint(4) default '0',
  `title` varchar(63) default '',
  `desc` varchar(255) default '',
  `lastcompiled` timestamp(14) NOT NULL,
  `lastmodified` timestamp(14) NOT NULL default '00000000000000',
  `url` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`quiz`
--

/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` (`id`,`authorid`,`groupid`,`permission`,`title`,`desc`,`lastcompiled`,`lastmodified`,`url`) VALUES 
 (1,3,1,1,'asd','null',20050708154822,20050704131329,'true'),
 (2,3,1,1,'aaa','null',20050708154822,20050704141740,'true'),
 (3,3,1,1,'aaa1','null',20050708154822,20050704142216,'true'),
 (4,3,1,4,'asd1','null',20050708154822,20050704142504,'true'),
 (5,3,1,4,'a1a1','null',20050906171825,20050906171825,'FALSE');
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`quizgroupmap`
--

DROP TABLE IF EXISTS `quizgroupmap`;
CREATE TABLE `quizgroupmap` (
  `quizid` int(11) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0',
  `permission` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`quizid`,`groupid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`quizgroupmap`
--

/*!40000 ALTER TABLE `quizgroupmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizgroupmap` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`quizquesmap`
--

DROP TABLE IF EXISTS `quizquesmap`;
CREATE TABLE `quizquesmap` (
  `quizid` int(11) NOT NULL default '0',
  `questionid` int(11) NOT NULL default '0',
  `position` tinyint(3) NOT NULL default '0',
  PRIMARY KEY  (`quizid`,`questionid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`quizquesmap`
--

/*!40000 ALTER TABLE `quizquesmap` DISABLE KEYS */;
INSERT INTO `quizquesmap` (`quizid`,`questionid`,`position`) VALUES 
 (1,22,1),
 (1,21,2),
 (1,20,3),
 (2,22,1),
 (2,21,2),
 (2,20,3),
 (3,22,1),
 (3,21,2),
 (3,20,3),
 (4,22,1),
 (4,21,2),
 (4,20,3);
/*!40000 ALTER TABLE `quizquesmap` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`relation`
--

DROP TABLE IF EXISTS `relation`;
CREATE TABLE `relation` (
  `sourceid` int(11) NOT NULL default '0',
  `targetid` int(11) NOT NULL default '0',
  `typeid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`sourceid`,`targetid`,`typeid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`relation`
--

/*!40000 ALTER TABLE `relation` DISABLE KEYS */;
INSERT INTO `relation` (`sourceid`,`targetid`,`typeid`) VALUES 
 (1,2,1),
 (1,54,1),
 (1,79,1),
 (1,95,1),
 (2,3,1),
 (2,26,1),
 (2,32,1),
 (2,40,1),
 (2,47,1),
 (2,48,1),
 (2,49,1),
 (2,50,1),
 (2,53,1),
 (3,4,1),
 (3,13,1),
 (3,17,1),
 (3,21,1),
 (4,5,1),
 (4,6,1),
 (4,7,1),
 (4,8,1),
 (4,9,1),
 (4,10,1),
 (4,11,1),
 (4,12,1),
 (13,14,1),
 (13,15,1),
 (13,16,1),
 (17,18,1),
 (17,19,1),
 (17,20,1),
 (21,22,1),
 (21,23,1),
 (21,24,1),
 (21,25,1),
 (26,27,1),
 (26,28,1),
 (26,29,1),
 (26,30,1),
 (26,31,1),
 (32,33,1),
 (32,34,1),
 (32,35,1),
 (32,36,1),
 (32,37,1),
 (32,38,1),
 (32,39,1),
 (40,41,1),
 (40,42,1),
 (40,43,1),
 (40,44,1),
 (40,45,1),
 (40,46,1),
 (50,51,1),
 (50,52,1),
 (54,55,1),
 (54,75,1),
 (55,56,1),
 (55,60,1),
 (55,63,1),
 (55,64,1),
 (55,67,1),
 (55,72,1),
 (55,73,1),
 (56,57,1),
 (56,58,1),
 (56,59,1),
 (60,61,1),
 (60,62,1),
 (64,65,1),
 (64,66,1),
 (67,68,1),
 (67,69,1),
 (67,70,1),
 (67,71,1),
 (73,74,1),
 (75,76,1),
 (75,77,1),
 (75,78,1),
 (79,80,1),
 (79,89,1),
 (80,81,1);
INSERT INTO `relation` (`sourceid`,`targetid`,`typeid`) VALUES 
 (80,85,1),
 (80,88,1),
 (81,82,1),
 (81,83,1),
 (81,84,1),
 (85,86,1),
 (85,87,1),
 (89,90,1),
 (89,92,1),
 (90,91,1),
 (91,93,1),
 (93,94,1),
 (95,96,1),
 (95,115,1),
 (95,178,1),
 (95,193,1),
 (96,97,1),
 (96,98,1),
 (96,108,1),
 (96,109,1),
 (96,114,1),
 (98,99,1),
 (98,100,1),
 (98,101,1),
 (98,102,1),
 (98,107,1),
 (102,103,1),
 (102,104,1),
 (102,105,1),
 (102,106,1),
 (109,110,1),
 (109,111,1),
 (109,112,1),
 (109,113,1),
 (115,116,1),
 (115,163,1),
 (116,117,1),
 (116,152,1),
 (116,157,1),
 (116,158,1),
 (116,159,1),
 (116,160,1),
 (117,118,1),
 (117,127,1),
 (117,132,1),
 (117,149,1),
 (118,119,1),
 (118,120,1),
 (118,121,1),
 (118,122,1),
 (118,123,1),
 (118,124,1),
 (118,125,1),
 (118,126,1),
 (127,128,1),
 (127,129,1),
 (127,130,1),
 (127,131,1),
 (127,234,1),
 (132,133,1),
 (132,138,1),
 (132,148,1),
 (133,134,1),
 (133,135,1),
 (133,136,1),
 (133,137,1),
 (138,139,1),
 (138,140,1),
 (138,142,1),
 (138,146,1),
 (138,147,1);
INSERT INTO `relation` (`sourceid`,`targetid`,`typeid`) VALUES 
 (138,233,1),
 (140,141,1),
 (142,143,1),
 (142,144,1),
 (142,145,1),
 (149,150,1),
 (149,151,1),
 (152,153,1),
 (152,154,1),
 (152,155,1),
 (152,156,1),
 (160,161,1),
 (160,162,1),
 (163,164,1),
 (163,169,1),
 (163,170,1),
 (163,171,1),
 (163,172,1),
 (163,173,1),
 (163,174,1),
 (164,165,1),
 (164,166,1),
 (164,167,1),
 (164,168,1),
 (174,175,1),
 (178,176,1),
 (178,177,1),
 (178,179,1),
 (178,180,1),
 (178,184,1),
 (178,188,1),
 (178,192,1),
 (180,181,1),
 (180,182,1),
 (180,183,1),
 (184,185,1),
 (184,186,1),
 (184,187,1),
 (188,189,1),
 (188,190,1),
 (188,191,1),
 (188,235,1),
 (193,194,1),
 (193,200,1),
 (193,205,1),
 (193,215,1),
 (193,225,1),
 (193,231,1),
 (193,232,1),
 (194,195,1),
 (194,196,1),
 (194,197,1),
 (194,198,1),
 (194,199,1),
 (200,201,1),
 (200,202,1),
 (200,203,1),
 (200,204,1),
 (205,206,1),
 (205,207,1),
 (205,208,1),
 (205,209,1),
 (205,210,1),
 (205,211,1),
 (205,212,1),
 (205,213,1),
 (205,214,1),
 (215,216,1);
INSERT INTO `relation` (`sourceid`,`targetid`,`typeid`) VALUES 
 (215,217,1),
 (215,218,1),
 (215,219,1),
 (215,220,1),
 (215,221,1),
 (215,222,1),
 (215,223,1),
 (215,224,1),
 (225,226,1),
 (225,227,1),
 (225,228,1),
 (225,229,1),
 (225,230,1);
/*!40000 ALTER TABLE `relation` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL default '0',
  `username` char(25) NOT NULL default '',
  `password` char(15) default NULL,
  `role` char(10) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `UNIQUE` (`username`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`,`username`,`password`,`role`) VALUES 
 (1,'girishc','girishc','admin'),
 (2,'peterb','peterb','admin'),
 (3,'sergey','grey123','admin'),
 (4,'test','test','user'),
 (5,'guest','guest','user');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Table structure for table `quizpack`.`usergroupmap`
--

DROP TABLE IF EXISTS `usergroupmap`;
CREATE TABLE `usergroupmap` (
  `userid` int(11) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0',
  `rights` tinyint(4) default NULL,
  PRIMARY KEY  (`userid`,`groupid`)
) TYPE=MyISAM;

--
-- Dumping data for table `quizpack`.`usergroupmap`
--

/*!40000 ALTER TABLE `usergroupmap` DISABLE KEYS */;
INSERT INTO `usergroupmap` (`userid`,`groupid`,`rights`) VALUES 
 (2,1,4),
 (3,1,4),
 (3,2,2),
 (4,2,2),
 (1,1,4);
/*!40000 ALTER TABLE `usergroupmap` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
