
CREATE TABLE TB_USERS (
    USER_ID VARCHAR(50)  NOT NULL,
    USER_NAME VARCHAR(50)  NULL,
    PASSWORD VARCHAR(30)  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_AUTHORITIES (
    USER_ID VARCHAR(50)  NOT NULL,
    ROLE VARCHAR(30)  NOT NULL
);

CREATE TABLE TB_ROLES (
    ROLE VARCHAR(30)  NOT NULL,
    ROLE_NM VARCHAR(50)  NULL,
    ROLE_DC VARCHAR(200)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE ROLES_HIERARCHY (
    PARENT_ROLE VARCHAR(30)  NULL,
    CHILD_ROLE VARCHAR(30)  NULL
);

CREATE TABLE TB_PROGRAM (
    PROGRAM_ID VARCHAR(5)  NOT NULL,
    PROGRAM_NM VARCHAR(50)  NULL,
    PROGRAM_DC VARCHAR(200)  NULL,
    PROGRAM_URL VARCHAR(200)  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_MENU (
    MENU_ID VARCHAR(3)  NOT NULL,
    UP_MENU_ID VARCHAR(5)  NOT NULL,
    PROGRAM_ID VARCHAR(5)  NOT NULL,
    MENU_NM VARCHAR(50)  NULL,
    MENU_DC VARCHAR(200)  NULL,
    MENU_SEQ NUMERIC  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_USER_HISTORY (
    USER_ID VARCHAR(50)  NOT NULL,
    LOGIN_DT DATETIME  NULL,
    LOGOUT_DT DATETIME  NULL
);

CREATE TABLE TB_GROUP_CODE (
    GROUP_CD VARCHAR(3)  NOT NULL,
    CD_DC VARCHAR(200)  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_DETAIL_CODE (
    GROUP_CD VARCHAR(3)  NOT NULL,
    DETAIL_CD VARCHAR(3)  NOT NULL,
    CD_SEQ NUMERIC  NULL,
    CD_DC VARCHAR(200)  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_MENU_PROGRAM (
    ROLE VARCHAR(30)  NOT NULL,
    MENU_ID VARCHAR(3)  NOT NULL
);

CREATE TABLE TB_BOARD_MANAGE (
    BOARD_MANAGE_SEQ NUMERIC  NOT NULL,
    PROGRAM_ID VARCHAR(5)  NOT NULL,
    TB_BOARD_NM VARCHAR(100)  NULL,
    TB_COMMENT_NM VARCHAR(100)  NULL,
    BOARD_NM VARCHAR(200)  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_FILE_MASTER (
    FILE_ID VARCHAR(50)  NOT NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_FILE_DETAIL (
    FILE_ID VARCHAR(50)  NOT NULL,
    FILE_DETAIL_ID VARCHAR(50)  NOT NULL,
    FILE_SEQ NUMERIC  NOT NULL,
    FILE_PATH VARCHAR(200)  NULL,
    FILE_NAME VARCHAR(100)  NULL,
    FILE_EXT VARCHAR(30)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_USER_DETAIL (
    USER_ID VARCHAR(50)  NOT NULL,
    BIRTH_DT VARCHAR(8)  NULL,
    AGE NUMERIC  NULL,
    PHONE VARCHAR(50)  NULL,
    ADDR VARCHAR(255)  NULL,
    EMAIL VARCHAR(40)  NULL,
    FILE_ID VARCHAR(50)  NULL,
    EMAIL_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_UP_MENU (
    UP_MENU_ID VARCHAR(5)  NOT NULL,
    UP_MENU_DC VARCHAR(200)  NULL,
    UP_MENU_NM VARCHAR(50)  NULL,
    UP_MENU_SEQ NUMERIC  NULL,
    USE_YN VARCHAR(1)  NULL,
    IN_DT DATETIME  NULL,
    UP_DT DATETIME  NULL,
    WRITE_ID VARCHAR(50)  NULL
);

CREATE TABLE TB_COM_SEQ (
	TB_SEQ NUMERIC NOT NULL,
	TB_NM  VARCHAR(50)
);


##CREATE TABLE TB_COMMENT_1 (
##    USER_ID VARCHAR(50)  NOT NULL,
##    BOARD_SEQ NUMERIC  NOT NULL,
##    COMMNET_SEQ NUMERIC  NULL,
##    COMMENT_LV NUMERIC  NULL,
##    GOOD_CT NUMERIC  NULL,
##    BAD_CT NUMERIC  NULL,
##    IN_DT DATETIME  NULL,
##    UP_DT DATETIME  NULL,
##    WRITE_ID VARCHAR(50)  NULL
##);

##CREATE TABLE TB_BOARD_1 (
##    BOARD_SEQ NUMERIC  NOT NULL,
##    USER_ID VARCHAR(50)  NOT NULL,
##    TITLE VARCHAR(200)  NULL,
##    DETAIL LONGTEXT  NULL,
##    FILE_ID VARCHAR(50)  NULL,
##    READ_CT NUMERIC  NULL,
##    GOOD_CT NUMERIC  NULL,
##    BAD_CT NUMERIC  NULL,
##    USE_YN VARCHAR(1)  NULL,
##    IN_DT DATETIME  NULL,
##    UP_DT DATETIME  NULL,
##    WRITE_ID VARCHAR(50)  NULL
##);