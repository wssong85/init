package pantheon.sdb.f09.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.codehaus.jettison.json.JSONArray;
import pantheon.com.utl.Util;
import pantheon.sdb.f09.dao.SDBF09DAO;
import pantheon.sdb.f09.service.SDBF09Service;

@Service("SDBF09Service")
public class SDBF09ServiceImpl implements SDBF09Service {
	@Resource(name = "SDBF09DAO")
	private SDBF09DAO sdbf09Dao;

	@Override
	public List<Map<String, String>> selectSopPart(Map<String, String> param) throws Exception {
		return sdbf09Dao.selectSopPart(param);
	}

	@Override
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception {
		return sdbf09Dao.selectSopInfo(param);
	}

	@Override
	public void insertSopInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("ADDDATA").length(); i++){
			Map<String, String> sopMap = new HashMap<String, String>();
			sopMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			sopMap.put("GROUP_AT", "Y");
			sopMap.put("UPPER_SN", array.getJSONObject(0).getString("UPPER_SN"));
			sopMap.put("QESTN_SN", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("QESTN_SN"));
			sopMap.put("QESTN_CN", array.getJSONObject(0).getJSONArray("ADDDATA").getJSONObject(i).getString("QESTN_CN"));
			sopMap.put("USE_AT", "Y");
			sopMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			sdbf09Dao.insertSopInfo(sopMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("EDITDATA").length(); i++){
			Map<String, String> sopMap = new HashMap<String, String>();
			sopMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			sopMap.put("UPPER_SN", array.getJSONObject(0).getString("UPPER_SN"));
			sopMap.put("QESTN_SN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("QESTN_SN"));
			sopMap.put("QESTN_CN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("QESTN_CN"));
			sopMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			sopMap.put("SN", array.getJSONObject(0).getJSONArray("EDITDATA").getJSONObject(i).getString("SN"));
			sdbf09Dao.updateSopInfo(sopMap);
		}
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DELDATA").length(); i++){
			Map<String, String> sopMap = new HashMap<String, String>();
			sopMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			sopMap.put("UPPER_SN", array.getJSONObject(0).getString("UPPER_SN"));
			sopMap.put("USE_AT", "N");
			sopMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			sopMap.put("SN", array.getJSONObject(0).getJSONArray("DELDATA").getJSONObject(i).getString("SN"));
			sdbf09Dao.deleteSopInfo(sopMap);
		}
	}

	@Override
	public void deleteSopInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DELDATA").length(); i++){
			Map<String, String> sopMap = new HashMap<String, String>();
			sopMap.put("SE_CODE", array.getJSONObject(0).getString("SE_CODE"));
			sopMap.put("UPPER_SN", array.getJSONObject(0).getString("UPPER_SN"));
			sopMap.put("USE_AT", "N");
			sopMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			sopMap.put("SN", array.getJSONObject(0).getJSONArray("DELDATA").getJSONObject(i).getJSONObject("item").getString("SN"));
			sdbf09Dao.deleteSopInfo(sopMap);
		}
	}
}
