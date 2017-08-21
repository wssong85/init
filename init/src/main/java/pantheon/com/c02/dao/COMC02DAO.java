package pantheon.com.c02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * Medical dictionary 관리를 위한 데이터 접근 클래스
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
@Repository("COMC02DAO")
public class COMC02DAO extends EgovComAbstractDAO {

	/**
	 * 버전목록 조회
	 * @param map
	 */
	public void insertEdcCrMdicForExcelList(Map<String, Object> map) {
		insert("COMC02DAO.insertEdcCrMdicForExcelList", map);
	}
	
	/**
	 * ATC 입력
	 * @param map
	 */
	public void insertEdcCrAtcByExcelList(Map<String, Object> map) {
		insert("COMC02DAO.insertEdcCrAtcByExcelList", map);
	}
	
	/**
	 * ATC 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrAtcByDicaryVer(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC02DAO.selectEdcCrAtcByDicaryVer", map);
	}
	
	/**
	 * WHOART 입력
	 * @param map
	 */
	public void insertEdcCrWhoartByExcelList(Map<String, Object> map) {
		insert("COMC02DAO.insertEdcCrWhoartByExcelList", map);
	}
	
	/**
	 * WHOART 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrWhoartByDicaryVer(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC02DAO.selectEdcCrWhoartByDicaryVer", map);
	}
	
	/**
	 * MedDRA 입력
	 * @param map
	 */
	public void insertEdcCrMeddraByExcellList(Map<String, Object> map) {
		insert("COMC02DAO.insertEdcCrMeddraByExcellList", map);
	}
	
	/**
	 * MedDRA 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrMeddraByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC02DAO.selectEdcCrMeddraByPk", map);
	}
	
	/**
	 * KIMS 입력
	 * @param map
	 */
	public void insertEdcCrKimsByExcelList(Map<String, Object> map) {
		insert("COMC02DAO.insertEdcCrKimsByExcelList", map);
	}
	
	/**
	 * KIMS 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEdcCrKimsByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMC02DAO.selectEdcCrKimsByPk", map);
	}
	
	/**
	 * kims count
	 * @param map
	 * @return
	 */
	public int selectEdcCrKimsCountByPk(Map<String, String> map) {
		return (Integer) select("COMC02DAO.selectEdcCrKimsCountByPk", map); 
	}
	
	/**
	 * meddra count
	 * @param map
	 * @return
	 */
	public int selectEdcCrMeddraCountByPk(Map<String, String> map) {
		return (Integer) select("COMC02DAO.selectEdcCrMeddraCountByPk", map);
	}
	
	/**
	 * whoart count
	 * @param map
	 * @return
	 */
	public int selectEdcCrWhoartCountByDicaryVer(Map<String, String> map) {
		return (Integer) select("COMC02DAO.selectEdcCrWhoartCountByDicaryVer", map);
	}
	
	/**
	 * atc count
	 * @param map
	 * @return
	 */
	public int selectEdcCrAtcCountByDicaryVer(Map<String, String> map) {
		return (Integer) select("COMC02DAO.selectEdcCrAtcCountByDicaryVer", map);
	}
	 
}
