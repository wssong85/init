package pantheon.iwrs.c01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 배송 관리를 위한 데이터 접근 클래스
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
@Repository("IWRC01DAO")
public class IWRC01DAO extends EgovComAbstractDAO {	
	
	/**
	 * 배송정보 리스트 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDeliveryInfo(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("IWRC01DAO.selectDeliveryInfo", param);
	}
	
	public String selectRequstManageCode() throws Exception{
		return (String) select("IWRC01DAO.selectRequstManageCode");
	}
	
	/**
	 * 배송요청 알림 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertDeliveryRequestInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDeliveryRequestInfo", param);
	}
	
	/**
	 * 배송요청 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertDeliveryInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDeliveryInfo", param);
	}
	
	/**
	 * 배송 요청 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateDeliveryInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliveryInfo", param);
	}
	
	/**
	 * IP 그룹 정보 조회
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectGroupInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRC01DAO.selectGroupInfo", param);
	}
	
	/**
	 * 배송 ip 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDeliveryIpInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRC01DAO.selectDeliveryIpInfo", param);
	}
	
	/**
	 * 배송 ip 정보 등록 
	 * @param param
	 * @return
	 */
	public void insertDeliveryIpInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDeliveryIpInfo", param);
	}
	
	/**
	 * 배송 ip 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateIpStatusInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateIpStatusInfo", param);
	}
	
	/**
	 * ip target 번호 조회 
	 * @param param
	 * @return
	 */
	public int selectIpTargetNo(Map<String, String> param) throws Exception{
		return (int)select("IWRC01DAO.selectIpTargetNo", param);
	}
	
	/**
	 * 배송관리 코드 조회
	 * @param param
	 * @return
	 */
	public String selectDlvyManageCode(Map<String, String> param)throws Exception{
		return (String)select("IWRC01DAO.selectDlvyManageCode", param);
	}
	
	/**
	 * 배송 관리 번호 조회
	 * @param param
	 * @return
	 */
	public int selectDlvyManageNo(Map<String, String> param) throws Exception{
		return (int)select("IWRC01DAO.selectDlvyManageSn", param);
	}
	
	/**
	 * 배송 ip 상세 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDeliveryIpDetailInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRC01DAO.selectDeliveryIpDetailInfo", param);
	}
	
	/**
	 * 배송요청 정보 조회 
	 * @param param
	 * @return
	 */
	public Map<String, String> selectDeliveryRequestInfo(Map<String, String> param) throws Exception{
		return (Map<String, String>)select("IWRC01DAO.selectDeliveryRequestInfo", param);
	}
	
	/**
	 * 배송 ip 상세 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectDeliveryIpDetailForCancel(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRC01DAO.selectDeliveryIpDetailForCancel", param);
	}
	
	/**
	 * 배송 ip 상태 정보 수정 
	 * @param param
	 * @return
	 */
	public void updateDeliveryIpStatusInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliveryIpStatusInfo", param);
	}
	
	/**
	 * 배송확인 정보 등록 
	 * @param param
	 * @return
	 */
	public void updateDeliveryConfirmInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliveryConfirmInfo", param);
	}
	
	/**
	 * 배송 취소 정보 등록 
	 * @param param
	 * @return
	 */
	public void updateDeliveryCancelInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliveryCancelInfo", param);
	}
	
	/**
	 * 배송 취소 정보 조회 
	 * @param param
	 * @return
	 */
	public Map<String, String> selectCancelInfo(Map<String, String> param) throws Exception{
		return (Map<String, String>)select("IWRC01DAO.selectCancelInfo", param);
	}
	
	/**
	 * IP 오류 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectIpErrorInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>)list("IWRC01DAO.selectIpErrorInfo", param);
	}
	
	/**
	 * 배송 인수확인 정보 등록 
	 * @param param
	 * @return
	 */
	public void updateDeliInsuInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliInsuInfo", param);
	}
	
	/**
	 * 배송 인수 IP 정보 등록 
	 * @param param
	 * @return
	 */
	public void updateDeliInsuIpInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDeliInsuIpInfo", param);
	}
	
	/**
	 * IP 에러정보 등록 
	 * @param param
	 * @return
	 */
	public void updateIpErrorInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateIpErrorInfo", param);
	}
	
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectIpType", param);
	}
	
	public List<Map<String, String>> selectDlvyManagerInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectDlvyManagerInfo", param);
	}
	
	public List<Map<String, String>> selectInstt(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectInstt", param);
	}
	
	public void insertDrugStockInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDrugStockInfo", param);
	}
	
	public void updateDrugStockInfo(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateDrugStockInfo", param);
	}
	
	public void insertDrugStockDetailInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDrugStockDetailInfo", param);
	}
	
	public void updateDrugStockDetailInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.updateDrugStockDetailInfo", param);
	}
	
	public void insertDrugStockIpInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.insertDrugStockIpInfo", param);
	}
	
	public void updateDrugStockIpInfo(Map<String, String> param) throws Exception{
		insert("IWRC01DAO.updateDrugStockIpInfo", param);
	}
	
	public List<Map<String, String>> selectDrugStockInfoCnt(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectDrugStockInfoCnt", param);
	}
	
	public List<Map<String, String>> selectDrugStockDetailInfoCnt(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectDrugStockDetailInfoCnt", param);
	}
	
	public List<Map<String, String>> selectDrugStockIpInfoCnt(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectDrugStockIpInfoCnt", param);
	}
	
	public String selectInvntryManageCode() throws Exception{
		return (String) select("IWRC01DAO.selectInvntryManageCode");
	}
	
	public List<Map<String, String>> selectInvntryManageInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectInvntryManageInfo", param);
	}
	
	public void updateInventoryCount(Map<String, String> param) throws Exception{
		update("IWRC01DAO.updateInventoryCount", param);
	}
	
	public List<Map<String, String>> selectDeliveryIpCode(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectDeliveryIpCode", param);
	}
	
	public List<Map<String, String>> selectInvntryManageDetailInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRC01DAO.selectInvntryManageDetailInfo", param);
	}
	
	public String selectUserInsttCode(Map<String, String> param) throws Exception{
		return (String) select("IWRC01DAO.selectUserInsttCode", param);
	}
}
