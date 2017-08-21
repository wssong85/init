package pantheon.sdb.f02.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.f02.dao.SDBF02DAO;
import pantheon.sdb.f02.service.SDBF02Service;
import org.codehaus.jettison.json.JSONArray;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBF02Service")
public class SDBF02ServiceImpl implements SDBF02Service {
	@Resource(name = "SDBF02DAO")
	private SDBF02DAO sdbf02Dao;
	
	@Resource(name = "ATRAIL_SDB_SM_LTRTRE_SEARCH_INFO")
	private EgovPropertyService atrailSdbSmLtrtreSearchInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

	@Override
	public List<Map<String, String>> selectLiteratureList(Map<String, String> param) throws Exception {
		return sdbf02Dao.selectLiteratureList(param);
	}

	@Override
	public void insertLiteratureInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("param"));
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("ADDED").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("CMPNY_NM", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("CMPNY_NM"));
			map.put("PRDUCT_NM", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("PRDUCT_NM"));
			map.put("KWRD", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("KWRD"));
			map.put("SEARCH_SITE", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("SEARCH_SITE"));
			map.put("SEARCH_OPERTNDE_ONE", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("SEARCH_OPERTNDE_ONE").replace("-", "").replace("/", ""));
			map.put("SEARCH_OPERTNDE_TWO", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("SEARCH_OPERTNDE_TWO").replace("-", "").replace("/", ""));
			map.put("EXMNT_THESIS_CO_ONE", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("EXMNT_THESIS_CO_ONE"));
			map.put("EXMNT_THESIS_CO_TWO", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("EXMNT_THESIS_CO_TWO"));
			map.put("REPORT_THESIS_CO_ONE", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("REPORT_THESIS_CO_ONE"));
			map.put("REPORT_THESIS_CO_TWO", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("REPORT_THESIS_CO_TWO"));
			map.put("REPORT_NUM_ONE", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("REPORT_NUM_ONE"));
			map.put("REPORT_NUM_TWO", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("REPORT_NUM_TWO"));
			map.put("THESISURL", array.getJSONObject(0).getJSONArray("ADDED").getJSONObject(i).getString("THESISURL"));
			map.put("USE_AT", "Y");
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			int sn = sdbf02Dao.selectLiteratureSeq();
			map.put("LTRTRE_SEARCH_SN", String.valueOf(sn));
			
			sdbf02Dao.insertLiteratureInfo(map);
			comz06Service.createCmDtaAtrailForInsertByString(map, atrailSdbSmLtrtreSearchInfo, null, "문헌검색등록");
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("EDITED").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("CMPNY_NM", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("CMPNY_NM"));
			map.put("PRDUCT_NM", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("PRDUCT_NM"));
			map.put("KWRD", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("KWRD"));
			map.put("SEARCH_SITE", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("SEARCH_SITE"));
			map.put("SEARCH_OPERTNDE_ONE", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("SEARCH_OPERTNDE_ONE").replace("-", "").replace("/", ""));
			map.put("SEARCH_OPERTNDE_TWO", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("SEARCH_OPERTNDE_TWO").replace("-", "").replace("/", ""));
			map.put("EXMNT_THESIS_CO_ONE", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("EXMNT_THESIS_CO_ONE"));
			map.put("EXMNT_THESIS_CO_TWO", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("EXMNT_THESIS_CO_TWO"));
			map.put("REPORT_THESIS_CO_ONE", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("REPORT_THESIS_CO_ONE"));
			map.put("REPORT_THESIS_CO_TWO", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("REPORT_THESIS_CO_TWO"));
			map.put("REPORT_NUM_ONE", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("REPORT_NUM_ONE"));
			map.put("REPORT_NUM_TWO", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("REPORT_NUM_TWO"));
			map.put("THESISURL", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("THESISURL"));
			map.put("USE_AT", "Y");
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("LTRTRE_SEARCH_SN", array.getJSONObject(0).getJSONArray("EDITED").getJSONObject(i).getString("LTRTRE_SEARCH_SN"));
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailSdbSmLtrtreSearchInfo, null, "문헌검색수정");
			sdbf02Dao.updateLiteratureInfo(map);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DELETED").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("USE_AT", "N");
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("LTRTRE_SEARCH_SN", array.getJSONObject(0).getJSONArray("DELETED").getJSONObject(i).getString("LTRTRE_SEARCH_SN"));
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailSdbSmLtrtreSearchInfo, null, "문헌검색삭제");
			sdbf02Dao.deleteLiteratureInfo(map);
		}
	}
}
