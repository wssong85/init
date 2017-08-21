package pantheon.ctms.b02.service;

import java.util.List;
import java.util.Map;



/**
 * 계약관리 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.02.26
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.26  김복민          최초 생성
 *  
 */
public interface CTMB02Service {
	/**
	 * PMS 과제 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectPmsTask_NoList(Map<String, String> map) throws Exception;
	
	/**
	 * PMS 과제정보 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectPmsSummaryGrid(Map<String, String> map) throws Exception;
	
	/**
	 * PMS protocol 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectPmsProtocolGrid(Map<String, String> map) throws Exception;
	
	/**
	 * PMS 연차수집정보 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectPmsAnnualGrid(Map<String, String> map) throws Exception;
	
	/**
	 * PMS 과제정보 Status 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectPmsStatusGrid(Map<String, String> map) throws Exception;
	
	
	
}
