package pantheon.ctms.z02.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;




















import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("CTMZ02DAO")
public class CTMZ02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMZ02DAO.class);
	
	/**
	 * 기관정보 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ02DAO.selectVisitInfo", map);
	}
	
	/**
	 * 보고서 참석자 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ02DAO.selectVisitInfoGrid", map);
	}
	
	/**
	 * 보고서 참석자 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectVisitInfoMain(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ02DAO.selectVisitInfoMain", map);
	}
	
	
	/**
	 * 보고서 준비기록 저장
	 * @param map
	 */
	public void insertPlanVisitReport(Map<String, Object> map) {
		insert("CTMZ02DAO.insertPlanVisitReport", map);
	}
	
	/**
	 * 보고서 준비기록 수정
	 * @param map
	 */
	public void updatePlanVisitReport(Map<String, Object> map) {
		update("CTMZ02DAO.updatePlanVisitReport", map);
	}
	
	/**
	 * 보고서 참석자 수정
	 * @param map
	 */
	public void updatePlanVisitInfo(Map<String, Object> map) {
		update("CTMZ02DAO.updatePlanVisitInfo", map);
	}
	
	
	/**
	 * 보고서 준비기록 CTMS_ST_REPORT_ITEM
	 * @param map
	 */
	public void insertPlanVisitItem(Map<String, Object> map) {
		insert("CTMZ02DAO.insertPlanVisitItem", map);
	}
	
	/**
	 * 보고서 준비기록 CTMS_ST_REPORT_VISIT
	 * @param map
	 */
	public void insertPlanVisitInfo(Map<String, Object> map) {
		insert("CTMZ02DAO.insertPlanVisitInfo", map);
	}
	
	/**
	 * 결재순번 수정
	 * @param map
	 */
	public void updateApproval(Map<String, Object> map) {
		update("CTMZ02DAO.updateApproval", map);
	}
	
	/**
	 * 방문보고서 ITEM수정
	 * @param map
	 */
	public void updateVisitReportItem(Map<String, Object> map) {
		update("CTMZ02DAO.updateVisitReportItem", map);
	}
	
	/**
	 * VISIT 삭제
	 * @param map
	 */
	public void deletePlanVisitInfo(Map<String, Object> map) {
		update("CTMZ02DAO.deletePlanVisitInfo", map);
	}
	
	/**
	 * 보고서 결재정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ02DAO.selectApprovalInfo", map);
	}
	
	/**
	 * 방문보고서 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ02DAO.selectVisitInfoItem", map);
	}
	
	
}

