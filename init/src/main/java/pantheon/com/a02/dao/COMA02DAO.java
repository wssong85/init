package pantheon.com.a02.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 프로그램관리를 위한 데이터 접근 클래스
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
@Repository("COMA02DAO")
public class COMA02DAO extends EgovComAbstractDAO{
	
	/**
	 * 프로그램목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmProgrm(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMA02DAO.selectCmProgrm", map);
	}
	
	/**
	 * 프로그램목록 입력
	 * @param map
	 */
	public void insertCmProgrm(Map<String, Object> map) {
		insert("COMA02DAO.insertCmProgrm", map);
	}
	
	/**
	 * 프로그램목록 수정
	 * @param map
	 * @return
	 */
	public int updateCmProgrmByPk(Map<String, Object> map) {
		return update("COMA02DAO.updateCmProgrmByPk", map);
	}
	
	/**
	 * 프로그램목록 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmProgrmbyPk(Map<String, Object> map) {
		return delete("COMA02DAO.deleteCmProgrmbyPk", map);
	}
	
	/**
	 * 버튼목록을 프로그램아이디로 목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmButtonByProgrmId(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMA02DAO.selectCmButtonByProgrmId", map);
	}
	
	/**
	 * 버튼목록을 입력
	 * @param map
	 */
	public void insertCmButton(Map<String, Object> map) {
		insert("COMA02DAO.insertCmButton", map);
	}
	
	/**
	 * 버튼목록을 수정
	 * @param map
	 * @return
	 */
	public int updateCmButton(Map<String, Object> map) {
		return update("COMA02DAO.updateCmButton", map);
	}
	
	/**
	 * 버튼목록을 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmButton(Map<String, Object> map) {
		return delete("COMA02DAO.deleteCmButton", map);
	}
	
	/**
	 * 프로그램 ID 중복체크
	 * @param map
	 * @return
	 */
	public int selectCmProgrmForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMA02DAO.selectCmProgrmForDupCheck", map);
	}
	
	/**
	 * 버튼ID 중복체크
	 * @param map
	 * @return
	 */
	public int selectCmButtonForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMA02DAO.selectCmButtonForDupCheck", map);
	}
	
	/**
	 * 버튼 삭제를 위해 버튼 수정
	 * @param map
	 * @return
	 */
	public int updateCmButtonForDelete(Map<String, Object> map) {
		return (Integer) update("COMA02DAO.updateCmButtonForDelete", map);
	}
	
	/**
	 * 프로그램 삭제를 위해 프로그램 수정
	 * @param map
	 * @return
	 */
	public int updateCmProgrmForDelete(Map<String, Object> map) {
		return (Integer) update("COMA02DAO.updateCmProgrmForDelete", map);
	}
	
	/**
	 * 버튼 삭제를 위해 버튼 조회
	 * @param map
	 * @return
	 */
	public int selectCmButtonForDelete(Map<String, Object> map) {
		return (Integer) select("COMA02DAO.selectCmButtonForDelete", map);
	}
	
	/**
	 * 수정하기전 홈화면인지 확인한다.
	 * @param map
	 * @return
	 */
	public int selectCmProgrmForDulCheckByEssntlAt(Map<String, Object> map) {
		return (Integer) select("COMA01DAO.selectCmProgrmForDulCheckByEssntlAt", map);
	}
	
	/**
	 * 역할제한 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleLmttByProgrmId(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("COMA02DAO.selectCmRoleLmttByProgrmId", map);
	}
	
	/**
	 * 역할 제한 입력
	 * @param map
	 */
	public void insertCmRoleLmttByPk(Map<String, Object> map) {
		insert("COMA02DAO.insertCmRoleLmttByPk", map);
	}
	
	/**
	 * 역할 제한 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmRoleLmttByPk(Map<String, Object> map) {
		return delete("COMA02DAO.deleteCmRoleLmttByPk", map);
	}
	
	/**
	 * 역할 제한 수정
	 * @param map
	 * @return
	 */
	public int updateCmRoleLmttByPk(Map<String, Object> map) {
		return update("COMA02DAO.updateCmRoleLmttByPk", map);
	}
	
	/**
	 * 역할 제한 수정(삭제)
	 * @param map
	 * @return
	 */
	public int updateCmRoleLmttForDelete(Map<String, Object> map) {
		return update("COMA02DAO.updateCmRoleLmttForDelete", map);
	}
	
	/**
	 * 역할 고정여부 구분자로 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleByFixingAtForComboBox(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMA02DAO.selectCmRoleByFixingAtForComboBox", map);
	}
	
	/**
	 * audit trail 삭제 이력 남기기 위해 역할 제한 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmRoleLmttByPk(Map<String, Object> map) {
		return (List<Map<String, Object>>) list("COMA02DAO.selectCmRoleLmttByPk", map);
	}
	
	/**
	 * 역할 제한 프로그램 아이디로 삭제
	 * @param map
	 * @return
	 */
	public int deleteCmRoleLmttByProgrmId(Map<String, Object> map) {
		return delete("COMA02DAO.deleteCmRoleLmttByProgrmId", map);
	}
	
	/**
	 * 역할 제한 삭제 위해 PK로 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmRoleLmttByPkForDupCheck(Map<String, Object> map) {
		return (Integer) select("COMA02DAO.selectCmRoleLmttByPkForDupCheck", map);
	}
	
} 
