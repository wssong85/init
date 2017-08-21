package pantheon.com.h01.service;

import java.util.List;
import java.util.Map;

/**
 * 전자계약 처리하는 비지니스 인터페이스 클래스
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
public interface COMH01Service {
	
	/**
	 * 과제 중복체크
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public int selectEdcCrTaskCountForDupCheckByTaskNo(String str) throws Exception;
	
	/**
	 * 유저 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmUserForJoin(Map<String, String> map) throws Exception;
	
	/**
	 * 연구자 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCmRsrchuserForJoin(Map<String, String> map) throws Exception;
	
	/**
	 * 시간 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmStdTimeForJoin() throws Exception;
	
	/**
	 * ctms계약 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCtmsCoCntrctManageForJoin(Map<String, String> map) throws Exception;
	
	/**
	 * ctms 계약 입력
	 * @param map
	 * @throws Exception
	 */
	public void insertCtmsCoCntrctManageForJoin(Map<String, String> map) throws Exception;
	
	/**
	 * 유저 중복체크
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public int selectCmUserCountForDupCheck(String str) throws Exception;
	
	/**
	 * 유저 조회
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectCmUserByReqUserId(String str) throws Exception;

	/**
	 * 유저 조회
	 * @param map
	 * @throws Exception
	 */
	public void selectCmUserForContractReq(Map<String, String> map) throws Exception;
	
	/**
	 * 연구자 카운팅
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public int selectCmRsrchuserCountByUserId(String str) throws Exception;

	/**
	 * 유저 이메일로 조회
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public int selectCmUserCountForEmail(String str) throws Exception;
}
