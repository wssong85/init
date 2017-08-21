package pantheon.iwrs.c01.service;

import java.util.List;
import java.util.Map;

/**
 * 배송정보 처리하는 비지니스 인터페이스 클래스
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
public interface IWRC01Service {
	/**
	 * 배송 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */	
	public List<Map<String, String>> selectDeliveryInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 요청 알림 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertDeliveryRequestInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 요청 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertDeliveryInfo(Map<String, String> param) throws Exception;
	
	/**
	 * ㅇ배송 요청 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateDeliveryInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 IP별 상세 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectDeliveryIpDetailInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 요청 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectDeliveryRequestInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 확인 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateDeliveryConfirmInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 취소 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateDeliveryCancelInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 배송 취소 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectCancelInfo(Map<String, String> param) throws Exception;
	
	/**
	 * IP 에러 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectIpErroInfo(Map<String, String> param) throws Exception;
	
	/**
	 * IP 인수 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateIpInsuInfo(Map<String, String> param) throws Exception;
	
	/**
	 * IP Type 정보 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectGroupInfo(Map<String, String> param) throws Exception;
	
	public List<Map<String, String>> selectIpType(Map<String, String> param) throws Exception;
	
	public List<Map<String, String>> selectInstt(Map<String, String> param) throws Exception;
	
	public List<Map<String, String>> selectDeliveryIpCode(Map<String, String> param) throws Exception;
	
	public String selectUserInsttCode(Map<String, String> param) throws Exception;
}
