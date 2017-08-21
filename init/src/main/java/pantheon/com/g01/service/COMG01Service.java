package pantheon.com.g01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 공지사항 처리하는 비지니스 인터페이스 클래스
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
public interface COMG01Service {
	
	/**
	 * 공지사항 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmNoticeListByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 목록 카운팅
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCmNoticeListCountByPk(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 입력
	 * @param map
	 * @param request
	 * @throws Exception
	 */
	public void insertCmNotice(Map<String, String> map, HttpServletRequest request) throws Exception;
	
	/**
	 * 공지사항 수정
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public int updateCmNotice(Map<String, String> map, HttpServletRequest request) throws Exception;
	
	/**
	 * 공지사항 수정(삭제)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmNoticeForDelete(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCmNoticeForInqireNum(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 조회
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCmNoticeByPk(Map<String, String> map) throws Exception;
}
