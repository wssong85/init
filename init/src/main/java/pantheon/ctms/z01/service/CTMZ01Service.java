package pantheon.ctms.z01.service;

import java.util.List;
import java.util.Map;

public interface CTMZ01Service {
	
	/**
	 * 기관정보 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	public List<Map<String, Object>> selectInsttInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 방문그리드 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVisitReportInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 적합성그리드 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectComPatibilityReportInfo(Map<String, String> map) throws Exception;

	
}
