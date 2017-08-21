package pantheon.ctms.j06.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ06DAO")
public class DMCJ06DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ06DAO.class);
	
    //연구자관리 정보 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchManage(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ06DAO.selectRsrchManage", map);
	}
	
	 //연구자조회 정보 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ06DAO.selectRsrUserInfo", map);
	}
	

	
	//연구자정보 승인/반려
	public void updateRsrchManage(Map<String, Object> map) {
		update("DMCJ06DAO.updateRsrchManage", map);
	}
	
	public void deleteUserTask(Map<String, Object> map) {
		update("DMCJ06DAO.deleteUserTask", map);
	}
	
	
	
}

