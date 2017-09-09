INSERT INTO `roles_hierarchy` (`PARENT_ROLE`, `CHILD_ROLE`) VALUES
	('ROLE_ANONYMOUS', 'IS_AUTHENTICATED_ANONYMOUSLY'),
	('IS_AUTHENTICATED_ANONYMOUSLY', 'IS_AUTHENTICATED_REMEMBERED'),
	('IS_AUTHENTICATED_REMEMBERED', 'IS_AUTHENTICATED_FULLY'),
	('ROLE_A', 'ROLE_USER'),
	('ROLE_SYSTEM', 'ROLE_USER'),
	('IS_AUTHENTICATED_FULLY', 'ROLE_USER');

INSERT INTO `tb_authorities` (`USER_ID`, `ROLE`) VALUES
	('admin', 'ROLE_SYSTEM'),
	('USERA', 'ROLE_A');

INSERT INTO `tb_com_seq` (`TB_SEQ`, `TB_NM`, `LAST_UPDATE_DATE`) VALUES (1, 'TB_BOARD_MANAGE', NOW());

INSERT INTO `tb_detail_code` (`GROUP_CD`, `DETAIL_CD`, `CD_SEQ`, `CD_DC`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('QWE', 'QW1', 0, 'zxcz', 'Y', '2017-08-22 22:03:06', '2017-08-22 22:03:06', NULL);

INSERT INTO `tb_group_code` (`GROUP_CD`, `CD_DC`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('QWE', 'asd', 'Y', '2017-08-22 22:02:55', '2017-08-22 22:02:55', NULL);

INSERT INTO `tb_menu` (`MENU_ID`, `UP_MENU_ID`, `PROGRAM_ID`, `MENU_NM`, `MENU_DC`, `MENU_SEQ`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM0201', 'COM02', 'COM02', '역할관리', '', 1, 'Y', '2017-09-02 20:54:36', '2017-09-02 20:54:36', NULL),
	('COM0301', 'COM03', 'COM03', '프로그램관리', '', 1, 'Y', '2017-09-02 20:54:58', '2017-09-02 20:54:58', NULL),
	('COM0501', 'COM05', 'COM05', '권한관리', '', 1, 'Y', '2017-09-02 20:55:17', '2017-09-02 20:55:17', NULL),
	('COM0601', 'COM06', 'COM06', '사용자관리', '', 1, 'Y', '2017-09-02 20:55:28', '2017-09-02 20:55:28', NULL),
	('COM0401', 'COM04', 'COM04', '메뉴관리', '', 1, 'Y', '2017-09-02 21:04:30', '2017-09-02 21:04:30', NULL),
	('COM0701', 'COM07', 'COM07', '게시판관리', '', 1, 'Y', '2017-09-02 21:04:41', '2017-09-02 21:04:41', NULL),
	('COM0101', 'COM01', 'COM01', '코드관리', '', 1, 'Y', '2017-09-02 21:13:18', '2017-09-02 21:13:18', NULL);

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

INSERT INTO `tb_program` (`PROGRAM_ID`, `PROGRAM_NM`, `PROGRAM_DC`, `PROGRAM_URL`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM01', '코드관리', '코드관리', '/com/code/codeManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM02', '역할관리', '역할관리', '/com/role/roleManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM03', '프로그램관리', '', '/com/role/programManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM04', '메뉴관리', '', '/com/role/menuManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM05', '권한관리', '', '/com/role/menuManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM06', '사용자관리', '', '/com/user/userManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL),
	('COM07', '게시판관리', '', '/com/board/boardManage.do', 'Y', '2017-09-02 20:35:58', '2017-09-02 20:35:58', NULL);

INSERT INTO `tb_roles` (`ROLE`, `ROLE_NM`, `ROLE_DC`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('ROLE_SYSTEM', '시스템 관리자', '시스템 관리자', '2017-09-02 20:38:11', '2017-09-02 20:38:11', ''),
	('ROLE_A', 'A 권한', '테스트 A 권한', '2017-09-02 20:38:11', '2017-09-02 20:38:11', ''),
	('ROLE_B', 'B 권한', '테스트 B 권한', '2017-09-02 20:38:11', '2017-09-02 20:38:11', '');

INSERT INTO `tb_up_menu` (`UP_MENU_ID`, `UP_MENU_DC`, `UP_MENU_NM`, `UP_MENU_SEQ`, `USE_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('COM01', '', '코드관리', 1, 'Y', '2017-09-02 20:42:26', '2017-09-02 20:45:58', NULL),
	('COM02', '', '역할관리', 2, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM03', '', '프로그램관리', 3, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM04', '', '메뉴관리', 4, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM05', '', '권한관리', 5, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM06', '', '사용자관리', 6, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL),
	('COM07', '', '게시판관리', 7, 'Y', '2017-09-02 20:45:30', '2017-09-02 20:45:58', NULL);

INSERT INTO `tb_user` (`USER_ID`, `USER_NAME`, `PASSWORD`, `USE_YN`, `IN_DT`, `WRITE_ID`) VALUES
	('admin', '관리자', '1234', 'Y', '2017-08-25 20:37:15', NULL),
	('USERA', '테스트A', '1234', 'Y', '2017-09-02 21:24:30', NULL);

INSERT INTO `tb_user_detail` (`USER_ID`, `BIRTH_DT`, `AGE`, `PHONE`, `ADDR`, `EMAIL`, `FILE_ID`, `EMAIL_YN`, `IN_DT`, `UP_DT`, `WRITE_ID`) VALUES
	('admin', '99991234', 99, '01012345678', '주소임', '이메일임', '2', 'Y', '2017-08-25 20:38:36', '2017-08-25 20:38:37', NULL),
	('USERA', '1', 1, '1', '1', '1', NULL, 'Y', '2017-09-02 21:24:30', '2017-09-02 21:24:30', NULL);