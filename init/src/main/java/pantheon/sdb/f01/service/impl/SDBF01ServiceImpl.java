package pantheon.sdb.f01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.sdb.f01.dao.SDBF01DAO;
import pantheon.sdb.f01.service.SDBF01Service;
import org.codehaus.jettison.json.JSONArray;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("SDBF01Service")
public class SDBF01ServiceImpl implements SDBF01Service {
	@Resource(name = "SDBF01DAO")
	private SDBF01DAO sdbf01Dao;
	
	@Resource(name = "SDB_CASE_SEQ")
	private EgovIdGnrService sdbCaseSeq;

	@Override
	public List<Map<String, String>> selectQcResultReportList(Map<String, String> param) throws Exception { 
		return sdbf01Dao.selectQcResultReportList(param);
	}
	
	@Override
	public Map<String, String> selectQcReportInfo(Map<String, String> param) throws Exception{
		return sdbf01Dao.selectQcReportInfo(param);
	}

	@Override
	public List<Map<String, String>> selectQcSopItemCheckList(Map<String, String> param) throws Exception {
		return sdbf01Dao.selectQcSopItemCheckList(param);
	}

	@Override
	public void insertQcResultReportInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		
		Map<String, String> qcReportMap = new HashMap<String, String>();
		
		qcReportMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
		qcReportMap.put("SAFE_MANAGE_CHRGDEPT_CHARGER", array.getJSONObject(0).getString("SAFE_MANAGE_CHRGDEPT_CHARGER"));
		qcReportMap.put("QLMNGMT_OPRTNDE", array.getJSONObject(0).getString("QLMNGMT_OPRTNDE"));
		qcReportMap.put("QLMNGMT_CHARGER", array.getJSONObject(0).getString("QLMNGMT_CHARGER"));
		qcReportMap.put("PD_BGNDE", array.getJSONObject(0).getString("PD_BGNDE"));
		qcReportMap.put("PD_LASTDE", array.getJSONObject(0).getString("PD_LASTDE"));
		qcReportMap.put("TOT_IEM_CO", array.getJSONObject(0).getString("TOT_IEM_CO"));
		qcReportMap.put("VIOLT_IEM_CO", array.getJSONObject(0).getString("VIOLT_IEM_CO"));
		qcReportMap.put("SFMNGCHRG_DPRLR_MEMO", array.getJSONObject(0).getString("SFMNGCHRG_DPRLR_MEMO"));
		qcReportMap.put("SETLELN_CODE", array.getJSONObject(0).getString("SETLELN_CODE"));
		qcReportMap.put("USE_AT", "Y");
		qcReportMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
		
		String reportNo = "".equals(array.getJSONObject(0).getString("QC_REPRT_NO")) ? sdbf01Dao.selectQcReportNo(qcReportMap) : array.getJSONObject(0).getString("QC_REPRT_NO");
		
