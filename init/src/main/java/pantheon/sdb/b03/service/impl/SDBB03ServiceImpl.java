package pantheon.sdb.b03.service.impl;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.sdb.b03.dao.SDBB03DAO;
import pantheon.sdb.b03.service.SDBB03Service;
import pantheon.sdb.c02.service.MultiLangManageService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("SDBB03Service")
public class SDBB03ServiceImpl implements SDBB03Service{
	
	@Resource(name = "SDBB03DAO")
	private SDBB03DAO sdbb03DAO;
	
	@Resource(name = "SDB_DELNGLN_SEQ")
	private EgovIdGnrService sdbDelnglnSeq;
	
	@Resource(name = "MultiLangManageService")
	private MultiLangManageService multiLangManageService;
	
	@Override
	public void insertOrganList(Map<String, String> iMap) throws Exception {
		// TODO Auto-generated method stub
		if(iMap.get("CURD").equals("C"))
		{
			int Instr_code = Integer.parseInt(sdbDelnglnSeq.getNextStringId());
			String txt_code = String.format("%04d", Instr_code);
		    Calendar c = Calendar.getInstance();
		    String txtYear = new String();
		    txtYear = String.valueOf(c.get(Calendar.YEAR));
			String Category ="OR"; //Organ
			
			String txtTg_code = Category+""+txtYear+""+txt_code;
			iMap.put("INSTT_NO", txtTg_code);
			
			multiLangManageService.mullangInsert(iMap.get("INSTT_NM_KOR"), iMap.get("INSTT_NM_ENG"), "INSTT_NM", iMap);
			multiLangManageService.mullangInsert(iMap.get("ADRES_DSTNC_KOR"), iMap.get("ADRES_DSTNC_ENG"), "ADRES_DSTNC", iMap);
			multiLangManageService.mullangInsert(iMap.get("ADRES_CTY_KOR"), iMap.get("ADRES_CTY_ENG"), "ADRES_CTY", iMap);
			multiLangManageService.mullangInsert(iMap.get("ADRES_LCLTY_KOR"), iMap.get("ADRES_LCLTY_ENG"), "ADRES_LCLTY", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPORTR_KOR"), iMap.get("REPORTR_ENG"), "REPORTR", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPORTR_APPN_NM_KOR"), iMap.get("REPORTR_APPN_NM_ENG"), "REPORTR_APPN_NM", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPORTR_MIDDLE_NM_KOR"), iMap.get("REPORTR_MIDDLE_NM_ENG"), "REPORTR_MIDDLE_NM", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPORTR_FAMILY_NM_KOR"), iMap.get("REPORTR_FAMILY_NM_ENG"), "REPORTR_FAMILY_NM", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPORTR_DEPT_KOR"), iMap.get("REPORTR_DEPT_ENG"), "REPORTR_DEPT", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPRT_TY_DETAIL_KOR"), iMap.get("REPRT_TY_DETAIL_ENG"), "REPRT_TY_DETAIL", iMap);
			multiLangManageService.mullangInsert(iMap.get("CLASS_KOR"), iMap.get("CLASS_ENG"), "CLASS", iMap);
			multiLangManageService.mullangInsert(iMap.get("MAJOR_KOR"), iMap.get("MAJOR_ENG"), "MAJOR", iMap);
			multiLangManageService.mullangInsert(iMap.get("REPRT_SJ_KOR"), iMap.get("REPRT_SJ_ENG"), "REPRT_SJ", iMap);
			multiLangManageService.mullangInsert(iMap.get("SPCLTYREALM_KOR"), iMap.get("SPCLTYREALM_ENG"), "SPCLTYREALM", iMap);
			
			
			sdbb03DAO.insertOrganList(iMap);
		}else if(iMap.get("CURD").equals("U")) {
			multiLangManageService.mullangUpdate(iMap.get("INSTT_NM"), iMap.get("INSTT_NM_KOR"), iMap.get("INSTT_NM_ENG"), "INSTT_NM", iMap);
			multiLangManageService.mullangUpdate(iMap.get("ADRES_DSTNC"), iMap.get("ADRES_DSTNC_KOR"), iMap.get("ADRES_DSTNC_ENG"), "ADRES_DSTNC", iMap);
			multiLangManageService.mullangUpdate(iMap.get("ADRES_CTY"), iMap.get("ADRES_CTY_KOR"), iMap.get("ADRES_CTY_ENG"), "ADRES_CTY", iMap);
			multiLangManageService.mullangUpdate(iMap.get("ADRES_LCLTY"), iMap.get("ADRES_LCLTY_KOR"), iMap.get("ADRES_LCLTY_ENG"), "ADRES_LCLTY", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPORTR_APPN_NM"), iMap.get("REPORTR_APPN_NM_KOR"), iMap.get("REPORTR_APPN_NM_ENG"), "REPORTR_APPN_NM", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPORTR_MIDDLE_NM"), iMap.get("REPORTR_MIDDLE_NM_KOR"), iMap.get("REPORTR_MIDDLE_NM_ENG"), "REPORTR_MIDDLE_NM", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPORTR_FAMILY_NM"), iMap.get("REPORTR_FAMILY_NM_KOR"), iMap.get("REPORTR_FAMILY_NM_ENG"), "REPORTR_FAMILY_NM", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPORTR_DEPT"), iMap.get("REPORTR_DEPT_KOR"), iMap.get("REPORTR_DEPT_ENG"), "REPORTR_DEPT", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPRT_TY_DETAIL"), iMap.get("REPRT_TY_DETAIL_KOR"), iMap.get("REPRT_TY_DETAIL_ENG"), "REPRT_TY_DETAIL", iMap);
			multiLangManageService.mullangUpdate(iMap.get("CLASS"), iMap.get("CLASS_KOR"), iMap.get("CLASS_ENG"), "CLASS", iMap);
			multiLangManageService.mullangUpdate(iMap.get("MAJOR"), iMap.get("MAJOR_KOR"), iMap.get("MAJOR_ENG"), "MAJOR", iMap);
			multiLangManageService.mullangUpdate(iMap.get("REPRT_SJ"), iMap.get("REPRT_SJ_KOR"), iMap.get("REPRT_SJ_ENG"), "REPRT_SJ", iMap);
			multiLangManageService.mullangUpdate(iMap.get("SPCLTYREALM"), iMap.get("SPCLTYREALM_KOR"), iMap.get("SPCLTYREALM_ENG"), "SPCLTYREALM", iMap);
			
			sdbb03DAO.updateOrganList(iMap);
		}else if(iMap.get("CURD").equals("D")){
			sdbb03DAO.deleteOrganList(iMap);		
		}
		
	}
	
	@Override
	public Map<String, Object> selectOrganInfo(Map<String, String> param) throws Exception{
		
		return sdbb03DAO.selectOrganInfo(param);
	}
	
	/**
	 * 기관 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectOrganList(Map<String, String> map) throws Exception {
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb03DAO.selectOrganList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectOrganListPop(Map<String, String> map)throws Exception{
		
		return sdbb03DAO.selectOrganListPop(map);
	}
}
