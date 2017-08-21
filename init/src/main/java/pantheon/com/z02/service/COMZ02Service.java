package pantheon.com.z02.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 업로드 처리하는 비지니스 인터페이스 클래스
 * @author 송원석
 * @since 2016.03.02
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.02  송원석          최초 생성
 *  
 */
public interface COMZ02Service {
	
	
	/**
	 * 파일업로드하며 파일정보 pdf 저장(moduleKnd 값에 모듈 이름이나 파일을 가져올 수 있는 구분자를 넣어줘야 한다.)
	 * @param request
	 * @param moduleKnd
	 * @return
	 * @throws Exception
	 */
	public String insertDmFileMstrForPdf(EgovPropertyService egovPeopertyService, String moduleKnd, String fileNm, Map<String, String> map) throws Exception;
	
	/**
	 * 파일업로드하며 파일정보 저장(moduleKnd 값에 모듈 이름이나 파일을 가져올 수 있는 구분자를 넣어줘야 한다.)
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String insertDmFileMstr(HttpServletRequest request, String moduleKnd) throws Exception;

	/**
	 * 파일상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 파일상세 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 파일업로드
	 * @param request
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public String uploadFile(HttpServletRequest request) throws Exception;
	
	/**
	 * 파일삭제
	 * @param request
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void deleteFile(String deletePath) throws Exception;

	/**
	 * 파일 상세 업로드
	 * @param request
	 * @param string
	 * @return
	 * @throws Exception
	 */
	public String insertDmFileDetail(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception;
	
	/**
	 * 파일 상세 삭제 없는 업로드
	 * @param request
	 * @param string
	 * @return
	 * @throws Exception
	 */
	public String insertDmFileDetailNonDelete(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception;
	
	/**
	 * 파일 각자 삭제
	 * @param request
	 * @param moduleKnd
	 * @param fileMastrSn
	 * @param splitDeleteDetailSn
	 * @return
	 * @throws Exception
	 */
	public void deleteDmFileDetailEachDelete(String fileMastrSn, String splitDeleteDetailSn) throws Exception;

	/**
	 * 과제번호로 word를 조회한다.
	 * @param map
	 * @throws Exception
	 */
	public String selectEdcCrTaskForWord(Map<String, String> map) throws Exception; 
}
