

-- 테이블 realtime.tb_authorities 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_authorities` (
  `USER_ID` varchar(50) NOT NULL,
  `ROLE` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_authorities:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_authorities` DISABLE KEYS */;
INSERT INTO `tb_authorities` (`USER_ID`, `ROLE`) VALUES
	('admin', 'ROLE_SYSTEM'),
	('USERA', 'ROLE_A');
/*!40000 ALTER TABLE `tb_authorities` ENABLE KEYS */;

-- 테이블 realtime.tb_board_26 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board_26` (
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `DETAIL` longtext DEFAULT NULL,
  `FILE_ID` varchar(50) DEFAULT NULL,
  `READ_CT` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_board_26:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board_26` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_board_26` ENABLE KEYS */;

-- 테이블 realtime.tb_board_27 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board_27` (
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `DETAIL` longtext DEFAULT NULL,
  `FILE_ID` varchar(50) DEFAULT NULL,
  `READ_CT` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_board_27:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board_27` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_board_27` ENABLE KEYS */;

-- 테이블 realtime.tb_board_34 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board_34` (
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `DETAIL` longtext DEFAULT NULL,
  `FILE_ID` varchar(50) DEFAULT NULL,
  `READ_CT` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_board_34:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board_34` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_board_34` ENABLE KEYS */;

-- 테이블 realtime.tb_board_37 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board_37` (
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `DETAIL` longtext DEFAULT NULL,
  `FILE_ID` varchar(50) DEFAULT NULL,
  `READ_CT` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_board_37:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board_37` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_board_37` ENABLE KEYS */;

-- 테이블 realtime.tb_board_manage 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board_manage` (
  `BOARD_MANAGE_SEQ` decimal(10,0) NOT NULL,
  `PROGRAM_ID` varchar(5) NOT NULL,
  `TB_BOARD_NM` varchar(100) DEFAULT NULL,
  `TB_COMMENT_NM` varchar(100) DEFAULT NULL,
  `BOARD_NM` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_board_manage:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board_manage` DISABLE KEYS */;
INSERT INTO `tb_board_manage` (`BOARD_MANAGE_SEQ`, `PROGRAM_ID`, `TB_BOARD_NM`, `TB_COMMENT_NM`, `BOARD_NM`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	(34, 'BD_34', 'zxc', 'xzc', '', 'Y', '2017-08-22 21:12:59', '2017-08-22 21:12:59', NULL),
	(37, 'BD_37', 'asd', '', '', 'Y', '2017-08-22 22:05:40', '2017-08-22 22:05:40', NULL);
/*!40000 ALTER TABLE `tb_board_manage` ENABLE KEYS */;

-- 테이블 realtime.tb_comment_26 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_comment_26` (
  `USER_ID` varchar(50) NOT NULL,
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `COMMNET_SEQ` decimal(10,0) DEFAULT NULL,
  `COMMENT_LV` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_comment_26:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_comment_26` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comment_26` ENABLE KEYS */;

-- 테이블 realtime.tb_comment_27 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_comment_27` (
  `USER_ID` varchar(50) NOT NULL,
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `COMMNET_SEQ` decimal(10,0) DEFAULT NULL,
  `COMMENT_LV` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_comment_27:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_comment_27` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comment_27` ENABLE KEYS */;

-- 테이블 realtime.tb_comment_34 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_comment_34` (
  `USER_ID` varchar(50) NOT NULL,
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `COMMNET_SEQ` decimal(10,0) DEFAULT NULL,
  `COMMENT_LV` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_comment_34:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_comment_34` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comment_34` ENABLE KEYS */;

-- 테이블 realtime.tb_comment_37 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_comment_37` (
  `USER_ID` varchar(50) NOT NULL,
  `BOARD_SEQ` decimal(10,0) NOT NULL,
  `COMMNET_SEQ` decimal(10,0) DEFAULT NULL,
  `COMMENT_LV` decimal(10,0) DEFAULT NULL,
  `GOOD_CT` decimal(10,0) DEFAULT NULL,
  `BAD_CT` decimal(10,0) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_comment_37:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_comment_37` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comment_37` ENABLE KEYS */;

-- 테이블 realtime.tb_com_seq 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_com_seq` (
  `TB_SEQ` bigint(20) unsigned NOT NULL DEFAULT 1 COMMENT '시퀀스 현재값',
  `TB_NM` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `LAST_UPDATE_DATE` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`TB_SEQ`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='TB_SEQ_NAME 시퀀스 테이블';

-- 테이블 데이터 realtime.tb_com_seq:1 rows 내보내기
/*!40000 ALTER TABLE `tb_com_seq` DISABLE KEYS */;
INSERT INTO `tb_com_seq` (`TB_SEQ`, `TB_NM`, `LAST_UPDATE_DATE`) VALUES
	(37, 'TB_BOARD_MANAGE', '2017-08-22 22:05:40');
/*!40000 ALTER TABLE `tb_com_seq` ENABLE KEYS */;

-- 테이블 realtime.tb_detail_code 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_detail_code` (
  `GROUP_CD` varchar(3) NOT NULL,
  `DETAIL_CD` varchar(3) NOT NULL,
  `CD_SEQ` decimal(10,0) DEFAULT NULL,
  `CD_DC` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_detail_code:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_detail_code` DISABLE KEYS */;
INSERT INTO `tb_detail_code` (`GROUP_CD`, `DETAIL_CD`, `CD_SEQ`, `CD_DC`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('QWE', 'QW1', 0, 'zxcz', 'Y', '2017-08-22 22:03:06', '2017-08-22 22:03:06', NULL);
/*!40000 ALTER TABLE `tb_detail_code` ENABLE KEYS */;

-- 테이블 realtime.tb_file_detail 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_file_detail` (
  `FILE_ID` varchar(50) NOT NULL,
  `FILE_DETAIL_ID` varchar(50) NOT NULL,
  `FILE_SEQ` decimal(10,0) NOT NULL,
  `FILE_PATH` varchar(200) DEFAULT NULL,
  `FILE_NAME` varchar(100) DEFAULT NULL,
  `FILE_EXT` varchar(30) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_file_detail:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_file_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_file_detail` ENABLE KEYS */;

-- 테이블 realtime.tb_file_master 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_file_master` (
  `FILE_ID` varchar(50) NOT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_file_master:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_file_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_file_master` ENABLE KEYS */;

-- 테이블 realtime.tb_group_code 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_group_code` (
  `GROUP_CD` varchar(3) NOT NULL,
  `CD_DC` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_group_code:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_group_code` DISABLE KEYS */;
INSERT INTO `tb_group_code` (`GROUP_CD`, `CD_DC`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('QWE', 'asd', 'Y', '2017-08-22 22:02:55', '2017-08-22 22:02:55', NULL);
/*!40000 ALTER TABLE `tb_group_code` ENABLE KEYS */;

-- 테이블 realtime.tb_menu 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_menu` (
  `MENU_ID` varchar(20) NOT NULL,
  `UP_MENU_ID` varchar(20) NOT NULL,
  `PROGRAM_ID` varchar(20) NOT NULL,
  `MENU_NM` varchar(50) DEFAULT NULL,
  `MENU_DC` varchar(200) DEFAULT NULL,
  `MENU_SEQ` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_menu:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_menu` DISABLE KEYS */;
INSERT INTO `tb_menu` (`MENU_ID`, `UP_MENU_ID`, `PROGRAM_ID`, `MENU_NM`, `MENU_DC`, `MENU_SEQ`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM0201', 'COM02', 'COM02', '역할관리', '', 0, 'Y', '2017-09-02 20:54:36', '2017-09-02 20:54:36', NULL),
	('COM0301', 'COM03', 'COM03', '프로그램관리', '', 0, 'Y', '2017-09-02 20:54:58', '2017-09-02 20:54:58', NULL),
	('COM0501', 'COM05', 'COM05', '권한관리', '', 0, 'Y', '2017-09-02 20:55:17', '2017-09-02 20:55:17', NULL),
	('COM0601', 'COM06', 'COM06', '사용자관리', '', 0, 'Y', '2017-09-02 20:55:28', '2017-09-02 20:55:28', NULL),
	('COM0401', 'COM04', 'COM04', '메뉴관리', '', 0, 'Y', '2017-09-02 21:04:30', '2017-09-02 21:04:30', NULL),
	('COM0701', 'COM07', 'COM07', '게시판관리', '', 0, 'Y', '2017-09-02 21:04:41', '2017-09-02 21:04:41', NULL),
	('COM0101', 'COM01', 'COM01', '코드관리', '', 0, 'Y', '2017-09-02 21:13:18', '2017-09-02 21:13:18', NULL);
/*!40000 ALTER TABLE `tb_menu` ENABLE KEYS */;

-- 테이블 realtime.tb_menu_program 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_menu_program` (
  `ROLE` varchar(50) NOT NULL,
  `MENU_ID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_menu_program:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_menu_program` DISABLE KEYS */;
INSERT INTO `tb_menu_program` (`ROLE`, `MENU_ID`) VALUES
	('ROLE_SYSTEM', 'COM0101'),
	('ROLE_SYSTEM', 'COM0201'),
	('ROLE_SYSTEM', 'COM0301'),
	('ROLE_SYSTEM', 'COM0401'),
	('ROLE_SYSTEM', 'COM0501'),
	('ROLE_SYSTEM', 'COM0601'),
	('ROLE_SYSTEM', 'COM0701'),
	('ROLE_A', 'COM0101'),
	('ROLE_A', 'COM0201');
/*!40000 ALTER TABLE `tb_menu_program` ENABLE KEYS */;

-- 테이블 realtime.tb_program 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_program` (
  `PROGRAM_ID` varchar(20) NOT NULL,
  `PROGRAM_NM` varchar(50) DEFAULT NULL,
  `PROGRAM_DC` varchar(200) DEFAULT NULL,
  `PROGRAM_URL` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_program:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_program` DISABLE KEYS */;
INSERT INTO `tb_program` (`PROGRAM_ID`, `PROGRAM_NM`, `PROGRAM_DC`, `PROGRAM_URL`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM01', '코드관리', '코드관리', '/com/code/codeManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM02', '역할관리', '역할관리', '/com/role/roleManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM03', '프로그램관리', '', '/com/role/programManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM04', '메뉴관리', '', '/com/role/menuManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM05', '권한관리', '', '/com/role/menuManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM06', '사용자관리', '', '/com/user/userManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM07', '게시판관리', '', '/com/board/boardManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL);
/*!40000 ALTER TABLE `tb_program` ENABLE KEYS */;

-- 테이블 realtime.tb_roles 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_roles` (
  `ROLE` varchar(30) NOT NULL,
  `ROLE_NM` varchar(50) DEFAULT NULL,
  `ROLE_DC` varchar(200) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_roles:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_roles` DISABLE KEYS */;
INSERT INTO `tb_roles` (`ROLE`, `ROLE_NM`, `ROLE_DC`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('ROLE_SYSTEM', '시스템 관리자', '시스템 관리자', '2017-09-02 20:38:11', '2017-09-02 20:38:11', ''),
	('ROLE_A', 'A 권한', '테스트 A 권한', '2017-09-02 20:38:11', '2017-09-02 20:38:11', ''),
	('ROLE_B', 'B 권한', '테스트 B 권한', '2017-09-02 20:38:11', '2017-09-02 20:38:11', '');
/*!40000 ALTER TABLE `tb_roles` ENABLE KEYS */;

-- 테이블 realtime.tb_up_menu 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_up_menu` (
  `UP_MENU_ID` varchar(5) NOT NULL,
  `UP_MENU_DC` varchar(200) DEFAULT NULL,
  `UP_MENU_NM` varchar(50) DEFAULT NULL,
  `UP_MENU_SEQ` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_up_menu:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_up_menu` DISABLE KEYS */;
INSERT INTO `tb_up_menu` (`UP_MENU_ID`, `UP_MENU_DC`, `UP_MENU_NM`, `UP_MENU_SEQ`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM01', '', '코드관리', 1, 'Y', '2017-09-02 20:42:26', '2017-09-02 20:45:58', NULL),
	('COM02', '', '역할관리', 2, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM03', '', '프로그램관리', 3, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM04', '', '메뉴관리', 4, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM05', '', '권한관리', 5, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM06', '', '사용자관리', 6, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM07', '', '게시판관리', 7, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL);
/*!40000 ALTER TABLE `tb_up_menu` ENABLE KEYS */;

-- 테이블 realtime.tb_users 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_users` (
  `USER_ID` varchar(50) NOT NULL COMMENT '사용자ID',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '사용자명',
  `PASSWORD` varchar(30) DEFAULT NULL COMMENT '패스워드',
  `USE_YN` varchar(1) DEFAULT NULL COMMENT '사용여부',
  `IN_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_users:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` (`USER_ID`, `USER_NAME`, `PASSWORD`, `USE_YN`, `IN_DT`, `WRITE_ID`) VALUES
	('admin', '관리자', '1234', 'Y', '2017-08-25 20:37:15', NULL),
	('USERA', '테스트A', '1234', 'Y', '2017-09-02 21:24:30', NULL);
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;

-- 테이블 realtime.tb_user_detail 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_user_detail` (
  `USER_ID` varchar(50) NOT NULL,
  `BIRTH_DT` varchar(8) DEFAULT NULL COMMENT '생년월일',
  `AGE` decimal(10,0) DEFAULT NULL COMMENT '나이',
  `PHONE` varchar(50) DEFAULT NULL COMMENT '전화번호',
  `ADDR` varchar(255) DEFAULT NULL COMMENT '주소',
  `EMAIL` varchar(40) DEFAULT NULL COMMENT '이메일',
  `FILE_ID` varchar(50) DEFAULT NULL,
  `EMAIL_YN` varchar(1) DEFAULT NULL COMMENT '이메일 사용여부',
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL COMMENT '수정일',
  `WRITE_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 realtime.tb_user_detail:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_user_detail` DISABLE KEYS */;
INSERT INTO `tb_user_detail` (`USER_ID`, `BIRTH_DT`, `AGE`, `PHONE`, `ADDR`, `EMAIL`, `FILE_ID`, `EMAIL_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('admin', '99991234', 99, '01012345678', '주소임', '이메일임', '2', 'Y', '2017-08-25 20:38:36', '2017-08-25 20:38:37', NULL),
	('USERA', '1', 1, '1', '1', '1', NULL, 'Y', '2017-09-02 21:24:30', '2017-09-02 21:24:30', NULL);
/*!40000 ALTER TABLE `tb_user_detail` ENABLE KEYS */;

-- 테이블 realtime.tb_user_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_user_history` (
  `USER_ID` varchar(50) NOT NULL,
  `LOGIN_DT` datetime DEFAULT NULL,
  `LOGOUT_DT` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;