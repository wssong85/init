package pantheon.ctms.z01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMZ01DAO")
public class CTMZ01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMZ01DAO.class);
	
	/**
	 * 기관정보 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInsttInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ01DAO.selectInsttInfo", map);
	}
	
	/**
	 * 방문정보 그리드 데이터 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitReportInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ01DAO.selectVisitReportInfo", map);
	}
	
	/**
	 * 적합성 그리드 데이터 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectComPatibilityReportInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ01DAO.selectComPatibilityReportInfo", map);
	}
	
   
}

