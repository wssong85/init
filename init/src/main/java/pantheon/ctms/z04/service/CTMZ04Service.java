package pantheon.ctms.z04.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CTMZ04Service {
	
	/**
	 * 모니터링계획 보고서 저장
	 * @param request
	 * @param response
	 * @return
	 */	
	public void insertMonitoringPlanReport(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 모니터링 방문보고서 저장
	 * @param request
	 * @param response
	 * @return
	 */	
	public void insertMonitoringVisitReport(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 모니터링 결재번호 저장
	 * @param request
	 * @param response
	 * @return
	 */	
	public void updateApproval(List<Map<String, Object>> list) throws Exception;
	
	
	/**
	 * 모니터링 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectMonitoringGrid(Map<String, String> map) throws Exception;
	
	/**
	 * 모니터링 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map) throws Exception;
	
	/**
	 * 모니터링 VISIT_ODR 조회
	 * @param request
	 * @param response
	 * @return
	 */		
	public Map<String, Object> selectVisitOdr(Map<String, String> map) throws Exception;
	
	/**
	 * 모니터링 VISIT_ODR 이전데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */		
	public Map<String, Object> selectvisitOdrPrevious(Map<String, String> map) throws Exception;
	
	
	
	/**
	 * 모니터링 VISIT1 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectVisitInfoGrid1(Map<String, String> map) throws Exception;
	
	/**
	 * 모니터링 VISIT2 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectVisitInfoGrid2(Map<String, String> map) throws Exception;
	
	
	/**
	 * 모니터링 결재번호 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception;

	
	/**
	 * 모니터링 MAIN 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */	
	public Map<String, Object> selectMonitoringMain(Map<String, String> map) throws Exception;
}
