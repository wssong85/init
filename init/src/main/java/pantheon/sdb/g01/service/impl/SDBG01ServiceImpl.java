package pantheon.sdb.g01.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.dao.COMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.g01.dao.SDBG01DAO;
import pantheon.sdb.g01.service.SDBG01Service;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBG01Service")
public class SDBG01ServiceImpl implements SDBG01Service{
	@Resource(name = "SDBG01DAO")
	private SDBG01DAO sdbg01DAO;
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "SDB_MULLANG_SEQ")
	private EgovIdGnrService sdbMullangSeq;
	
	@Resource(name = "SDB_DEMOGRAPHICS_SEQ")
	private EgovIdGnrService sdbDemographicsSeq;
	
	@Resource(name = "SDB_NARRATIVE_SEQ")
	private EgovIdGnrService sdbNarrativeSeq;
	
//	@Resource(name = "SDB_MANUFACTOR_SEQ")
//	private EgovIdGnrService sdbManufactorSeq;
	
	@Resource(name = "SDB_SOURCE_SEQ")
	private EgovIdGnrService sdbSourceSeq;
	
	@Resource(name = "SDB_REPORT_SEQ")
	private EgovIdGnrService sdbReportSeq;
	
	@Resource(name = "SDB_PARENT_SEQ")
	private EgovIdGnrService sdbParentSeq;
	
	@Resource(name = "SDB_LAB_SEQ")
	private EgovIdGnrService sdbLabSeq;
	
	@Resource(name = "SDB_MEDICAL_SEQ")
	private EgovIdGnrService sdbMedicalSeq;	
	
	@Resource(name = "SDB_DRUGHISTORY_SEQ")
	private EgovIdGnrService sdbDrugHistorySeq;
	
	@Resource(name = "SDB_AE_SEQ")
	private EgovIdGnrService sdbAeSeq;
	
	@Resource(name = "SDB_DRUG_SEQ")
	private EgovIdGnrService sdbDrugSeq;
	
	@Resource(name = "ATRAIL_SDB_AM_CHANGE_RESN")
	protected EgovPropertyService atrailchangeresn;
	
	@Resource(name = "ATRAIL_SDB_AM_HRMFLNS_CASE_DC")
	protected EgovPropertyService atrailhrmflnscasedc;
	
	@Resource(name = "ATRAIL_SDB_AM_TEST_INFO")
	protected EgovPropertyService atrailtestinfo;
	
	@Resource(name = "ATRAIL_SDB_AM_HRMFLNS_CASE_INFO")
	protected EgovPropertyService atrailhrmflns_case_info;
	
	@Resource(name = "ATRAIL_SDB_AM_AE_INFO")
	protected EgovPropertyService atrailae_info;
	
	@Resource(name = "ATRAIL_SDB_AM_MEDCIN_INFO")
	protected EgovPropertyService atrailmedcin_info;
	
	@Resource(name = "ATRAIL_SDB_AM_RELATE")
	protected EgovPropertyService atrailrelate;
	
	
	
}
