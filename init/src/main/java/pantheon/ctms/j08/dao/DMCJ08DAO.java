package pantheon.ctms.j08.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;







import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ08DAO")
public class DMCJ08DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ08DAO.class);
	
    //공지사항 관리 목록 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectTaskUserInfo", map);
	}
	
	//공지사항 관리 목록 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectCommonCodeList", map);
	}	
	
	//공지사항 관리 목록 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOverlapUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectOverlapUserInfo", map);
	}
	
	//표준시간 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.standardTimeList", map);
	}
	
	//Role_Id 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectRoleId", map);
	}
	
	//사용자가 가진 ROLE_ID 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserRoleId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectUserRoleId", map);
	}
	
	//과제별사용자 정보 수정
	public void deleteTaskUserInfo(Map<String, Object> map) {
		update("DMCJ08DAO.deleteTaskUserInfo", map);
	}
	
	//과제별사용자 정보 저장
	public void insertTaskUser(Map<String, Object> map) {
		update("DMCJ08DAO.insertTaskUser", map);
	}
	
	//과제별사용자 역할 삭제
	public void deleteTaskUserByRole(Map<String, Object> map) {
		delete("DMCJ08DAO.deleteTaskUserByRole", map);
	}
		
	//사용자 역할 저장
	public void insertUserByRole(Map<String, Object> map) {
		insert("DMCJ08DAO.insertUserByRole", map);
	}
	
	//과제별사용자 역할 저장
	public void insertTaskUserByRole(Map<String, Object> map) {
		insert("DMCJ08DAO.insertTaskUserByRole", map);
	}
	
	//cm_기관 저장
	public void insertCm_Instt(Map<String, Object> map) {
		insert("DMCJ08DAO.insertCm_Instt", map);
	}
	
	//거래처사용자 저장
	public void insertBcncUser(Map<String, Object> map) {
		insert("DMCJ08DAO.insertBcncUser", map);
	}
	
	//cm_사용자 저장
	public void insertCm_User(Map<String, Object> map) {
		insert("DMCJ08DAO.insertCm_User", map);
	}
	
	//cm_사용자 수정
	public void updateCm_User(Map<String, Object> map) {
		update("DMCJ08DAO.updateCm_User", map);
	}
	
	//instt_ty bcnuser 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInstt_TyBcnUser(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectInstt_TyBcnUser", map);
	}
		
	//instt_ty rsrchuser 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInstt_TyRsrchUser(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectInstt_TyRsrchUser", map);
	}
	
	//사용자 role 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserRoleInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ08DAO.selectUserRoleInfo", map);
	}
	
	
	
	
	
	
}

