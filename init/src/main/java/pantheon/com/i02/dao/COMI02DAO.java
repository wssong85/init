package pantheon.com.i02.dao;

import java.util.Map;

import org.springframework.stereotype.Repository; 

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 아이디/비밀번호 찾기 관리를 위한 데이터 접근 클래스
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
@Repository("COMI02DAO")
public class COMI02DAO extends EgovComAbstractDAO{
	
	/**
	 * 아이디 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmUserForFindId(Map<String, String> map) {
		return (Map<String, String>) select("COMI02DAO.selectCmUserForFindId", map);
	}
	
	/**
	 * 비밀번호  이력 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserForChgPassword(Map<String, String> map) {
		return update("COMI02DAO.updateCmUserForChgPassword", map);
	}
	
	/**
	 * 비밀번호 이력 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserForChgPasswordByPasswordCode(Map<String, String> map) {
		return update("COMI02DAO.updateCmUserForChgPasswordByPasswordCode", map);
	}
	
	/**
	 * 메일 발송 시 유저 조회
	 * @param map
	 * @return
	 */
	public int selectCmUserForSendTmpMail(Map<String, String> map) {
		return (Integer) select("COMI02DAO.selectCmUserForSendTmpMail", map);
	}
	
	/**
	 * 메일 발송 시 유저 수정
	 * @param map
	 * @return
	 */
	public int updateCmUserForSendTmpMail(Map<String, String> map) throws Exception{
//		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		return (Integer) update("COMI02DAO.updateCmUserForSendTmpMail", map);
	}
	
	/**
	 * 비밀번호 코드 수정
	 * @param map
	 * @return
	 */
	public int updateCmuserByPasswordCode(Map<String, String> map) {
		return (Integer) update("COMI02DAO.updateCmUserByPasswordCode", map);
	}
	
	/**
	 * 비밀번호 수정
	 * @param map
	 * @return
	 */
	public int selectCmUserForChgPassword(Map<String, String> map) {
		return (Integer) select("COMI02DAO.selectCmUserForChgPassword", map);
	}
	
	/**
	 * 비밀번호 변경페이지 패스워드 코드 확인
	 * @param map
	 * @return
	 */
	public int selectCmUserCountByPasswordCode(Map<String, String> map) {
		return (Integer) select("COMI02DAO.selectCmUserCountByPasswordCode", map);
	}
}
