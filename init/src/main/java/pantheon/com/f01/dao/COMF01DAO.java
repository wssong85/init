package pantheon.com.f01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 통합사용자관리를 위한 데이터 접근 클래스
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
@Repository("COMF01DAO")
public class COMF01DAO extends EgovComAbstractDAO{
	
	/**
	 * 통합사용자관리 목록 조회 
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmUserListByUser(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("COMF01DAO.selectCmUserListByUser", map);
	}
		
	/**
	 * 통합사용자관리 목록 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmUserListCountByUser(Map<String, String> map) {
		return (Integer) select("COMF01DAO.selectCmUserListCountByUser", map);
	}
	
	/**
	 * 유저 롤 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmUserRoleByUserId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMF01DAO.selectCmUserRoleByUserId", map);
	}
	
	/**
	 * 유저 롤 입력
	 * @param map
	 * @return
	 */
	public void insertCmUserRoleByUserId(Map<String, Object> map) {
		insert("COMF01DAO.insertCmUserRoleByUserId", map);
	}
	
	/**
	 * 유저 롤 삭제 
	 * @param map
	 * @return
	 */
	public int deleteCmUserRoleByUserId(Map<String, Object> map) {
		return delete("COMF01DAO.deleteCmUserRoleByUserId", map);
	}
	
	/**
	 * 유저 롤 수정 
	 * @param map
	 * @return
	 */
	public int updateCmUserRoleByUserId(Map<String, Object> map) {
		return update("COMF01DAO.updateCmUserRoleByUserId", map);
	}
	
	/**
	 * 유저 중복 체크 
	 * @param map
	 * @return
	 */
	public int selectCmUserRoleForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMF01DAO.selectCmUserRoleForDupCheck", map);
	}

	/**
	 * 신규유저 입력
	 * @param map
	 * @throws Exception 
	 */
	public void insertCmUserForCreate(Map<String, String> map) {
		insert("COMF01DAO.insertCmUserForCreate", map);
	}

	/**
	 * 외부사용자 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserByUserSeCode02(Map<String, Object> map) {
		return update("COMF01DAO.updateCmUserByUserSeCode02", map);
	}
}
