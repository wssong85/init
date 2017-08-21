package pantheon.ctms.w02.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;







import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMW02DAO")
public class CTMW02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMW02DAO.class);
	
	/**
	 * Time Zone 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.standardTimeList", map);
	}
	
	/**
	 * CRF Status Report 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCTMW0201(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.selectCTMW0201", map);
	}
	
	/**
	 * CRF Status ReportlVISIT 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCTMW0202(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.selectCTMW0202", map);
	}
	
	/**
	 * Subject CRF Version Report 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCTMW0203(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.selectCTMW0203", map);
	}
	
	/**
	 * User Report 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCTMW0205(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.selectCTMW0205", map);
	}
	
	/**
	 * User History Report 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCTMW0206(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMW02DAO.selectCTMW0206", map);
	}
	
	
	
}

