package pantheon.sdb.c01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.c01.dao.SDBC01DAO;
import pantheon.sdb.c01.service.SDBC01Service;
import pantheon.sdb.c02.service.MultiLangManageService;
import pantheon.sdb.c02.service.SDBC02Service;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service("SDBC01Service")
public class SDBC01ServiceImpl implements SDBC01Service{
	@Resource(name = "SDBC01DAO")
	private SDBC01DAO sdbc01DAO;
	
	@Resource(name = "SDB_MULLANG_SEQ")
	private EgovIdGnrService sdbMullangSeq;
	
	@Resource(name = "SDB_SOURCE_SEQ")
	private EgovIdGnrService sdbSourceSeq;
	
	@Resource(name = "SDBC02Service")
	private SDBC02Service sdbc02Service;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "SDB_AM_TRIAL_INFO")
	protected EgovPropertyService atrailtrialinfo;
	
	@Resource(name = "SDB_AM_LTRTRE_INFO")
	protected EgovPropertyService atrailltrtreinfo;
	
	@Resource(name = "ATRAIL_SDB_AM_ETC_INFO")
	protected EgovPropertyService atrailetcinfo;
	
	@Resource(name = "MultiLangManageService")
	private MultiLangManageService multiLangManageService;
	
	
	/**
	 * Study 리스트 조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectTrialList(Map<String, String> map) throws Exception{
		return sdbc01DAO.selectTrialList(map);
	}
	@Override
	public Map<String, Object> selectStudyInfo(Map<String, String> param) throws Exception{
		
		return sdbc01DAO.selectStudyInfo(param);
	}
	
	/**
	 * EDC Study 리스트 조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectStudyList(Map<String, String> map) throws Exception{
		return  sdbc01DAO.selectStudyList(map);
		
	}
	/**
	 * EDC Study 리스트 Countg
	 * @param map
	 * @return String
	 * @throws Exception
	 */
	@Override
	public String selectStudyListCount(Map<String, String> map) throws Exception{ 
		return  sdbc01DAO.selectStudyListCount(map);
		
	}
	
	/**
	 * Study 등록/수정/삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@Override
	public void insertStudyInfo(Map<String, String> param) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		String txtprtcl_nm 		 					= iMap.get("PRTCL_NM");
		String txtprtcl_nm_kor	 					= iMap.get("PRTCL_NM_KOR");
		String txtprtcl_nm_eng 		 				= iMap.get("PRTCL_NM_ENG");
		String txtrsrch_knd_etc_matter_memo 		= iMap.get("RSRCH_KND_ETC_MATTER_MEMO");
		String txtrsrch_knd_etc_matter_memo_kor		= iMap.get("RSRCH_KND_ETC_MATTER_MEMO_KOR");
		String txtrsrch_knd_etc_matter_memo_eng 	= iMap.get("RSRCH_KND_ETC_MATTER_MEMO_ENG");
		String txtrymslmdong_ctrl_cmpnynm 			= iMap.get("RYMSLMDONG_CTRL_CMPNYNM");
		String txtrymslmdong_ctrl_cmpnynm_kor		= iMap.get("RYMSLMDONG_CTRL_CMPNYNM_KOR");
		String txtrymslmdong_ctrl_cmpnynm_eng 		= iMap.get("RYMSLMDONG_CTRL_CMPNYNM_ENG");
		String txtrymslmdong_ctrl_prductnm 			= iMap.get("RYMSLMDONG_CTRL_PRDUCTNM");
		String txtrymslmdong_ctrl_prductnm_kor		= iMap.get("RYMSLMDONG_CTRL_PRDUCTNM_KOR");
		String txtrymslmdong_ctrl_prductnm_eng 		= iMap.get("RYMSLMDONG_CTRL_PRDUCTNM_ENG");
		
		String txtetc_info_one 		 				= iMap.get("ETC_INFO_ONE");
		String txtetc_info_one_kor   				= iMap.get("ETC_INFO_ONE_KOR");
		String txtetc_info_one_eng   				= iMap.get("ETC_INFO_ONE_ENG");
		String txtetc_info_two 		 				= iMap.get("ETC_INFO_TWO");
		String txtetc_info_two_kor   				= iMap.get("ETC_INFO_TWO_KOR");
		String txtetc_info_two_eng   				= iMap.get("ETC_INFO_TWO_ENG");
		String txtetc_info_three 	 				= iMap.get("ETC_INFO_THREE");			
		String txtetc_info_three_kor 				= iMap.get("ETC_INFO_THREE_KOR");
		String txtetc_info_three_eng 				= iMap.get("ETC_INFO_THREE_ENG");
		
		String MullangSeq ="";
		
		if(iMap.get("CURD").equals("C")) {
			//다국어 입력 시작
			if((txtprtcl_nm_kor != null && !"".equals(txtprtcl_nm_kor)) || (txtprtcl_nm_eng != null && !"".equals(txtprtcl_nm_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtprtcl_nm_kor, txtprtcl_nm_eng);
				iMap.put("PRTCL_NM", MullangSeq);
			}
			
			if((txtrsrch_knd_etc_matter_memo_kor != null && !"".equals(txtrsrch_knd_etc_matter_memo_kor)) || (txtrsrch_knd_etc_matter_memo_eng != null && !"".equals(txtrsrch_knd_etc_matter_memo_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrsrch_knd_etc_matter_memo_kor, txtrsrch_knd_etc_matter_memo_eng);
				iMap.put("RSRCH_KND_ETC_MATTER_MEMO", MullangSeq);
			}
			
			if((txtrymslmdong_ctrl_cmpnynm_kor != null && !"".equals(txtrymslmdong_ctrl_cmpnynm_kor)) || (txtrymslmdong_ctrl_cmpnynm_eng != null && !"".equals(txtrymslmdong_ctrl_cmpnynm_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrymslmdong_ctrl_cmpnynm_kor, txtrymslmdong_ctrl_cmpnynm_eng);
				iMap.put("RYMSLMDONG_CTRL_CMPNYNM", MullangSeq);
			}
			
			if((txtrymslmdong_ctrl_prductnm_kor != null && !"".equals(txtrymslmdong_ctrl_prductnm_kor)) || (txtrymslmdong_ctrl_prductnm_eng != null && !"".equals(txtrymslmdong_ctrl_prductnm_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrymslmdong_ctrl_prductnm_kor, txtrymslmdong_ctrl_prductnm_eng);
				iMap.put("RYMSLMDONG_CTRL_PRDUCTNM", MullangSeq);
			}
			
			if((txtetc_info_one_kor != null && !"".equals(txtetc_info_one_kor)) || (txtetc_info_one_eng != null && !"".equals(txtetc_info_one_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_one_kor, txtetc_info_one_eng);
				iMap.put("ETC_INFO_ONE", MullangSeq);
			}
			
			if((txtetc_info_two_kor != null && !"".equals(txtetc_info_two_kor)) || (txtetc_info_two_eng != null && !"".equals(txtetc_info_two_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_two_kor, txtetc_info_two_eng);
				iMap.put("ETC_INFO_TWO", MullangSeq);
			}
			
			if((txtetc_info_three_kor != null && !"".equals(txtetc_info_three_kor)) || (txtetc_info_three_eng != null && !"".equals(txtetc_info_three_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_three_kor, txtetc_info_three_eng);
				iMap.put("ETC_INFO_THREE", MullangSeq);
			}	
			//다국어 입력 끝
			
			sdbc01DAO.insertStudyInfo(iMap);	
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailtrialinfo, null, null);
		} else if(iMap.get("CURD").equals("U")) {
			if(txtprtcl_nm == null || "".equals(txtprtcl_nm)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtprtcl_nm_kor, txtprtcl_nm_eng);
				iMap.put("PRTCL_NM", MullangSeq);
			}
			else if((txtprtcl_nm_kor != null && !"".equals(txtprtcl_nm_kor)) || (txtprtcl_nm_eng != null && !"".equals(txtprtcl_nm_eng))|| (txtprtcl_nm != null && !"".equals(txtprtcl_nm))){
				multiLangManageService.updateMul(txtprtcl_nm, txtprtcl_nm_kor, txtprtcl_nm_eng);
			}
			
			if(txtrsrch_knd_etc_matter_memo == null || "".equals(txtrsrch_knd_etc_matter_memo)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrsrch_knd_etc_matter_memo_kor, txtrsrch_knd_etc_matter_memo_eng);
				iMap.put("RSRCH_KND_ETC_MATTER_MEMO", MullangSeq);
			}
			else if((txtrsrch_knd_etc_matter_memo_kor != null && !"".equals(txtrsrch_knd_etc_matter_memo_kor)) || (txtrsrch_knd_etc_matter_memo_eng != null && !"".equals(txtrsrch_knd_etc_matter_memo_eng))|| (txtrsrch_knd_etc_matter_memo != null && !"".equals(txtrsrch_knd_etc_matter_memo))){
				multiLangManageService.updateMul(txtrsrch_knd_etc_matter_memo, txtrsrch_knd_etc_matter_memo_kor, txtrsrch_knd_etc_matter_memo_eng);
			}
			
			if(txtrymslmdong_ctrl_cmpnynm == null || "".equals(txtrymslmdong_ctrl_cmpnynm)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrymslmdong_ctrl_cmpnynm_kor, txtrymslmdong_ctrl_cmpnynm_eng);
				iMap.put("RYMSLMDONG_CTRL_CMPNYNM", MullangSeq);
			}
			else if((txtrymslmdong_ctrl_cmpnynm_kor != null && !"".equals(txtrymslmdong_ctrl_cmpnynm_kor)) || (txtrymslmdong_ctrl_cmpnynm_eng != null && !"".equals(txtrymslmdong_ctrl_cmpnynm_eng))|| (txtrymslmdong_ctrl_cmpnynm != null && !"".equals(txtrymslmdong_ctrl_cmpnynm))){
				multiLangManageService.updateMul(txtrymslmdong_ctrl_cmpnynm, txtrymslmdong_ctrl_cmpnynm_kor, txtrymslmdong_ctrl_cmpnynm_eng);
			}
			
			if(txtrymslmdong_ctrl_prductnm == null || "".equals(txtrymslmdong_ctrl_prductnm)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtrymslmdong_ctrl_prductnm_kor, txtrymslmdong_ctrl_cmpnynm_eng);
				iMap.put("RYMSLMDONG_CTRL_PRDUCTNM", MullangSeq);
			}
			else if((txtrymslmdong_ctrl_prductnm_kor != null && !"".equals(txtrymslmdong_ctrl_prductnm_kor)) || (txtrymslmdong_ctrl_prductnm_eng != null && !"".equals(txtrymslmdong_ctrl_prductnm_eng))|| (txtrymslmdong_ctrl_prductnm != null && !"".equals(txtrymslmdong_ctrl_prductnm))){
				multiLangManageService.updateMul(txtrymslmdong_ctrl_prductnm, txtrymslmdong_ctrl_prductnm_kor, txtrymslmdong_ctrl_prductnm_eng);
			}
			
			if(txtetc_info_one == null || "".equals(txtetc_info_one)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_one_kor, txtetc_info_one_eng);
				iMap.put("ETC_INFO_ONE", MullangSeq);
			}
			else if((txtetc_info_one_kor != null && !"".equals(txtetc_info_one_kor)) || (txtetc_info_one_eng != null && !"".equals(txtetc_info_one_eng))|| (txtetc_info_one != null && !"".equals(txtetc_info_one))){
				multiLangManageService.updateMul(txtetc_info_one, txtetc_info_one_kor, txtetc_info_one_eng);
			}
			
			if(txtetc_info_two == null || "".equals(txtetc_info_two)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_two_kor, txtetc_info_two_eng);
				iMap.put("ETC_INFO_TWO", MullangSeq);
			}
			else if((txtetc_info_two_kor != null && !"".equals(txtetc_info_two_kor)) || (txtetc_info_two_eng != null && !"".equals(txtetc_info_two_eng))|| (txtetc_info_two != null && !"".equals(txtetc_info_two))){
				multiLangManageService.updateMul(txtetc_info_two, txtetc_info_two_kor, txtetc_info_two_eng);
			}
			
			if(txtetc_info_three == null || "".equals(txtetc_info_three)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_three_kor, txtetc_info_three_eng);
				iMap.put("ETC_INFO_THREE", MullangSeq);
			}
			else if((txtetc_info_three_kor != null && !"".equals(txtetc_info_three_kor)) || (txtetc_info_three_eng != null && !"".equals(txtetc_info_three_eng))|| (txtetc_info_three != null && !"".equals(txtetc_info_three))){
				multiLangManageService.updateMul(txtetc_info_three, txtetc_info_three_kor, txtetc_info_three_eng);
			}	
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailtrialinfo, null, null);
			sdbc01DAO.updateStudyInfo(iMap);			
		} else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailtrialinfo, null, null);
			sdbc01DAO.deleteStudyInfo(iMap);
		}
	}
	/**
	 * Spontaneous 리스트 조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSpontaneousList(Map<String, String> map) throws Exception{
		return sdbc01DAO.selectSpontaneousList(map);
	}
	/**
	 * Literature 리스트 조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectLiteratureList(Map<String, String> map) throws Exception{
		return sdbc01DAO.selectLiteratureList(map);
	}
	/**
	 * Literature 상세조회
	 * @param map
	 * @return map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectLiteratureInfo(Map<String, String> map) throws Exception{
		return   sdbc01DAO.selectLiteratureInfo(map);
	}
	/**
	 * Literature 등록/수정/삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@Override
	public void insertLiteratureInfo(Map<String, String> param) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		
		String txtmode 				 = iMap.get("CURD");
		String txtltrtre_no 		 = iMap.get("LTRTRE_NO");
		String txtprduct_code 		 = iMap.get("PRDUCT_CODE");
		String txtltrtre_sj 		 = iMap.get("LTRTRE_SJ");
		String txtltrtre_sj_kor 	 = iMap.get("LTRTRE_SJ_KOR");
		String txtltrtre_sj_eng 	 = iMap.get("LTRTRE_SJ_ENG");
		String txtjrnl_info 		 = iMap.get("JRNL_INFO");
		String txtjrnl_info_kor 	 = iMap.get("JRNL_INFO_KOR");
		String txtjrnl_info_eng 	 = iMap.get("JRNL_INFO_ENG");
		String txtauthr 		 	 = iMap.get("AUTHR");
		String txtauthr_kor 	 	 = iMap.get("AUTHR_KOR");
		String txtauthr_eng 	 	 = iMap.get("AUTHR_ENG");
		String txtetc_info_one 		 = iMap.get("ETC_INFO_ONE");
		String txtetc_info_one_kor   = iMap.get("ETC_INFO_ONE_KOR");
		String txtetc_info_one_eng   = iMap.get("ETC_INFO_ONE_ENG");
		String txtetc_info_two 		 = iMap.get("ETC_INFO_TWO");
		String txtetc_info_two_kor   = iMap.get("ETC_INFO_TWO_KOR");
		String txtetc_info_two_eng   = iMap.get("ETC_INFO_TWO_ENG");
		String txtetc_info_three 	 = iMap.get("ETC_INFO_THREE");			
		String txtetc_info_three_kor = iMap.get("ETC_INFO_THREE_KOR");
		String txtetc_info_three_eng = iMap.get("ETC_INFO_THREE_ENG");
		System.out.println(txtmode);
		
		String MullangSeq ="";
		
		if(iMap.get("CURD").equals("C")) {
			//다국어 입력 시작
			if((txtltrtre_sj_kor != null && !"".equals(txtltrtre_sj_kor)) || (txtltrtre_sj_eng != null && !"".equals(txtltrtre_sj_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtltrtre_sj_kor, txtltrtre_sj_eng);
				iMap.put("LTRTRE_SJ", MullangSeq);
			}
			
			if((txtjrnl_info_kor != null && !"".equals(txtjrnl_info_kor)) || (txtjrnl_info_eng != null && !"".equals(txtjrnl_info_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtjrnl_info_kor, txtjrnl_info_eng);
				iMap.put("JRNL_INFO", MullangSeq);
			}
			
			if((txtauthr_kor != null && !"".equals(txtauthr_kor)) || (txtauthr_eng != null && !"".equals(txtauthr_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtauthr_kor, txtauthr_eng);
				iMap.put("AUTHR", MullangSeq);
			}
			
			if((txtetc_info_one_kor != null && !"".equals(txtetc_info_one_kor)) || (txtetc_info_one_eng != null && !"".equals(txtetc_info_one_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_one_kor, txtetc_info_one_eng);
				iMap.put("ETC_INFO_ONE", MullangSeq);
			}
			
			if((txtetc_info_two_kor != null && !"".equals(txtetc_info_two_kor)) || (txtetc_info_two_eng != null && !"".equals(txtetc_info_two_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_two_kor, txtetc_info_two_eng);
				iMap.put("ETC_INFO_TWO", MullangSeq);
			}
			
			if((txtetc_info_three_kor != null && !"".equals(txtetc_info_three_kor)) || (txtetc_info_three_eng != null && !"".equals(txtetc_info_three_eng))){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_three_kor, txtetc_info_three_eng);
				iMap.put("ETC_INFO_THREE", MullangSeq);
			}	
			//다국어 입력 끝
			
//			SourceSeq = sdbSourceSeq.getNextStringId();
//			iMap.put("ETC_INFO_NO", SourceSeq);
			System.out.println("============ Literature 등록");
			System.out.println(iMap);
			sdbc01DAO.insertLiteratureInfo(iMap);	
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailltrtreinfo, null, null);
		} else if(iMap.get("CURD").equals("U")) {
			if(txtltrtre_sj == null || "".equals(txtltrtre_sj)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtltrtre_sj_kor, txtltrtre_sj_eng);
				iMap.put("LTRTRE_SJ", MullangSeq);
			}
			else if((txtltrtre_sj_kor != null && !"".equals(txtltrtre_sj_kor)) || (txtltrtre_sj_eng != null && !"".equals(txtltrtre_sj_eng))|| (txtltrtre_sj != null && !"".equals(txtltrtre_sj))){
				multiLangManageService.updateMul(txtltrtre_sj, txtltrtre_sj_kor, txtltrtre_sj_eng);
			}
			
			if(txtjrnl_info == null || "".equals(txtjrnl_info)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtjrnl_info_kor, txtjrnl_info_eng);
				iMap.put("JRNL_INFO", MullangSeq);
			}
			else if((txtjrnl_info_kor != null && !"".equals(txtjrnl_info_kor)) || (txtjrnl_info_eng != null && !"".equals(txtjrnl_info_eng))|| (txtjrnl_info != null && !"".equals(txtjrnl_info))){
				multiLangManageService.updateMul(txtjrnl_info, txtjrnl_info_kor, txtjrnl_info_eng);
			}
			
			if(txtauthr == null || "".equals(txtauthr)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtauthr_kor, txtauthr_eng);
				iMap.put("AUTHR", MullangSeq);
			}
			else if((txtauthr_kor != null && !"".equals(txtauthr_kor)) || (txtauthr_eng != null && !"".equals(txtauthr_eng))|| (txtauthr != null && !"".equals(txtauthr))){
				multiLangManageService.updateMul(txtauthr, txtauthr_kor, txtauthr_eng);
			}
			
			if(txtetc_info_one == null || "".equals(txtetc_info_one)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_one_kor, txtetc_info_one_eng);
				iMap.put("ETC_INFO_ONE", MullangSeq);
			}
			else if((txtetc_info_one_kor != null && !"".equals(txtetc_info_one_kor)) || (txtetc_info_one_eng != null && !"".equals(txtetc_info_one_eng))|| (txtetc_info_one != null && !"".equals(txtetc_info_one))){
				multiLangManageService.updateMul(txtetc_info_one, txtetc_info_one_kor, txtetc_info_one_eng);
			}
			
			if(txtetc_info_two == null || "".equals(txtetc_info_two)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_two_kor, txtetc_info_two_eng);
				iMap.put("ETC_INFO_TWO", MullangSeq);
			}
			else if((txtetc_info_two_kor != null && !"".equals(txtetc_info_two_kor)) || (txtetc_info_two_eng != null && !"".equals(txtetc_info_two_eng))|| (txtetc_info_two != null && !"".equals(txtetc_info_two))){
				multiLangManageService.updateMul(txtetc_info_two, txtetc_info_two_kor, txtetc_info_two_eng);
			}
			
			if(txtetc_info_three == null || "".equals(txtetc_info_three)){
				MullangSeq = sdbMullangSeq.getNextStringId();
				multiLangManageService.insertMul(MullangSeq, txtetc_info_three_kor, txtetc_info_three_eng);
				iMap.put("ETC_INFO_THREE", MullangSeq);
			}
			else if((txtetc_info_three_kor != null && !"".equals(txtetc_info_three_kor)) || (txtetc_info_three_eng != null && !"".equals(txtetc_info_three_eng))|| (txtetc_info_three != null && !"".equals(txtetc_info_three))){
				multiLangManageService.updateMul(txtetc_info_three, txtetc_info_three_kor, txtetc_info_three_eng);
			}	
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailltrtreinfo, null, null);
			sdbc01DAO.updateLiteratureInfo(iMap);			
		} else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailltrtreinfo, null, null);
			sdbc01DAO.deleteLiteratureInfo(iMap);
		}
		
	}
	/**
	 * Etc 리스트조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectEtcList(Map<String, String> map) throws Exception{
		return sdbc01DAO.selectEtcList(map);
	}
	/**
	 * ICSR 리스트조회
	 * @param map
	 * @return list
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectICSRList(Map<String, String> map) throws Exception{
		return sdbc01DAO.selectICSRList(map);
	}
	/**
	 * Etc 상세조회
	 * @param map
	 * @return map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectEtcInfo(Map<String, String> param) throws Exception{
		Map<String, Object> result = sdbc01DAO.selectEtcInfo(param);
		return result;
	}
	/**
	 * Etc 등록/수정/삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@Override
	public void  insertEtcInfo(Map<String, String> param) throws Exception{
		
		Map<String, String> iMap = new HashMap<String, String>();
		iMap = param;
		
		String txtmode 				 = iMap.get("CURD");
		String txtetc_info_no 		 = iMap.get("ETC_INFO_NO");
		String txtprduct_code 		 = iMap.get("PRDUCT_CODE");
		String txtsourc 			 = iMap.get("SOURC");
		String txtsourc_kor 		 = iMap.get("SOURC_KOR");
		String txtsourc_eng 		 = iMap.get("SOURC_ENG");
		String txtetc_info_one 		 = iMap.get("ETC_INFO_ONE");
		String txtetc_info_one_kor   = iMap.get("ETC_INFO_ONE_KOR");
		String txtetc_info_one_eng   = iMap.get("ETC_INFO_ONE_ENG");
		String txtetc_info_two 		 = iMap.get("ETC_INFO_TWO");
		String txtetc_info_two_kor   = iMap.get("ETC_INFO_TWO_KOR");
		String txtetc_info_two_eng   = iMap.get("ETC_INFO_TWO_ENG");
		String txtetc_info_three 	 = iMap.get("ETC_INFO_THREE");			
		String txtetc_info_three_kor = iMap.get("ETC_INFO_THREE_KOR");
		String txtetc_info_three_eng = iMap.get("ETC_INFO_THREE_ENG");
		System.out.println(txtmode);
		
		//String MullangSeq ="";
		
		
		if(iMap.get("CURD").equals("C")) {
			
			multiLangManageService.mullangInsert(txtsourc_kor, txtsourc_eng, "SOURC", iMap);
			multiLangManageService.mullangInsert(txtetc_info_one_kor, txtetc_info_one_eng, "ETC_INFO_ONE", iMap);
			multiLangManageService.mullangInsert(txtetc_info_two_kor, txtetc_info_two_eng, "ETC_INFO_TWO", iMap);
			multiLangManageService.mullangInsert(txtetc_info_three_kor, txtetc_info_three_eng, "ETC_INFO_THREE", iMap);
			
			System.out.println("============ etc 등록");
			System.out.println(iMap);
			sdbc01DAO.insertEtcInfo(iMap);	
			comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailetcinfo, null, null);
		} else if(iMap.get("CURD").equals("U")) {
			
			multiLangManageService.mullangUpdate(txtsourc, txtsourc_kor, txtsourc_eng, "SOURC", iMap);
			multiLangManageService.mullangUpdate(txtetc_info_one, txtetc_info_one_kor, txtetc_info_one_eng, "ETC_INFO_ONE", iMap);
			multiLangManageService.mullangUpdate(txtetc_info_two, txtetc_info_two_kor, txtetc_info_two_eng, "ETC_INFO_TWO", iMap);
			multiLangManageService.mullangUpdate(txtetc_info_three, txtetc_info_three_kor, txtetc_info_three_eng, "ETC_INFO_THREE", iMap);
			
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailetcinfo, null, null);
			sdbc01DAO.updateEtcInfo(iMap);			
		} else if(iMap.get("CURD").equals("D")){
			comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailetcinfo, null, null);
			sdbc01DAO.deleteEtcInfo(iMap);
		}	
	}
	
	
}
