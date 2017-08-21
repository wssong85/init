package pantheon.sdb.c01.service;

import java.util.List;
import java.util.Map;

public interface SDBC01Service {
	/**
	 * Trial 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectTrialList(Map<String, String> map) throws Exception;
	
	/**
	 * Spontaneous 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectSpontaneousList(Map<String, String> map) throws Exception;
	
	/**
	 * Literature 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectLiteratureList(Map<String, String> map) throws Exception;
	
	/**
	 * Etc 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectEtcList(Map<String, String> map) throws Exception;
	
	/**
	 * ICSR 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectICSRList(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @throws Exception
	 */
	void insertEtcInfo(Map<String, String> param) throws Exception;	

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectEtcInfo(Map<String, String> param) throws Exception;

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectLiteratureInfo(Map<String, String> param) throws Exception;

	/**
	 * @param map
	 * @throws Exception
	 */
	void insertLiteratureInfo(Map<String, String> map) throws Exception;
	
	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectStudyList(Map<String, String> map) throws Exception;	

	/**
	 * @param param
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectStudyInfo(Map<String, String> param) throws Exception;

	/**
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String selectStudyListCount(Map<String, String> map) throws Exception;

	/**
	 * @param param
	 * @throws Exception
	 */
	void insertStudyInfo(Map<String, String> param) throws Exception;

	

	

	

		

}
