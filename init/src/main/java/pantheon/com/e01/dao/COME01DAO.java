package pantheon.com.e01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 인터페이스 관리를 위한 데이터 접근 클래스
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
@Repository("COME01DAO")
public class COME01DAO extends EgovComAbstractDAO{
	
	/**
	 * EAI SAP 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSapBcncTmprByBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectSapBcncTmprByBatch");
	}
	
	/**
	 * SAP 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSapBcncInfoByBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectSapBcncInfoByBatch");
	}
	
	/**
	 * SAP 입력
	 * @param map
	 */
	public void insertSapBcncInfoByBatch(Map<String, Object> map) {
		insert("COME01DAO.insertSapBcncInfoByBatch", map);
	}

	/**
	 * SAP 수정
	 * @param str
	 * @return
	 */
	public int updateSapBcncTmprByKunnr(String str) {
		return update("COME01DAO.updateSapBcncTmprByKnnr", str);
	}
	
	/**
	 * EAI 부서 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInfraDeptTmprByBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectInfraDeptTmprByBatch");
	}
	
	/**
	 * 부서 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmDeptInfoByBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectCmDeptInfoByBatch");
	}
	
	/**
	 * 부서 입력
	 * @param map
	 */
	public void insertCmDeptInfo(Map<String, Object> map) {
		insert("COME01DAO.insertCmDeptInfo", map);
	}
	
	/**
	 * 부서 수정
	 * @param str
	 * @return
	 */
	public int updateCmDeptInfoByDeptCd(String str) {
		return update("COME01DAO.updateCmDeptInfoByDeptCd", str);
	}
	
	/**
	 * 배치 할지 안할지 기준이 되는 값 조회
	 * @return
	 */
	public String selectCmSysEnvrnByEnvrnSe() {
		return (String) select("COME01DAO.selectCmSysEnvrnByEnvrnSe");
	}
	
	/**
	 * 유저 수정
	 * @param str
	 * @return
	 */
	public int updateCmUserForBatch(String str) {
		return update("COME01DAO.updateCmUserForBatch", str);
	}
	
	/**
	 * 유저 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmUserForBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectCmUserForBatch");
	}
	
	/**
	 * 내부유저 수정
	 * @param str
	 * @return
	 */
	public int updateCmJobUserForBatch(String str) {
		return update("COME01DAO.updateCmJobUserForBatch", str);
	}
	
	/**
	 * 내부유저 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmJobUserForBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectCmJobUserForBatch");
	}
	
	/**
	 * EAI 유저 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInfraUserTmprByBatch() {
		return (List<Map<String, Object>>) list("COME01DAO.selectInfraUserTmprByBatch"); 
	}
	
	/**
	 * 유저 입력
	 * @param map
	 */
	public void insertCmUserByBatch(Map<String, String> map) {
		insert("COME01DAO.insertCmUserByBatch", map);
	}
	
	/**
	 * 내부유저 입력
	 * @param map
	 */
	public void insertCmJobUserByBatch(Map<String, String> map) {
		insert("COME01DAO.insertCmJobUserByBatch", map);
	}
	
	/**
	 * EAI SAP 삭제
	 * @return
	 */
	public int deleteSapBcncTmprByBatch() {
		return delete("COME01DAO.deleteSapBcncTmprByBatch"); 
	}
	
	/**
	 * EAI 유저 삭제
	 * @return
	 */
	public int deleteInfraUserTmprByBatch() {
		return delete("COME01DAO.deleteInfraUserTmprByBatch");
	}
	
	/**
	 * EAI 부서 삭제
	 * @return
	 */
	public int deleteInfraDeptTmprByBatch() {
		return delete("COME01DAO.deleteInfraDeptTmprByBatch");
	}
	
	/**
	 * 인터페이스 목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmIntrfcListByCondition(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COME01DAO.selectCmIntrfcListByCondition", map);
	}
	
	/**
	 * 인터페이스 목록 카운트
	 * @param map
	 * @return
	 */
	public int selectCmIntrfcListCountByCondition(Map<String, String> map) {
		return (int) select("COME01DAO.selectCmIntrfcListCountByCondition", map);
	}
}
