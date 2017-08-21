package pantheon.ctms.z03.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CTMZ03Service {


	/**
	 * 보고서 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectSiteVisitList(Map<String, String> map) throws Exception;
	
	/**
	 * 보고서 신규여부 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public Map<String, Object> selectReportCrudInfo(Map<String, String> map) throws Exception;

	/**
	 * 보고서 상단 Title정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public Map<String, Object> selectReportTitleInfo(Map<String, String> map) throws Exception;

	/**
	 * 보고서 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public Map<String, Object> selectReportMainInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 보고서 항목 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectReportItemList(Map<String, String> map) throws Exception;


	/**
	 * 참석자 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map) throws Exception;

	/**
	 * 방문 보고서 저장
	 * @param list
	 * @throws Exception
	 */
	public String insertVisitReport(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 방문 보고서 저장
	 * @param list
	 * @throws Exception
	 */
	public void updateReportApprovalSn(Map<String, Object> map) throws Exception;

}
