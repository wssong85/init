CREATE TABLE IF NOT EXISTS `roles_hierarchy` (
  `PARENT_ROLE` varchar(50) DEFAULT NULL,
  `CHILD_ROLE` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_authorities` (
  `USER_ID` varchar(50) NOT NULL,
  `ROLE` varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `tb_board_manage` (
  `BOARD_MANAGE_SEQ` decimal(10,0) NOT NULL,
  `PROGRAM_ID` varchar(20) NOT NULL,
  `TB_BOARD_NM` varchar(100) DEFAULT NULL,
  `TB_COMMENT_NM` varchar(100) DEFAULT NULL,
  `BOARD_NM` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_com_seq` (
  `TB_SEQ` bigint(20) unsigned NOT NULL DEFAULT 1 COMMENT '시퀀스 현재값',
  `TB_NM` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `LAST_UPDATE_DATE` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`TB_SEQ`)
);

CREATE TABLE IF NOT EXISTS `tb_detail_code` (
  `GROUP_CD` varchar(20) NOT NULL,
  `DETAIL_CD` varchar(20) NOT NULL,
  `CD_SEQ` decimal(10,0) DEFAULT NULL,
  `CD_DC` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

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
);

CREATE TABLE IF NOT EXISTS `tb_file_master` (
  `FILE_ID` varchar(50) NOT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_group_code` (
  `GROUP_CD` varchar(20) NOT NULL,
  `CD_DC` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

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
);

CREATE TABLE IF NOT EXISTS `tb_menu_program` (
  `ROLE` varchar(50) NOT NULL,
  `MENU_ID` varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS `tb_program` (
  `PROGRAM_ID` varchar(20) NOT NULL,
  `PROGRAM_NM` varchar(50) DEFAULT NULL,
  `PROGRAM_DC` varchar(200) DEFAULT NULL,
  `PROGRAM_URL` varchar(200) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_roles` (
  `ROLE` varchar(50) NOT NULL,
  `ROLE_NM` varchar(50) DEFAULT NULL,
  `ROLE_DC` varchar(200) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_up_menu` (
  `UP_MENU_ID` varchar(20) NOT NULL,
  `UP_MENU_DC` varchar(200) DEFAULT NULL,
  `UP_MENU_NM` varchar(50) DEFAULT NULL,
  `UP_MENU_SEQ` decimal(10,0) DEFAULT NULL,
  `USE_YN` varchar(1) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_user` (
  `USER_ID` varchar(50) NOT NULL COMMENT '사용자ID',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '사용자명',
  `PASSWORD` varchar(30) DEFAULT NULL COMMENT '패스워드',
  `USE_YN` varchar(1) DEFAULT NULL COMMENT '사용여부',
  `IN_DT` datetime DEFAULT NULL,
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_user_detail` (
  `USER_ID` varchar(50) NOT NULL,
  `BIRTH_DT` varchar(8) DEFAULT NULL COMMENT '생년월일',
  `AGE` decimal(10,0) DEFAULT NULL COMMENT '나이',
  `PHONE` varchar(50) DEFAULT NULL COMMENT '전화번호',
  `ADDR` varchar(255) DEFAULT NULL COMMENT '주소',
  `EMAIL` varchar(40) DEFAULT NULL COMMENT '이메일',
  `EMAIL_YN` varchar(1) DEFAULT NULL COMMENT '이메일 사용여부',
  `FILE_ID` varchar(50) DEFAULT NULL,
  `IN_DT` datetime DEFAULT NULL,
  `UP_DT` datetime DEFAULT NULL COMMENT '수정일',
  `WRITE_ID` varchar(50) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `tb_user_history` (
  `USER_ID` varchar(50) NOT NULL,
  `LOGIN_DT` datetime DEFAULT NULL,
  `LOGOUT_DT` datetime DEFAULT NULL
);

DELIMITER //
CREATE DEFINER=`realtime`@`%` FUNCTION `SEQ_NAME_CURRVAL`(str VARCHAR(100)) RETURNS int(11)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
MainBlock: BEGIN

    DECLARE cur_val int;

    SELECT
        TB_SEQ INTO cur_val
    FROM
        TB_COM_SEQ        
    WHERE TB_NM = str    
    ;

    RETURN cur_val;

END MainBlock//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`realtime`@`%` FUNCTION `SEQ_NAME_NEXTVAL`(str VARCHAR(100)) RETURNS bigint(20)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
MainBlock: BEGIN

UPDATE TB_COM_SEQ
SET TB_SEQ = (@v_current_value:= (TB_SEQ+1 ))
,LAST_UPDATE_DATE = now()
,TB_NM = str
where TB_NM = str;

RETURN @v_current_value;

END MainBlock//
DELIMITER ;