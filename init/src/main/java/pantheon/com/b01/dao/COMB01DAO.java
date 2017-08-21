package pantheon.com.b01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 역할 관리를 위한 데이터 접근 클래스
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
@Repository("COMB01DAO")
public class COMB01DAO extends EgovComAbstractDAO{
	
	/**
	 * 역할 콤보박스리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmRoleForComboBox(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMB01DAO.selectCmRoleForComboBox", map);
	}
	
	/**
	 * 유저정보로 사용자 역할이 있는지 확인
	 * @param map
	 * @return
	 */
	public int selectCmUserRoleCountByUserId(Map<String, Object> map) {
		return (int) select("COMB01DAO.selectCmUserRoleCountByUserId", map);
	}
	
	/**
	 * 사용자역할정보 입력
	 * @param map
	 */
	public void insertCmUserRoleByUserId(Map<String, Object> map) {
		insert("COMB01DAO.insertCmUserRoleByUserId", map);
	}
	
	/**
	 * 사용자역할정보 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserRoleByUserId(Map<String, Object> map) {
		return update("COMB01DAO.updateCmUserRoleByUserId", map);
	}
	
	/**
	 * 역할정보 수정
	 * @param map
	 * @return
	 */
	public int updateCmRoleByRoleId(Map<String, Object> map) {
		return update("COMB01DAO.updateCmRoleByRoleId", map);
	}
	
	/**
	 * 역할정보 입력
	 * @param map
	 */
	public void insertCmRole(Map<String, Object> map) {
		insert("COMB01DAO.insertCmRole", map);
	}
	
	/**
	 * 역할정보 목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRole(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMB01DAO.selectCmRole", map);
	}
	
	/**
	 * 역할 체계 목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectComtnrolesHierarchy(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMB01DAO.selectComtnrolesHierarchy", map);
	}
	
	/**
	 * 역할 체계 삭제
	 * @param map
	 * @return
	 */
	public int deleteComtnrolesHierarchy(Map<String, String> map) {
		return delete("COMB01DAO.deleteComtnrolesHierarchy", map);
	}
	
	/**
	 * 역할 체계 입력
	 * @param map
	 */
	public void insertComtnrolesHierarchy(Map<String, Object> map) {
		insert("COMB01DAO.insertComtnrolesHierarchy", map);
	}
	
	/**
	 * 역할 중복 체크
	 * @param map
	 * @return
	 */
	public int selectCmRoleForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMB01DAO.selectCmRoleForDupCheck", map);
	}
	
	/**
	 * 역할 삭제 위해 수정
	 * @param map
	 * @return
	 */
	public int updateCmRoleForDelete(Map<String, Object> map) {
		return (Integer) update("COMB01DAO.updateCmRoleForDelete", map);
	}
	
	/**
	 * 역할계층 입력(extends)
	 * @param map
	 */
	public void insertComtnrolesHierarchyForExtends(Map<String, Object> map) {
		insert("COMB01DAO.insertComtnrolesHierarchyForExtends", map);
	}
	
	/**
	 * 역할계층 입력(admin)
	 * @param map
	 */
	public void insertComtnrolesHierarchyForAdmin(Map<String, Object> map) {
		insert("COMB01DAO.insertComtnrolesHierarchyForAdmin", map);
	}
	
	/**
	 * 역할계층 삭제(extends)
	 * @param map
	 * @return
	 */
	public int deleteComtnrolesHierarchyForExtends(Map<String, Object> map) {
		return delete("COMB01DAO.deleteComtnrolesHierarchyForExtends", map);
	}
	
	/**
	 * 역할계층 입력(admin)
	 * @param map
	 * @return
	 */
	public int deleteComtnrolesHierarchyForAdmin(Map<String, Object> map) {
		return delete("COMB01DAO.deleteComtnrolesHierarchyForAdmin", map);
	}
	
	/**
	 * 역할계층 중복체크(admin) 
	 * @param map
	 * @return
	 */
	public int selectComtnrolesHierarchyForDupCheckByAdmin(Map<String, Object> map) {
		return (Integer) select("COMB01DAO.selectComtnrolesHierarchyForDupCheckByAdmin", map);
	}
	
	/**
	 * 역할계층 중복체크(extends) 
	 * @param map
	 * @return
	 */
	public int selectComtnrolesHierarchyForDupCheckByExtends(Map<String, Object> map) {
		return (Integer) select("COMB01DAO.selectComtnrolesHierarchyForDupCheckByExtends", map);
	}
	
	/**
	 * 역할권한 중복체크
	 * @param map
	 * @return
	 */
	public int selectCmRoleAuthorForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMB01DAO.selectCmRoleAuthorForDupCheck", map);
	}
	
	/**
	 * 과제권한 중복체크
	 * @param map
	 * @return
	 */
	public int selectCtmsDmcTaskRoleForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMB01DAO.selectCtmsDmcTaskRoleForDupCheck", map);
	}
	
} 