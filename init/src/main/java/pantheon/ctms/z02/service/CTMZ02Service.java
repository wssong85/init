package pantheon.ctms.z02.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface CTMZ02Service {
	
	/**
	 * 개시방문 준비기록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectVisitInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 개시방문 준비기록 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertPlanVisitReport(List<Map<String, Object>> list) throws Exception;
	
		
	/**
	 * 개시방문 보고서 참석자 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map) throws Exception;

	/**
	 * 개시방문 보고서 Main 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public Map<String, Object> selectVisitInfoMain(Map<String, String> map) throws Exception;
	
	/**
	 * 개시방문 결재정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 개시방문 보고서 ITEM 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map) throws Exception;
	/**
	 * 개시방문 결재순번 수정
	 * @param list
	 * @throws Exception
	 */
	public void updateApproval(List<Map<String, Object>> list) throws Exception;
	
	
	/**
	 * 방문보고서 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertVisitReport(List<Map<String, Object>> list) throws Exception;
	
}
