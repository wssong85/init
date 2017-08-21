package pantheon.iwrs.b01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 트리거 정보 관리를 위한 데이터 접근 클래스
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
@Repository("IWRB01DAO")
public class IWRB01DAO extends EgovComAbstractDAO {
	/**
	 * 트리거 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertTriggerInfo(Map<String, String> param) throws Exception{
		insert("IWRB01DAO.insertTriggerInfo", param);
	}

	/**
	 * 트리거 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateTriggerInfo(Map<String, String> param) throws Exception{
		update("IWRB01DAO.updateTriggerInfo", param);
	}
	
	/**
	 * 트리거 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectTriggerInfo(Map<String, String> param) throws Exception{
		List<Map<String, String>> triggerList = (List<Map<String, String>>)list("IWRB01DAO.selectTriggerInfo", param);
		System.err.println(triggerList);
		return triggerList;
	}
	
	/**
	 * 배송 요청 트리거 등록 
	 * @param
	 * @return
	 */
	public void insertRequestDelivery() throws Exception{
		insert("IWRB01DAO.insertRequestDelivery");
	}
	
	/**
	 * IP Type 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRB01DAO.selectIpType", param);
	}
	
	public int selectUserInfo(Map<String, String> param) throws Exception{
		return (int) select("IWRB01DAO.selectUserInfo", param);
	}
	
	public String selectTriggerNo() throws Exception{
		return (String) select("IWRB01DAO.selectTriggerNo");
	}
	
	public List<Map<String, String>> selectTaskInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRB01DAO.selectTaskInfo", param);
	}
	
	public List<Map<String, String>> selectInsttInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRB01DAO.selectInsttInfo", param);
	}
	
	public String selectTriggerFlag(Map<String, String> param) throws Exception{
		return (String) select("IWRB01DAO.selectTriggerFlag", param);
	}
	
	public int selectDeliveryCount(Map<String, String> param) throws Exception{
		return (int)  select("IWRB01DAO.selectDeliveryCount", param);
	}
	
	public int selectMaxInventoryQuantity(Map<String, String> param) throws Exception{
		return (int) select("IWRB01DAO.selectMaxInventoryQuantity", param);
	}
	
	public int selectUsefulInventoryQuantity(Map<String, String> param) throws Exception{
		return (int) select("IWRB01DAO.selectUsefulInventoryQuantity", param);
	}
		
	public void insertDlvyManageInfo(Map<String, String> param) throws Exception{
		insert("IWRB01DAO.insertDlvyManageInfo", param);
	}
}
