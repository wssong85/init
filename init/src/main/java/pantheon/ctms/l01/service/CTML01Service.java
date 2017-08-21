package pantheon.ctms.l01.service;

import java.util.List;
import java.util.Map;



/**
 * Milestone 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
public interface CTML01Service {

	/**
	 * 공통코드 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;

	/**
	 * CRA 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCRAList(Map<String, String> map) throws Exception;

	/**
	 * Task 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) throws Exception;

	/**
	 * Milestone 계획 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMileStonePlanList(Map<String, String> map) throws Exception;

	/**
	 * Milestone 계획 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertMileStonePlanInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 과제정보 조회
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> selectTaskInfo(Map<String, String> map) throws Exception;
	
	
	/**
	 * Milestone 년간 Plan 기간 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMilestoneYearInfo(Map<String, String> map) throws Exception;
	
	/**
	 * Milestone 월간 Plan 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMilestonerPlanBarList(Map<String, String> map) throws Exception;
	
	/**
	 * 과제정보 조회
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> selectMilestoneColWidthInfo(Map<String, String> map) throws Exception;
	/*-------------------------------------------------------------------------------------------------------------*/

	
}
