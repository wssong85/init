package pantheon.ctms.z15.service;

import java.util.List;
import java.util.Map;

public interface CTMZ15Service {
	
	/**
	 * 시험전 방문보고서 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectTitleList(Map<String, String> map) throws Exception;
	
	/**
	 * 시험전 방문보고서 저장
	 * @param list
	 * @throws Exception
	 */
	public void insertPreTrialVisitReport(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 시험전 방문보고서 MAIN 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */	
	public Map<String, Object> selectTrialVisitReport(Map<String, String> map) throws Exception;
		
	
	/**
	 * 시험전 방문보고서 ITEM 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectItemReport(Map<String, String> map) throws Exception;
	
	/**
	 * 결재번호 저장
	 * @param request
	 * @param response
	 * @return
	 */	
	public void updateApproval(List<Map<String, Object>> list) throws Exception;
	
	
	/**
	 * 결재번호 조회
	 * @param request
	 * @param response
	 * @return
	 */	
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception;
	
}
