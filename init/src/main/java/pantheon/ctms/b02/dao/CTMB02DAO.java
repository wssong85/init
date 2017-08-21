package pantheon.ctms.b02.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;





import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMB02DAO")
public class CTMB02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMB02DAO.class);
    
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPmsTask_NoList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB02DAO.selectPmsTask_NoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPmsSummaryGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB02DAO.selectPmsSummaryGrid", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPmsProtocolGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB02DAO.selectPmsProtocolGrid", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPmsAnnualGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB02DAO.selectPmsAnnualGrid", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPmsStatusGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB02DAO.selectPmsStatusGrid", map);
	}	
	
}

