package pantheon.com.b02.service;

import java.util.List;
import java.util.Map;


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
public interface COMB02Service {

	/**
	 * 역할권한관리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmRoleAuthorByRoleId(Map<String, String> map) throws Exception;
	
	/**
	 * 역할권한관리 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertCmRoleAuthorByRoleId(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 역할권한관리 전체 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmMenuForDefaultGrid(Map<String, String> map) throws Exception;
	
	/**
	 * 역할제한여부 N 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmRoleByFixingAtNForComboBox(Map<String, String> map) throws Exception;
	
	/**
	 * 역할제한여부 Y 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmRoleByFixingAtYForComboBox(Map<String, String> map) throws Exception;

}
