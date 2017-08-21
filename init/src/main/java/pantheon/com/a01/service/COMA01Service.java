package pantheon.com.a01.service;

import java.util.List;
import java.util.Map;

/**
 * 메뉴관리 처리하는 비지니스 인터페이스 클래스
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
public interface COMA01Service {
	
	/**
	 * 상위메뉴 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmMenuForUpperMenu(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 하위메뉴 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmMenuByUpperMenu(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 메뉴아이디로 메뉴삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteCmMenuForMenuId(Map<String, String> map) throws Exception;
	
	/**
	 * 메뉴아이디로 메뉴수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmMenuForMenuId(Map<String, String> map) throws Exception;
	
	/**
	 * 상위메뉴아이디로 메뉴삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteCmMenuForUpperMenuId(Map<String, String> map) throws Exception;
	
	/**
	 * 상위메뉴아이디로 메뉴수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmMenuForUpperMenuId(Map<String, String> map) throws Exception;
	
	/**
	 * 상위메뉴아이디로 메뉴목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmMenuListByUpperMenuId(Map<String, String> map) throws Exception;
	
	/**
	 * 상위메뉴목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmMenuListForUpperMenuId(Map<String, String> map) throws Exception;
}
