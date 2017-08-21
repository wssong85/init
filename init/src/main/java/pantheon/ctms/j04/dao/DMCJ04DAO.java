package pantheon.ctms.j04.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;







import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ04DAO")
public class DMCJ04DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ04DAO.class);
    //request form 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRequestList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ04DAO.selectRequestList", map);
	}	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ04DAO.selectCommonCodeList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ04DAO.selectUserInfo", map);
	}	
	
	
	public int selectRequestListByCount(Map<String, String> map) {
		return (int) select("DMCJ04DAO.selectRequestListByCount", map);
	}
	
	//requestForm 요청
	public void updateRequestFormBySttus(Map<String, Object> map) {
		update("DMCJ04DAO.updateRequestFormBySttus", map);
	}
	
	

	
	
	
	
	
}

