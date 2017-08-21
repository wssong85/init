package pantheon.ctms.j03.service;

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
public interface DMCJ03Service {

	/**
	 * int
	 * @param map
	 * @throws Exception
	 */
	public int selectEduMgrCount(Map<String, String> map) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEduMgrList(Map<String, String> map) throws Exception;

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> selectEduMgrInfo(Map<String, String> map) throws Exception;

	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEduRoleList(Map<String, String> map) throws Exception;
	
	/**
	 * 교육 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public String insertEduInfo(List<Map<String, Object>> list) throws Exception;

	/**
	 * 교육 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertEduRoleInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserByEducationList(Map<String, String> map) throws Exception;
	/*-------------------------------------------------------------------------------------------------------------*/

}
