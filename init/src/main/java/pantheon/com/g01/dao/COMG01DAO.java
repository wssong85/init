package pantheon.com.g01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 공지사항 관리를 위한 데이터 접근 클래스
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
@Repository("COMG01DAO")
public class COMG01DAO extends EgovComAbstractDAO{
	
	/**
	 * 공지사항 목록 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmNoticeListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMG01DAO.selectCmNoticeListByPk", map);
	}
	
	/**
	 * 공지사항 목록 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmNoticeListCountByPk(Map<String, String> map) {
		return (int) select("COMG01DAO.selectCmNoticeListCountByPk", map);
	}
	
	/**
	 * 공지사항 입력
	 * @param map
	 */
	public void insertCmNotice(Map<String, String> map) {
		insert("COMG01DAO.insertCmNotice", map);
	}
	
	/**
	 * 공지사항 수정
	 * @param map
	 * @return
	 */
	public int updateCmNotice(Map<String, String> map) {
		return update("COMG01DAO.updateCmNotice", map);
	}
	
	/**
	 * 공지사항 수정(삭제)
	 * @param map
	 * @return
	 */
	public int updateCmNoticeForDelete(Map<String, String> map) {
		return update("COMG01DAO.updateCmNoticeForDelete", map);
	}
	
	/**
	 * 공지사항 수정
	 * @param str
	 * @return
	 */
	public int updateCmNoticeForInqireNum(Map<String, String> map) {
		return update("COMG01DAO.updateCmNoticeForInqireNum", map);
	}
	
	/**
	 * 공지사항 조회
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCmNoticeByPk(Map<String, String> map) {
		return (Map<String, Object>) select("COMG01DAO.selectCmNoticeByPk", map);
	}
}
