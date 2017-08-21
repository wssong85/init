package pantheon.sdb.f07.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.sdb.f07.dao.SDBF07DAO;
import pantheon.sdb.f07.service.SDBF07Service;
//import org.codehaus.jettison.json.JSONArray;

@Service("SDBF07Service")
public class SDBF07ServiceImpl implements SDBF07Service {
	@Resource(name = "SDBF07DAO")
	private SDBF07DAO sdbf07Dao;
	
	@Override
	public List<Map<String, String>> selectAssessmentSettingInfo(Map<String, String> param) throws Exception{
		return sdbf07Dao.selectAssessmentSettingInfo(param);
	}

	@Override
	public void insertAssessmentInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("ADDDATA").length(); i++){
			Map<String, String> assessmentMap = new HashMap<String, String>();
			assessmentMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			assessmentMap.put("GROUP_AT", "N");
			assessmentMap.put("QESTN_SN", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("QESTN_SN"));
			assessmentMap.put("QESTN_CN", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("QESTN_CN"));
			assessmentMap.put("YES_SCORE", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("YES_SCORE"));
			assessmentMap.put("NO_SCORE", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("NO_SCORE"));
			assessmentMap.put("NOT_KNOW_SCORE", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("NOT_KNOW_SCORE"));
			assessmentMap.put("USE_AT", "Y");
			assessmentMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			sdbf07Dao.insertAssessmentInfo(assessmentMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("EDITDATA").length(); i++){
			Map<String, String> assessmentMap = new HashMap<String, String>();
			assessmentMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			assessmentMap.put("QESTN_SN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("QESTN_SN"));
			assessmentMap.put("QESTN_CN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("QESTN_CN"));
			assessmentMap.put("YES_SCORE", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("YES_SCORE"));
			assessmentMap.put("NO_SCORE", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("NO_SCORE"));
			assessmentMap.put("NOT_KNOW_SCORE", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("NOT_KNOW_SCORE"));
			assessmentMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			assessmentMap.put("SN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("SN"));
			sdbf07Dao.updateAssessmentInfo(assessmentMap);
		}
	}

	@Override
	public void deleteAssessmentInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DELDATA").length(); i++){
			Map<String, String> assessmentMap = new HashMap<String, String>();
			assessmentMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			assessmentMap.put("USE_AT", "N");
			assessmentMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			assessmentMap.put("SN", array.getJSONObject(0).getJSONArray("DELDATA").getJSONObject(i).getJSONObject("item").getString("SN"));
			sdbf07Dao.deleteAssessmentInfo(assessmentMap);
		}
		
	}
}
