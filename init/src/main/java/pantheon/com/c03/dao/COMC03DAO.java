package pantheon.com.c03.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * KCD 관리를 위한 데이터 접근 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
@Repository("COMC03DAO")
public class COMC03DAO extends EgovComAbstractDAO{
	
	/**
	 * 사전목록 입력
	 * @param map
	 */
	public void insertEdcCrMic(Map<String, Object> map) {
		insert("COMC03DAO.insertEdcCrMic", map);
	}
	
	/**
	 * KCD 입력
	 * @param map
	 */
	public void insertEdcCrKcd(Map<String, Object> map) {
		insert("COMC03DAO.insertEdcCrKcd", map);
	}
	
	/**
	 * 사전목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrMdicByDicarySeCode(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC03DAO.selectEdcCrMdicByDicarySeCode", map);
	}
	
	/**
	 * KCD 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrKcdByKcdSn(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC03DAO.selectEdcCrKcdByKcdSn", map);
	}
	
	/**
	 * KCD count
	 * @param map
	 * @return
	 */
	public int selectEdcCrKcdCountByKcdSn(Map<String, String> map) {
		return (Integer) select("COMC03DAO.selectEdcCrKcdCountByKcdSn", map);
	}
}
