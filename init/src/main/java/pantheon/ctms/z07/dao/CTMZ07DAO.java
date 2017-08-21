package pantheon.ctms.z07.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;







import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMZ07DAO")
public class CTMZ07DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMZ07DAO.class);
	
	/**
	 * 시험전 방문보고서 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTitleList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ07DAO.selectTitleList", map);
	}
	
	/**
	 * 시험전 방문보고서 MAIN 조회
	 * @param map
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPreTrialVisitReport(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ07DAO.selectPreTrialVisitReport", map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT1 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitReport1(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ07DAO.selectVisitReport1", map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT2 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitReport2(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ07DAO.selectVisitReport2", map);
	}
	
	/**
	 * 시험전 방문보고서 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectItemReport(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ07DAO.selectItemReport", map);
	}
	
	/**
	 * 시험전 방문보고서 MAIN 저장
	 * @param map
	 */
	public void insertMainPreReport(Map<String, Object> map) {
		insert("CTMZ07DAO.insertMainPreReport", map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT 저장
	 * @param map
	 */
	public void insertVisitPreReport(Map<String, Object> map) {		
		insert("CTMZ07DAO.insertVisitPreReport", map);
	}
	
	/**
	 * 시험전 방문보고서 ITEM 저장
	 * @param map
	 */
	public void insertItemPreReport(Map<String, Object> map) {		
		insert("CTMZ07DAO.insertItemPreReport", map);
	}
	
	/**
	 * 시험전 방문보고서 MAIN 수정
	 * @param map
	 */
	public void updateMainPreReport(Map<String, Object> map) {
		update("CTMZ07DAO.updateMainPreReport", map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT 수정
	 * @param map
	 */
	public void updateVisitPreReport(Map<String, Object> map) {
		update("CTMZ07DAO.updateVisitPreReport", map);
	}
	
	/**
	 * 시험전 방문보고서 ITEM 수정
	 * @param map
	 */
	public void updateItemPreReport(Map<String, Object> map) {		
		update("CTMZ07DAO.updateItemPreReport", map);
	}
	
	/**
	 * 결재번호 저장
	 * @param map
	 */
	public void updateApproval(Map<String, Object> map) {		
		update("CTMZ07DAO.updateApproval", map);
	}
	
	/**
	 * 결재 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ07DAO.selectApprovalInfo", map);
	}
	
}

