package pantheon.edc.k03.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * Lab 정상범위 관리를 처리하는 비지니스 인터페이스 클래스
 * @author 오동근
 * @since 2016.02.29
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.29  오동근          최초 생성
 *  
 */
public interface EDCK03Service{
	
	/**
	 * Lab 정상범위 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectLabList(Map<String, Object> param) throws Exception;
	
	/**
	 * Lab 정상범위 목록 Count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectLabListCount(Map<String, Object> param) throws Exception;
	
	/**
	 * Lab 정상범위 상세
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectLab(Map<String, Object> param) throws Exception;
	/**
	 * Lab 정상범위 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void insertLab(Map<String, Object> param) throws Exception;

	/**
	 * Lab 정상범위 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateLab(Map<String, Object> param) throws Exception;
	
	/**
	 * Analysis parameter 조회 팝업 List
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectAnalysisList(Map<String, String> param) throws Exception;
	
	/**
	 * Lab 파일 업로드 양식 다운로드
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectLabTemplate(Map<String, String> param) throws Exception;
	
	/**
	 * Lab 파일 업로드 후 화면에 뿌려준다.
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectLabListByExcel(HttpServletRequest request, Map<String, String> param ) throws Exception;
	
	/**
	 * Lab 업로드 파일 DB에 저장.
	 * @param param
	 * @throws Exception
	 */
	public void insertLabData(List<Map<String, Object>> param) throws Exception;

}
