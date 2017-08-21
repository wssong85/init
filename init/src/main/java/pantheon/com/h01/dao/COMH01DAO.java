package pantheon.com.h01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 전자계약 관리를 위한 데이터 접근 클래스
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
@Repository("COMH01DAO")
public class COMH01DAO extends EgovComAbstractDAO{
	
	/**
	 * 과제 중복체크
	 * @param str
	 * @return
	 */
	public int selectEdcCrTaskCountForDupCheckByTaskNo(String str) {
		return (Integer) select("COMH01DAO.selectEdcCrTaskCountForDupCheckByTaskNo", str);
	}

	/**
	 * 유저 입력
	 * @param map
	 */
	public void insertCmUserForJoin(Map<String, String> map) {
		insert("COMH01DAO.insertCmUserForJoin", map);
	}
	
	/**
	 * 연구자 입력
	 * @param map
	 */
	public void insertCmRsrchuserForJoin(Map<String, String> map) {
		insert("COMH01DAO.insertCmRsrchuserForJoin", map);
	}
	
	/**
	 * 시간 조회
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmStdTimeForJoin() {
		return (List<Map<String, Object>>) list("COMH01DAO.selectCmStdTimeForJoin");
	}
	
	/**
	 * CTMS 계약 수정
	 * @param map
	 * @return
	 */
	public int updateCtmsCoCntrctManageForJoin(Map<String, String> map) {
		return update("COMH01DAO.updateCtmsCoCntrctManageForJoin", map);
	}
	
	/**
	 * CTMS 계약 입력
	 * @param map
	 */
	public void insertCtmsCoCntrctManageForJoin(Map<String, String> map) {
		insert("COMH01DAO.insertCtmsCoCntrctManageForJoin", map);
	}
	
	/**
	 * 유저 중복체크
	 * @param str
	 * @return
	 */
	public int selectCmUserCountForDupCheck(String str) {
		return (Integer) select("COMH01DAO.selectCmUserCountForDupCheck", str);
	}
	
	/**
	 * CTMS 계약 조회
	 * @return
	 */
	public String selectCtmsCoCntrctManageForSeq() {
		return (String) select("COMH01DAO.selectCtmsCoCntrctManageForSeq");
	}
	
	/**
	 * 유저 입력
	 * @param map
	 */
	public void insertCmUserTaskForJoin(Map<String, String> map) {
		insert("COMH01DAO.insertCmUserTaskForJoin", map);
	}
	
	/**
	 * 유저 조회
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmUserByReqUserId(String str) {
		return (Map<String, String>) select("COMH01DAO.selectCmUserByReqUserId", str);
	}
	
	/**
	 * 유저 조회
	 * @param map
	 * @return
	 */
	public int selectCmUserForContractReq(Map<String, String> map) {
		return (Integer) select("COMH01DAO.selectCmUserForContractReq", map);
	}
	
	/**
	 * 유저 조회
	 * @param map
	 * @return
	 */
	public int selectCmUserByUserId(Map<String, String> map) {
		return (Integer) select("COMH01DAO.selectCmUserByUserId", map);
	}
	
	/**
	 * 유저조회
	 * @param map
	 * @return
	 */
	public int selectCmUserByUseYn(Map<String, String> map) {
		return (Integer) select("COMH01DAO.selectCmUserByUseYn", map);
	}
	
	/**
	 * 유저조호
	 * @param map
	 * @return
	 */
	public int selectCmUserByAcntLockAt(Map<String, String> map) {
		return (Integer) select("COMH01DAO.selectCmUserByAcntLockAt", map);
	}
	
	/**
	 * 유저 조회
	 * @param map
	 * @return
	 */
	public int selectCmUserForLoginFailrCo(Map<String, String> map) {
		return (Integer) select("COMH01DAO.selectCmUserForLoginFailrCo", map);
	}
	
	/**
	 * 유저 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserForLoginFailrCo(Map<String, String> map) {
		return (Integer) update("COMH01DAO.updateCmUserForLoginFailrCo", map);
	}

	/**
	 * 연구자 카운팅
	 * @param str
	 * @return
	 */
	public int selectCmRsrchuserCountByUserId(String str) {
		return (Integer) select("COMH01DAO.selectCmRsrchuserCountByUserId", str);
	}

	/**
	 * 유저 조회
	 * @param str
	 * @return
	 */
	public int selectCmUserCountForEmail(String str) {
		return (Integer) select("COMH01DAO.selectCmUserCountForEmail", str);
	}
	
	/**
	 * 유저 이력 남기기 위해 조회(acnt_lock_at ,  login_failer_co)
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmUserForAcntLockAt(Map<String, String> map) {
		return (Map<String, String>) select("COMH01DAO.selectCmUserForAcntLockAt", map); 
	}
	
	/**
	 * TASK_NO로 TASK_SN 조회
	 * @param map
	 * @return
	 */
	public String selectEdcCrTaskForTaskSn(Map<String, String> map) {
		return (String) select("COMH01DAO.selectEdcCrTaskForTaskSn", map);
	}
}
 