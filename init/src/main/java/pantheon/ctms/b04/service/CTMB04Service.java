package pantheon.ctms.b04.service;

import java.util.List;
import java.util.Map;


/**
 * 과제별 수탁관리
 * @author 김복민
 * @since 2016.02.26
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.04.11  김복민          최초 생성
 *  
 */
public interface CTMB04Service {

	/**
	 * 과제별 수탁관리 조회
	 * @param map
	 * @throws Exception
	 */	
	public List<Map<String, Object>> selectTaskTrustInsttList(Map<String, String> map) throws Exception;

	/**
	 * 과제별 수탁관리
	 * @param map
	 * @throws Exception
	 */	
	public void insertTaskTrustInstt(List<Map<String, Object>> list) throws Exception;

	
}
