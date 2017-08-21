package pantheon.com.z06.service;

import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * ATRAIL 자동관리를 처리하는 비지니스 인터페이스 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
public interface COMZ06Service {
	
	/**
	 * ATRAIL 입력(INSERT)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForInsertByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(INSERT)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForInsertByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(UPDATE)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForUpdateByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(UPDATE)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForUpdateByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(DELETE)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForDeleteByObject(Map<String, Object> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(DELETE)
	 * @param map
	 * @param propertyService
	 * @param code
	 * @param reason
	 * @throws Exception
	 */
	public void createCmDtaAtrailForDeleteByString(Map<String, String> map, EgovPropertyService propertyService, String code, String reason) throws Exception;
	
	/**
	 * ATRAIL 입력(INSERT)
	 * @param tableNm
	 * @param columnNm
	 * @param tablePk
	 * @param pkNm
	 * @param code
	 * @param reson
	 * @return
	 * @throws Exception
	 */
	public void insertCmDtaAtrail(String tableNm, String[] columnNm, String[] labels, String tablePk, String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception;
	
	/**
	 * ATRAIL 입력(UPDATE)
	 * @param tableNm
	 * @param columnNm
	 * @param tablePk
	 * @param pkNm
	 * @param code
	 * @param reson
	 * @return
	 * @throws Exception
	 */
	public void insertCmDtaAtrailForUpdate(String tableNm, Map<String, String> columnNm, String[] labels, String tablePk, String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception;
	
	/**
	 * ATRAIL 입력(DELETE)
	 * @param tableNm
	 * @param columnNm
	 * @param labels
	 * @param tablePk
	 * @param pkNm
	 * @param code
	 * @param reason
	 * @param module
	 * @throws Exception
	 */
	public void insertCmDtaAtrailForDelete(String tableNm, Map<String, String> columnNm, String[] labels, String tablePk, String pkNm, String code, String reason, String module, Map<String, String> labelMap) throws Exception;
}
