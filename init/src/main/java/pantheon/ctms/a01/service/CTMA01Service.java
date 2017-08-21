package pantheon.ctms.a01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


/**
 * 공통코드 처리하는 비지니스 인터페이스 클래스
 * @author 김복민
 * @since 2016.02.25
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.25  김복민          최초 생성
 *  
 */
public interface CTMA01Service {
	
	/**
	 * 공지사항 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectNoticeInfo(Map<String, String> map) throws Exception;

	/**
	 * 공지사항 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNotice(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 count 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNoticeByCount(Map<String, String> map) throws Exception;
	
	/**
	 * 공지사항 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateNotice(Map<String, Object> map) throws Exception;
	
	/**
	 * 공지사항 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertNotice(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 알림 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNotifyCtmsList(Map<String, String> map) throws Exception;

	/**
	 * 알림 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNotifyDmcList(Map<String, String> map) throws Exception;

	/**
	 * 알림 생성
	 * @param map
	 * @throws Exception
	 */
	public void insertNotification(Map<String, Object> map) throws Exception;

	/**
	 * 알림 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateNotification(Map<String, Object> map) throws Exception;

}