		qcReportMap.put("QC_REPRT_NO", reportNo);
		System.err.println(array.getJSONObject(0).getString("QC_REPRT_NO"));
		if("".equals(array.getJSONObject(0).getString("QC_REPRT_NO"))){
			sdbf01Dao.insertQcResultReportInfo(qcReportMap);
		}else{
			sdbf01Dao.updateQcResultReportInfo(qcReportMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("GROUP").length(); i++){
			Map<String, String> groupMap = new HashMap<String, String>();
		
			if("".equals(array.getJSONObject(0).getString("QC_REPRT_NO"))){
				int sopItemNo = sdbf01Dao.selectSopItemCheckNo(qcReportMap);
				groupMap.put("CECK_LIST_SN", String.valueOf(sopItemNo));
			}
			
			groupMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
			groupMap.put("QC_REPRT_NO", reportNo);
			groupMap.put("IEM_CODE", array.getJSONObject(0).getJSONArray("GROUP").getJSONObject(i).getString("IEM_CODE"));
			groupMap.put("IEM_CECK_AT", array.getJSONObject(0).getJSONArray("GROUP").getJSONObject(i).getString("IEM_CECK_AT"));
			groupMap.put("USE_AT", "Y");
			groupMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
			
			if("".equals(array.getJSONObject(0).getString("QC_REPRT_NO"))){
				sdbf01Dao.insertQcSopItemCheckInfo(groupMap);
			}else{
				sdbf01Dao.updateQcSopItemCheckInfo(groupMap);
			}
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("CHECK").length(); i++){
			Map<String, String> checkMap = new HashMap<String, String>();
			
			if("".equals(array.getJSONObject(0).getString("QC_REPRT_NO"))){
				int sopItemNo = sdbf01Dao.selectSopItemCheckNo(qcReportMap);
				checkMap.put("CECK_LIST_SN", String.valueOf(sopItemNo));
			}
			
			checkMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
			checkMap.put("QC_REPRT_NO", reportNo);
			checkMap.put("IEM_CODE", array.getJSONObject(0).getJSONArray("CHECK").getJSONObject(i).getString("IEM_CODE"));
			checkMap.put("UPPER_IEM_CODE", array.getJSONObject(0).getJSONArray("CHECK").getJSONObject(i).getString("UPPER_IEM_CODE"));
			checkMap.put("RESULT_CODE", array.getJSONObject(0).getJSONArray("CHECK").getJSONObject(i).getString("RESULT_CODE"));
			checkMap.put("MEMO", array.getJSONObject(0).getJSONArray("CHECK").getJSONObject(i).getString("MEMO"));
			checkMap.put("USE_AT", "Y");
			checkMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
			
			if("".equals(array.getJSONObject(0).getString("QC_REPRT_NO"))){
				sdbf01Dao.insertQcSopItemCheckInfo(checkMap);
			}else{
				sdbf01Dao.updateQcSopItemCheckInfo(checkMap);
			}
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("CASE").length(); i++){
			Map<String, String> caseMap = new HashMap<String, String>();
			
			caseMap.put("SN", sdbCaseSeq.getNextStringId());
			caseMap.put("QC_REPRT_NO", reportNo);
			caseMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
			caseMap.put("ABOVECASE_CODE", array.getJSONObject(0).getJSONArray("CASE").getJSONObject(i).getString("ABOVECASE_CODE"));
			caseMap.put("USE_AT", "Y");
			caseMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
			
			sdbf01Dao.insertAboveCaseInfo(caseMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DELCASE").length(); i++){
			Map<String, String> deleteMap = new HashMap<String, String>();
			
			deleteMap.put("QC_REPRT_NO", reportNo);
			deleteMap.put("SN", array.getJSONObject(0).getJSONArray("DELCASE").getJSONObject(i).getString("SN"));
			deleteMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
			deleteMap.put("ABOVECASE_CODE", array.getJSONObject(0).getJSONArray("DELCASE").getJSONObject(i).getString("ABOVECASE_CODE"));
			deleteMap.put("USE_AT", "N");
			deleteMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
			
			sdbf01Dao.deleteAboveCaseInfo(deleteMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("CAPA").length(); i++){
			Map<String, String> capaMap = new HashMap<String, String>();
			
			
			capaMap.put("QC_REPRT_NO", reportNo);
			capaMap.put("PRDUCT_CODE", array.getJSONObject(0).getString("PRDUCT_CODE"));
			capaMap.put("VIOLTIEM", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("VIOLTIEM"));
			capaMap.put("VIOLTCN", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("VIOLTCN"));
			capaMap.put("SOLUTENNC", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("SOLUTENNC"));
			capaMap.put("UNSOLV_RESN", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("UNSOLV_RESN"));
			capaMap.put("RM", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("RM"));
			capaMap.put("USE_AT", "Y");
			capaMap.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
			System.err.println(array.getJSONObject(0).getJSONArray("CAPA"));
			if("".equals(array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("FLLWMANAGT_SN"))){
				String sn = sdbf01Dao.selectFllwmanagtSn(capaMap);
				capaMap.put("FLLWMANAGT_SN", sn);
				sdbf01Dao.insertCapaListInfo(capaMap);
			}else{
				capaMap.put("FLLWMANAGT_SN", array.getJSONObject(0).getJSONArray("CAPA").getJSONObject(i).getString("FLLWMANAGT_SN"));
				sdbf01Dao.updateCapaListInfo(capaMap);
			}
			
		}
	}

	@Override
	public List<Map<String, String>> selectUserInfo(Map<String, String> param) throws Exception {
		return sdbf01Dao.selectUserInfo(param);
	}

	@Override
	public List<Map<String, String>> selectCaseInfo(Map<String, String> param) throws Exception {
		return sdbf01Dao.selectCaseInfo(param);
	}

	@Override
	public List<Map<String, String>> selectProductCaseInfo(Map<String, String> param) throws Exception {
		return sdbf01Dao.selectProductCaseInfo(param);
	}
	
	@Override
	public void updateApprovalQcInfo(Map<String, String> param) throws Exception{
		sdbf01Dao.updateApprovalQcInfo(param);
	}

	@Override
	public List<Map<String, String>> selectCapaListInfo(Map<String, String> param) throws Exception {
		return sdbf01Dao.selectCapaListInfo(param);
	}
}
