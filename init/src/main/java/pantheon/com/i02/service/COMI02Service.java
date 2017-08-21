package pantheon.com.i02.service;

import java.util.Map;

/**
 * 아이디/비밀번호 찾기 처리하는 비지니스 인터페이스 클래스
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
public interface COMI02Service {

	/**
	 * 아이디 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectCmUserForFindId(Map<String, String> map) throws Exception;

	/**
	 * 메일 발송 시 유저 수정(비밀번호 코드)
	 * @param map
	 * @throws Exception
	 */
	public void updateCmUserForSendTmpMail(Map<String, String> map) throws Exception;
	
	/**
	 * 비밀번호 코드 수정(Main 클릭)
	 * @throws Exception
	 */
	public String updateCmUserForMainClick(Map<String, String> map) throws Exception;

	/**
	 * 비밀번호 변경 시 유저 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateCmUserForChgPassword(Map<String, String> map) throws Exception;

	/**
	 * 비밀번호 변경
	 * @param map
	 * @throws Exception
	 */
	public void updateCmUserForChgPasswordByPasswordCode(Map<String, String> map) throws Exception;
	
}
