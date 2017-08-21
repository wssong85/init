package pantheon.ctms.b04.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMB04DAO")
public class CTMB04DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMB04DAO.class);
    
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskTrustInsttList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB04DAO.selectTaskTrustInsttList", map);
	}
		
	public void insertTaskTrustInstt(Map<String, Object> map) {
		insert("CTMB04DAO.insertTaskTrustInstt", map);
	}
	
	public void updateTaskTrustInstt(Map<String, Object> map) {
		update("CTMB04DAO.updateTaskTrustInstt", map);
	}
	
	public void deleteTaskTrustInstt(Map<String, Object> map) {
		update("CTMB04DAO.deleteTaskTrustInstt", map);
	}
	
	
}

