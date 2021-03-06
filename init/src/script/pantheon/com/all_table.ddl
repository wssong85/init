
CREATE TABLE CDISC_CL_CODE
(
	CDISC_UPPER_CODE     VARCHAR2(10) NOT NULL ,
	ESTN_POSBL_AT        VARCHAR2(10) NULL ,
	CDISC_SUBMIT_VALUE   VARCHAR2(300) NULL ,
	CDISC_SYNONM         VARCHAR2(300) NULL ,
	CDISC_DFN            VARCHAR2(8) NULL ,
	NCI_NM               VARCHAR2(100) NULL ,
	USE_AT               VARCHAR2(10) NULL ,
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(8) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(8) NULL ,
	CODE_NM              VARCHAR2(100) NULL ,
	CODE_DC              VARCHAR2(300) NULL ,
	CDISC_CODE           VARCHAR2(10) NOT NULL 
);



CREATE UNIQUE INDEX PCDISC_CL_CODE ON CDISC_CL_CODE
(CDISC_CODE   ASC,CDISC_UPPER_CODE   ASC);



ALTER TABLE CDISC_CL_CODE
	ADD CONSTRAINT  PCDISC_CL_CODE PRIMARY KEY (CDISC_CODE,CDISC_UPPER_CODE);



CREATE TABLE CDISC_DOMN
(
	CDISC_DOMN_SN        NUMBER NOT NULL ,
	DOMN_NM              VARCHAR2(200) NULL ,
	DOMN_DC              VARCHAR2(4000) NULL ,
	DOMN_CLASS           VARCHAR2(300) NULL ,
	DOMN_STRCT           VARCHAR2(300) NULL ,
	DOMN_PURPS           VARCHAR2(300) NULL ,
	DOMN_KEYS            VARCHAR2(300) NULL ,
	DOMN_LOCATION        VARCHAR2(300) NULL ,
	CDISC_RULE_SN        NUMBER NOT NULL ,
	DOMN_ORDR            NUMBER(10) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_401020127 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PCDISC_DOMN ON CDISC_DOMN
(CDISC_DOMN_SN   ASC);



ALTER TABLE CDISC_DOMN
	ADD CONSTRAINT  PCDISC_DOMN PRIMARY KEY (CDISC_DOMN_SN);



CREATE TABLE CDISC_DOMN_VRIABL
(
	DOMN_VRIABL_SN       NUMBER NOT NULL ,
	VRIABL_NM            VARCHAR2(200) NULL ,
	VRIABL_LBL           VARCHAR2(200) NULL ,
	VRIABL_TY            VARCHAR2(200) NULL ,
	VRIABL_ROLE          VARCHAR2(100) NULL ,
	VRIABL_DC            VARCHAR2(4000) NULL ,
	ESSNTL_AT            CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1665808128 CHECK (ESSNTL_AT IN ('Y', 'N')),
	CDISC_DOMN_SN        NUMBER NOT NULL ,
	LBL_ORDR             NUMBER(10) NULL ,
	CDISC_CODE           VARCHAR2(10) NULL ,
	CDISC_UPPER_CODE     VARCHAR2(10) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1335466157 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	VRIABL_TY_CODE       VARCHAR2(10) NULL ,
	CRF_LBL_ONE          VARCHAR2(200) NULL ,
	CRF_LBL_TWO          VARCHAR2(200) NULL ,
	CDISC_CODE_NM        VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX PCDISC_DOMN_VRIABL ON CDISC_DOMN_VRIABL
(DOMN_VRIABL_SN   ASC);



ALTER TABLE CDISC_DOMN_VRIABL
	ADD CONSTRAINT  PCDISC_DOMN_VRIABL PRIMARY KEY (DOMN_VRIABL_SN);



CREATE TABLE CDISC_RULE
(
	CDISC_RULE_SN        NUMBER NOT NULL ,
	RULE_NM              VARCHAR2(200) NULL ,
	RULE_DC              VARCHAR2(4000) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_418383577 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	CDISC_VER            VARCHAR(6) NULL ,
	CDISC_FILE_SN        NUMBER NULL ,
	CDISC_SE_CODE        VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX PCDISC_RULE ON CDISC_RULE
(CDISC_RULE_SN   ASC);



ALTER TABLE CDISC_RULE
	ADD CONSTRAINT  PCDISC_RULE PRIMARY KEY (CDISC_RULE_SN);



CREATE TABLE CM_BCNCUSER
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	INSTT_CODE           VARCHAR2(10) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_182710958 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_BCNCUSER ON CM_BCNCUSER
(USER_ID   ASC);



ALTER TABLE CM_BCNCUSER
	ADD CONSTRAINT  PCM_BCNCUSER PRIMARY KEY (USER_ID);



CREATE TABLE CM_BUTTON
(
	BUTTON_ID            VARCHAR2(32) NOT NULL ,
	BUTTON_NM            VARCHAR2(200) NOT NULL ,
	BUTTON_DC            VARCHAR2(4000) NULL ,
	BUTTON_ORDR          NUMBER(10) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1509026004 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL ,
	PROGRM_ID            VARCHAR2(32) NOT NULL 
);



CREATE UNIQUE INDEX PCM_BUTTON ON CM_BUTTON
(BUTTON_ID   ASC,PROGRM_ID   ASC);



ALTER TABLE CM_BUTTON
	ADD CONSTRAINT  PCM_BUTTON PRIMARY KEY (BUTTON_ID,PROGRM_ID);



CREATE TABLE CM_CLCODE
(
	CMMN_CLCODE          VARCHAR2(5) NOT NULL ,
	CMMN_CLCODE_NM       VARCHAR2(200) NOT NULL ,
	CMMN_CLCODE_DC       VARCHAR2(4000) NULL ,
	CMMN_CLCODE_ENGNM    VARCHAR2(200) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1677988307 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_CLCODE ON CM_CLCODE
(CMMN_CLCODE   ASC);



ALTER TABLE CM_CLCODE
	ADD CONSTRAINT  PCM_CLCODE PRIMARY KEY (CMMN_CLCODE);



CREATE TABLE CM_CMMNCODE
(
	CMMN_CODE            VARCHAR2(10) NOT NULL ,
	CMMN_CODE_NM         VARCHAR2(200) NULL ,
	CMMN_CODE_ENGNM      VARCHAR2(200) NULL ,
	CMMN_CODE_DC         VARCHAR2(1000) NULL ,
	SORT_ORDR            NUMBER(10) NOT NULL ,
	CMMN_CLCODE          VARCHAR2(5) NOT NULL ,
	UPPER_CMMNCODE       VARCHAR2(10) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_216406946 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_CMMNCODE ON CM_CMMNCODE
(CMMN_CODE   ASC,CMMN_CLCODE   ASC);



ALTER TABLE CM_CMMNCODE
	ADD CONSTRAINT  PCM_CMMNCODE PRIMARY KEY (CMMN_CODE,CMMN_CLCODE);



CREATE TABLE CM_DEPTINFO
(
	COMP_CD              VARCHAR2(3) NOT NULL ,
	DEPT_CD              VARCHAR2(10) NOT NULL ,
	DEPT_NM              VARCHAR2(64) NULL ,
	DEPT_UP              VARCHAR2(10) NULL ,
	DEPT_LEVEL           VARCHAR2(30) NULL ,
	DEPT_ORDER           VARCHAR2(1) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_131464369 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_DEPTINFO ON CM_DEPTINFO
(COMP_CD   ASC,DEPT_CD   ASC);



ALTER TABLE CM_DEPTINFO
	ADD CONSTRAINT  PCM_DEPTINFO PRIMARY KEY (COMP_CD,DEPT_CD);



CREATE TABLE CM_DTA_ATRAIL
(
	UPDT_DE              DATE NULL ,
	CHANGE_LBL           VARCHAR2(200) NULL ,
	UPDTBFE_VALUE        VARCHAR2(300) NULL ,
	AFTUPD_VALUE         VARCHAR2(300) NULL ,
	STRE_ETC_RESN        VARCHAR2(4000) NULL ,
	ATRAIL_SN            NUMBER NOT NULL ,
	STRE_RESN_CODE       VARCHAR2(10) NULL ,
	USER_ID              VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PCM_DTA_ATRAIL ON CM_DTA_ATRAIL
(ATRAIL_SN   ASC);



ALTER TABLE CM_DTA_ATRAIL
	ADD CONSTRAINT  PCM_DTA_ATRAIL PRIMARY KEY (ATRAIL_SN);



CREATE TABLE CM_INSTT
(
	INSTT_CODE           VARCHAR2(10) NOT NULL ,
	KUNNR                VARCHAR2(10) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_943388903 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_INSTT ON CM_INSTT
(INSTT_CODE   ASC);



ALTER TABLE CM_INSTT
	ADD CONSTRAINT  PCM_INSTT PRIMARY KEY (INSTT_CODE);



CREATE TABLE CM_INTRFC
(
	OPERT_SN             NUMBER NOT NULL ,
	OPERT_NM             VARCHAR2(200) NULL ,
	OPERT_STTUS          VARCHAR2(10) NULL ,
	STTUS_RESN           VARCHAR2(4000) NULL ,
	OPERT_DT             DATE NULL 
);



CREATE UNIQUE INDEX PCM_INTRFC ON CM_INTRFC
(OPERT_SN   ASC);



ALTER TABLE CM_INTRFC
	ADD CONSTRAINT  PCM_INTRFC PRIMARY KEY (OPERT_SN);



CREATE TABLE CM_JOBUSER
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	COMP_CD              VARCHAR2(3) NULL ,
	EMPL_NO              VARCHAR2(10) NULL ,
	DEPT_CD              VARCHAR2(10) NULL ,
	COST_CNTER           VARCHAR2(10) NULL ,
	HFFC_AT              CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_198972343 CHECK (HFFC_AT IN ('Y', 'N')),
	CLSF_CODE            VARCHAR2(10) NULL ,
	ECNY_DE              VARCHAR2(10) NULL ,
	RETIRE_DE            VARCHAR2(10) NULL ,
	DTY_CODE             VARCHAR2(10) NULL ,
	DPRLR_AT             CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_437596762 CHECK (DPRLR_AT IN ('Y', 'N')),
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_334943722 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_JOBUSER ON CM_JOBUSER
(USER_ID   ASC);



ALTER TABLE CM_JOBUSER
	ADD CONSTRAINT  PCM_JOBUSER PRIMARY KEY (USER_ID);



CREATE TABLE CM_MENU
(
	MENU_ID              VARCHAR2(32) NOT NULL ,
	MENU_NM              VARCHAR2(200) NOT NULL ,
	MENU_DC              VARCHAR2(4000) NULL ,
	MODULE_CODE          VARCHAR2(10) NOT NULL ,
	MENU_ORDR            NUMBER(10) NULL ,
	UPPER_MENU_ID        VARCHAR2(32) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1344552191 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_MENU ON CM_MENU
(MENU_ID   ASC);



ALTER TABLE CM_MENU
	ADD CONSTRAINT  PCM_MENU PRIMARY KEY (MENU_ID);



CREATE TABLE CM_NOTICE
(
	NOTICE_SN            NUMBER NOT NULL ,
	FIXING_AT            CHAR(1) DEFAULT  'N'  NULL  CONSTRAINT  check_at_135342434 CHECK (FIXING_AT IN ('Y', 'N')),
	NOTICE_SJ            VARCHAR2(1000) NULL ,
	NOTICE_CN            VARCHAR2(4000) NULL ,
	INQIRE_NUM           NUMBER(10) NULL ,
	FILE_MASTR_SN        NUMBER NULL ,
	NOTICE_BGNDE         DATE NULL ,
	NOTICE_ENDDE         DATE NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1510015193 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_NOTICE ON CM_NOTICE
(NOTICE_SN   ASC);



ALTER TABLE CM_NOTICE
	ADD CONSTRAINT  PCM_NOTICE PRIMARY KEY (NOTICE_SN);



CREATE TABLE CM_PROGRM
(
	PROGRM_ID            VARCHAR2(32) NOT NULL ,
	PROGRM_NM            VARCHAR2(200) NOT NULL ,
	PROGRM_DC            VARCHAR2(4000) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1224076769 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL ,
	PROGRM_URL           VARCHAR2(200) NULL ,
	PROGRM_ORDR          NUMBER(10) NULL ,
	MENU_ID              VARCHAR2(32) NOT NULL 
);



CREATE UNIQUE INDEX PCM_PROGRM ON CM_PROGRM
(PROGRM_ID   ASC);



ALTER TABLE CM_PROGRM
	ADD CONSTRAINT  PCM_PROGRM PRIMARY KEY (PROGRM_ID);



CREATE TABLE CM_PROGRM_CONECT
(
	CONECT_SN            NUMBER NOT NULL ,
	USER_ID              VARCHAR2(32) NULL ,
	CONECT_IP            VARCHAR2(32) NULL ,
	CONECT_DT            DATE NULL ,
	PROGRM_ID            VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PCM_PROGRM_CONECT ON CM_PROGRM_CONECT
(CONECT_SN   ASC);



ALTER TABLE CM_PROGRM_CONECT
	ADD CONSTRAINT  PCM_PROGRM_CONECT PRIMARY KEY (CONECT_SN);



CREATE TABLE CM_ROLE
(
	ROLE_ID              VARCHAR2(32) NOT NULL ,
	ROLE_NM              VARCHAR2(200) NOT NULL ,
	RM                   VARCHAR2(4000) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1379153909 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_ROLE ON CM_ROLE
(ROLE_ID   ASC);



ALTER TABLE CM_ROLE
	ADD CONSTRAINT  PCM_ROLE PRIMARY KEY (ROLE_ID);



CREATE TABLE CM_ROLE_AUTHOR
(
	ROLE_ID              VARCHAR2(32) NOT NULL ,
	PROGRM_ID            VARCHAR2(32) NOT NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_929590899 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_ROLE_AUTHOR ON CM_ROLE_AUTHOR
(ROLE_ID   ASC,PROGRM_ID   ASC);



ALTER TABLE CM_ROLE_AUTHOR
	ADD CONSTRAINT  PCM_ROLE_AUTHOR PRIMARY KEY (ROLE_ID,PROGRM_ID);



CREATE TABLE CM_RSRCHUSER
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	INSTT_CODE           VARCHAR2(10) NULL ,
	IRB_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_116114064 CHECK (IRB_AT IN ('Y', 'N')),
	HSPTL_NM             VARCHAR2(200) NULL ,
	ZIP                  VARCHAR2(6) NULL ,
	ADDRONE              VARCHAR2(100) NULL ,
	ADDRTWO              VARCHAR2(200) NULL ,
	GOAL_CASE_CO         NUMBER(10) NULL ,
	CNTRCT_STTUS         VARCHAR2(10) NULL ,
	FILE_MASTR_SN        NUMBER NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_65773205 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_RSRCHUSER ON CM_RSRCHUSER
(USER_ID   ASC);



ALTER TABLE CM_RSRCHUSER
	ADD CONSTRAINT  PCM_RSRCHUSER PRIMARY KEY (USER_ID);



CREATE TABLE CM_SANCLINE
(
	SANCLINE_SN          NUMBER NOT NULL ,
	SANCLINE_NM          VARCHAR2(200) NULL ,
	SANCLINE_DC          VARCHAR2(4000) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_32565946 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_SANCLINE ON CM_SANCLINE
(SANCLINE_SN   ASC);



ALTER TABLE CM_SANCLINE
	ADD CONSTRAINT  PCM_SANCLINE PRIMARY KEY (SANCLINE_SN);



CREATE TABLE CM_SANCLINE_DETAIL
(
	DETAIL_SN            NUMBER NOT NULL ,
	SANCTN_CODE          VARCHAR2(10) NULL ,
	SANCLINE_SN          NUMBER NOT NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1872933305 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL ,
	CONFMER_ID           VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PCM_SANCLINE_DETAIL ON CM_SANCLINE_DETAIL
(SANCLINE_SN   ASC,DETAIL_SN   ASC);



ALTER TABLE CM_SANCLINE_DETAIL
	ADD CONSTRAINT  PCM_SANCLINE_DETAIL PRIMARY KEY (SANCLINE_SN,DETAIL_SN);



CREATE TABLE CM_SANCTN_PROCESS
(
	SANCTN_CODE          VARCHAR2(10) NULL ,
	SANCTN_NO            VARCHAR2(10) NOT NULL ,
	SANCTNER_ID          VARCHAR2(32) NULL ,
	STTUS_CODE           VARCHAR2(10) NULL ,
	REQUST_NO            VARCHAR2(10) NOT NULL ,
	SANCTN_DT            DATE NULL ,
	SANCTN_COMMENT       VARCHAR2(10) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1637659569 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_SANCTN_PROCESS ON CM_SANCTN_PROCESS
(REQUST_NO   ASC,SANCTN_NO   ASC);



ALTER TABLE CM_SANCTN_PROCESS
	ADD CONSTRAINT  PCM_SANCTN_PROCESS PRIMARY KEY (REQUST_NO,SANCTN_NO);



CREATE TABLE CM_SANCTN_REQUST
(
	REQUST_NO            VARCHAR2(10) NOT NULL ,
	RQESTER_ID           VARCHAR2(32) NULL ,
	STTUS_CODE           VARCHAR2(10) NULL ,
	REQUST_COMMENT       VARCHAR2(10) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1550358985 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_SANCTN_REQUST ON CM_SANCTN_REQUST
(REQUST_NO   ASC);



ALTER TABLE CM_SANCTN_REQUST
	ADD CONSTRAINT  PCM_SANCTN_REQUST PRIMARY KEY (REQUST_NO);



CREATE TABLE CM_SYS_CONECT
(
	CONECT_SN            NUMBER NOT NULL ,
	USER_ID              VARCHAR2(32) NULL ,
	CONECT_SE            VARCHAR2(10) NULL ,
	CONECT_IP            VARCHAR2(32) NULL ,
	CONECT_DT            DATE NULL 
);



CREATE UNIQUE INDEX PCM_SYS_CONECT ON CM_SYS_CONECT
(CONECT_SN   ASC);



ALTER TABLE CM_SYS_CONECT
	ADD CONSTRAINT  PCM_SYS_CONECT PRIMARY KEY (CONECT_SN);



CREATE TABLE CM_USER
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	PASSWORD             VARCHAR2(100) NOT NULL ,
	USER_NM              VARCHAR2(200) NULL ,
	USER_SE_CODE         VARCHAR2(10) NULL ,
	USER_ENGNM           VARCHAR2(200) NULL ,
	EMAIL                VARCHAR2(100) NULL ,
	TELNO                VARCHAR2(20) NULL ,
	LOGIN_FAILR_CO       NUMBER(10) NULL ,
	PASSWORD_CHANGE_DE   DATE NULL ,
	SBSCRB_DE            DATE NULL ,
	ACNT_LOCK_AT         CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_273496181 CHECK (ACNT_LOCK_AT IN ('Y', 'N')),
	USE_YN               VARCHAR2(1) NULL  CONSTRAINT  check_at_1495741681 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_USER ON CM_USER
(USER_ID   ASC);



ALTER TABLE CM_USER
	ADD CONSTRAINT  PCM_USER PRIMARY KEY (USER_ID);



CREATE TABLE CM_USER_ROLE
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	ROLE_ID              VARCHAR2(32) NOT NULL ,
	USE_YN               VARCHAR2(1) NULL  CONSTRAINT  check_at_304176731 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCM_USER_ROLE ON CM_USER_ROLE
(USER_ID   ASC,ROLE_ID   ASC);



ALTER TABLE CM_USER_ROLE
	ADD CONSTRAINT  PCM_USER_ROLE PRIMARY KEY (USER_ID,ROLE_ID);



CREATE TABLE CM_USERTASK
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_98295984 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL ,
	TASK_NO              VARCHAR2(50) NOT NULL 
);



CREATE UNIQUE INDEX PCM_USERTASK ON CM_USERTASK
(USER_ID   ASC,TASK_NO   ASC);



ALTER TABLE CM_USERTASK
	ADD CONSTRAINT  PCM_USERTASK PRIMARY KEY (USER_ID,TASK_NO);



CREATE TABLE COMTCZIP
(
	ZIP                  VARCHAR2(6) NOT NULL ,
	SN                   NUMBER(10) NOT NULL ,
	CTPRVN_NM            VARCHAR2(20) NULL ,
	SIGNGU_NM            VARCHAR2(20) NULL ,
	EMD_NM               VARCHAR2(60) NULL ,
	LI_BULD_NM           VARCHAR2(60) NULL ,
	LNBR_DONG_HO         VARCHAR2(20) NULL 
);



CREATE UNIQUE INDEX PCOMTCZIP ON COMTCZIP
(ZIP   ASC,SN   ASC);



ALTER TABLE COMTCZIP
	ADD CONSTRAINT  PCOMTCZIP PRIMARY KEY (ZIP,SN);



CREATE TABLE COMTHEMAILDSPTCHMANAGE
(
	MSSAGE_ID            VARCHAR2(20) NOT NULL ,
	EMAIL_CN             CLOB NULL ,
	RCVER                VARCHAR2(100) NOT NULL ,
	SJ                   VARCHAR2(60) NOT NULL ,
	DSPTCH_DT            CHAR(20) NOT NULL ,
	SNDR                 VARCHAR2(100) NULL 
);



CREATE UNIQUE INDEX PCOMTHEMAILDSPTCHMANAGE ON COMTHEMAILDSPTCHMANAGE
(MSSAGE_ID   ASC);



ALTER TABLE COMTHEMAILDSPTCHMANAGE
	ADD CONSTRAINT  PCOMTHEMAILDSPTCHMANAGE PRIMARY KEY (MSSAGE_ID);



CREATE TABLE COMTRDNMADRZIP
(
	SN                   NUMBER(10) NOT NULL ,
	CTPRVN_NM            VARCHAR2(20) NULL ,
	SIGNGU_NM            VARCHAR2(20) NULL ,
	RDMN_CODE            CHAR(14) NULL ,
	RDMN                 VARCHAR2(60) NULL ,
	BDNBR_MNNM           NUMBER(5) NULL ,
	BDNBR_SLNO           NUMBER(5) NULL ,
	BULD_NM              VARCHAR2(60) NULL ,
	DETAIL_BULD_NM       VARCHAR2(60) NULL ,
	ZIP                  VARCHAR2(6) NULL 
);



CREATE UNIQUE INDEX PCOMTRDNMADRZIP ON COMTRDNMADRZIP
(SN   ASC);



ALTER TABLE COMTRDNMADRZIP
	ADD CONSTRAINT  PCOMTRDNMADRZIP PRIMARY KEY (SN);



CREATE TABLE CT_QUERY_DETAIL
(
	QUERY_DETAIL_CODE    CHAR(3) NOT NULL ,
	QUERY_CODE           CHAR(12) NOT NULL ,
	QESTN_ANSWER_STTUS_CODE VARCHAR2(10) NULL ,
	REGISTER_ID          VARCHAR2(32) NULL ,
	RCVER_ID             VARCHAR2(32) NULL ,
	REGISTER_IP          VARCHAR2(32) NULL ,
	QUERY_CN             VARCHAR2(300) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_996826296 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCT_QUERY_DETAIL ON CT_QUERY_DETAIL
(QUERY_DETAIL_CODE   ASC,QUERY_CODE   ASC);



ALTER TABLE CT_QUERY_DETAIL
	ADD CONSTRAINT  PCT_QUERY_DETAIL PRIMARY KEY (QUERY_DETAIL_CODE,QUERY_CODE);



CREATE TABLE CT_QUERY_MASTR
(
	QUERY_CODE           CHAR(12) NOT NULL ,
	MODULE_CODE          VARCHAR2(10) NULL ,
	QUERY_TY_CODE        VARCHAR2(10) NULL ,
	QUERY_STTUS_CODE     VARCHAR2(10) NULL ,
	END_RESN_CODE        VARCHAR2(10) NULL ,
	END_RESN_ETC         VARCHAR2(300) NULL ,
	ENDER_ID             VARCHAR2(32) NULL ,
	END_DT               DATE NULL ,
	PBLSHR_ID            VARCHAR2(32) NULL ,
	PBLICTE_DT           DATE NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1616924797 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PCT_QUERY_MASTR ON CT_QUERY_MASTR
(QUERY_CODE   ASC);



ALTER TABLE CT_QUERY_MASTR
	ADD CONSTRAINT  PCT_QUERY_MASTR PRIMARY KEY (QUERY_CODE);



CREATE TABLE DM_FILE_DETAIL
(
	DETAIL_SN            NUMBER NOT NULL ,
	FILE_MASTR_SN        NUMBER NOT NULL ,
	ORGINL_FILE_NM       VARCHAR2(10) NULL ,
	ORGINL_EXTSN_NM      VARCHAR2(10) NULL ,
	ORGINL_SIZE          VARCHAR2(10) NULL ,
	UPLOAD_FILE_NM       VARCHAR2(10) NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_793925222 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PDM_FILE_DETAIL ON DM_FILE_DETAIL
(DETAIL_SN   ASC,FILE_MASTR_SN   ASC);



ALTER TABLE DM_FILE_DETAIL
	ADD CONSTRAINT  PDM_FILE_DETAIL PRIMARY KEY (DETAIL_SN,FILE_MASTR_SN);



CREATE TABLE DM_FILE_MASTR
(
	FILE_MASTR_SN        NUMBER NOT NULL ,
	MODULE_KND           VARCHAR2(10) NULL ,
	UPLOAD_PHYSIC_COURS  VARCHAR2(500) NULL ,
	DWLD_PHYSIC_COURS    VARCHAR2(500) NULL ,
	DRM_RELIS_AT         CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1816749055 CHECK (DRM_RELIS_AT IN ('Y', 'N')),
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_240400503 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PDM_FILE_MASTR ON DM_FILE_MASTR
(FILE_MASTR_SN   ASC);



ALTER TABLE DM_FILE_MASTR
	ADD CONSTRAINT  PDM_FILE_MASTR PRIMARY KEY (FILE_MASTR_SN);



CREATE TABLE EDC_CR_ATC
(
	FIVE_T_LVL           VARCHAR2(200) NULL ,
	ATC_SN               NUMBER NOT NULL ,
	FOUR_T_LVL           VARCHAR2(200) NULL ,
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_251592673 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	ONE_T_LVL            VARCHAR2(200) NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	THREE_T_LVL          VARCHAR2(200) NULL ,
	TWO_T_LVL            VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX PEDC_CR_ATC ON EDC_CR_ATC
(DICARY_SE_CODE   ASC,DICARY_VER   ASC,ATC_SN   ASC);



ALTER TABLE EDC_CR_ATC
	ADD CONSTRAINT  PEDC_CR_ATC PRIMARY KEY (DICARY_SE_CODE,DICARY_VER,ATC_SN);



CREATE TABLE EDC_CR_KCD
(
	DISS_CODE            VARCHAR2(200) NULL ,
	KCD_SN               NUMBER NOT NULL ,
	KOREAN_NM            VARCHAR2(11) NULL ,
	ENG_NM               VARCHAR2(200) NULL ,
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_536739799 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PEDC_CR_KCD ON EDC_CR_KCD
(DICARY_SE_CODE   ASC,DICARY_VER   ASC,KCD_SN   ASC);



ALTER TABLE EDC_CR_KCD
	ADD CONSTRAINT  PEDC_CR_KCD PRIMARY KEY (DICARY_SE_CODE,DICARY_VER,KCD_SN);



CREATE TABLE EDC_CR_KIMS
(
	GOODS_NM             VARCHAR2(200) NULL ,
	KIMS_SN              NUMBER NOT NULL ,
	KIMS_CODE            VARCHAR2(11) NULL ,
	IRDNT_NM             VARCHAR2(200) NULL ,
	SLE_CMPNY_NM         VARCHAR2(200) NULL ,
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_132315056 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL 
);



CREATE UNIQUE INDEX PEDC_CR_KIMS ON EDC_CR_KIMS
(DICARY_SE_CODE   ASC,DICARY_VER   ASC,KIMS_SN   ASC);



ALTER TABLE EDC_CR_KIMS
	ADD CONSTRAINT  PEDC_CR_KIMS PRIMARY KEY (DICARY_SE_CODE,DICARY_VER,KIMS_SN);



CREATE TABLE EDC_CR_MDIC
(
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_200471989 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	DICARY_FILE_SN       NUMBER NULL 
);



CREATE UNIQUE INDEX PEDC_CR_MDIC ON EDC_CR_MDIC
(DICARY_SE_CODE   ASC,DICARY_VER   ASC);



ALTER TABLE EDC_CR_MDIC
	ADD CONSTRAINT  PEDC_CR_MDIC PRIMARY KEY (DICARY_SE_CODE,DICARY_VER);



CREATE TABLE EDC_CR_MEDDRA
(
	LLT                  VARCHAR2(200) NULL ,
	MEDDRA_SN            NUMBER NOT NULL ,
	PT                   VARCHAR2(200) NULL ,
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_322320486 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	SOC                  VARCHAR2(200) NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	HLT                  VARCHAR2(200) NULL ,
	HLGT                 VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX PEDC_CR_MEDDRA ON EDC_CR_MEDDRA
(DICARY_SE_CODE   ASC,DICARY_VER   ASC,MEDDRA_SN   ASC);



ALTER TABLE EDC_CR_MEDDRA
	ADD CONSTRAINT  PEDC_CR_MEDDRA PRIMARY KEY (DICARY_SE_CODE,DICARY_VER,MEDDRA_SN);



CREATE TABLE EDC_CR_WHOART
(
	WHOART_NM            VARCHAR2(200) NULL ,
	WHOART_SN            NUMBER NOT NULL ,
	WHOART_CODE          VARCHAR2(200) NULL ,
	DICARY_SE_CODE       VARCHAR2(10) NOT NULL ,
	USE_AT               CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_491537251 CHECK (USE_AT IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	FRST_CRTR            VARCHAR2(32) NULL ,
	LAST_UPDDE           DATE NULL ,
	LAST_UPDUSR          VARCHAR2(32) NULL ,
	DICARY_VER           VARCHAR(6) NOT NULL ,
	KOREAN_SJ            VARCHAR2(200) NULL ,
	ENG_SJ               VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX PEDC_CR_WHOART ON EDC_CR_WHOART
(DICARY_SE_CODE   ASC,DICARY_VER   ASC,WHOART_SN   ASC);



ALTER TABLE EDC_CR_WHOART
	ADD CONSTRAINT  PEDC_CR_WHOART PRIMARY KEY (DICARY_SE_CODE,DICARY_VER,WHOART_SN);



CREATE TABLE INFRA_DEPT_TMPR
(
	COMP_CD              VARCHAR2(3) NULL ,
	DEPT_CD              VARCHAR2(10) NULL ,
	DEPT_NM              VARCHAR2(64) NULL ,
	DEPT_UP              VARCHAR2(10) NULL ,
	DEPT_LEVEL           VARCHAR2(30) NULL ,
	DEPT_ORDER           VARCHAR2(1) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1717789089 CHECK (USE_YN IN ('Y', 'N')),
	EAI_TX_ID            VARCHAR2(10) NULL ,
	EAI_FLAG             VARCHAR2(10) NULL ,
	EAI_MESSAGE          VARCHAR2(10) NULL ,
	EAI_DATE             VARCHAR2(10) NULL ,
	EAI_TRANS_TP         VARCHAR2(10) NULL ,
	EAI_SEQ              VARCHAR2(10) NOT NULL 
);



CREATE UNIQUE INDEX PINFRA_DEPT_TMPR ON INFRA_DEPT_TMPR
(EAI_SEQ   ASC);



ALTER TABLE INFRA_DEPT_TMPR
	ADD CONSTRAINT  PINFRA_DEPT_TMPR PRIMARY KEY (EAI_SEQ);



CREATE TABLE INFRA_USER_TMPR
(
	COMP_CD              VARCHAR2(3) NULL ,
	EMP_NO               VARCHAR2(10) NULL ,
	DEPT_CD              VARCHAR2(10) NULL ,
	COST_CD              VARCHAR2(10) NULL ,
	WORK_YN              CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1735953608 CHECK (WORK_YN IN ('Y', 'N')),
	POSITION_CD          VARCHAR2(10) NULL ,
	INS_DT               VARCHAR2(10) NULL ,
	DEL_DT               VARCHAR2(10) NULL ,
	JOB_CD               VARCHAR2(10) NULL ,
	CHIEF_FLAG           CHAR(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1364816925 CHECK (CHIEF_FLAG IN ('Y', 'N')),
	EAI_SEQ              VARCHAR2(10) NOT NULL ,
	EMP_NM               VARCHAR2(200) NULL ,
	EMP_ENG_NAME         VARCHAR2(200) NULL ,
	CJ_ID                VARCHAR2(32) NULL ,
	EMAIL                VARCHAR2(100) NULL ,
	PHONE_NO             VARCHAR2(20) NULL ,
	EAI_TX_ID            VARCHAR2(10) NULL ,
	EAI_FLAG             VARCHAR2(10) NULL ,
	EAI_MESSAGE          VARCHAR2(10) NULL ,
	EAI_DATE             VARCHAR2(10) NULL ,
	EAI_TRANS_TP         VARCHAR2(10) NULL 
);



CREATE UNIQUE INDEX PINFRA_USER_TMPR ON INFRA_USER_TMPR
(EAI_SEQ   ASC);



ALTER TABLE INFRA_USER_TMPR
	ADD CONSTRAINT  PINFRA_USER_TMPR PRIMARY KEY (EAI_SEQ);



CREATE TABLE SAP_BCNC_INFO
(
	KUNNR                VARCHAR2(10) NOT NULL ,
	NAME1                VARCHAR2(35) NULL ,
	LAND1                VARCHAR2(3) NULL ,
	VTWEG                VARCHAR2(2) NULL ,
	PSTLZ                VARCHAR2(10) NULL ,
	ORT01                VARCHAR2(35) NULL ,
	REGIO                VARCHAR2(3) NULL ,
	STRAS                VARCHAR2(35) NULL ,
	STCD1                VARCHAR2(16) NULL ,
	STCD2                VARCHAR2(11) NULL ,
	J_1KFREPRE           VARCHAR2(10) NULL ,
	STCD3                VARCHAR2(18) NULL ,
	TELF1                VARCHAR2(16) NULL ,
	TELFX                VARCHAR2(31) NULL ,
	J_1KFTBUS            VARCHAR2(30) NULL ,
	J_1KFTIND            VARCHAR2(30) NULL ,
	VKGRP                VARCHAR2(3) NULL ,
	BEZEI2               VARCHAR2(20) NULL ,
	VKBUR                VARCHAR2(10) NULL ,
	BEZEI1               VARCHAR2(20) NULL ,
	CESSION_KZ           VARCHAR2(2) NULL ,
	LOEVM                VARCHAR2(1) NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_43302043 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PSAP_BCNC_INFO ON SAP_BCNC_INFO
(KUNNR   ASC);



ALTER TABLE SAP_BCNC_INFO
	ADD CONSTRAINT  PSAP_BCNC_INFO PRIMARY KEY (KUNNR);



CREATE TABLE SAP_BCNC_TMPR
(
	KUNNR                VARCHAR2(10) NOT NULL ,
	NAME1                VARCHAR2(35) NULL ,
	LAND1                VARCHAR2(3) NULL ,
	VTWEG                VARCHAR2(2) NULL ,
	PSTLZ                VARCHAR2(10) NULL ,
	ORT01                VARCHAR2(35) NULL ,
	REGIO                VARCHAR2(3) NULL ,
	STRAS                VARCHAR2(35) NULL ,
	STCD1                VARCHAR2(16) NULL ,
	STCD2                VARCHAR2(11) NULL ,
	J_1KFREPRE           VARCHAR2(10) NULL ,
	STCD3                VARCHAR2(18) NULL ,
	TELF1                VARCHAR2(16) NULL ,
	TELFX                VARCHAR2(31) NULL ,
	J_1KFTBUS            VARCHAR2(30) NULL ,
	J_1KFTIND            VARCHAR2(30) NULL ,
	VKGRP                VARCHAR2(3) NULL ,
	BEZEI2               VARCHAR2(20) NULL ,
	VKBUR                VARCHAR2(10) NULL ,
	BEZEI1               VARCHAR2(20) NULL ,
	CESSION_KZ           VARCHAR2(2) NULL ,
	LOEVM                VARCHAR2(1) NULL 
);



CREATE UNIQUE INDEX PSAP_BCNC_TMPR ON SAP_BCNC_TMPR
(KUNNR   ASC);



ALTER TABLE SAP_BCNC_TMPR
	ADD CONSTRAINT  PSAP_BCNC_TMPR PRIMARY KEY (KUNNR);



CREATE TABLE ST_BKMK
(
	USER_ID              VARCHAR2(32) NOT NULL ,
	MENU_ID              VARCHAR2(32) NOT NULL ,
	USE_YN               VARCHAR2(1) DEFAULT  'Y'  NULL  CONSTRAINT  check_at_1244547049 CHECK (USE_YN IN ('Y', 'N')),
	FRST_CREDE           DATE NULL ,
	REGIST_ID            VARCHAR2(8) NOT NULL ,
	LAST_UPDDE           DATE NULL ,
	UPDATE_ID            VARCHAR2(8) NOT NULL 
);



CREATE UNIQUE INDEX PST_BKMK ON ST_BKMK
(USER_ID   ASC,MENU_ID   ASC);



ALTER TABLE ST_BKMK
	ADD CONSTRAINT  PST_BKMK PRIMARY KEY (USER_ID,MENU_ID);



ALTER TABLE CDISC_DOMN
	ADD (CONSTRAINT FCDISC_DOMN FOREIGN KEY (CDISC_RULE_SN) REFERENCES CDISC_RULE (CDISC_RULE_SN));



ALTER TABLE CDISC_DOMN_VRIABL
	ADD (CONSTRAINT FCDISC_DOMN_VRIABL FOREIGN KEY (CDISC_DOMN_SN) REFERENCES CDISC_DOMN (CDISC_DOMN_SN));



ALTER TABLE CDISC_DOMN_VRIABL
	ADD (CONSTRAINT FCDISC_DOMN_VRIABL FOREIGN KEY (CDISC_CODE, CDISC_UPPER_CODE) REFERENCES CDISC_CL_CODE (CDISC_CODE, CDISC_UPPER_CODE) ON DELETE SET NULL);



ALTER TABLE CM_BCNCUSER
	ADD (CONSTRAINT FCM_BCNCUSER FOREIGN KEY (INSTT_CODE) REFERENCES CM_INSTT (INSTT_CODE) ON DELETE SET NULL);



ALTER TABLE CM_BUTTON
	ADD (CONSTRAINT FCM_BUTTON FOREIGN KEY (PROGRM_ID) REFERENCES CM_PROGRM (PROGRM_ID));



ALTER TABLE CM_CMMNCODE
	ADD (CONSTRAINT FCM_CMMNCODE FOREIGN KEY (CMMN_CLCODE) REFERENCES CM_CLCODE (CMMN_CLCODE));



ALTER TABLE CM_DTA_ATRAIL
	ADD (CONSTRAINT FCM_DTA_ATRAIL FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID) ON DELETE SET NULL);



ALTER TABLE CM_INSTT
	ADD (CONSTRAINT FCM_INSTT FOREIGN KEY (KUNNR) REFERENCES SAP_BCNC_INFO (KUNNR) ON DELETE SET NULL);



ALTER TABLE CM_JOBUSER
	ADD (CONSTRAINT FCM_JOBUSER FOREIGN KEY (COMP_CD, DEPT_CD) REFERENCES CM_DEPTINFO (COMP_CD, DEPT_CD) ON DELETE SET NULL);



ALTER TABLE CM_PROGRM
	ADD (CONSTRAINT FCM_PROGRM FOREIGN KEY (MENU_ID) REFERENCES CM_MENU (MENU_ID));



ALTER TABLE CM_PROGRM_CONECT
	ADD (CONSTRAINT FCM_PROGRM_CONECT FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID) ON DELETE SET NULL);



ALTER TABLE CM_ROLE_AUTHOR
	ADD (CONSTRAINT FCM_ROLE_AUTHOR_01 FOREIGN KEY (ROLE_ID) REFERENCES CM_ROLE (ROLE_ID));



ALTER TABLE CM_ROLE_AUTHOR
	ADD (CONSTRAINT FCM_ROLE_AUTHOR FOREIGN KEY (PROGRM_ID) REFERENCES CM_PROGRM (PROGRM_ID));



ALTER TABLE CM_RSRCHUSER
	ADD (CONSTRAINT FCM_RSRCHUSER FOREIGN KEY (INSTT_CODE) REFERENCES CM_INSTT (INSTT_CODE) ON DELETE SET NULL);



ALTER TABLE CM_SANCLINE_DETAIL
	ADD (CONSTRAINT FCM_SANCLINE_DETAIL FOREIGN KEY (SANCLINE_SN) REFERENCES CM_SANCLINE (SANCLINE_SN));



ALTER TABLE CM_SANCTN_PROCESS
	ADD (CONSTRAINT FCM_SANCTN_PROCESS FOREIGN KEY (REQUST_NO) REFERENCES CM_SANCTN_REQUST (REQUST_NO));



ALTER TABLE CM_SYS_CONECT
	ADD (CONSTRAINT FCM_SYS_CONECT FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID) ON DELETE SET NULL);



ALTER TABLE CM_USER
	ADD (CONSTRAINT FCM_USER FOREIGN KEY (USER_ID) REFERENCES CM_BCNCUSER (USER_ID));



ALTER TABLE CM_USER
	ADD (CONSTRAINT FCM_USER FOREIGN KEY (USER_ID) REFERENCES CM_RSRCHUSER (USER_ID));



ALTER TABLE CM_USER
	ADD (CONSTRAINT FCM_USER FOREIGN KEY (USER_ID) REFERENCES CM_JOBUSER (USER_ID));



ALTER TABLE CM_USER_ROLE
	ADD (CONSTRAINT FCM_USER_ROLE FOREIGN KEY (ROLE_ID) REFERENCES CM_ROLE (ROLE_ID));



ALTER TABLE CM_USER_ROLE
	ADD (CONSTRAINT FCM_USER_ROLE FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID));



ALTER TABLE CM_USERTASK
	ADD (CONSTRAINT FCM_USERTASK FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID) ON DELETE SET NULL);



ALTER TABLE CT_QUERY_DETAIL
	ADD (CONSTRAINT FCT_QUERY_DETAIL FOREIGN KEY (QUERY_CODE) REFERENCES CT_QUERY_MASTR (QUERY_CODE));



ALTER TABLE DM_FILE_DETAIL
	ADD (CONSTRAINT FDM_FILE_DETAIL FOREIGN KEY (FILE_MASTR_SN) REFERENCES DM_FILE_MASTR (FILE_MASTR_SN));



ALTER TABLE EDC_CR_ATC
	ADD (CONSTRAINT FEDC_CR_ATC FOREIGN KEY (DICARY_SE_CODE, DICARY_VER) REFERENCES EDC_CR_MDIC (DICARY_SE_CODE, DICARY_VER));



ALTER TABLE EDC_CR_KCD
	ADD (CONSTRAINT FEDC_CR_KCD FOREIGN KEY (DICARY_SE_CODE, DICARY_VER) REFERENCES EDC_CR_MDIC (DICARY_SE_CODE, DICARY_VER));



ALTER TABLE EDC_CR_KIMS
	ADD (CONSTRAINT FEDC_CR_KIMS FOREIGN KEY (DICARY_SE_CODE, DICARY_VER) REFERENCES EDC_CR_MDIC (DICARY_SE_CODE, DICARY_VER));



ALTER TABLE EDC_CR_MEDDRA
	ADD (CONSTRAINT FEDC_CR_MEDDRA FOREIGN KEY (DICARY_SE_CODE, DICARY_VER) REFERENCES EDC_CR_MDIC (DICARY_SE_CODE, DICARY_VER));



ALTER TABLE EDC_CR_WHOART
	ADD (CONSTRAINT FEDC_CR_WHOART FOREIGN KEY (DICARY_SE_CODE, DICARY_VER) REFERENCES EDC_CR_MDIC (DICARY_SE_CODE, DICARY_VER));



ALTER TABLE ST_BKMK
	ADD (CONSTRAINT FST_BKMK FOREIGN KEY (MENU_ID) REFERENCES CM_MENU (MENU_ID));



ALTER TABLE ST_BKMK
	ADD (CONSTRAINT FST_BKMK FOREIGN KEY (USER_ID) REFERENCES CM_USER (USER_ID));