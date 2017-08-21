package pantheon.iwrs.d04.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.iwrs.d04.dao.IWRD04DAO;
import pantheon.iwrs.d04.service.IWRD04Service;

/**
 * 공장 재고 현황 처리하는 비지니스 구현 클래스
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
@Service("IWRD04Service")
public class IWRD04ServiceImpl implements IWRD04Service {
	@Resource(name = "IWRD04DAO")
	private IWRD04DAO iwrd04Dao;
	
	@Resource(name = "IWRS_IP_IP_CODE_INFO")
	private EgovPropertyService iwrsIpIpCodeInfo;
	
	@Resource(name = "IWRS_DL_DLVY_IP_STATUS_INFO")
	private EgovPropertyService iwrsDlDlvyIpInfo;
	
	@Resource(name = "IWRS_DS_INVNTRYMANAGE_IP_INFO")
	private EgovPropertyService iwrsDsInvntrymanageIpInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Override
	public List<Map<String, String>> selectFactoryInventoryInfo(Map<String, String> param) throws Exception{
		return iwrd04Dao.selectFactoryInventoryInfo(param);
	}

	@Override
	public void updateIpStatus(Map<String, String> param) throws Exception {
		String ip_code = param.get("IP_CODE");
		String ip_type = param.get("IP_TYPE");
		String creat_code = param.get("CREAT_CODE");
		String ip_sttus_code = param.get("IP_STTUS_CODE");
		String ip_error_code = param.get("IP_ERROR_CODE");
		String ip_etc = param.get("IP_ETC");
		String user_id = param.get("USER_ID");
				
		String ip_code_array[] = ip_code.split(",");
		String ip_type_array[] = ip_type.split(",");
		for(int i = 0; i < ip_code_array.length; i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("IP_CODE", ip_code_array[i]);
			map.put("IP_TYPE", ip_type_array[i]);
			map.put("CREAT_CODE", creat_code);
			map.put("IP_STTUS_CODE", ip_sttus_code);
			map.put("IP_ERROR_CODE", ip_error_code);
			map.put("IP_STTUS_ETC", ip_etc);
			map.put("IP_ERROR_COMMENT", param.get("IP_ERROR_COMMENT"));
			map.put("IP_ERROR_REGISTER_ID", user_id);
			map.put("UPDATE_ID", user_id);
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsIpIpCodeInfo, null, "공장 재고 상태 변경");
			iwrd04Dao.updateIpStatus(map);
			if(iwrd04Dao.selectDeliveryIpStatus(map) > 0){
				comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsDlDlvyIpInfo, null, "공장 재고 상태 변경");
				iwrd04Dao.updateDeliveryIpStatus(map);
			}
			if(iwrd04Dao.selectDrugStockIpStatus(map) > 0){
				comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsDsInvntrymanageIpInfo, null, "공장 재고 상태 변경");
				iwrd04Dao.updateDrugStockIpStatus(map);	
			}
		}
	}
	
	@Override
	public int selectFactoryInvntoryTotalCount(Map<String, String> param) throws Exception{
		return iwrd04Dao.selectFactoryInvntoryTotalCount(param);
	}
	
	@Override
	public int selectFactoryInventoryCount(Map<String, String> param) throws Exception{
		return iwrd04Dao.selectFactoryInventoryCount(param);
	}
	
	@Override
	public List<Map<String, String>> selectFactoryInventorySummary(Map<String, String> param) throws Exception{
		return iwrd04Dao.selectFactoryInventorySummary(param);
	}
}
