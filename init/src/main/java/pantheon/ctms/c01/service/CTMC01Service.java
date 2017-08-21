package pantheon.ctms.c01.service;

import java.util.List;
import java.util.Map;



/**
 * Milestone 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
public interface CTMC01Service {

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectInvestInfoList(Map<String, String> map) throws Exception;

	/*-------------------------------------------------------------------------------------------------------------*/

	
}
