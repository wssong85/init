package pantheon.edc.l01.service;

import java.util.List;
import java.util.Map;

/**
 * Data Import 처리하는 비지니스 인터페이스 클래스
 * @author 오동근
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17  오동근          최초 생성
 *  
 */
public interface EDCL01Service {
	
	/**
	 * Data Import 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCdiscList(Map<String, Object> param) throws Exception;
	
	public String defineXmlValidationChk(String filePath, String fileNo, String cdiscSeCode, String imprtNm) throws Exception;
	
	public String excelValidationChk(String filePath, String cfcdiscDomnSn) throws Exception;
	
	public String xmlValidationChk(String filePath, String cfcdiscDomnSn) throws Exception;
	
	public String selectCdiscListCount(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectCdiscDomainList(String cfcdiscSn) throws Exception;
	
	public List<Map<String, Object>> selectCdiscVriablList(String cfcdiscDomnSn) throws Exception;
	
	public List<Map<String, Object>> selectCdiscVariablValueList(Map<String, Object> param) throws Exception;
	
}
