package pantheon.iwrs.b01.service;

import java.util.List;
import java.util.Map;

/**
 * 트리거 처리하는 비지니스 인터페이스 클래스
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
public interface IWRB01Service {
	/**
	 * 트리거 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertTriggerInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 트리거 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateTriggerInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 트리거 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectTriggerInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 트리거 배송요청 등록 
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void insertRequestDelivery(Map<String, String> param) throws Exception;
	
	/**
	 * 해당 과제의 Ip Type 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception;
	
	public int selectUserInfo(Map<String, String> param) throws Exception;
}
