package pantheon.ctms.h01.service;

import java.util.List;
import java.util.Map;

public interface CTMH01Service {
	
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
	 * Request 파일이름 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRequestFileNm(Map<String, String> map) throws Exception;
	
	/**
	 * Request Count
	 * @param map
	 * @throws Exception
	 */
	public int selectRequestListByCount(Map<String, String> map) throws Exception;
	
	/**
	 * Request 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRequestForm(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * fileUpload 삭제
	 * @param map
	 * @throws Exception
	 */
	public void insertFileUpload(List<Map<String, Object>> list) throws Exception;
	
	
	
	/**
	 * 공통코드 정보조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;

}
