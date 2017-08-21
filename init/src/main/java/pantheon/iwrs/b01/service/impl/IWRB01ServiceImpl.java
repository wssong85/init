package pantheon.iwrs.b01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.iwrs.b01.dao.IWRB01DAO;
import pantheon.iwrs.b01.service.IWRB01Service;
import pantheon.iwrs.c01.dao.IWRC01DAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 트리거 처리하는 비지니스 구현 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
@Service("IWRB01Service")
public class IWRB01ServiceImpl extends EgovAbstractServiceImpl implements IWRB01Service {
	@Resource(name = "IWRB01DAO")
	private IWRB01DAO iwrb01Dao;
	
	@Resource(name = "IWRC01DAO")
	private IWRC01DAO iwrc01Dao;
	
	@Resource(name = "IWRS_DS_TRIGR_INFO")
	private EgovPropertyService iwrsDsTrigrInfo;
	
	@Resource(name = "IWRS_DL_DLVYMANAGE_INFO")
	private EgovPropertyService iwrsDlDlvymanageInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	public void insertTriggerInfo(Map<String, String> param) throws Exception{
		System.err.println(param);
		JSONArray array = new JSONArray(param.get("param"));
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("TRIGGER_DATA").length(); i++){
			for(int j = 0; j < array.getJSONObject(0).getJSONArray("IPTYPE").length(); j++){
				Map<String, String> map = new HashMap<String, String>();
				
				map.put("APPLCDE", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString("APPLCDE").replace("-", "").replace("/", ""));
				map.put("TRIGR_LVL", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString(array.getJSONObject(0).getJSONArray("IPTYPE").get(j).toString() + "_INV"));
				map.put("MXMM_INVNTRY_QTT", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString(array.getJSONObject(0).getJSONArray("IPTYPE").get(j).toString() + "_MAX"));
				map.put("IP_TYPE", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString("IP_TYPE_" + array.getJSONObject(0).getJSONArray("IPTYPE").getString(j)));
				map.put("MEMO", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString("MEMO"));
				map.put("INSTT_CODE", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString("INSTT_CODE"));
				map.put("TASK_CODE", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString("TASK_SN"));
				map.put("USE_AT", "Y");
				map.put("USER_ID", array.getJSONObject(0).getString("USER_ID"));
				System.err.println(map);
				if("null".equals(array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString(array.getJSONObject(0).getJSONArray("IPTYPE").getString(j) + "_TR_NO"))){
					String trigrNo = iwrb01Dao.selectTriggerNo();
					map.put("TRIGR_NO", trigrNo);
					iwrb01Dao.insertTriggerInfo(map);
					comz06Service.createCmDtaAtrailForInsertByString(map, iwrsDsTrigrInfo, null, "트리거 설정");
				}else{
					map.put("TRIGR_NO", array.getJSONObject(0).getJSONArray("TRIGGER_DATA").getJSONObject(i).getString(array.getJSONObject(0).getJSONArray("IPTYPE").getString(j) + "_TR_NO"));
					comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsDsTrigrInfo, null, "트리거 설정");
					iwrb01Dao.updateTriggerInfo(map);
				}				
			}
		}
		
	}
	
	public void updateTriggerInfo(Map<String, String> param) throws Exception{
		comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDsTrigrInfo, null, "트리거 설정");
		iwrb01Dao.updateTriggerInfo(param);
	}
	
	public List<Map<String, String>> selectTriggerInfo(Map<String, Object> param) throws Exception{
		String ipTypeCol = "";
		String ipTypeWhere = "";
		String col = "";
		String mainCol = "";
		String trigrNoCol = "";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
//		System.err.println(map);
		List<Map<String, String>> ipTypeList = iwrb01Dao.selectIpType(map);
//		System.err.println(ipTypeList);
		for(int i = 0; i < ipTypeList.size(); i++){
			if(i == 0){
				ipTypeWhere += "'" + ipTypeList.get(i).get("IP_TYPE") + "' AS " + ipTypeList.get(i).get("IP_TYPE");
			}else{
				ipTypeWhere += ", '" + ipTypeList.get(i).get("IP_TYPE") + "' AS " + ipTypeList.get(i).get("IP_TYPE");
			}
			mainCol += ", B." + ipTypeList.get(i).get("INV") + " ";
			mainCol += ", B." + ipTypeList.get(i).get("MAX") + " ";
			mainCol += ", '" + ipTypeList.get(i).get("IP_TYPE") + "'" + "IP_TYPE_" + ipTypeList.get(i).get("IP_TYPE") + " ";
			col += ", B." +  ipTypeList.get(i).get("IP_TYPE") + " AS " + ipTypeList.get(i).get("INV") + ", C." + ipTypeList.get(i).get("IP_TYPE") + " AS " + ipTypeList.get(i).get("MAX") + ", '" + ipTypeList.get(i).get("IP_TYPE") + "' AS IP_TYPE_" + ipTypeList.get(i).get("IP_TYPE");
			ipTypeCol += ", " + ipTypeList.get(i).get("IP_TYPE");
			trigrNoCol += ", (SELECT TRIGR_NO FROM IWRS_DS_TRIGR WHERE TASK_CODE = A.TASK_SN AND INSTT_CODE = A.INSTT_CODE AND IP_TYPE = '" + ipTypeList.get(i).get("IP_TYPE") + "') AS " + ipTypeList.get(i).get("IP_TYPE") + "_TR_NO ";
		}
		
//		sql += "SELECT CASE WHEN A.INSTT_CODE = B.INSTT_CODE THEN B.INSTT_CODE ELSE A.INSTT_CODE END INSTT_CODE, ";
//		sql += mainCol;
//		sql += "CASE WHEN A.INSTT_CODE = B.INSTT_CODE THEN B.APPLCDE ELSE A.APPLCDE END APPLCDE, ";
//		sql += "CASE WHEN A.INSTT_CODE = B.INSTT_CODE THEN B.MEMO ELSE '' END MEMO ";
//		sql += "FROM (";
//		sql += "SELECT A.INSTT_CODE, " + col + ", A.APPLCDE ";
//		sql += "FROM (SELECT B.TASK_CODE, A.INSTT_CODE, A.APPLCDE FROM ";
//		sql += "IWRS_PG_TRIGRESTBSMANAGE A INNER JOIN IWRS_PGE_CREATMASTR B ON A.CREATESTBSCODE = B.CREATESTBSCODE AND A.VER = B.VER GROUP BY TASK_CODE, INSTT_CODE, APPLCDE) A INNER JOIN ";
//		sql += "(SELECT TASK_CODE, INSTT_CODE, " + ipTypeCol + " FROM ";
//		sql += "(SELECT B.TASK_CODE, A.INSTT_CODE, A.IP_TYPE, A.TRIGR_LVL FROM IWRS_PG_TRIGRESTBSMANAGE A INNER JOIN IWRS_PGE_CREATMASTR B ON A.CREATESTBSCODE = B.CREATESTBSCODE AND A.VER = B.VER WHERE B.TASK_CODE = '1') ";
//		sql += "PIVOT (MAX(TRIGR_LVL) FOR IP_TYPE IN (" + ipTypeWhere + "))) B ON A.TASK_CODE = B.TASK_CODE AND A.INSTT_CODE = B.INSTT_CODE ";
//		sql += "INNER JOIN (SELECT TASK_CODE, INSTT_CODE, " + ipTypeCol + " FROM ";
//		sql += "(SELECT B.TASK_CODE, A.INSTT_CODE, A.IP_TYPE, A.MXMM_INVNTRY_QTT FROM IWRS_PG_TRIGRESTBSMANAGE A INNER JOIN IWRS_PGE_CREATMASTR B ON A.CREATESTBSCODE = B.CREATESTBSCODE AND A.VER = B.VER WHERE B.TASK_CODE = '1') ";
//		sql += "PIVOT (MAX(MXMM_INVNTRY_QTT) FOR IP_TYPE IN (" + ipTypeWhere + "))) C ON A.TASK_CODE = C.TASK_CODE AND A.INSTT_CODE = C.INSTT_CODE ) A LEFT JOIN (";
//		sql += "SELECT A.INSTT_CODE, " + col + ", A.APPLCDE, A.MEMO ";
//		sql += "FROM (SELECT TASK_CODE, INSTT_CODE, APPLCDE, MEMO FROM ";
//		sql += "IWRS_DS_TRIGR GROUP BY TASK_CODE, INSTT_CODE, APPLCDE, MEMO) A INNER JOIN ";
//		sql += "(SELECT TASK_CODE, INSTT_CODE, " + ipTypeCol + " FROM ";
//		sql += "(SELECT TASK_CODE, INSTT_CODE, IP_TYPE, TRIGR_LVL FROM IWRS_DS_TRIGR WHERE TASK_CODE = '1') ";
//		sql += "PIVOT (MAX(TRIGR_LVL) FOR IP_TYPE IN (" + ipTypeWhere + "))) B ON A.TASK_CODE = B.TASK_CODE AND A.INSTT_CODE = B.INSTT_CODE ";
//		sql += "INNER JOIN (SELECT TASK_CODE, INSTT_CODE, " + ipTypeCol + " FROM ";
//		sql += "(SELECT TASK_CODE, INSTT_CODE, IP_TYPE, MXMM_INVNTRY_QTT FROM IWRS_DS_TRIGR WHERE TASK_CODE = '1') ";
//		sql += "PIVOT (MAX(MXMM_INVNTRY_QTT) FOR IP_TYPE IN (" + ipTypeWhere + "))) C ON A.TASK_CODE = C.TASK_CODE AND A.INSTT_CODE = C.INSTT_CODE ) B ";
//		sql += "ON A.INSTT_CODE = B.INSTT_CODE";
		
		map.put("mainCol", mainCol);
		map.put("col", col);
		map.put("ipTypeCol", ipTypeCol);
		map.put("ipTypeWhere", ipTypeWhere);
		map.put("trigrNoCol", trigrNoCol);
		
		return iwrb01Dao.selectTriggerInfo(map);
	}
	
	public void insertRequestDelivery(Map<String, String> param) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("TASK_SN", param.get("TASK_CODE"));
		List<Map<String, String>> taskList = iwrb01Dao.selectTaskInfo(map);
		for(Map<String, String> task : taskList){
			System.err.println(task);
			map.put("TASK_CODE", String.valueOf(task.get("TASK_CODE")));
			map.put("TASK_SN", String.valueOf(task.get("TASK_CODE")));
			map.put("INSTT_CODE", param.get("INSTT_CODE"));
			List<Map<String, String>> insttList = iwrb01Dao.selectInsttInfo(map);
			for(Map<String, String> instt : insttList){
				System.err.println(instt);
				List<Map<String, String>> ipTypeList = iwrb01Dao.selectIpType(map);
				for(Map<String, String> ipType : ipTypeList){
					map.put("INSTT_CODE", String.valueOf(instt.get("INSTT_CODE")));
					map.put("IP_TYPE", String.valueOf(ipType.get("IP_TYPE")));
					String triggerFlag = iwrb01Dao.selectTriggerFlag(map);
					int deliveryCnt = iwrb01Dao.selectDeliveryCount(map);
					if("Y".equals(triggerFlag) && deliveryCnt == 0){
						List<Map<String, String>> ipTypeDetailList = iwrb01Dao.selectIpType(map);
						String deliveryManageNo = iwrc01Dao.selectDlvyManageCode(map);
						for(Map<String, String> ipTypeDetail : ipTypeDetailList){
							map.put("IP_TYPE", ipTypeDetail.get("IP_TYPE"));
							int maxInventoryQty = iwrb01Dao.selectMaxInventoryQuantity(map);
							int usefulInventoryQty = iwrb01Dao.selectUsefulInventoryQuantity(map);
							Map<String, String> snParamMap = new HashMap<String, String>();
							snParamMap.put("DLVYMANAGE_CODE", deliveryManageNo);
							int sn = iwrc01Dao.selectDlvyManageNo(snParamMap);
							map.put("DLVYMANAGE_CODE", deliveryManageNo);
							map.put("SN", String.valueOf(sn));
							map.put("MXMM_INVNTRY_QTT", String.valueOf(maxInventoryQty));
							map.put("USEFUL_INVNTRY_QTT", String.valueOf(usefulInventoryQty));
							iwrb01Dao.insertDlvyManageInfo(map);
							comz06Service.createCmDtaAtrailForInsertByString(map, iwrsDlDlvymanageInfo, null, "배송 요청 등록");
						}
						break;
					}
				}
			}
		}
	}
	
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception{
		return iwrb01Dao.selectIpType(param);
	}
	
	@Override
	public int selectUserInfo(Map<String, String> param) throws Exception{
		return iwrb01Dao.selectUserInfo(param);
	}
}
