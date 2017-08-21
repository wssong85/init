package pantheon.iwrs.d04.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 공장 재고 IP 관리를 위한 데이터 접근 클래스
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
@Repository("IWRD04DAO")
public class IWRD04DAO extends EgovComAbstractDAO {
	
	/**
	 * 공장 재고 현황 정보 조회 
	 * @param param
	 * @return
	 */
	public List<Map<String, String>> selectFactoryInventoryInfo(Map<String, String> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>)list("IWRD04.selectFactoryInventoryInfo", param);
	}
	
	/**
	 * 공장 재고 IP 상태 변경 
	 * @param param
	 * @return
	 */
	public void updateIpStatus(Map<String, String> param) throws Exception{
		update("IWRD04.updateIpStatus", param);
	}
	
	/**
	 * 배송 IP 상태 변경 
	 * @param param
	 * @return
	 */
	public void updateDeliveryIpStatus(Map<String, String> param) throws Exception{
		update("IWRD04.updateDeliveryIpStatus", param);
	}
	
	/**
	 * 재고 IP 상태 변경 
	 * @param param
	 * @return
	 */
	public void updateDrugStockIpStatus(Map<String, String> param) throws Exception{
		update("IWRD04.updateDrugStockIpStatus", param);
	}
	
	public int selectFactoryInvntoryTotalCount(Map<String, String> param) throws Exception{
		return (int) select("IWRD04.selectFactoryInvntoryTotalCount", param);
	}
	
	public int selectFactoryInventoryCount(Map<String, String> param) throws Exception{
		return (int) select("IWRD04.selectFactoryInventoryCount", param);
	}
	
	public int selectDeliveryIpStatus(Map<String, String> param) throws Exception{
		return (int) select("IWRD04DAO.selectDeliveryIpStatus", param);
	}
	
	public int selectDrugStockIpStatus(Map<String, String> param) throws Exception{
		return (int) select("IWRD04DAO.selectDrugStockIpStatus", param);
	}
	
	public List<Map<String, String>> selectFactoryInventorySummary(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("IWRD04DAO.selectFactoryInventorySummary", param);
	}
}
