package pantheon.iwrs.d04.service;

import java.util.List;
import java.util.Map;

/**
 * 공장 재고 현황 처리하는 비지니스 인터페이스 클래스
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
public interface IWRD04Service {
	
	/**
	 * 공장 IP 현황 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectFactoryInventoryInfo(Map<String, String> param) throws Exception;
	
	/**
	 * IP 상태 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateIpStatus(Map<String, String> param) throws Exception;
	
	public int selectFactoryInvntoryTotalCount(Map<String, String> param) throws Exception;
	
	public int selectFactoryInventoryCount(Map<String, String> param) throws Exception;
	
	public List<Map<String, String>> selectFactoryInventorySummary(Map<String, String> param) throws Exception;
}
