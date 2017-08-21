package pantheon.com.a02.service;

import java.util.List;
import java.util.Map;

/**
 * 프로그램관리 처리하는 비지니스 인터페이스 클래스
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
public interface COMA02Service {

	/**
	 * 프로그램 리스트 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCmProgrm(Map<String, String> map) throws Exception;
	
	/**
	 * 프로그램 저장
	 * @param list
	 */
	public void insertCmProgrm(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 버튼 리스트 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCmButtonByProgrmId(Map<String, String> map) throws Exception;
	
	/**
	 * 버튼 저장
	 * @param list
	 */
	public void insertCmButton(List<Map<String, Object>> list) throws Exception;

	/**
	 * 역할제한 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmRoleLmttByProgrmId(Map<String, Object> map) throws Exception;
	
	/**
	 * 역할 제한 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmRoleLmttByPk(List<Map<String, Object>> map) throws Exception;
	
	/**
	 * 역할 고정 여부로 조회 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmRoleByFixingAtForComboBox(Map<String, String> map) throws Exception;
	
}
