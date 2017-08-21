package pantheon.ctms.j01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;




import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ01DAO")
public class DMCJ01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ01DAO.class);
	
    //과제 진행 현황
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskRegStatusList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ01DAO.selectTaskRegStatusList", map);
	}
	
    //과제별 진행 현황
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskProgressList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ01DAO.selectTaskProgressList", map);
	}
	
    //공지사항 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskNoticeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ01DAO.selectTaskNoticeList", map);
	}	
	
	
}

