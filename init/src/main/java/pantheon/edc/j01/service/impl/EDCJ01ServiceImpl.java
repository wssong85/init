package pantheon.edc.j01.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.edc.j01.dao.EDCJ01DAO;
import pantheon.edc.j01.service.EDCJ01Service;

@Service("EDCJ01Service")
public class EDCJ01ServiceImpl implements EDCJ01Service {
	
	@Resource(name = "EDCJ01DAO")
    EDCJ01DAO edcj01DAO;
	
	@Resource(name = "EDC_RM_AET_SEQ")
	private EgovIdGnrService rmAetSeq;
	
	@Resource(name = "EDC_RM_DRFSTF_SEQ")
	private EgovIdGnrService drfstfSeq;
	
	@Resource(name = "EDC_RM_HSTCS_SEQ")
	private EgovIdGnrService hstcsSeq;
	
	@Resource(name = "EDC_RM_DRFSTF_HSTCS_SEQ")
	private EgovIdGnrService drfstfHstcsSeq;
	
	@Resource(name = "EDC_RM_INSPCT_RESULT_SEQ")
	private EgovIdGnrService inspctResultSeq;

	/**
	 * 이상반응 신속보고 목록 조회
	 * 
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectSaeRepList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepList(param);
	}

	/**
	 * 이상반응 신속보고 상세 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectSaeRep(Map<String, Object> param)	throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRep(param);
	}

	/**
	 * 이상반응 신속보고 상세 이상약물반응 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectSaeRepAetList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepAetList(param);
	}

	/**
	 * 이상반응 신속보고 상세 약물정보 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSaeRepDreAList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepDreAList(param);
	}

	/**
	 * 이상반응 신속보고 상세 기타병용약물 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSaeRepDreBList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepDreBList(param);
	}

	/**
	 * 이상반응 신속보고 상세 주요 병력 및 동반 질환 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSaeRepHstcsList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepHstcsList(param);
	}

	/**
	 * 이상반응 신속보고 상세 이상약물반응 관련 약물 과거력 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSaeRepDreHstcsList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepDreHstcsList(param);
	}

	/**
	 * 이상반응 신속보고 상세 원인규명을 위한 검사 결과 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectSaeRepInspctList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edcj01DAO.selectSaeRepInspctList(param);
	}

	/**
	 * 이상반응 신속보고 저장 Process
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertSaeList(Map<String, Object> param) throws Exception {
		try {
			if (param.get("base") != null && !"".equals(param.get("base"))) {
				Map<String, Object> iMap = makeMap(new JSONObject(String.valueOf(param.get("base"))));
				System.out.println(iMap);
				edcj01DAO.updateSaeList(iMap);
				/*
				// 이상약물반응 테이블에 키값으로 값이 있으면 update 없으면 insert
				if(edcj01DAO.selectRmAetCnt(iMap) > 0){
					edcj01DAO.updateRmAet(iMap);
				}else{
					iMap.put("aetSn", rmAetSeq.getNextStringId());
					edcj01DAO.insertRmAet(iMap);
				}*/
			}
			
			if (param.get("saeRepDreAList") != null && !"".equals(param.get("saeRepDreAList"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("saeRepDreAList")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> aMap : list) {
					if (aMap.get("CRUD").equals("C")) {
						aMap.put("drfstfSn", drfstfSeq.getNextStringId());
						aMap.put("drfstfSeCode", "01");
						edcj01DAO.insertRepDre(aMap);
					} else {
						if (aMap.get("CRUD").equals("U")) {
							aMap.put("USE_AT", "Y");
						} else {
							aMap.put("USE_AT", "N");
						}
						System.out.println(aMap);
						edcj01DAO.updateRepDre(aMap);
					}
				}
			}
			
			if (param.get("saeRepDreBList") != null && !"".equals(param.get("saeRepDreBList"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("saeRepDreBList")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> bMap : list) {
					if (bMap.get("CRUD").equals("C")) {
						bMap.put("drfstfSn", drfstfSeq.getNextStringId());
						bMap.put("drfstfSeCode", "02");
						edcj01DAO.insertRepDre(bMap);
					} else {
						if (bMap.get("CRUD").equals("U")) {
							bMap.put("USE_AT", "Y");
						} else {
							bMap.put("USE_AT", "N");
						}
						System.out.println(bMap);
						edcj01DAO.updateRepDre(bMap);
					}
				}
			}
			
			if (param.get("saeRepHstcsList") != null && !"".equals(param.get("saeRepHstcsList"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("saeRepHstcsList")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> cMap : list) {
					if (cMap.get("CRUD").equals("C")) {
						cMap.put("hstcsSn", hstcsSeq.getNextStringId());
						edcj01DAO.insertRepHstcs(cMap);
					} else {
						if (cMap.get("CRUD").equals("U")) {
							cMap.put("USE_AT", "Y");
						} else {
							cMap.put("USE_AT", "N");
						}
						System.out.println(cMap);
						edcj01DAO.updateRepHstcs(cMap);
					}
				}
			}
			
			if (param.get("saeRepDreHstcsList") != null && !"".equals(param.get("saeRepDreHstcsList"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("saeRepDreHstcsList")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> dMap : list) {
					if (dMap.get("CRUD").equals("C")) {
						dMap.put("drfstfhstcsSn", drfstfHstcsSeq.getNextStringId());
						edcj01DAO.insertRepDreHstcs(dMap);
					} else {
						if (dMap.get("CRUD").equals("U")) {
							dMap.put("USE_AT", "Y");
						} else {
							dMap.put("USE_AT", "N");
						}
						System.out.println(dMap);
						edcj01DAO.updateRepDreHstcs(dMap);
					}
				}
			}
			
			if (param.get("saeRepInspctList") != null && !"".equals(param.get("saeRepInspctList"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("saeRepInspctList")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> fMap : list) {
					if (fMap.get("CRUD").equals("C")) {
						fMap.put("inspctResultSn", inspctResultSeq.getNextStringId());
						edcj01DAO.insertRepInspct(fMap);
					} else {
						if (fMap.get("CRUD").equals("U")) {
							fMap.put("USE_AT", "Y");
						} else {
							fMap.put("USE_AT", "N");
						}
						System.out.println(fMap);
						edcj01DAO.updateRepInspct(fMap);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	private Map<String, Object> makeMap(JSONObject jsonObject) {
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator<String> iterator = jsonObject.keys();
		while (iterator.hasNext()) {
			String key = iterator.next();
			Object value = null;
			try {
				value = jsonObject.get(key);
				if (value.equals(null)) {
					value = null;
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
			map.put(key, value);
		}
		return map;
	}

}
