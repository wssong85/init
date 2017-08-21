package pantheon.com.c03.service;

import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


/**
 * KCD 처리하는 비지니스 인터페이스 클래스
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
public interface COMC03Service {

	/**
	 * KCD 엑셀 조회
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectExcellForKcd(HttpServletRequest request) throws Exception;

	/**
	 * KCD 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertEdcCrKcdByExcelList(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 사전목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrMdicByDicarySeCode(Map<String, String> map) throws Exception;
	
	/**
	 * KCD 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcCrKcdByKcdSn(Map<String, String> map) throws Exception;
	
	/**
	 * KCD count
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrKcdCountByKcdSn(Map<String, String> map) throws Exception;
}
