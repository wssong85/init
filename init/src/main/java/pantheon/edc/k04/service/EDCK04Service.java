package pantheon.edc.k04.service;

import java.util.List;
import java.util.Map;

/**
 * Lab 정상범위 관리를 처리하는 비지니스 인터페이스 클래스
 * @author 오동근
 * @since 2016.02.29
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.29  오동근          최초 생성
 *  
 */
public interface EDCK04Service{
	
	/**
	 * DB Freezing selectEdcTaskList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcTaskList( Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing selectEdcSiteList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcSiteList( Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing selectEdcSiteList
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcSubInsttList( Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing selectTaskInfo
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskInfo( Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing updateEdcCrTaskReqNo
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateEdcCrTaskReqNo(Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing 결제상태 check후 완료되면 main table의 status 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateEdcCrTaskFrzStt(Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing selectEdcFrzngHist
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEdcFrzngHist( Map<String, Object> param) throws Exception;
	
	/**
	 * DB Freezing updateFrzEdcCrInsttFrm
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateFrzEdcCrInsttFrm(List<Map<String, Object>> param) throws Exception;
	
	/**
	 * Freezing updateSubFrzEdcCrInsttFrm
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateSubFrzEdcCrInsttFrm(List<Map<String, Object>> param) throws Exception;
}
