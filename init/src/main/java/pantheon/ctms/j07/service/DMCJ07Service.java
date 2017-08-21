package pantheon.ctms.j07.service;

import java.util.List;
import java.util.Map;



/**
 * Milestone 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.04.25
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.04.25  김복민          최초 생성
 *  
 */
public interface DMCJ07Service {

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRoleByProgAndBtnList(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskByBtnList(Map<String, String> map) throws Exception;

	/**
	 * 과제별 버튼 권한 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertTaskByBtnInfo(List<Map<String, Object>> list) throws Exception;

	/*-------------------------------------------------------------------------------------------------------------*/

	
}
