package pantheon.com.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 공통쿼리 관리를 위한 데이터 접근 클래스
 * 
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.02.24 송원석 최초 생성
 * 
 */
@Repository("PantheonCommonDAO")
public class PantheonCommonDAO extends EgovComAbstractDAO {

	/**
	 * 리스트를 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectQueryDataList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("PantheonCommonDAO." + map.get("QUERY"), map);
	}

	/**
	 * 리스트를 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectQueryDataList2(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("PantheonCommonDAO." + map.get("QUERY"), map);
	}

	/**
	 * 1ROW 조회
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectQueryData(Map<String, String> map) {
		return (Map<String, Object>) select("PantheonCommonDAO." + map.get("QUERY"), map);
	}

	/**
	 * COUNTING
	 * 
	 * @param map
	 * @return
	 */
	public int selectQueryListCount(Map<String, String> map) {
		return (int) select("PantheonCommonDAO." + map.get("QUERY"), map);
	}

}
