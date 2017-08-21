package pantheon.com.b02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 역할 권한 관리를 위한 데이터 접근 클래스
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
@Repository("COMB02DAO")
public class COMB02DAO extends EgovComAbstractDAO{
	
	/**
	 * 역할권한 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleAuthorByRoleId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmRoleAuthorByRoleId", map);
	}
	
	/**
	 * 역할권한 입력
	 * @param map
	 */
	public void insertCmRoleAuthorByRoleId(Map<String, Object> map) {
		insert("COMB02DAO.insertCmRoleAuthorByRoleId", map);
	}
	
	/**
	 * 역할권한 삭제
	 * @param str
	 * @return
	 */
	public int deleteCmRoleAuthorByRoleId(Map<String, Object> map) {
		return delete("COMB02DAO.deleteCmRoleAuthorByRoleId", map);
	}
	
	/**
	 * 메뉴아이디로 프로그램아이디를 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmProgrmForCmRoleAuthorRegist(Map<String, Object> map) {
		return (List<Map<String, String>>) list("COMB02DAO.selectCmProgrmForCmRoleAuthorRegist", map);
	}
	
	/**
	 * 역할권한 리스트 조회
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleAuthorListByRoleIdAndFixingAtN(String str) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmRoleAuthorListByRoleIdAndFixingAtN", str);
	}
	
	/**
	 * 역할권한 리스트 조회
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleAuthorListByRoleIdAndFixingAtY(String str) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmRoleAuthorListByRoleIdAndFixingAtY", str);
	}
	
	/**
	 * 프로그램 홈메뉴 중복체크
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmProgrmForDupCheckHome(String str) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmProgrmForDupCheckHome", str); 
	}
	
	/**
	 * 역할별 권한관리 전체메뉴 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmMenuForDefaultGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmMenuForDefaultGrid", map);
	}
	
	/**
	 * 고정여부 역할 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleAuthorByRoleIdForFixingAt(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmRoleAuthorByRoleIdForFixingAt", map);
	}
	
	/**
	 * 고정여부 전체 역할 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmMenuForDefaultGridForFixingAt(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMB02DAO.selectCmMenuForDefaultGridForFixingAt", map);
	}
	
	/**
	 * 역할 고정여부 조회
	 * @param map
	 * @return
	 */
	public String selectCmRoleForFixingAt(Map<String, String> map) {
		return (String) select("COMB02DAO.selectCmRoleForFixingAt", map);
	}
	
	/**
	 * 역할 제한여부 N 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmRoleByFixingAtNForComboBox(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMB02DAO.selectCmRoleByFixingAtNForComboBox", map);
	}
	
	/**
	 * 역할 제한여부 Y 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmRoleByFixingAtYForComboBox(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMB02DAO.selectCmRoleByFixingAtYForComboBox", map);
	}
	
}
