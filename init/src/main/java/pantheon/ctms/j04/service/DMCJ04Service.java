package pantheon.ctms.j04.service;

import java.util.List;
import java.util.Map;

public interface DMCJ04Service {
	
	/**
	 * Request List 데이터 정보조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRequestList(Map<String, String> map) throws Exception;
	
	/**
	 * Request List 유저 정보조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserInfo(Map<String, String> map) throws Exception;
	
	
	/**
	 * Request Count
	 * @param map
	 * @throws Exception
	 */
	public int selectRequestListByCount(Map<String, String> map) throws Exception;
	
	
	/**
	 * 공통코드 정보조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;

	/**
	 * Request Form 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRequestForm(List<Map<String, Object>> list) throws Exception;
	
}
