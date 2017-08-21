package pantheon.com.c01.service;

import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 역할권한 관리 처리하는 비지니스 인터페이스 클래스
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
public interface COMC01Service {
	
	/**
	 * CDISC 엑셀 리스트 조회
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectExcellForCdisc(HttpServletRequest request) throws Exception;
	
	/**
	 * CDISC 엑셀 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertCdiscByExcelList(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * CDISC 규칙 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCdiscRuleList() throws Exception;

	/**
	 * CDISC 도메인 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCdiscDomnListByCdiscRuleSn(Map<String, String> map) throws Exception;
	
	/**
	 * CDISC variable 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCdiscDomnVriablListByCdiscDomnSn(Map<String, String> map) throws Exception;
	
	/**
	 * CDISC 터미널 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCdiscClCodeByCdiscRuleSn(Map<String, String> map) throws Exception;
	
	/**
	 * CDISC 도메인 count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCdiscDomnListCountByCdiscRuleSn(Map<String, String> map) throws Exception;
	
	/**
	 * CDISC variable count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCdiscDomnVriablListCountByCdiscDomnSn(Map<String, String> map) throws Exception;
	
	/**
	 * CDISC 터미널 count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCdiscClCodeCountByCdiscRuleSn(Map<String, String> map) throws Exception;
}
