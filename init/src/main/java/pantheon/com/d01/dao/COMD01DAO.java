package pantheon.com.d01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 공통코드 관리를 위한 데이터 접근 클래스
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
@Repository("COMD01DAO")
public class COMD01DAO extends EgovComAbstractDAO{
	
	/**
	 * 분류코드 리스트 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmClCodeListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMD01DAO.selectCmClCodeListByPk", map);
	}
	
	/**
	 * 분류코드 수정
	 * @param map
	 * @return
	 */
	public int updateCmClCodeByPk(Map<String, Object> map) {
		return update("COMD01DAO.updateCmClCodeListByPk", map);
	}
	
	/**
	 * 분류코드 저장
	 * @param map
	 */
	public void insertCmClCode(Map<String, Object> map) {
		insert("COMD01DAO.insertCmClCode", map);
	}
	
	/**
	 * 공통코드 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmCmmnCodeListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMD01DAO.selectCmCmmnCodeListByPk", map);
	}
	
	/**
	 * 공통코드 수정
	 * @param map
	 * @return
	 */
	public int updateCmCmmnCodeByPk(Map<String, Object> map) {
		return update("COMD01DAO.updateCmCmmnCodeByPk", map);
	}
	
	/**
	 * 공통코드 저장 
	 * @param map
	 */
	public void insertCmCmmnCode(Map<String, Object> map) {
		insert("COMD01DAO.insertCmCmmnCode", map);
	}
	
	/**
	 * 공통코드 pk로 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmCmmnCodeByPk(Map<String, Object> map) {
		return delete("COMD01DAO.deleteCmCmmnCodeByPk", map);
	}
	
	/**
	 * 공통코드 분류코드로 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmCmmnCodeByCmmnClCode(Map<String, Object> map) {
		return delete("COMD01DAO.deleteCmCmmnCodeByCmmnClCode", map);
	}
	
	/**
	 * 분류코드 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmClCodeByPk(Map<String, Object> map) {
		return delete("COMD01DAO.deleteCmClCodeByPk", map);
	}
	
	/**
	 * 공통코드 수정(삭제) 
	 * @param map
	 * @return
	 */
	public int updateCmCmmnCodeForDelete(Map<String, Object> map) {
		return update("COMD01DAO.updateCmCmmnCodeForDelete", map);
	}
	
	/**
	 * 분류코드 수정(삭제)
	 * @param map
	 * @return
	 */
	public int updateCmClCodeForDelete(Map<String, Object> map) {
		return update("COMD01DAO.updateCmClCodeForDelete", map); 
	}
	
	/**
	 * 분류코드 중복체크
	 * @param map
	 * @return
	 */
	public int selectCmClCodeForDupCheck(Map<String, Object> map) {
		return (int) select("COMD01DAO.selectCmClCodeForDupCheck", map);
	}
	
	/**
	 * 공통코드 중복체크
	 * @param map
	 * @return
	 */
	public int selectCmCmmnCodeForDupCheck(Map<String, Object> map) {
		return (int) select("COMD01DAO.selectCmCmmnCodeForDupCheck", map);
	}
	
	/**
	 * 공통코드 삭제전 조회
	 * @param map
	 * @return
	 */
	public int selectCmCmmnCodeForDelete(Map<String, Object> map) {
		return (int) select("COMD01DAO.selectCmCmmnCodeForDelete", map);
	}
}
