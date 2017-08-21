package pantheon.ctms.j02.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;




import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ02DAO")
public class DMCJ02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ02DAO.class);
	
    //공지사항 관리 목록 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllNoticeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ02DAO.selectAllNoticeList", map);
	}
	
	//공지사항 관리 작성(송신) 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeByPopup(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ02DAO.selectNoticeByPopup", map);
	}
	
	//RoleId 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ02DAO.selectRoleId", map);
	}
	
	
	//공통코드 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ02DAO.selectCommonCodeList", map);
	}
	
	//공지사항 권한 관리 저장	
	public void insertNoticeManageData(Map<String, Object> map) {
		insert("DMCJ02DAO.insertNoticeManageData", map);
	}
	
	//공지사항 권한 저장	
	public void insertNoticeAuthor(Map<String, Object> map) {
		insert("DMCJ02DAO.insertNoticeAuthor", map);
	}
	

	
	
	
	//공지사항 송신권한 삭제
	public void deleteNoticeBySendRole(Map<String, Object> map) {
		delete("DMCJ02DAO.deleteNoticeBySendRole", map);
	}
		
	//공지사항 수신권한 삭제	
	public void deleteNoticeByReceptionRole(Map<String, Object> map) {
		delete("DMCJ02DAO.deleteNoticeByReceptionRole", map);
	}
	
	
	
	
	
}

