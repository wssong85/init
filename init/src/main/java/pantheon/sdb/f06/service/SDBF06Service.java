package pantheon.sdb.f06.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 교육이수리스트 등록 관리 인터페이스 클래스
 * @author 이원민
 * @since 2016.03.22
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.22   이원민                    최초 생성
 *  
 */
public interface SDBF06Service {
	
	/**
	 * 전자이력서 정보 등록 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertResumeInfo(HttpServletRequest req) throws Exception;
	
	/**
	 * 전자이력서 정보 수정 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateResumeInfo(HttpServletRequest req) throws Exception;
	
	/**
	 * 전자이력서 정보 조회 
	 * @param param
	 * @return List<Map<String, String>>
	 * @throws Exception
	 */
	public List<Map<String, String>> selectResumeInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 등록된 첨부파일 개별 삭제 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void deleteFileInfo(Map<String, String> param) throws Exception;
	
	/**
	 * 등록된 전자이력서 정보 삭제 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void deleteResumeInfo(Map<String, String> param) throws Exception;
}
