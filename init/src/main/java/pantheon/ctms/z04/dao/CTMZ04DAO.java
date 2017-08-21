package pantheon.ctms.z04.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMZ04DAO")
public class CTMZ04DAO extends EgovComAbstractDAO{
	
	/**
	 * 모니터링 MAIN 저장
	 * @param map
	 */
	public void insertMonitoringPlanReport(Map<String, Object> map) {
		insert("CTMZ04DAO.insertMonitoringPlanReport", map);
	}
	
	/**
	 * 모니터링 MAIN 수정
	 * @param map
	 */
	public void updateMonitoringPlanReport(Map<String, Object> map) {
		update("CTMZ04DAO.updateMonitoringPlanReport", map);
	}
	
	/**
	 * 모니터링 VISIT 저장
	 * @param map
	 */
	public void insertVisitInfoGrid(Map<String, Object> map) {		
		insert("CTMZ04DAO.insertVisitInfoGrid", map);
	}
	/**
	 * 모니터링 VISIT 수정
	 * @param map
	 */
	public void updatePlanVisitInfo(Map<String, Object> map) {		
		update("CTMZ04DAO.updatePlanVisitInfo", map);
	}
	
	/**
	 * 모니터링 VISIT 미사용
	 * @param map
	 */
	public void deletePlanVisitInfo(Map<String, Object> map) {		
		update("CTMZ04DAO.deletePlanVisitInfo", map);
	}
	
	
	/**
	 * 모니터링 ITEM 저장
	 * @param map
	 */
	public void insertItemInfoGrid(Map<String, Object> map) {		
		insert("CTMZ04DAO.insertItemInfoGrid", map);
	}
	
	
	/**
	 * 모니터링 ITEM 수정
	 * @param map
	 */
	public void updateVisitReportItem(Map<String, Object> map) {		
		update("CTMZ04DAO.updateVisitReportItem", map);
	}
	
	
	
	/**
	 * 모니터링 목록조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMonitoringGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ04DAO.selectMonitoringGrid", map);
	}
	
	/**
	 * 모니터링 VISIT1 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoGrid1(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ04DAO.selectVisitInfoGrid1", map);
	}
	
	/**
	 * 모니터링 VISIT2 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoGrid2(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ04DAO.selectVisitInfoGrid2", map);
	}
	
	/**
	 * 모니터링 ITEM 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ04DAO.selectVisitInfoItem", map);
	}
	
	/**
	 * 모니터링 MAIN 조회
	 * @param map
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMonitoringMain(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ04DAO.selectMonitoringMain", map);
	}
	
	/**
	 * 모니터링 결재번호 저장
	 * @param map
	 */
	public void updateApproval(Map<String, Object> map) {
		update("CTMZ04DAO.updateApproval", map);
	}
	
	/**
	 * VISIT_ODR 이전회차 조사대상자정보 수정
	 * @param map
	 */
	public void updateOdrPrevious(Map<String, Object> map) {
		update("CTMZ04DAO.updateOdrPrevious", map);
	}
	
	
	/**
	 * 모니터링 결재번호 조회
	 * @param map
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMZ04DAO.selectApprovalInfo", map);
	}
	
	/**
	 * VISIT_ODR 조회
	 * @param map
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectVisitOdr(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ04DAO.selectVisitOdr", map);
	}
	
	/**
	 * VISIT_ODR 이전회차 조사대상자정보 조회
	 * @param map
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectvisitOdrPrevious(Map<String, String> map) {
		return (Map<String, Object>) select("CTMZ04DAO.selectvisitOdrPrevious", map);
	}
	
	
}
