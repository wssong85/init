package pantheon.com.z06.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.dao.NTCOMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("NTCOMZ06Service")
public class NTCOMZ06ServiceImpl implements COMZ06Service{
	
	@Resource(name = "NTCOMZ06DAO")
	private NTCOMZ06DAO comz06DAO;
	
	@Override
	public void createCmDtaAtrailForInsertByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += String.valueOf(map.get(iStr)) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrail(tableNm, columns, labels, Util.getStrForTrail(tablePk), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}
	
	@Override
	public void createCmDtaAtrailForUpdateByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += String.valueOf(map.get(iStr)) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrailForUpdate(tableNm, Util.getMapForTrailByObject(map, columns), Util.getMapForTrailByArrObject(map, columns, labels), propertyService.getString("TABLE_PK"), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}
	
	@Override
	public void createCmDtaAtrailForDeleteByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += String.valueOf(map.get(iStr)) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrailForDelete(tableNm, Util.getMapForTrailByObject(map, columns), Util.getMapForTrailByArrObject(map, columns, labels), propertyService.getString("TABLE_PK"), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}
	
	@Override
	public void createCmDtaAtrailForInsertByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += map.get(iStr) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrail(tableNm, columns, labels, Util.getStrForTrail(tablePk), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}
	
	@Override
	public void createCmDtaAtrailForUpdateByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += map.get(iStr) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrailForUpdate(tableNm, Util.getMapForTrail(map, columns), Util.getMapForTrailByArrString(map, columns, labels), propertyService.getString("TABLE_PK"), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}

	@Override
	public void createCmDtaAtrailForDeleteByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception {
		String tableNm = propertyService.getString("TABLE_NM");
		String[] tablePk = propertyService.getString("TABLE_PK").split(",");
		String[] columns = propertyService.getString("COLUMN_NM").split(",");
		String[] labels = propertyService.getString("LABEL_NM").split(",");
		String module = propertyService.getString("MODULE");
		String pkNm = "";
		for(String iStr : tablePk) {
			pkNm += map.get(iStr) + ",";
		}
		pkNm = pkNm.substring(0, pkNm.length() -1);
		
		insertCmDtaAtrailForDelete(tableNm, Util.getMapForTrail(map, columns), Util.getMapForTrailByArrString(map, columns, labels), propertyService.getString("TABLE_PK"), pkNm, code, reason, module, Util.getLabelMap(columns, labels));
	}
	
