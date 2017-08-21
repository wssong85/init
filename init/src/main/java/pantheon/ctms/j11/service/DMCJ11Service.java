package pantheon.ctms.j11.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;



/**
 * 공통팝업 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.03.07
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.07  김복민          최초 생성
 *  
 */
public interface DMCJ11Service {

	/**
	 * 기관 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) throws Exception;
	
	/**
	 * To do 기관 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTodoListInsttInfo(Map<String, String> map) throws Exception;
	

	/**
	 * 사용자 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskUserList(Map<String, String> map) throws Exception;
	

	/**
	 * 반려사유 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReturnReasonInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 반려사유 생성
	 * @param map
	 * @throws Exception
	 */
	public void insertReturnReasonInfo(Map<String, String> map) throws Exception;

	/*-------------------------------------------------------------------------------------------------------------*/

	/**
	 * 파일삭제
	 * @param request
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void deleteFile(HttpServletRequest request, String path, String name) throws Exception;
	
	/**
	 * 파일업로드하며 파일정보 저장(moduleKnd 값에 모듈 이름이나 파일을 가져올 수 있는 구분자를 넣어줘야 한다.)
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */	
	public String insertDmFileMstr(HttpServletRequest request, Map<String, String> map) throws Exception;
	
	
	/**
	 * 파일 상세 업로드
	 * @param request
	 * @param string
	 * @return
	 * @throws Exception
	 */
	public String insertDmFileDetail(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception;
	
	/**
	 * FILE MASTER 순번
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDmFileMasterForSN(Map<String, String> map) throws Exception;
	
	/**
	 * FILE Detail 정보
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> selectDmFileDetailInfo(Map<String, String> map) throws Exception;

	/**
	 * 과제정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskList(Map<String, String> map) throws Exception;
	
	/**
	 * 유저역할정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserRoleInfoList(Map<String, String> map) throws Exception;
	
	/**
	 * 공통코드 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;
	
	/**
	 * 승인된 연구자 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map) throws Exception;
	
	
}
