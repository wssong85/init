package pantheon.sdb.c02.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.dao.COMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.c02.dao.SDBC02DAO;
import pantheon.sdb.c02.service.MultiLangManageService;
import pantheon.sdb.c02.service.SDBC02Service;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBC02Service")
public class SDBC02ServiceImpl implements SDBC02Service{
	@Resource(name = "SDBC02DAO")
	private SDBC02DAO sdbc02DAO;
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "SDBC02Service")
	private SDBC02Service sdbc02Service;
	
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
	
	@Resource(name = "SDB_DMSTC_RPT_SEQ")
	private EgovIdGnrService sdbDmstcRptSeq;
	
	
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
	
	@Resource(name = "ATRAIL_SDB_AM_REPORTER_INFO")
	protected EgovPropertyService atrailreporter_info;
	
	@Resource(name = "ATRAIL_SDB_AM_PARNTS_INFO")
	protected EgovPropertyService atrailparnts_info;
	
	@Resource(name = "ATRAIL_SDB_AM_AE_INFO")
	protected EgovPropertyService atrailae_info;
	
	@Resource(name = "ATRAIL_SDB_AM_MDLC_RCORD_INFO")
	protected EgovPropertyService atrailmdlc_rcord_info;
	
	@Resource(name = "ATRAIL_SDB_AM_MEDCIN_INFO")
	protected EgovPropertyService atrailmedcin_info;
	
	@Resource(name = "ATRAIL_SDB_AM_MEDCIN_RCORD_INFO")
	protected EgovPropertyService atrailmedcin_rcord_info;
	
	@Resource(name = "ATRAIL_SDB_AM_RELATE")
	protected EgovPropertyService atrailrelate;
	
	@Resource(name = "ATRAIL_SDB_AM_DMSTC_RPT_INFO")
	protected EgovPropertyService atraildmstcrptinfo;
	
	@Resource(name = "MultiLangManageService")
	private MultiLangManageService multiLangManageService;
	
	
	
//	public void insertMul(String code, String kor, String eng) throws Exception{		
//		
//		Map<String, String> iMap = new HashMap<String, String>();
//		Map<String, String> iMap_M = new HashMap<String, String>();
//		iMap.put("MULLANG_CODE",code);
//		iMap.put("KOREAN",kor);
//		iMap.put("ENG",eng);	
//		
//		sdbc02DAO.insertMul(iMap);
//		/**
//		 * CLOB으로 지정된 컬럼에 대해 이력을 남긴다.
//		 * @param map
//		 * LABEL_NM (이력남길 컬럼 이름)
//		 * MODULE (모듈이름)
//		 * PK_NM (TABLE_PK 의 실제 값 (2개면 2개 넣고 1개면 1개 넣음, 컬럼간 구분자는 ","로 해야한다.))
//		 * TABLE_PK (테이블의 PK (2개면 2개 넣고 1개면 1개 넣음, 컬럼간 구분자는 ","로 해야한다.)
//		 * COLUMN_NM (CLOB 컬럼 이름)
//		 * TABLE_NM (CLOB 컬럼있는 테이블)
//		 * STRE_RESN_CODE ((입력시 필수 코드)01 신규 , 04 수정, 06 삭제)
//		 * STRE_ETC_RESN (string 들어감 (이유))
//		 * UPDTBFE_VALUE (이전값)
//		 * AFTUPD_VALUE (이후값)
//		 * @throws Exception
//		 */
//		
////comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailmullanginfo, null, null);
//		iMap_M.put("LABEL_NM","한글");
//		iMap_M.put("MODULE","SDB");
//		iMap_M.put("PK_NM","다국어 코드");
//		iMap_M.put("TABLE_PK","MULLANG_CODE");
//		iMap_M.put("COLUMN_NM","KOREAN");
//		iMap_M.put("TABLE_NM","SDB_IM_MULLANG_INFO");
//		iMap_M.put("STRE_RESN_CODE","01");
//		iMap_M.put("STRE_ETC_RESN","");
//		iMap_M.put("UPDTBFE_VALUE","");
//		iMap_M.put("AFTUPD_VALUE",kor);
//		comz06DAO.insertCmDtaAtrailForClob(iMap_M);
//	}
//	
//	public void updateMul(String code, String kor, String eng) throws Exception{		
//		
//		Map<String, String> iMap = new HashMap<String, String>();
//		iMap.put("MULLANG_CODE",code);
//		iMap.put("KOREAN",kor);
//		iMap.put("ENG",eng);
//		
//		//comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmullanginfo, null, "이상사례");
//		sdbc02DAO.updateMul(iMap);
//	}
	
	@Override
	public void insertReason(Map<String, String> iMap) throws Exception {
		
		sdbc02DAO.insertReason(iMap);
			String strReason = iMap.get("CN");
			String strReasonCode = iMap.get("CN_CODE");
			
	//		System.out.println("========Audit");
	//		System.out.println(iMap);
	//		System.out.println(strReason);
		comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailchangeresn, strReasonCode, strReason);
	}
	
	@Override
	public void insertNarrativeInfo(Map<String, String> param)throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		String txthrmflns_case_dc 	 	= iMap.get("HRMFLNS_CASE_DC");
		String txthrmflns_case_dc_kor  	= iMap.get("HRMFLNS_CASE_DC_KOR");
		String txthrmflns_case_dc_eng  	= iMap.get("HRMFLNS_CASE_DC_ENG");
		String txtreportr_opinion 	 	= iMap.get("REPORTR_OPINION");
		String txtreportr_opinion_kor  	= iMap.get("REPORTR_OPINION_KOR");
		String txtreportr_opinion_eng  	= iMap.get("REPORTR_OPINION_ENG");
		String txtaplcnt_opinion 		= iMap.get("APLCNT_OPINION");
		String txtaplcnt_opinion_kor 	= iMap.get("APLCNT_OPINION_KOR");
		String txtaplcnt_opinion_eng 	= iMap.get("APLCNT_OPINION_ENG");
		String txtdifr_info 			= iMap.get("DIFR_INFO");
		String txtdifr_info_kor 		= iMap.get("DIFR_INFO_KOR");
		String txtdifr_info_eng 		= iMap.get("DIFR_INFO_ENG");
		String txtrsrch_nm 			 	= iMap.get("RSRCH_NM");
		String txtrsrch_nm_kor 		 	= iMap.get("RSRCH_NM_KOR");
		String txtrsrch_nm_eng 		 	= iMap.get("RSRCH_NM_ENG");
		
		if(iMap.get("CURD").equals("C")) {
			multiLangManageService.mullangInsert(txthrmflns_case_dc_kor, txthrmflns_case_dc_eng, "HRMFLNS_CASE_DC", iMap);
			multiLangManageService.mullangInsert(txtreportr_opinion_kor, txtreportr_opinion_eng, "REPORTR_OPINION", iMap);
			multiLangManageService.mullangInsert(txtaplcnt_opinion_kor, txtaplcnt_opinion_eng, "APLCNT_OPINION", iMap);
			multiLangManageService.mullangInsert(txtdifr_info_kor, txtdifr_info_eng, "DIFR_INFO", iMap);
			multiLangManageService.mullangInsert(txtrsrch_nm_kor, txtrsrch_nm_eng, "RSRCH_NM", iMap);
			
			String NarrativeSeq = sdbNarrativeSeq.getNextStringId();
			iMap.put("CASE_DC_SN", NarrativeSeq);
			sdbc02DAO.insertNarrativeInfo(iMap);	
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailhrmflnscasedc, null, null);
			
		}else if(iMap.get("CURD").equals("U")) {
			multiLangManageService.mullangUpdate(txthrmflns_case_dc, txthrmflns_case_dc_kor, txthrmflns_case_dc_eng, "HRMFLNS_CASE_DC", iMap);
			multiLangManageService.mullangUpdate(txtreportr_opinion, txtreportr_opinion_kor, txtreportr_opinion_eng, "REPORTR_OPINION", iMap);
			multiLangManageService.mullangUpdate(txtaplcnt_opinion, txtaplcnt_opinion_kor, txtaplcnt_opinion_eng, "APLCNT_OPINION", iMap);
			multiLangManageService.mullangUpdate(txtdifr_info, txtdifr_info_kor, txtdifr_info_eng, "DIFR_INFO", iMap);
			multiLangManageService.mullangUpdate(txtrsrch_nm, txtrsrch_nm_kor, txtrsrch_nm_eng, "RSRCH_NM", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflnscasedc, null, null);
			sdbc02DAO.updateNarrativeInfo(iMap);
		}else if(iMap.get("CURD").equals("D")){
			sdbc02DAO.deleteNarrativeInfo(iMap);
		}
		
	}
	
