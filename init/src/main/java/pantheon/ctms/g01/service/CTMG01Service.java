package pantheon.ctms.g01.service;

import java.util.List;
import java.util.Map;



/**
 * 연구자등록 비지니스 인터페이스 클래스
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
public interface CTMG01Service {

	/**
	 * int
	 * @param map
	 * @throws Exception
	 */
	public int selectRsrchuserCount(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchuserList(Map<String, String> map) throws Exception;

	/*-------------------------------------------------------------------------------------------------------------*/
	
	/**
	 * 표준시간대 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) throws Exception;
	
	/**
	 * 연구자정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchUserInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 연구자ID 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmUser(Map<String, String> map) throws Exception;
	
	public void deleteTaskUserRoleInfo(List<Map<String, Object>> list) throws Exception;
	
}