	@Override
	public void insertCmDtaAtrail(String tableNm, String[] columnNm, String[] labels, String tablePk,
			String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		Map<String, String> convertMap = new HashMap<String, String>();
		
		String[] arr = tablePk.split(",");
		String[] arr2 = pkNm.split(",");
		
		for(int i = 0; i < arr.length; i++) {
			convertMap.put(arr[i], arr2[i]);
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		for(String mapkey : columnNm) {
			if(Util.isDamo(mapkey)) {
				sb.append("DAMO_DEC(" + mapkey + ") AS " + mapkey + " ,");
			} else {
				sb.append(mapkey + " ,");
			}
		}
		sb.delete(sb.length()-1, sb.length());
				
		sb.append(" FROM ");
		sb.append(tableNm);
		sb.append(" WHERE 1=1 ");
		for(String mapkey2 : convertMap.keySet()){
			if(Util.isDamo(mapkey2)) {
				sb.append(" AND " + mapkey2 + "= DAMO_ENC('" + convertMap.get(mapkey2)+"')");
			} else {
				sb.append(" AND " + mapkey2 + "='" + convertMap.get(mapkey2)+"'");
			}
		}
		sb.append(" AND ROWNUM = 1");
		
		Map<String, Object> resultMap = comz06DAO.selectDynamicTable(sb.toString());
		
		for(String iStr : columnNm) {
			
			for(Object mapkey : resultMap.keySet()){
				
				if(!iStr.equals(EgovStringUtil.isNullToString(mapkey))) {
					continue;
				}
				
				if(resultMap.get(mapkey) == null) {
					continue;
				}
				
				map.put("TABLE_NM", tableNm);
				map.put("TABLE_PK", tablePk);
				map.put("PK_NM", pkNm);
				map.put("COLUMN_NM", String.valueOf(mapkey));
				map.put("MODULE", module);
				
				map.put("AFTUPD_VALUE", String.valueOf(resultMap.get(mapkey)));
				
				if(EgovStringUtil.isEmpty(code)) {
					map.put("STRE_RESN_CODE", "01");
				} else {
					map.put("STRE_RESN_CODE", code);
				}
				
				if(reason != null && reason.indexOf("CONVERT_PROGRM_NM") > 0) {
					
					String[] strTmp = reason.split("&");
					
					if(strTmp.length == 3) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", null);
						
					} else if(strTmp.length == 4) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", strTmp[3]);
					}
					
				} else {
					
					map.put("STRE_ETC_RESN", reason);
					
				}
				
				try {
					map.put("TASK_NO", Util.getUserMap().get("TASK_NO"));
					map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				} catch (Exception e) {
					map.put("USER_ID", "admin");
				}
				
				for(String labelStr : labelMap.keySet()) {
					if(labelStr.equals(EgovStringUtil.isNullToString(mapkey))) {
						map.put("LABEL_NM", labelMap.get(labelStr));
					}
				}
				
				comz06DAO.insertCmDtaAtrail(map);
			}
		}
	}

	@Override
	public void insertCmDtaAtrailForUpdate(String tableNm, Map<String, String> columnNm, String[] labels,
			String tablePk, String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		Map<String, String> convertMap = new HashMap<String, String>();
		
		String[] arr = tablePk.split(",");
		String[] arr2 = pkNm.split(",");
		
		for(int i = 0; i < arr.length; i++) {
			convertMap.put(arr[i], arr2[i]);
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		for(String mapkey : columnNm.keySet()){
			if(Util.isDamo(mapkey)) {
				sb.append("DAMO_DEC(" + mapkey + ") AS " + mapkey + " ,");
			} else {
				sb.append(mapkey + " ,");
			}
		}
		sb.delete(sb.length()-1, sb.length());
				
		sb.append(" FROM ");
		sb.append(tableNm);
		sb.append(" WHERE 1=1 ");
		for(String mapkey2 : convertMap.keySet()){
			if(Util.isDamo(mapkey2)) {
				sb.append(" AND " + mapkey2 + "= DAMO_ENC('" + convertMap.get(mapkey2)+"')");
			} else {
				sb.append(" AND " + mapkey2 + "='" + convertMap.get(mapkey2)+"'");
			}
		}
		sb.append(" AND ROWNUM = 1");
		
		Map<String, Object> resultMap = comz06DAO.selectDynamicTable(sb.toString());
		
		for(String columnMapkey : columnNm.keySet()) {
			
			for(Object mapkey : resultMap.keySet()){
				
				if(!columnMapkey.equals(EgovStringUtil.isNullToString(mapkey))) {
					continue;
				}
				
				if(resultMap.get(mapkey) == null) {
					continue;
				}
				
				if(String.valueOf(resultMap.get(mapkey)).equals(String.valueOf(columnNm.get(mapkey)))) {
					continue;
				}
				
				map.put("TABLE_NM", tableNm);
				map.put("TABLE_PK", tablePk);
				map.put("PK_NM", pkNm);
				map.put("COLUMN_NM", String.valueOf(mapkey));
				map.put("MODULE", module);
				
				map.put("UPDTBFE_VALUE", String.valueOf(resultMap.get(mapkey)));
				map.put("AFTUPD_VALUE", columnNm.get(mapkey));
				
				if(EgovStringUtil.isEmpty(code)) {
					map.put("STRE_RESN_CODE", "04");
				} else {
					map.put("STRE_RESN_CODE", code);
				}
				
				if(reason != null && reason.startsWith("CONVERT_PROGRM_NM")) {
					
					String[] strTmp = reason.split("&");
					
					if(strTmp.length == 3) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", null);
						
					} else if(strTmp.length == 4) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", strTmp[3]);
					}
					
				} else {
					
					map.put("STRE_ETC_RESN", reason);
					
				}

				try {
					map.put("TASK_NO", Util.getUserMap().get("TASK_NO"));
					map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				} catch (Exception e) {
					map.put("USER_ID", "admin");
				}
				
				for(String labelStr : labelMap.keySet()) {
					if(labelStr.equals(EgovStringUtil.isNullToString(mapkey))) {
						map.put("LABEL_NM", labelMap.get(labelStr));
					}
				}
				
				comz06DAO.insertCmDtaAtrail(map);
			}
		}

	}

	@Override
	public void insertCmDtaAtrailForDelete(String tableNm, Map<String, String> columnNm, String[] labels, String tablePk, String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		Map<String, String> convertMap = new HashMap<String, String>();
		
		String[] arr = tablePk.split(",");
		String[] arr2 = pkNm.split(",");
		
		for(int i = 0; i < arr.length; i++) {
			convertMap.put(arr[i], arr2[i]);
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		for(String mapkey : columnNm.keySet()){
			if(Util.isDamo(mapkey)) {
				sb.append("DAMO_DEC(" + mapkey + ") AS " + mapkey + " ,");
			} else {
				sb.append(mapkey + " ,");
			}
		}
		sb.delete(sb.length()-1, sb.length());
				
		sb.append(" FROM ");
		sb.append(tableNm);
		sb.append(" WHERE 1=1 ");
		for(String mapkey2 : convertMap.keySet()){
			if(Util.isDamo(mapkey2)) {
				sb.append(" AND " + mapkey2 + "= DAMO_ENC('" + convertMap.get(mapkey2)+"')");
			} else {
				sb.append(" AND " + mapkey2 + "='" + convertMap.get(mapkey2)+"'");
			}
		}
		sb.append(" AND ROWNUM = 1");
		
		Map<String, Object> resultMap = comz06DAO.selectDynamicTable(sb.toString());
		
		for(String columnMapkey : columnNm.keySet()) {
			
			for(Object mapkey : resultMap.keySet()){
				
				if(resultMap.get(mapkey) == null) {
					continue;
				}
				
				if(!columnMapkey.equals(EgovStringUtil.isNullToString(mapkey))) {
					continue;
				}
				
				map.put("TABLE_NM", tableNm);
				map.put("TABLE_PK", tablePk);
				map.put("PK_NM", pkNm);
				map.put("COLUMN_NM", String.valueOf(mapkey));
				map.put("MODULE", module);
				
				map.put("UPDTBFE_VALUE", String.valueOf(resultMap.get(mapkey)));
				map.put("AFTUPD_VALUE", "");
				
				if(EgovStringUtil.isEmpty(code)) {
					map.put("STRE_RESN_CODE", "06");
				} else {
					map.put("STRE_RESN_CODE", code);
				}
				
				if(reason != null && reason.indexOf("CONVERT_PROGRM_NM") > 0) {
					
					String[] strTmp = reason.split("&");
					
					if(strTmp.length == 3) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", null);
						
					} else if(strTmp.length == 4) {
						
						map.put("PROGRM_NM", strTmp[1]);
						map.put("CONECT_IP", strTmp[2]);
						map.put("STRE_ETC_RESN", strTmp[3]);
					}
					
				} else {
					
					map.put("STRE_ETC_RESN", reason);
					
				}
				
				try {
					map.put("TASK_NO", Util.getUserMap().get("TASK_NO"));
					map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				} catch (Exception e) {
					map.put("USER_ID", "admin");
				}
				
				for(String labelStr : labelMap.keySet()) {
					if(labelStr.equals(EgovStringUtil.isNullToString(mapkey))) {
						map.put("LABEL_NM", labelMap.get(labelStr));
					}
				}
				
				comz06DAO.insertCmDtaAtrail(map);
				
			}
		}
		
	}

}
