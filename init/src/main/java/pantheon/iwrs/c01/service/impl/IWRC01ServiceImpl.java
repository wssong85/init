package pantheon.iwrs.c01.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.iwrs.c01.dao.IWRC01DAO;
import pantheon.iwrs.c01.service.IWRC01Service;
import pantheon.iwrs.c02.service.IWRC02Service;
import egovframework.rte.fdl.property.EgovPropertyService;
import org.codehaus.jettison.json.JSONArray;

/**
 * 배송정보 처리하는 비지니스 구현 클래스
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
@Service("IWRC01Service")
public class IWRC01ServiceImpl implements IWRC01Service {
	@Resource(name = "IWRC01DAO")
	private IWRC01DAO iwrc01Dao;
	
	@Resource(name = "IWRS_DL_DLVYREQUSTMANAGE_INFO")
	private EgovPropertyService iwrsDlDlvyrequstmanageInfo;
	
	@Resource(name = "IWRS_DL_DLVYMANAGE_INFO")
	private EgovPropertyService iwrsDlDlvymanageInfo;
	
	@Resource(name = "IWRS_DL_DLVY_IP_INFO")
	private EgovPropertyService iwrsDlDlvyIpInfo;
	
	@Resource(name = "IWRS_IP_IP_CODE_INFO")
	private EgovPropertyService iwrsIpIpCodeInfo;
	
	@Resource(name = "IWRS_DS_INVNTRYMANAGE_DETAIL_INFO")
	private EgovPropertyService iwrsDsInvntrymanageDetailInfo;
	
	@Resource(name = "IWRS_DS_INVNTRYMANAGE_IP_INFO")
	private EgovPropertyService iwrsDsInvntrymanageIpInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "IWRC02Service")
	private IWRC02Service iwrc02Service;
	
	
	@Override
	public List<Map<String, String>> selectDeliveryInfo(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectDeliveryInfo(param);
	}
	
	@Override
	public void insertDeliveryRequestInfo(Map<String, String> param) throws Exception{
		param.put("DLVYREQUSTMANAGE_CODE", iwrc01Dao.selectRequstManageCode());
//		System.err.println(param);
		iwrc01Dao.insertDeliveryRequestInfo(param);
		comz06Service.createCmDtaAtrailForInsertByString(param, iwrsDlDlvyrequstmanageInfo, null, "관리약사 배송 요청 등록");
		
//		if(true){
//			throw new Exception("테스트");
//		}
	}
	
	@Override
	public void insertDeliveryInfo(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("param"));
		String code = iwrc01Dao.selectDlvyManageCode(param);
//		System.err.println("code : " + code);
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("iptype").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("DLVYMANAGE_CODE", code);
			
			int sn = iwrc01Dao.selectDlvyManageNo(map);
			
			map.put("SN", String.valueOf(sn));
			map.put("INSTT_CODE", array.getJSONObject(0).getString("instt_code"));
			map.put("TASK_CODE", array.getJSONObject(0).getString("task_code"));
			map.put("DLVY_HOPEDE", array.getJSONObject(0).getString("deli_request_date"));
			map.put("IP_TYPE", array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType"));
			map.put("DLVY_REQUST_QTT", array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipCnt"));
			map.put("DLVY_REQUST_OCCRRNC_CODE", "02");
			map.put("DLVY_STTUS_CODE", "02");
			map.put("DLVY_REQUST_COMMENT", array.getJSONObject(0).getString("memo"));
			map.put("DLVY_RQESTER_ID", array.getJSONObject(0).getString("user_id"));
			map.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			map.put("USE_AT", "Y");
			System.out.println("USER_ID :" + Util.getUserMap().get("USER_ID"));
			System.out.println("TASK_NO :" + Util.getUserMap().get("TASK_NO"));
			iwrc01Dao.insertDeliveryInfo(map);
			comz06Service.createCmDtaAtrailForInsertByString(map, iwrsDlDlvymanageInfo, null, "배송 요청 등록");
			
			map.put("IP_STTUS_CODE", "02");
			map.put("type", null);
//			System.err.println(map);
			List<Map<String, String>> list = iwrc01Dao.selectGroupInfo(map);
			for(int j = 0; j < list.size(); j++){
//				System.err.println("array : " + array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType"));
//				System.err.println("list : " + list.get(j).get("IP_TYPE"));
				if(array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType").equals(list.get(j).get("IP_TYPE"))){
					map.put("MDLRTGR_CODE", list.get(j).get("MDLRTGR_CODE"));
//					System.err.println("들어왔음");
					List<Map<String, String>> ipList = iwrc01Dao.selectDeliveryIpInfo(map);
					for(Map<String, String> ipMap : ipList){
						map.put("IP_CODE", ipMap.get("IP_CODE"));
						map.put("CREAT_CODE", ipMap.get("CREAT_CODE"));
//						System.err.println(map);
						int ipTargetNo = iwrc01Dao.selectIpTargetNo(map);
						
						map.put("IP_TRGET_NO", String.valueOf(ipTargetNo));
						iwrc01Dao.insertDeliveryIpInfo(map);
//						System.err.println(map); 
						comz06Service.createCmDtaAtrailForInsertByString(map, iwrsDlDlvyIpInfo, null, "배송 요청 등록");
						comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsIpIpCodeInfo, null, "배송 요청 등록으로 인한 상태 변경");
						iwrc01Dao.updateIpStatusInfo(map);
					}
				}
			}
		}
	}
	
	@Override
	public void updateDeliveryInfo(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("param"));
		
		Map<String, String> dlvyManageCode = new HashMap<String, String>();
		dlvyManageCode.put("DLVYMANAGE_CODE", array.getJSONObject(0).getString("dlvymanage_code"));
		dlvyManageCode.put("USE_AT", "N");
		dlvyManageCode.put("USER_ID", array.getJSONObject(0).getString("user_id"));
		
		List<Map<String, String>> dlvyManageList = iwrc01Dao.selectDeliveryIpDetailForCancel(dlvyManageCode);
		for(int i = 0; i < dlvyManageList.size(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("IP_CODE", dlvyManageList.get(i).get("IP_CODE"));
			map.put("CREAT_CODE", dlvyManageList.get(i).get("CREAT_CODE"));
			map.put("IP_TYPE", dlvyManageList.get(i).get("IP_TYPE"));
			map.put("IP_TRGET_NO", String.valueOf(dlvyManageList.get(i).get("IP_TRGET_NO")));
			map.put("DLVYMANAGE_CODE", dlvyManageList.get(i).get("DLVYMANAGE_CODE"));
			map.put("SN", String.valueOf(dlvyManageList.get(i).get("SN")));
			map.put("IP_STTUS_CODE", "01");
			map.put("USE_AT", "N");
			map.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsIpIpCodeInfo, null, "배송 요청 수정으로 인한 상태 변경");
			iwrc01Dao.updateIpStatusInfo(map);
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsDlDlvyIpInfo, null, "배송 요청 수정");
			iwrc01Dao.updateDeliveryIpStatusInfo(map);
		}
//IP_TRGET_NO,DLVYMANAGE_CODE,IP_CODE,CREAT_CODE,IP_TYPE,SN
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("iptype").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("INSTT_CODE", array.getJSONObject(0).getString("instt_code"));
			map.put("TASK_CODE", array.getJSONObject(0).getString("task_code"));
			map.put("DLVY_HOPEDE", array.getJSONObject(0).getString("deli_request_date"));
			map.put("IP_TYPE", array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType"));
			map.put("DLVY_REQUST_QTT", array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipCnt"));
			map.put("SN", array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("SN"));
			map.put("DLVY_REQUST_COMMENT", array.getJSONObject(0).getString("memo"));
			map.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			map.put("DLVYMANAGE_CODE", array.getJSONObject(0).getString("dlvymanage_code"));
			map.put("DLVY_STTUS_CODE", "02");
			map.put("USE_AT", "Y");
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsDlDlvymanageInfo, null, "배송 요청 수정");
			iwrc01Dao.updateDeliveryInfo(map);
			
//			int sn = iwrc01Dao.selectDlvyManageNo(map);
//			
//			map.put("SN", String.valueOf(sn));
			
			map.put("IP_STTUS_CODE", "02");
			
			List<Map<String, String>> list = iwrc01Dao.selectGroupInfo(map);
			for(int j = 0; j < list.size(); j++){
//				System.err.println("array : " + array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType"));
//				System.err.println("list : " + list.get(j).get("IP_TYPE"));
				if(array.getJSONObject(0).getJSONArray("iptype").getJSONObject(i).getString("ipType").equals(list.get(j).get("IP_TYPE"))){
					map.put("MDLRTGR_CODE", list.get(j).get("MDLRTGR_CODE"));
//					System.err.println("들어왔음");
					List<Map<String, String>> ipList = iwrc01Dao.selectDeliveryIpInfo(map);
					for(Map<String, String> ipMap : ipList){
						map.put("IP_CODE", ipMap.get("IP_CODE"));
						map.put("CREAT_CODE", ipMap.get("CREAT_CODE"));
//						System.err.println(map);
						int ipTargetNo = iwrc01Dao.selectIpTargetNo(map);
						
						map.put("IP_TRGET_NO", String.valueOf(ipTargetNo));
						iwrc01Dao.insertDeliveryIpInfo(map);
						comz06Service.createCmDtaAtrailForInsertByString(map, iwrsDlDlvyIpInfo, null, "배송 요청 등록");
						comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsIpIpCodeInfo, null, "배송 요청 등록으로 인한 상태 변경");
						iwrc01Dao.updateIpStatusInfo(map);
					}
				}
			}
		}
	}
	
	@Override
	public List<Map<String, String>> selectDeliveryIpDetailInfo(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectDeliveryIpDetailInfo(param);
	}
	
	@Override
	public Map<String, String> selectDeliveryRequestInfo(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectDeliveryRequestInfo(param);
	}
	
	@Override
	public void updateDeliveryConfirmInfo(Map<String, String> param) throws Exception{
		param.put("DLVY_STTUS_CODE", "04");
		List<Map<String, String>> dlvyList = iwrc01Dao.selectDlvyManagerInfo(param);
		for(int i = 0; i < dlvyList.size(); i++){
			param.put("SN", String.valueOf(dlvyList.get(i).get("SN")));
			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDlDlvymanageInfo, null, "배송 확인");
			iwrc01Dao.updateDeliveryConfirmInfo(param);
		}
		
		param.put("IP_STTUS_CODE", "04");
				
		List<Map<String, String>> list = iwrc01Dao.selectDeliveryIpDetailForCancel(param);
		for(Map<String, String> ip : list){
			param.put("CREAT_CODE", ip.get("CREAT_CODE"));
			param.put("IP_CODE", ip.get("IP_CODE"));
			param.put("IP_TYPE", ip.get("IP_TYPE"));
			param.put("IP_TRGET_NO", String.valueOf(ip.get("IP_TRGET_NO")));
			param.put("SN", String.valueOf(ip.get("SN")));
			param.put("USE_AT", "Y");

			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDlDlvyIpInfo, null, "배송 확인");
			iwrc01Dao.updateDeliveryIpStatusInfo(param);
			
			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsIpIpCodeInfo, null, "배송 확인");
			iwrc01Dao.updateIpStatusInfo(param);
		}
	}
	
	@Override
	public void updateDeliveryCancelInfo(Map<String, String> param) throws Exception{
		List<Map<String, String>> dlvyList = iwrc01Dao.selectDlvyManagerInfo(param);
		for(int i = 0; i < dlvyList.size(); i++){
			param.put("SN", String.valueOf(dlvyList.get(i).get("SN")));
			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDlDlvymanageInfo, null, "배송 취소");
			iwrc01Dao.updateDeliveryCancelInfo(param);
		}
		
		param.put("IP_STTUS_CODE", "01");
		List<Map<String, String>> list = iwrc01Dao.selectDeliveryIpDetailForCancel(param);
		for(Map<String, String> ip : list){
			param.put("CREAT_CODE", ip.get("CREAT_CODE"));
			param.put("IP_CODE", ip.get("IP_CODE"));
			param.put("IP_TYPE", ip.get("IP_TYPE"));
			param.put("IP_TRGET_NO", String.valueOf(ip.get("IP_TRGET_NO")));
			param.put("SN", String.valueOf(ip.get("SN")));
			param.put("USE_AT", "Y");
			
			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsIpIpCodeInfo, null, "배송 취소");
			iwrc01Dao.updateIpStatusInfo(param);
			
			comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDlDlvyIpInfo, null, "배송 취소");
			iwrc01Dao.updateDeliveryIpStatusInfo(param);
		}
	}
	
	@Override
	public Map<String, String> selectCancelInfo(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectCancelInfo(param);
	}

	@Override
	public List<Map<String, String>> selectIpErroInfo(Map<String, String> param) throws Exception {
		return iwrc01Dao.selectIpErrorInfo(param);
	}

	@Override
	public void updateIpInsuInfo(Map<String, String> param) throws Exception {
		String invenCode = "";
		JSONArray array = new JSONArray(param.get("data"));
		
		Map<String, String> dlvyManageCode = new HashMap<String, String>();
		dlvyManageCode.put("DLVYMANAGE_CODE", array.getJSONObject(0).getString("dlvymanage_code"));
		dlvyManageCode.put("DLVY_COMPTDE", array.getJSONObject(0).getString("dlvy_comptde"));
		dlvyManageCode.put("UNDTAKE_CNFRMR_ID", array.getJSONObject(0).getString("user_id"));
		dlvyManageCode.put("USER_ID", array.getJSONObject(0).getString("user_id"));
		dlvyManageCode.put("UNDTAKECNFIRM_COMMENT", array.getJSONObject(0).getString("memo"));
		
		List<Map<String, String>> invenDetailCnt = iwrc01Dao.selectDrugStockDetailInfoCnt(dlvyManageCode);
		if(invenDetailCnt.size() > 0){
			invenCode = invenDetailCnt.get(0).get("INVNTRYMANAGE_CODE");
		}else{
			invenCode = iwrc01Dao.selectInvntryManageCode();
		}
		
		List<Map<String, String>> dlvyList = iwrc01Dao.selectDlvyManagerInfo(dlvyManageCode);
		for(int i = 0; i < dlvyList.size(); i++){
			dlvyManageCode.put("SN", String.valueOf(dlvyList.get(i).get("SN")));
			comz06Service.createCmDtaAtrailForUpdateByString(dlvyManageCode, iwrsDlDlvymanageInfo, null, "인수 확인");
			iwrc01Dao.updateDeliInsuInfo(dlvyManageCode);

			
			List<Map<String, String>> list = iwrc01Dao.selectInvntryManageInfo(dlvyManageCode);
			for(Map<String, String> invList : list){
				Map<String, String> invenMap = new HashMap<String, String>();
				invenMap.put("DLVYMANAGE_CODE", invList.get("DLVYMANAGE_CODE"));
				invenMap.put("SN", String.valueOf(invList.get("SN")));
				invenMap.put("IP_TYPE", invList.get("IP_TYPE"));
				invenMap.put("CREAT_CODE", invList.get("CREAT_CODE"));
				invenMap.put("TASK_CODE", invList.get("TASK_CODE"));
				invenMap.put("INSTT_CODE", invList.get("INSTT_CODE"));
				invenMap.put("PARMACY_INVNTRY_QTT", String.valueOf(invList.get("DLVY_REQUST_QTT")));
				invenMap.put("USEFUL_INVNTRY_QTT", String.valueOf(invList.get("DLVY_REQUST_QTT")));
				invenMap.put("USE_AT", "Y");
				invenMap.put("USER_ID", array.getJSONObject(0).getString("user_id"));
				invenMap.put("INVNTRYMANAGE_CODE", invenCode);
				
				if(invenDetailCnt.size() > 0){
					comz06Service.createCmDtaAtrailForUpdateByString(invenMap, iwrsDsInvntrymanageDetailInfo, null, "재고 등록");
					iwrc01Dao.updateDrugStockDetailInfo(invenMap);
				}else{
					iwrc01Dao.insertDrugStockDetailInfo(invenMap);
					comz06Service.createCmDtaAtrailForInsertByString(invenMap, iwrsDsInvntrymanageDetailInfo, null, "재고 등록");
				}
			}
		}
		
		int errCnt = 0;
		
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("error_data").length(); i++){
			Map<String, String> errorMap = new HashMap<String, String>();
			
			errorMap.put("IP_CODE", array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("IP_CODE"));
			errorMap.put("CREAT_CODE", array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("CREAT_CODE"));
			errorMap.put("IP_TYPE", array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("IP_TYPE"));
			errorMap.put("DLVYMANAGE_CODE", array.getJSONObject(0).getString("dlvymanage_code"));
			errorMap.put("IP_TRGET_NO", array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("IP_TRGET_NO"));
			errorMap.put("SN", array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("SN"));
			errorMap.put("USER_ID", array.getJSONObject(0).getString("user_id"));
			
			if("Y".equals(array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("OMISSION"))){
				errorMap.put("IP_STTUS_CODE", "06");
				errorMap.put("IP_ERROR_CODE", "04");
				errorMap.put("USEFUL_INVNTRY_AT", "N");
				errorMap.put("IP_ERROR_COMMENT", array.getJSONObject(0).getString("IP_ERROR_COMMENT"));
				errorMap.put("IP_ERROR_REGISTER_ID", array.getJSONObject(0).getString("user_id"));
				errCnt++;
			}else if("Y".equals(array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("DAMAGE"))){
				errorMap.put("IP_STTUS_CODE", "06");
				errorMap.put("IP_ERROR_CODE", "06");
				errorMap.put("USEFUL_INVNTRY_AT", "N");
				errorMap.put("IP_ERROR_COMMENT", array.getJSONObject(0).getString("IP_ERROR_COMMENT"));
				errorMap.put("IP_ERROR_REGISTER_ID", array.getJSONObject(0).getString("user_id"));
				errCnt++;
			}else if("Y".equals(array.getJSONObject(0).getJSONArray("error_data").getJSONObject(i).getString("LOSS"))){
				errorMap.put("IP_STTUS_CODE", "06");
				errorMap.put("IP_ERROR_CODE", "05");
				errorMap.put("USEFUL_INVNTRY_AT", "N");
				errorMap.put("IP_ERROR_COMMENT", array.getJSONObject(0).getString("IP_ERROR_COMMENT"));
				errorMap.put("IP_ERROR_REGISTER_ID", array.getJSONObject(0).getString("user_id"));
				errCnt++;
			}else{
				errorMap.put("IP_STTUS_CODE", "07");
				errorMap.put("IP_ERROR_CODE", "");
				errorMap.put("USEFUL_INVNTRY_AT", "Y");
				errorMap.put("IP_ERROR_REGISTER_ID", null);
			}
			errorMap.put("INVNTRYMANAGE_CODE", invenCode);
			errorMap.put("WRHOUSNGDE", array.getJSONObject(0).getString("dlvy_comptde"));
//			System.err.println(errorMap);
			comz06Service.createCmDtaAtrailForUpdateByString(errorMap, iwrsDlDlvyIpInfo, null, "인수 확인");
			iwrc01Dao.updateDeliInsuIpInfo(errorMap);
			comz06Service.createCmDtaAtrailForUpdateByString(errorMap, iwrsIpIpCodeInfo, null, "인수 확인");
			iwrc01Dao.updateIpErrorInfo(errorMap);
			
			List<Map<String, String>> ipInfoCnt = iwrc01Dao.selectDrugStockIpInfoCnt(errorMap);
			if(ipInfoCnt.size() > 0){
				comz06Service.createCmDtaAtrailForUpdateByString(errorMap, iwrsDsInvntrymanageIpInfo, null, "재고 등록");
				iwrc01Dao.updateDrugStockIpInfo(errorMap);
			}else{
				iwrc01Dao.insertDrugStockIpInfo(errorMap);
				comz06Service.createCmDtaAtrailForInsertByString(errorMap, iwrsDsInvntrymanageIpInfo, null, "재고 등록");
			}
		}
		
		for(int i = 0; i < dlvyList.size(); i++){
			dlvyManageCode.put("SN", String.valueOf(dlvyList.get(i).get("SN")));
			List<Map<String, String>> list = iwrc01Dao.selectInvntryManageInfo(dlvyManageCode);
			for(Map<String, String> invList : list){
				Map<String, String> invenMap = new HashMap<String, String>();
				invenMap.put("DLVYMANAGE_CODE", invList.get("DLVYMANAGE_CODE"));
				invenMap.put("SN", String.valueOf(invList.get("SN")));
				invenMap.put("INVNTRYMANAGE_CODE", invenCode);
				List<Map<String, String>> invnList = iwrc01Dao.selectInvntryManageDetailInfo(invenMap);
				invenMap.put("PARMACY_INVNTRY_QTT", String.valueOf(Integer.parseInt(invnList.get(0).get("PARMACY_INVNTRY_QTT")) - errCnt));
				invenMap.put("USEFUL_INVNTRY_QTT", String.valueOf(Integer.parseInt(invnList.get(0).get("USEFUL_INVNTRY_QTT")) - errCnt));
				
				comz06Service.createCmDtaAtrailForUpdateByString(invenMap, iwrsDsInvntrymanageDetailInfo, null, "재고 등록");
				iwrc01Dao.updateInventoryCount(invenMap);
				
			}
		}
	}
	
	@Override
	public List<Map<String, String>> selectGroupInfo(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectGroupInfo(param);
	}
	
	@Override
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectIpType(param);
	}
	
	@Override
	public List<Map<String, String>> selectInstt(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectInstt(param);
	}
	
	@Override
	public List<Map<String, String>> selectDeliveryIpCode(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectDeliveryIpCode(param);
	}
	
	@Override
	public String selectUserInsttCode(Map<String, String> param) throws Exception{
		return iwrc01Dao.selectUserInsttCode(param);
	}
}
