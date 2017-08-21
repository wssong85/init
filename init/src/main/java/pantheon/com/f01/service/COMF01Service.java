package pantheon.com.f01.service;

import java.util.List;
import java.util.Map;

/**
 * 통합사용자관리 처리하는 비지니스 인터페이스 클래스
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
public interface COMF01Service {
	
	/**
	 * 통합사용자관리 목록 조회 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmUserListByUser(Map<String, String> map) throws Exception;
	
	/**
	 * 통합사용자관리 목록 카운팅 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCmUserListCountByUser(Map<String, String> map) throws Exception;
	
	/**
	 * 통합사용자관리 유저 롤
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmUserRoleByUserId(Map<String, String> map) throws Exception;

	/**
	 * 통합사용자관리 유저 입력
	 * @param list
	 * @throws Exception
	 */
	public void insertCmUserRoleByUserId(List<Map<String, Object>> list) throws Exception;

	/**
	 * 신규유저 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmUserForCreate(Map<String, String> map) throws Exception;

	/**
	 * 내부 사용자 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateCmUserByUserSeCode02(List<Map<String, Object>> list) throws Exception;
}
