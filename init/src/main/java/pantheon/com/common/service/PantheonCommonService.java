package pantheon.com.common.service;

import java.util.List;
import java.util.Map;

/**
 * 공통쿼리 처리하는 인터페이스 클래스
 * 
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.02.24 송원석 최초 생성
 * 
 */
public interface PantheonCommonService {

	/**
	 * 리스트를 조회
	 * 
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectQueryDataList(Map<String, String> map) throws Exception;

	/**
	 * 리스트를 조회
	 * 
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectQueryDataList2(Map<String, Object> map) throws Exception;

	/**
	 * 1ROW 조회
	 * 
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectQueryData(Map<String, String> map) throws Exception;

	/**
	 * COUNTING
	 * 
	 * @param map
	 * @return
	 */
	public int selectQueryListCount(Map<String, String> map) throws Exception;
}