//	public void multiLangManageService.mullangInsert (String kor, String eng, String colName,  Map<String, String> iMap) throws Exception{
//		if((kor != null && !"".equals(kor)) || (eng != null && !"".equals(eng))){
//			String MullangSeq = sdbMullangSeq.getNextStringId();
//			sdbc02Service.insertMul(MullangSeq, kor, eng);
//			iMap.put(colName, MullangSeq);
//		}
//	}
//	
//	public void multiLangManageService.mullangUpdate (String code, String kor, String eng, String colName,  Map<String, String> iMap) throws Exception{
//		if(code == null || "".equals(code)){
//			String MullangSeq = sdbMullangSeq.getNextStringId();
//			sdbc02Service.insertMul(MullangSeq, kor, eng);
//			iMap.put(colName, MullangSeq);
//		}
//		else if((kor != null && !"".equals(kor)) || (eng != null && !"".equals(eng))|| (code != null && !"".equals(code))){
//			sdbc02Service.updateMul(code, kor, eng);
//		}
//	}
	
	@Override
	public Map<String, Object> selectNarrativeInfo(Map<String, String> iMap) throws Exception{
		return sdbc02DAO.selectNarrativeInfo(iMap);
		
	}
	
	@Override
	public List<Map<String, Object>> slSource(Map<String, String> iMap)throws Exception{
		//Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> result =  null;
		if (iMap.get("SOURCE_TYPE").equals("01")){
			result = sdbc02DAO.slSource_Study(iMap);
		}else if(iMap.get("SOURCE_TYPE").equals("02")){
			result = sdbc02DAO.slSource_Spontaneous(iMap);
		}
		else if(iMap.get("SOURCE_TYPE").equals("03")){
			result = sdbc02DAO.slSource_Literature(iMap);
		}
		else if(iMap.get("SOURCE_TYPE").equals("04")){
			result = sdbc02DAO.slSource_Etc(iMap);
		}
		else if(iMap.get("SOURCE_TYPE").equals("05")){
			result = sdbc02DAO.slSource_ICSR(iMap);
		}else{
			result = sdbc02DAO.slSource_Etc(iMap);			
		}
		
		return result;
	}
	
	@Override 
	public void insertDemographics(Map<String, String> iMap) throws Exception {
//		Map<String, String> iMap = new HashMap<String, String>();
//		iMap = param;	

		String txtin_out_etc_memo 		 	= iMap.get("IN_OUT_ETC_MEMO");
		String txtin_out_etc_memo_kor 		= iMap.get("IN_OUT_ETC_MEMO_KOR");
		String txtin_out_etc_memo_eng 		= iMap.get("IN_OUT_ETC_MEMO_ENG");
		String txtparnts_nm 				= iMap.get("PARNTS_NM");
		String txtparnts_nm_kor 			= iMap.get("PARNTS_NM_KOR");
		String txtparnts_nm_eng				= iMap.get("PARNTS_NM_ENG");
		String txtaddrone 		 			= iMap.get("ADRES");
		String txtaddrone_kor 		 		= iMap.get("ADRES_KOR");
		String txtaddrone_eng 		 		= iMap.get("ADRES_ENG");
		String txtinstt_nm 		 			= iMap.get("INSTT_NM");
		String txtinstt_nm_kor 		 		= iMap.get("INSTT_NM_KOR");
		String txtinstt_nm_eng 		 		= iMap.get("INSTT_NM_ENG");
		String txtadres_dstnc 		 		= iMap.get("ADRES_DSTNC");
		String txtadres_dstnc_kor 		 	= iMap.get("ADRES_DSTNC_KOR");
		String txtadres_dstnc_eng 		 	= iMap.get("ADRES_DSTNC_ENG");
		String txtadres_cty 		 		= iMap.get("ADRES_CTY");
		String txtadres_cty_kor 		 	= iMap.get("ADRES_CTY_KOR");
		String txtadres_cty_eng 		 	= iMap.get("ADRES_CTY_ENG");
		String txtadres_lclty 		 		= iMap.get("ADRES_LCLTY");
		String txtadres_lclty_kor 		 	= iMap.get("ADRES_LCLTY_KOR");
		String txtadres_lclty_eng 		 	= iMap.get("ADRES_LCLTY_ENG");
		String txtreportr 		 			= iMap.get("REPORTR");
		String txtreportr_kor 		 		= iMap.get("REPORTR_KOR");
		String txtreportr_eng 		 		= iMap.get("REPORTR_ENG");
		String txtreportr_appn_nm 		 	= iMap.get("REPORTR_APPN_NM");
		String txtreportr_appn_nm_kor 		= iMap.get("REPORTR_APPN_NM_KOR");
		String txtreportr_appn_nm_eng 		= iMap.get("REPORTR_APPN_NM_ENG");
		String txtreportr_middle_nm 		= iMap.get("REPORTR_MIDDLE_NM");
		String txtreportr_middle_nm_kor 	= iMap.get("REPORTR_MIDDLE_NM_KOR");
		String txtreportr_middle_nm_eng 	= iMap.get("REPORTR_MIDDLE_NM_ENG");
		String txtreportr_family_nm 		= iMap.get("REPORTR_FAMILY_NM");
		String txtreportr_family_nm_kor 	= iMap.get("REPORTR_FAMILY_NM_KOR");
		String txtreportr_family_nm_eng 	= iMap.get("REPORTR_FAMILY_NM_ENG");
		String txtreportr_dept 		 		= iMap.get("REPORTR_DEPT");
		String txtreportr_dept_kor 		 	= iMap.get("REPORTR_DEPT_KOR");
		String txtreportr_dept_eng 		 	= iMap.get("REPORTR_DEPT_ENG");
		String txtreprt_ty_detail 		 	= iMap.get("REPRT_TY_DETAIL");
		String txtreprt_ty_detail_kor 		= iMap.get("REPRT_TY_DETAIL_KOR");
		String txtreprt_ty_detail_eng 		= iMap.get("REPRT_TY_DETAIL_ENG");
		String txtclass 		 			= iMap.get("CLASS");
		String txtclass_kor 		 		= iMap.get("CLASS_KOR");
		String txtclass_eng 		 		= iMap.get("CLASS_ENG");
		String txtmajor 		 			= iMap.get("MAJOR");
		String txtmajor_kor 		 		= iMap.get("MAJOR_KOR");
		String txtmajor_eng 		 		= iMap.get("MAJOR_ENG");
		
				
		String txtdoc_list 							= iMap.get("DOC_LIST");
		String txtdoc_list_kor 						= iMap.get("DOC_LIST_KOR");	
		String txtdoc_list_eng 						= iMap.get("DOC_LIST_ENG");
		String txtregl_nation_case_reprt_no 		= iMap.get("REGL_NATION_CASE_REPRT_NO");
		String txtregl_nation_case_reprt_no_kor 	= iMap.get("REGL_NATION_CASE_REPRT_NO_KOR");
		String txtregl_nation_case_reprt_no_eng 	= iMap.get("REGL_NATION_CASE_REPRT_NO_ENG");
		String txtdifr_trnsmisman_reprt_no 			= iMap.get("DIFR_TRNSMISMAN_REPRT_NO");
		String txtdifr_trnsmisman_reprt_no_kor 		= iMap.get("DIFR_TRNSMISMAN_REPRT_NO_KOR");
		String txtdifr_trnsmisman_reprt_no_eng 		= iMap.get("DIFR_TRNSMISMAN_REPRT_NO_ENG");
		
		
		String txtbefore_report_manageno_sj 		= iMap.get("BEFORE_REPORT_MANAGENO_SJ");
		String txtbefore_report_manageno_sj_kor 	= iMap.get("BEFORE_REPORT_MANAGENO_SJ_KOR");
		String txtbefore_report_manageno_sj_eng 	= iMap.get("BEFORE_REPORT_MANAGENO_SJ_ENG");
		String txttracereport_resn_etc_opinion 		= iMap.get("TRACEREPORT_RESN_ETC_OPINION");
		String txttracereport_resn_etc_opinion_kor 	= iMap.get("TRACEREPORT_RESN_ETC_OPINION_KOR");
		String txttracereport_resn_etc_opinion_eng 	= iMap.get("TRACEREPORT_RESN_ETC_OPINION_ENG");
		String txtreferreport_manageno_sj 		 	= iMap.get("REFERREPORT_MANAGENO_SJ");
		String txtreferreport_manageno_sj_kor 		= iMap.get("REFERREPORT_MANAGENO_SJ_KOR");
		String txtreferreport_manageno_sj_eng 		= iMap.get("REFERREPORT_MANAGENO_SJ_ENG");
		String txtreport_cancl_resn 		 		= iMap.get("REPORT_CANCL_RESN");
		String txtreport_cancl_resn_kor 		 	= iMap.get("REPORT_CANCL_RESN_KOR");
		String txtreport_cancl_resn_eng 		 	= iMap.get("REPORT_CANCL_RESN_ENG");
		String txtsamensscase_etc_opinion 		 	= iMap.get("SAMENSSCASE_ETC_OPINION");
		String txtsamensscase_etc_opinion_kor 		= iMap.get("SAMENSSCASE_ETC_OPINION_KOR");
		String txtsamensscase_etc_opinion_eng 		= iMap.get("SAMENSSCASE_ETC_OPINION_ENG");
		String txtreprt_ty_etc_opinion 		 		= iMap.get("REPRT_TY_ETC_OPINION");
		String txtreprt_ty_etc_opinion_kor 		 	= iMap.get("REPRT_TY_ETC_OPINION_KOR");
		String txtreprt_ty_etc_opinion_eng 		 	= iMap.get("REPRT_TY_ETC_OPINION_ENG");
		String txtqualf_etc_opinion 		 		= iMap.get("QUALF_ETC_OPINION");
		String txtqualf_etc_opinion_kor 		 	= iMap.get("QUALF_ETC_OPINION_KOR");
		String txtqualf_etc_opinion_eng 		 	= iMap.get("QUALF_ETC_OPINION_ENG");

		
		
		
		if(iMap.get("CURD").equals("C")) {
			if(iMap.get("SOURCE_TYPE").equals("01")){
				iMap.put("PRTCL_NO", iMap.get("SOURCE")); 
			}else if(iMap.get("SOURCE_TYPE").equals("02")){
				iMap.put("SAFE_REPRT_NO", iMap.get("SOURCE"));
			}else if(iMap.get("SOURCE_TYPE").equals("03")){
				iMap.put("LTRTRE_NO", iMap.get("SOURCE"));
			}else if(iMap.get("SOURCE_TYPE").equals("04")){
				iMap.put("ETC_INFO_NO", iMap.get("SOURCE"));
			}			
			
			multiLangManageService.mullangInsert(txtdoc_list_kor, txtdoc_list_eng, "IN_OUT_ETC_MEMO", iMap);
			multiLangManageService.mullangInsert(txtregl_nation_case_reprt_no_kor, txtregl_nation_case_reprt_no_eng, "REGL_NATION_CASE_REPRT_NO", iMap);
			multiLangManageService.mullangInsert(txtdifr_trnsmisman_reprt_no_kor, txtdifr_trnsmisman_reprt_no_eng, "DIFR_TRNSMISMAN_REPRT_NO", iMap);
						
			multiLangManageService.mullangInsert(txtin_out_etc_memo_kor, txtin_out_etc_memo_eng, "IN_OUT_ETC_MEMO", iMap);
			multiLangManageService.mullangInsert(txtparnts_nm_kor, txtparnts_nm_eng, "PARNTS_NM", iMap);
			multiLangManageService.mullangInsert(txtinstt_nm_kor, txtinstt_nm_eng, "INSTT_NM", iMap);
			multiLangManageService.mullangInsert(txtaddrone_kor, txtaddrone_eng, "ADRES", iMap);
			multiLangManageService.mullangInsert(txtadres_dstnc_kor, txtadres_dstnc_eng, "ADRES_DSTNC", iMap);
			multiLangManageService.mullangInsert(txtadres_cty_kor, txtadres_cty_eng, "ADRES_CTY", iMap);
			multiLangManageService.mullangInsert(txtadres_lclty_kor, txtadres_lclty_eng, "ADRES_LCLTY", iMap);
			multiLangManageService.mullangInsert(txtreportr_kor, txtreportr_eng, "REPORTR", iMap);
			multiLangManageService.mullangInsert(txtreportr_appn_nm_kor, txtreportr_appn_nm_eng, "REPORTR_APPN_NM", iMap);
			multiLangManageService.mullangInsert(txtreportr_middle_nm_kor, txtreportr_middle_nm_eng, "REPORTR_MIDDLE_NM", iMap);
			multiLangManageService.mullangInsert(txtreportr_family_nm_kor, txtreportr_family_nm_eng, "REPORTR_FAMILY_NM", iMap);
			multiLangManageService.mullangInsert(txtreportr_dept_kor, txtreportr_dept_eng, "REPORTR_DEPT", iMap);
			multiLangManageService.mullangInsert(txtreprt_ty_detail_kor, txtreprt_ty_detail_eng, "REPRT_TY_DETAIL", iMap);
			multiLangManageService.mullangInsert(txtclass_kor, txtclass_eng, "CLASS", iMap);
			multiLangManageService.mullangInsert(txtmajor_kor, txtmajor_eng, "MAJOR", iMap);
			//추가사항
			multiLangManageService.mullangInsert(txtbefore_report_manageno_sj_kor, txtbefore_report_manageno_sj_eng, "BEFORE_REPORT_MANAGENO_SJ", iMap);
			multiLangManageService.mullangInsert(txttracereport_resn_etc_opinion_kor, txttracereport_resn_etc_opinion_eng, "TRACEREPORT_RESN_ETC_OPINION", iMap);
			multiLangManageService.mullangInsert(txtreferreport_manageno_sj_kor, txtreferreport_manageno_sj_eng, "REFERREPORT_MANAGENO_SJ", iMap);
			multiLangManageService.mullangInsert(txtreport_cancl_resn_kor, txtreport_cancl_resn_eng, "REPORT_CANCL_RESN", iMap);
			multiLangManageService.mullangInsert(txtsamensscase_etc_opinion_kor, txtsamensscase_etc_opinion_eng, "SAMENSSCASE_ETC_OPINION", iMap);
			multiLangManageService.mullangInsert(txtreprt_ty_etc_opinion_kor, txtreprt_ty_etc_opinion_eng, "REPRT_TY_ETC_OPINION", iMap);
			multiLangManageService.mullangInsert(txtqualf_etc_opinion_kor, txtqualf_etc_opinion_eng, "QUALF_ETC_OPINION", iMap);
			
			int iDemographicsSeq = Integer.parseInt(sdbDemographicsSeq.getNextStringId());
			String txt_code = String.format("%04d", iDemographicsSeq);
		    Calendar c = Calendar.getInstance();
		    String txtYear = new String();
		    String txtFollowNm = iMap.get("FOLLOW_NO");
		    
		    if (txtFollowNm == null || "".equals(txtFollowNm)|| txtFollowNm.equals("0")){
		    	txtFollowNm ="00";		    	
		    }else{
		    	txtFollowNm   = String.format("%02d", txtFollowNm);		    	
		    }
		    txtYear = String.valueOf(c.get(Calendar.YEAR));
			String Category ="S"; //manufactoring nm			
			String txtTg_code_h = Category+""+txtYear+"_"+txt_code;
			String txtTg_code = Category+""+txtYear+"_"+txt_code+"_"+txtFollowNm; 			
			iMap.put("HRMFLNS_CASE_CODE", txtTg_code_h);
			iMap.put("MAFU_NO", txtTg_code);
			// Report information SEQ
			String iSourceSeq = sdbDmstcRptSeq.getNextStringId();
			String txt_code_s = String.format("%04d", Integer.parseInt(iSourceSeq));
			String Category_s ="RI"; // Report Information
			String txt_s_code =  Category_s+""+txtYear+"_"+txt_code_s;
			iMap.put("RPT_NO", txt_s_code);
			// Reporter SEQ
			int iReportSeq = Integer.parseInt(sdbReportSeq.getNextStringId());
			String txt_code2 = String.format("%04d", iReportSeq);		    
		    String txtYear2 = new String();
		    txtYear2 = String.valueOf(c.get(Calendar.YEAR));
			String Category2 ="RE"; // 거래선			
			String txtTg_code2 = Category2+""+txtYear2+""+txt_code2;
			iMap.put("REPORTER_NO", txtTg_code2);
			
			String iParentSeq =sdbParentSeq.getNextStringId();
			iMap.put("PARNTS_NO", iParentSeq);
			
			sdbc02DAO.insertDemographics(iMap);
			sdbc02DAO.insertManufactorer(iMap);
			sdbc02DAO.insertReporter(iMap);
			sdbc02DAO.insertParent(iMap);
			
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailhrmflns_case_info, null, null);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atraildmstcrptinfo, null, null);			
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailreporter_info, null, null);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailparnts_info, null, null);
//			
		}else if(iMap.get("CURD").equals("U")) {
			multiLangManageService.mullangUpdate(txtdoc_list, txtdoc_list_kor, txtdoc_list_eng, "DOC_LIST", iMap);
			multiLangManageService.mullangUpdate(txtregl_nation_case_reprt_no, txtregl_nation_case_reprt_no_kor, txtregl_nation_case_reprt_no_eng, "REGL_NATION_CASE_REPRT_NO", iMap);
			multiLangManageService.mullangUpdate(txtdifr_trnsmisman_reprt_no, txtdifr_trnsmisman_reprt_no_kor, txtdifr_trnsmisman_reprt_no_eng, "DIFR_TRNSMISMAN_REPRT_NO", iMap);
			
			multiLangManageService.mullangUpdate(txtin_out_etc_memo, txtin_out_etc_memo_kor, txtin_out_etc_memo_eng, "IN_OUT_ETC_MEMO", iMap);
			multiLangManageService.mullangUpdate(txtparnts_nm,txtparnts_nm_kor, txtparnts_nm_eng, "PARNTS_NM", iMap);
			multiLangManageService.mullangUpdate(txtinstt_nm, txtinstt_nm_kor, txtinstt_nm_eng, "INSTT_NM", iMap);
			multiLangManageService.mullangUpdate(txtaddrone, txtaddrone_kor, txtaddrone_eng, "ADRES", iMap);
			multiLangManageService.mullangUpdate(txtadres_dstnc, txtadres_dstnc_kor, txtadres_dstnc_eng, "ADRES_DSTNC", iMap);
			multiLangManageService.mullangUpdate(txtadres_cty, txtadres_cty_kor, txtadres_cty_eng, "ADRES_CTY", iMap);
			multiLangManageService.mullangUpdate(txtadres_lclty, txtadres_lclty_kor, txtadres_lclty_eng, "ADRES_LCLTY", iMap);
			multiLangManageService.mullangUpdate(txtreportr, txtreportr_kor, txtreportr_eng, "REPORTR", iMap);
			multiLangManageService.mullangUpdate(txtreportr_appn_nm, txtreportr_appn_nm_kor, txtreportr_appn_nm_eng, "REPORTR_APPN_NM", iMap);
			multiLangManageService.mullangUpdate(txtreportr_middle_nm, txtreportr_middle_nm_kor, txtreportr_middle_nm_eng, "REPORTR_MIDDLE_NM", iMap);
			multiLangManageService.mullangUpdate(txtreportr_family_nm, txtreportr_family_nm_kor, txtreportr_family_nm_eng, "REPORTR_FAMILY_NM", iMap);
			multiLangManageService.mullangUpdate(txtreportr_dept, txtreportr_dept_kor, txtreportr_dept_eng, "REPORTR_DEPT", iMap);
			multiLangManageService.mullangUpdate(txtreprt_ty_detail, txtreprt_ty_detail_kor, txtreprt_ty_detail_eng, "REPRT_TY_DETAIL", iMap);
			multiLangManageService.mullangUpdate(txtclass, txtclass_kor, txtclass_eng, "CLASS", iMap);
			multiLangManageService.mullangUpdate(txtmajor, txtmajor_kor, txtmajor_eng, "MAJOR", iMap);
			//추가사항
			multiLangManageService.mullangUpdate(txtbefore_report_manageno_sj, txtbefore_report_manageno_sj_kor, txtbefore_report_manageno_sj_eng, "BEFORE_REPORT_MANAGENO_SJ", iMap);
			multiLangManageService.mullangUpdate(txttracereport_resn_etc_opinion, txttracereport_resn_etc_opinion_kor, txttracereport_resn_etc_opinion_eng, "TRACEREPORT_RESN_ETC_OPINION", iMap);
			multiLangManageService.mullangUpdate(txtreferreport_manageno_sj, txtreferreport_manageno_sj_kor, txtreferreport_manageno_sj_eng, "REFERREPORT_MANAGENO_SJ", iMap);
			multiLangManageService.mullangUpdate(txtreport_cancl_resn, txtreport_cancl_resn_kor, txtreport_cancl_resn_eng, "REPORT_CANCL_RESN", iMap);
			multiLangManageService.mullangUpdate(txtsamensscase_etc_opinion, txtsamensscase_etc_opinion_kor, txtsamensscase_etc_opinion_eng, "SAMENSSCASE_ETC_OPINION", iMap);
			multiLangManageService.mullangUpdate(txtreprt_ty_etc_opinion, txtreprt_ty_etc_opinion_kor, txtreprt_ty_etc_opinion_eng, "REPRT_TY_ETC_OPINION", iMap);
			multiLangManageService.mullangUpdate(txtqualf_etc_opinion, txtqualf_etc_opinion_kor, txtqualf_etc_opinion_eng, "QUALF_ETC_OPINION", iMap);
			
//			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflnscasedc, null, null);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atraildmstcrptinfo, null, null);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailreporter_info, null, null);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailparnts_info, null, null);
			
			sdbc02DAO.updateDemographics(iMap);
			sdbc02DAO.updateManufactorer(iMap);
			sdbc02DAO.updateReporter(iMap);
			sdbc02DAO.updateParent(iMap);
		}else if(iMap.get("CURD").equals("D")){
			
			sdbc02DAO.deleteDemographics(iMap);
		}
	}
	
	@Override
	public Map<String, Object> selectDemographics(Map<String, String> iMap) throws Exception {
		if (iMap.get("SOURCE_TYPE").equals("01")){
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
			
		}else if(iMap.get("SOURCE_TYPE").equals("02")){
			iMap.put("SOURC_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("03")){
			iMap.put("LTRTRE_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("04")){
			iMap.put("ETC_INFO_NO",iMap.get("SOURCE"));
		}
		else{
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
		}
		
		return sdbc02DAO.selectDemographics(iMap);
	}
	
	@Override
	public Map<String, Object> selectDemographics_Case(Map<String, String> param) throws Exception{
		return sdbc02DAO.selectDemographics_Case(param);
	}
	
	@Override
	public List<Map<String, Object>> selectSiteSubject(Map<String, String> iMap) throws Exception{
		List<Map<String, Object>> result =  null;
		if (iMap.get("SOURCE_TYPE").equals("01")){
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
			
		}else if(iMap.get("SOURCE_TYPE").equals("02")){
			iMap.put("SOURC_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("03")){
			iMap.put("LTRTRE_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("04")){
			iMap.put("ETC_INFO_NO",iMap.get("SOURCE"));
		}
		else{
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
		}
		
		result = sdbc02DAO.selectSiteSubject(iMap);
		
		return result;
	}
	
	@Override
	public List<Map<String, Object>> selectFollow(Map<String, String> iMap) throws Exception{
		List<Map<String, Object>> result =  null;
		if (iMap.get("SOURCE_TYPE").equals("01")){
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
			
		}else if(iMap.get("SOURCE_TYPE").equals("02")){
			iMap.put("SOURC_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("03")){
			iMap.put("LTRTRE_NO",iMap.get("SOURCE"));
		}
		else if(iMap.get("SOURCE_TYPE").equals("04")){
			iMap.put("ETC_INFO_NO",iMap.get("SOURCE"));
		}
		else{
			iMap.put("PRTCL_NO",iMap.get("SOURCE"));
		}
		
		result = sdbc02DAO.selectFollow(iMap);
		
		return result;
		
	}
	
	@Override
	public List<Map<String, Object>> selectLabList(Map<String, String> param) throws Exception{
		List<Map<String, Object>> result = null;
		result = sdbc02DAO.selectLabList(param);
		
		return result;
		
	}
	
	@Override
	public void insertLabInfo(Map<String, String> param) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		String txtunit 		= iMap.get("UNIT");
		String txtunit_kor 	= iMap.get("UNIT_KOR");
		String txtunit_eng 	= iMap.get("UNIT_ENG");
		String txtmemo 		= iMap.get("MEMO");
		String txtmemo_kor 	= iMap.get("MEMO_KOR");
		String txtmemo_eng 	= iMap.get("MEMO_ENG");
		
		String txttest 						= iMap.get("TEST");
		String txttest_kor 					= iMap.get("TEST_KOR");
		String txttest_eng 					= iMap.get("TEST_ENG");
		String txtresult 					= iMap.get("RESULT");
		String txtresult_kor 				= iMap.get("RESULT_KOR");
		String txtresult_eng 				= iMap.get("RESULT_ENG");
		String txttest_rcord_cmmn_memo 		= iMap.get("TEST_RCORD_CMMN_MEMO");
		String txttest_rcord_cmmn_memo_kor 	= iMap.get("TEST_RCORD_CMMN_MEMO_KOR");
		String txttest_rcord_cmmn_memo_eng 	= iMap.get("TEST_RCORD_CMMN_MEMO_ENG");
		
		if(iMap.get("CURD").equals("C")){
			String LabSeq = sdbLabSeq.getNextStringId();
			iMap.put("TEST_NO", LabSeq);
			multiLangManageService.mullangInsert(txttest_rcord_cmmn_memo_kor, txttest_rcord_cmmn_memo_eng, "TEST_RCORD_CMMN_MEMO", iMap);
			
			multiLangManageService.mullangInsert(txtunit_kor, txtunit_eng, "UNIT", iMap);
			multiLangManageService.mullangInsert(txtmemo_kor, txtmemo_eng, "MEMO", iMap);
			multiLangManageService.mullangInsert(txttest_kor, txttest_eng, "TEST", iMap);
			multiLangManageService.mullangInsert(txtresult_kor, txtresult_eng, "RESULT", iMap);
			
			sdbc02DAO.insertLabInfo(iMap);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailtestinfo, null, null);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsLab(iMap);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txttest_rcord_cmmn_memo, txttest_rcord_cmmn_memo_kor, txttest_rcord_cmmn_memo_eng, "TEST_RCORD_CMMN_MEMO", iMap);
			
			multiLangManageService.mullangUpdate(txtunit, txtunit_kor, txtunit_eng, "UNIT", iMap);
			multiLangManageService.mullangUpdate(txtmemo, txtmemo_kor, txtmemo_eng, "MEMO", iMap);
			multiLangManageService.mullangUpdate(txttest, txttest_kor, txttest_eng, "TEST", iMap);
			multiLangManageService.mullangUpdate(txtresult, txtresult_kor, txtresult_eng, "RESULT", iMap);
			
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailtestinfo, null, null);
			sdbc02DAO.updateLabInfo(iMap);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsLab(iMap);
		}else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailtestinfo, null, null);
			sdbc02DAO.deleteLabInfo(iMap);			
		}else if(iMap.get("CURD").equals("DEMO")){
			multiLangManageService.mullangUpdate(txttest_rcord_cmmn_memo, txttest_rcord_cmmn_memo_kor, txttest_rcord_cmmn_memo_eng, "TEST_RCORD_CMMN_MEMO", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsLab(iMap);			
		}
		
	}
	
	@Override
	public Map<String, Object> selectLabListInfo(Map<String, Object> param) throws Exception{
		
		return sdbc02DAO.selectLabListInfo(param); 
	}
	
	@Override
	public Map<String, Object> selectDemographicsLab(Map<String, String> param) throws Exception{
		return sdbc02DAO.selectDemographicsLab(param);
		
	}
	
	@Override	
	public Map<String, Object> selectDemographicsMedi(Map<String, String> param) throws Exception{
		return sdbc02DAO.selectDemographicsMedi(param);
	}
	
	@Override
	public List<Map<String, Object>> selectMedicalList(Map<String, String> map) throws Exception{
		List<Map<String, Object>> result = null;
		result = sdbc02DAO.selectMedicalList(map);
		
		return result;
	}
	
	@Override
	public Map<String, Object> selectMedicalHistoryInfo (Map<String, Object> param) throws Exception{
		
		return sdbc02DAO.selectMedicalHistoryInfo(param);
	}
	
	@Override
	public void insertMedicalHistory(Map<String, String> param) throws Exception {
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		String txtrcord_memo 		= iMap.get("RCORD_MEMO");
		String txtrcord_memo_kor 	= iMap.get("RCORD_MEMO_KOR");
		String txtrcord_memo_eng 	= iMap.get("RCORD_MEMO_ENG");
		
		String txtmdlc_rcord_nm 		= iMap.get("MDLC_RCORD_NM");
		String txtmdlc_rcord_nm_kor 	= iMap.get("MDLC_RCORD_NM_KOR");
		String txtmdlc_rcord_nm_eng 	= iMap.get("MDLC_RCORD_NM_ENG");	
		String txtmdlc_rcord_cmmn_memo 		= iMap.get("MDLC_RCORD_CMMN_MEMO");
		String txtmdlc_rcord_cmmn_memo_kor 	= iMap.get("MDLC_RCORD_CMMN_MEMO_KOR");
		String txtmdlc_rcord_cmmn_memo_eng 	= iMap.get("MDLC_RCORD_CMMN_MEMO_ENG");
		
		if(iMap.get("CURD").equals("C")){
			String MedicalSeq = sdbMedicalSeq.getNextStringId();
			iMap.put("MDLC_RCORD_NO", MedicalSeq);
			
			multiLangManageService.mullangInsert(txtrcord_memo_kor, txtrcord_memo_eng, "RCORD_MEMO", iMap);
			multiLangManageService.mullangInsert(txtmdlc_rcord_nm_kor, txtmdlc_rcord_nm_eng, "MDLC_RCORD_NM", iMap);
			multiLangManageService.mullangInsert(txtmdlc_rcord_cmmn_memo_kor, txtmdlc_rcord_cmmn_memo_eng, "MDLC_RCORD_CMMN_MEMO", iMap);
			
			sdbc02DAO.insertMedicalHistory(iMap);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailmdlc_rcord_info, null, null);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsMedi(iMap);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtrcord_memo, txtrcord_memo_kor, txtrcord_memo_eng, "RCORD_MEMO", iMap);
			multiLangManageService.mullangUpdate(txtmdlc_rcord_nm, txtmdlc_rcord_nm_kor, txtmdlc_rcord_nm_eng, "MDLC_RCORD_NM", iMap);
			multiLangManageService.mullangUpdate(txtmdlc_rcord_cmmn_memo, txtmdlc_rcord_cmmn_memo_kor, txtmdlc_rcord_cmmn_memo_eng, "MDLC_RCORD_CMMN_MEMO", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmdlc_rcord_info, null, null);
			sdbc02DAO.updateMedicalHistory(iMap);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsMedi(iMap);
		}else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmdlc_rcord_info, null, null);
			sdbc02DAO.deleteMedicalHistory(iMap);			
		}else if(iMap.get("CURD").equals("DEMO")){
			multiLangManageService.mullangUpdate(txtmdlc_rcord_cmmn_memo, txtmdlc_rcord_cmmn_memo_kor, txtmdlc_rcord_cmmn_memo_eng, "MDLC_RCORD_CMMN_MEMO", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
			sdbc02DAO.updateDemographicsMedi(iMap);			
		}
		
	}
	
	@Override
	public List<Map<String, Object>> selectDrugHistory(Map<String, String> map) throws Exception{
		List<Map<String, Object>> result = null;
		result = sdbc02DAO.selectDrugHistory(map);
		
		return result;
	}
	
	@Override
	public Map<String, Object> selectDrugHistoryInfo(Map<String, Object> param) throws Exception{
		
		return sdbc02DAO.selectDrugHistoryInfo(param);
	}
	
	@Override
	public void insertDrugHistory(Map<String, String> map) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = map;
		String txtmedcin_recoed_nm 		= iMap.get("MEDCIN_RECOED_NM");
		String txtmedcin_recoed_nm_kor 	= iMap.get("MEDCIN_RECOED_NM_KOR");
		String txtmedcin_recoed_nm_eng 	= iMap.get("MEDCIN_RECOED_NM_ENG");
		String txtmedcin_rcord_nm 		= iMap.get("MEDCIN_RCORD_NM");	
		String txtmedcin_rcord_nm_kor 	= iMap.get("MEDCIN_RCORD_NM_KOR");	
		String txtmedcin_rcord_nm_eng 	= iMap.get("MEDCIN_RCORD_NM_ENG");	
		String txtunconfm_medcinnm 		= iMap.get("UNCONFM_MEDCINNM");	
		String txtunconfm_medcinnm_kor 	= iMap.get("UNCONFM_MEDCINNM_KOR");	
		String txtunconfm_medcinnm_eng 	= iMap.get("UNCONFM_MEDCINNM_ENG");	
		String txtsgn_memo 				= iMap.get("SGN_MEMO");	
		String txtsgn_memo_kor 			= iMap.get("SGN_MEMO_KOR");	
		String txtsgn_memo_eng 			= iMap.get("SGN_MEMO_ENG");	
		String txtrespns_memo 			= iMap.get("RESPNS_MEMO");	
		String txtrespns_memo_kor 		= iMap.get("RESPNS_MEMO_KOR");	
		String txtrespns_memo_eng 		= iMap.get("RESPNS_MEMO_ENG");
		String txtdetail_cn				= iMap.get("DETAIL_CN");	
		String txtdetail_cn_kor 		= iMap.get("DETAIL_CN_KOR");	
		String txtdetail_cn_eng 		= iMap.get("DETAIL_CN_ENG");
		
		if(iMap.get("CURD").equals("C")){
			String DrugHistorySeq = sdbDrugHistorySeq.getNextStringId();
			iMap.put("MEDCIN_RCORD_NO", DrugHistorySeq);
			
			multiLangManageService.mullangInsert(txtmedcin_recoed_nm_kor, txtmedcin_recoed_nm_eng, "MEDCIN_RECOED_NM", iMap);
			multiLangManageService.mullangInsert(txtmedcin_rcord_nm_kor, txtmedcin_rcord_nm_eng, "MEDCIN_RCORD_NM", iMap);
			multiLangManageService.mullangInsert(txtunconfm_medcinnm_kor, txtunconfm_medcinnm_eng, "UNCONFM_MEDCINNM", iMap);
			multiLangManageService.mullangInsert(txtsgn_memo_kor, txtsgn_memo_eng, "SGN_MEMO", iMap);
			multiLangManageService.mullangInsert(txtrespns_memo_kor, txtrespns_memo_eng, "RESPNS_MEMO", iMap);
			multiLangManageService.mullangInsert(txtdetail_cn_kor, txtdetail_cn_eng, "DETAIL_CN", iMap);
			
			sdbc02DAO.insertDrugHistory(iMap);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailmedcin_rcord_info, null, null);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtmedcin_recoed_nm, txtmedcin_recoed_nm_kor, txtmedcin_recoed_nm_eng, "MEDCIN_RECOED_NM", iMap);
			multiLangManageService.mullangUpdate(txtmedcin_rcord_nm, txtmedcin_rcord_nm_kor, txtmedcin_rcord_nm_eng, "MEDCIN_RCORD_NM", iMap);
			multiLangManageService.mullangUpdate(txtunconfm_medcinnm, txtunconfm_medcinnm_kor, txtunconfm_medcinnm_eng, "UNCONFM_MEDCINNM", iMap);
			multiLangManageService.mullangUpdate(txtsgn_memo, txtsgn_memo_kor, txtsgn_memo_eng, "SGN_MEMO", iMap);
			multiLangManageService.mullangUpdate(txtrespns_memo, txtrespns_memo_kor, txtrespns_memo_eng, "RESPNS_MEMO", iMap);
			multiLangManageService.mullangUpdate(txtdetail_cn, txtdetail_cn_kor, txtdetail_cn_eng, "DETAIL_CN", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmedcin_rcord_info, null, null);
			sdbc02DAO.updateDrugHistory(iMap);
		}else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmedcin_rcord_info, null, null);
			sdbc02DAO.deleteDrugHistory(iMap);			
		}
		
	}
	
	@Override
	public List<Map<String, Object>> selectCasualityList(Map<String, String> map) throws Exception {
		List<Map<String, Object>> result = null;
		result = sdbc02DAO.selectCasualityList(map);
		
		return result;
	
	}
	
	@Override
	public void insertCasuality(List<Map<String, Object>> list) throws Exception{
		
		for(Map<String, Object> iMap : list) {
			 if(iMap.get("CURD").equals("U")) {				
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailrelate, null, null);
				sdbc02DAO.updateCasuality(iMap);
				
			} 
		}
	}
	
	@Override
	public void insertDrug(Map<String, String> map)throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = map;
		String txtmedcin_recoed_nm 			= iMap.get("MEDCIN_RECOED_NM");
		String txtmedcin_recoed_nm_kor 		= iMap.get("MEDCIN_RECOED_NM_KOR");
		String txtmedcin_recoed_nm_eng 		= iMap.get("MEDCIN_RECOED_NM_ENG");
		String txtmedcin_nm 				= iMap.get("MEDCIN_NM");
		String txtmedcin_nm_kor 			= iMap.get("MEDCIN_NM_KOR");
		String txtmedcin_nm_eng 			= iMap.get("MEDCIN_NM_ENG");
		String txtrstrct_form 				= iMap.get("RSTRCT_FORM");
		String txtrstrct_form_kor 			= iMap.get("RSTRCT_FORM_KOR");
		String txtrstrct_form_eng 			= iMap.get("RSTRCT_FORM_ENG");
		String txtcours 					= iMap.get("COURS");
		String txtcours_kor 				= iMap.get("COURS_KOR");
		String txtcours_eng 				= iMap.get("COURS_ENG");
		String txtfdqnt 					= iMap.get("FDQNT");
		String txtfdqnt_kor 				= iMap.get("FDQNT_KOR");
		String txtfdqnt_eng 				= iMap.get("FDQNT_ENG");
		String txtunit 						= iMap.get("UNIT");
		String txtunit_kor 					= iMap.get("UNIT_KOR");
		String txtunit_eng 					= iMap.get("UNIT_ENG");
		String txtdifr_usage_user_info 		= iMap.get("DIFR_USAGE_USER_INFO");
		String txtdifr_usage_user_info_kor 	= iMap.get("DIFR_USAGE_USER_INFO_KOR");
		String txtdifr_usage_user_info_eng 	= iMap.get("DIFR_USAGE_USER_INFO_ENG");
		String txtsgn_memo 					= iMap.get("SGN_MEMO");
		String txtsgn_memo_kor 				= iMap.get("SGN_MEMO_KOR");
		String txtsgn_memo_eng 				= iMap.get("SGN_MEMO_ENG");
		String txtdifr_info 				= iMap.get("DIFR_INFO");
		String txtdifr_info_kor 			= iMap.get("DIFR_INFO_KOR");
		String txtdifr_info_eng 			= iMap.get("DIFR_INFO_ENG");                  
		
		if(iMap.get("CURD").equals("C")){
			String DrugSeq = sdbDrugSeq.getNextStringId();
			iMap.put("MEDCIN_INFO_NO", DrugSeq);
			
			multiLangManageService.mullangInsert(txtmedcin_recoed_nm_kor, txtmedcin_recoed_nm_eng, "MEDCIN_RECOED_NM", iMap);
			multiLangManageService.mullangInsert(txtmedcin_nm_kor, txtmedcin_nm_eng, "MEDCIN_NM", iMap);
			multiLangManageService.mullangInsert(txtrstrct_form_kor, txtrstrct_form_eng, "RSTRCT_FORM", iMap);
			multiLangManageService.mullangInsert(txtcours_kor, txtcours_eng, "COURS", iMap);
			multiLangManageService.mullangInsert(txtfdqnt_kor, txtfdqnt_eng, "FDQNT", iMap);
			multiLangManageService.mullangInsert(txtunit_kor, txtunit_eng, "UNIT", iMap);
			multiLangManageService.mullangInsert(txtdifr_usage_user_info_kor, txtdifr_usage_user_info_eng, "DIFR_USAGE_USER_INFO", iMap);
			multiLangManageService.mullangInsert(txtsgn_memo_kor, txtsgn_memo_eng, "SGN_MEMO", iMap);
			multiLangManageService.mullangInsert(txtdifr_info_kor, txtdifr_info_eng, "DIFR_INFO", iMap);
			
			sdbc02DAO.insertDrug(iMap);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailmedcin_info, null, null);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtmedcin_recoed_nm, txtmedcin_recoed_nm_kor, txtmedcin_recoed_nm_eng, "MEDCIN_RECOED_NM", iMap);
			multiLangManageService.mullangUpdate(txtmedcin_nm, txtmedcin_nm_kor, txtmedcin_nm_eng, "MEDCIN_NM", iMap);
			multiLangManageService.mullangUpdate(txtrstrct_form, txtrstrct_form_kor, txtrstrct_form_eng, "RSTRCT_FORM", iMap);
			multiLangManageService.mullangUpdate(txtcours, txtcours_kor, txtcours_eng, "COURS", iMap);
			multiLangManageService.mullangUpdate(txtfdqnt, txtfdqnt_kor, txtfdqnt_eng, "FDQNT", iMap);
			multiLangManageService.mullangUpdate(txtunit, txtunit_kor, txtunit_eng, "UNIT", iMap);
			multiLangManageService.mullangUpdate(txtdifr_usage_user_info, txtdifr_usage_user_info_kor, txtdifr_usage_user_info_eng, "DIFR_USAGE_USER_INFO", iMap);
			multiLangManageService.mullangUpdate(txtsgn_memo, txtsgn_memo_kor, txtsgn_memo_eng, "SGN_MEMO", iMap);
			multiLangManageService.mullangUpdate(txtdifr_info, txtdifr_info_kor, txtdifr_info_eng, "DIFR_INFO", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmedcin_info, null, null);
			sdbc02DAO.updateDrug(iMap);
		}else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmedcin_info, null, null);
			sdbc02DAO.deleteDrug(iMap);			
		}
	
	}
	
	
	@Override
	public List<Map<String, Object>> selectDrugList(Map<String, String> map) throws Exception{
		List<Map<String, Object>> result = null;
		result = sdbc02DAO.selectDrugList(map);
		
		return result;
		
	}
	
	@Override
	public Map<String, Object> selectDrugInfo(Map<String, Object> param) throws Exception {
		return sdbc02DAO.selectDrugInfo(param);
		
	}
	
	@Override
	public List<Map<String, Object>> selectAeList(Map<String, String> param) throws Exception{
		List<Map<String, Object>> result = null;
		
		result = sdbc02DAO.selectAeList(param);
		
		return result;	
		
	}
	
	@Override
	public Map<String, Object> selectAeInfo(Map<String, String> param) throws Exception{		
		
		return sdbc02DAO.selectAeInfo(param);
		
	}
	
	@Override
	public Map<String, Object> selectDemoAeInfo(Map<String, String> param) throws Exception{
		return sdbc02DAO.selectDemoAeInfo(param);
	}
	
	@Override
	public void insertAe(Map<String, String> map) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = map;
		
		sdbc02DAO.updateDemoAe(iMap);
		
		String txtadverse_event 			= iMap.get("ADVERSE_EVENT");
		String txtadverse_event_kor 		= iMap.get("ADVERSE_EVENT_KOR");
		String txtadverse_event_eng 		= iMap.get("ADVERSE_EVENT_ENG");
		String txtmemo 						= iMap.get("MEMO");
		String txtmemo_kor 					= iMap.get("MEMO_KOR");
		String txtmemo_eng 					= iMap.get("MEMO_ENG");
		String txtemrps_resn	 			= iMap.get("EMRPS_RESN");
		String txtemrps_resn_kor 			= iMap.get("EMRPS_RESN_KOR");
		String txtemrps_resn_eng 			= iMap.get("EMRPS_RESN_ENG");
		String txtetc			 			= iMap.get("ETC");
		String txtetc_kor			 		= iMap.get("ETC_KOR");
		String txtetc_eng 					= iMap.get("ETC_ENG");		
		String txtae_detail_cn			 	= iMap.get("AE_DETAIL_CN");
		String txtae_detail_cn_kor			= iMap.get("AE_DETAIL_CN_KOR");
		String txtae_detail_cn_eng 			= iMap.get("AE_DETAIL_CN_ENG");
		
		if(iMap.get("CURD").equals("C")){ 
			String AeSeq = sdbAeSeq.getNextStringId();
			iMap.put("AE_NO", AeSeq);
			
			multiLangManageService.mullangInsert(txtadverse_event_kor, txtadverse_event_eng, "ADVERSE_EVENT", iMap);
			multiLangManageService.mullangInsert(txtmemo_kor, txtmemo_eng, "MEMO", iMap);
			multiLangManageService.mullangInsert(txtemrps_resn_kor, txtemrps_resn_eng, "EMRPS_RESN", iMap);
			multiLangManageService.mullangInsert(txtetc_kor, txtetc_eng, "ETC", iMap);
			multiLangManageService.mullangInsert(txtae_detail_cn_kor, txtae_detail_cn_eng, "AE_DETAIL_CN", iMap);
			
			
			sdbc02DAO.insertAe(iMap);
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailae_info, null, null);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtadverse_event, txtadverse_event_kor, txtadverse_event_eng, "ADVERSE_EVENT", iMap);
			multiLangManageService.mullangUpdate(txtmemo, txtmemo_kor, txtmemo_eng, "MEMO", iMap);
			multiLangManageService.mullangUpdate(txtemrps_resn, txtemrps_resn_kor, txtemrps_resn_eng, "EMRPS_RESN", iMap);
			multiLangManageService.mullangUpdate(txtetc, txtetc_kor, txtetc_eng, "ETC", iMap);
			multiLangManageService.mullangUpdate(txtae_detail_cn, txtae_detail_cn_kor, txtae_detail_cn_eng, "AE_DETAIL_CN", iMap);
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailae_info, null, null);
			sdbc02DAO.updateAe(iMap);
			
		}else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailae_info, null, null);
			sdbc02DAO.deleteAe(iMap);			
		}
	}	
	
	@Override
	public void insertDemoAe(Map<String, String> iMap)throws Exception{
		comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailhrmflns_case_info, null, null);
		sdbc02DAO.updateDemoAe(iMap);
		
	}
	
	@Override
	public void insertTransfer(Map<String, String> map) throws Exception{		
		
		if (map.get("SOURCE_TYPE").equals("01")) {
			map.put("PRTCL_NO", map.get("SOURCE"));  
			map.put("SOURC_NO", "");			
			map.put("LTRTRE_NO", "");
			map.put("ETC_INFO_NO", "");
		} else if (map.get("SOURCE_TYPE").equals("02")) {
			map.put("PRTCL_NO", "");  
			map.put("SOURC_NO", map.get("SOURCE"));			
			map.put("LTRTRE_NO", "");
			map.put("ETC_INFO_NO", "");
		} else if (map.get("SOURCE_TYPE").equals("03")) {
			map.put("PRTCL_NO", "");  
			map.put("SOURC_NO", "");			
			map.put("LTRTRE_NO", map.get("SOURCE"));
			map.put("ETC_INFO_NO", "");
		} else if (map.get("SOURCE_TYPE").equals("04")) {
			map.put("PRTCL_NO", "");  
			map.put("SOURC_NO", "");			
			map.put("LTRTRE_NO", "");
			map.put("ETC_INFO_NO", map.get("SOURCE"));
		}
		
		sdbc02DAO.updateTransfer(map);
	}
	
	
	@Override
	public Map<String, String> insertFollowUp(Map<String, String> map) throws Exception	{
		String txt_follow_no = "";
		String txt_follow = "";
		String txt_hrmflns_case = map.get("HRMFLNS_CASE_CODE");
		String txt_uid = map.get("UPDATE_ID");
		int tt_follow_no = Integer.parseInt(map.get("FOLLOW_NO"));
		tt_follow_no =tt_follow_no + 1;
		map.put("CHANGE_FOLLOW_NO", Integer.toString(tt_follow_no));
		
		
	    if ("".equals(txt_follow_no)){
	    	txt_follow = "00";		    	
	    }else{	    	
	    	txt_follow   = String.format("%02d", tt_follow_no);
	    }
	    

		String txtTg_code = txt_hrmflns_case+"_"+txt_follow; 			
		map.put("MAFU_NO", txtTg_code);
		
		
		
		sdbc02DAO.insertFollowUp(map);
		//comz06Service.createCmDtaAtrailForInsertByString(ma p, atrailhrmflns_case_info, null, null);
		
		sdbc02DAO.insertFollowUp_Drug_H(map);		
		sdbc02DAO.insertFollowUp_Lab(map);
		sdbc02DAO.insertFollowUp_Narative(map);
		
//		//Medical History 관련정보
//		List<Map<String, String>> list_MH = null;
//		list_MH = sdbc02DAO.selectFollowUpMedicalH(map);
//		
//		for (Map<String, String> map_mh : list_MH) {
//			String MedicalSeq = sdbMedicalSeq.getNextStringId(); //String AeSeq = sdbAeSeq.getNextStringId();
//			map_mh.put("CHANGE_FOLLOW_NO", Integer.toString(tt_follow_no));
//			map_mh.put("CHANGE_MDLC_RCORD_NO", MedicalSeq);
//			map_mh.put("UPDATE_ID", txt_uid);
//			
//			sdbc02DAO.insertFollowUp_Medical_H(map_mh);
//			//comz06Service.createCmDtaAtrailForInsertByString(map, atrailae_info, null, null);
//		}
//		
//		//AE 관련정보
//		List<Map<String, String>> list = null;
//		list = sdbc02DAO.selectFollowUpAe(map);
//		
//		for (Map<String, String> map_ae : list) {
//			String AeSeq = sdbAeSeq.getNextStringId(); //String AeSeq = sdbAeSeq.getNextStringId();
//			map_ae.put("CHANGE_FOLLOW_NO", Integer.toString(tt_follow_no));
//			map_ae.put("CHANGE_AE_NO", AeSeq);
//			map_ae.put("UPDATE_ID", txt_uid);
//			
//			sdbc02DAO.insertFollowUp_Ae(map_ae);
//			//comz06Service.createCmDtaAtrailForInsertByString(map, atrailae_info, null, null);
//		}
//		
//		//DRUG 정보
//		List<Map<String, String>> list_drug = null;
//		list_drug = sdbc02DAO.selectDrug(map);
//		
//		for (Map<String, String> map_drug : list_drug) {
//			String DrugSeq = sdbDrugSeq.getNextStringId();
//			map_drug.put("CHANGE_MEDCIN_INFO_NO", DrugSeq);
//			map_drug.put("UPDATE_ID", txt_uid);
//			map_drug.put("CHANGE_FOLLOW_NO", Integer.toString(tt_follow_no));
//			sdbc02DAO.insertFollowUp_Drug(map_drug);
//		}	
		Map<String, String> map_follow = new HashMap<String, String>();
		map_follow = map;		
		map_follow.put("FOLLOW_NO", map.get("CHANGE_FOLLOW_NO"));
		
		return map_follow;
		
	}
	
	@Override
	public List<Map<String, Object>> selectCaseListPop(Map<String, String> param)throws Exception{
		
		return sdbc02DAO.selectCaseListPop(param);
	}
	
	@Override
	public void insertCasuality_T(Map<String, String> map)throws Exception{
		
		List<Map<String, String>> list_ae = null;
		List<Map<String, String>> list_drug = null;
		list_ae = sdbc02DAO.selectAe_C(map);
		list_drug = sdbc02DAO.selectDrug_C(map);
		
		for (Map<String, String> map_ae : list_ae) {
			map_ae.put("UPDATE_ID", map.get("UPDATE_ID"));			
			for (Map<String, String> map_drug : list_drug)
			{
				String txtmedcin_info_no = map_drug.get("MEDCIN_INFO_NO");
				String txtdrfstfrole_se = map_drug.get("DRFSTFROLE_SE");
				String txtmedcin_recoed_nm = map_drug.get("MEDCIN_RECOED_NM");
				map_ae.put("MEDCIN_INFO_NO", txtmedcin_info_no);
				map_ae.put("DRFSTFROLE_SE", txtdrfstfrole_se);
				map_ae.put("MEDCIN_RECOED_NM", txtmedcin_recoed_nm);
				if(txtdrfstfrole_se.equals("2")){
					map_ae.put("REPORTR_RELATION_ONE", "");
					map_ae.put("REPORTR_RELATION_TWO", "");
					map_ae.put("SPON_RELATION_ONE", "");
					map_ae.put("SPON_RELATION_TWO", "");
				}
				sdbc02DAO.insertCasuality_T(map_ae);
			}
			
			//comz06Service.createCmDtaAtrailForInsertByString(map, atrailmedcin_info, null, null);
			//comz06Service.createCmDtaAtrailForInsertByString(map, atrailrelate, null, null);
		}
		
	}
}
