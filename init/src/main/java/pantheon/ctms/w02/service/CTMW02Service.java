package pantheon.ctms.w02.service;

import java.util.List;
import java.util.Map;

public interface CTMW02Service {
	
	/**
	 * Time Zone 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) throws Exception;
	
	/**
	 * CRF Status Report 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCTMW0201(Map<String, String> map) throws Exception;
	
	
	
	/**
	 * CRF Status Report : VISIT 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCTMW0202(Map<String, String> map) throws Exception;
	
	/**
	 * Subject CRF Version Report 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCTMW0203(Map<String, String> map) throws Exception;
	
	/**
	 * User Report 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCTMW0205(Map<String, String> map) throws Exception;
	
	/**
	 * User History Report 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCTMW0206(Map<String, String> map) throws Exception;

	
	

	

	
}
