package pantheon.com.b01.service;

import java.util.List;
import java.util.Map;

/**
 * 역할관리 처리하는 비지니스 인터페이스 클래스
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
public interface COMB01Service {
	
	/**
	 * 역할 콤보박스리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmRoleForComboBox(Map<String, String> map) throws Exception;

	/**
	 * 통합 사용자 관리에서 입력, 수정
	 * @param list
	 * @throws Exception
	 */
	public void insertCmRoleByCmRole(List<Map<String, Object>> list) throws Exception;

	/**
	 * 역할관리 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmRole(Map<String, String> map) throws Exception;

	/**
	 * 역할관리 입력,수정
	 * @param list
	 * @throws Exception
	 */
	public void insertCmRole(List<Map<String, Object>> list) throws Exception;

	/**
	 * 역할계층 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectComtnrolesHierarchy(Map<String, String> map) throws Exception;

	/**
	 * 역할계층 수정
	 * @param list
	 * @throws Exception
	 */
	public void insertComtnrolesHierarchy(List<Map<String, Object>> list) throws Exception;
}
