package pantheon.ctms.a01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMA01DAO")
public class CTMA01DAO extends EgovComAbstractDAO{

	/**
	 * 공지사항 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNotice(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMA01DAO.selectNotice", map);
	}

	/**
	 * 공지사항 상세 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeInfo(Map<String, String> map) {
		return (Map<String, Object>) select("CTMA01DAO.selectNoticeInfo", map);
	}

	/**
	 * 공지사항 수정
	 * @param map
	 * @return
	 */
	public void updateNotice(Map<String, Object> map) {
		insert("CTMA01DAO.updateNotice", map);
	}
	
	/**
	 * 공지사항 저장
	 * @param map
	 */	
	public void insertNotice(Map<String, Object> map) {
		insert("CTMA01DAO.insertNotice", map);
	}
	
	/**
	 * 공지사항 삭제
	 * @param map
	 */	
	public void deleteNotice(Map<String, Object> map) {
		insert("CTMA01DAO.deleteNotice", map);
	}
	
	/**
	 * 공지사항 count 조회
	 * @param map
	 */	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeByCount(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMA01DAO.selectNoticeByCount", map);
	}

	/*-------------------------------------------------------------------------------------------------------------------------*/

	/**
	 * CTMS 알림 리스트 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNotifyCtmsList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMA01DAO.selectNotifyCtmsList", map);
	}

	/**
	 * DMC 알림 리스트 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNotifyDmcList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMA01DAO.selectNotifyDmcList", map);
	}

	/**
	 * DMC 알림 리스트 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNotifyInfo(Map<String, Object> map) {
		return (Map<String, Object>) select("CTMA01DAO.selectNotifyInfo", map);
	}

	/**
	 * 알림 생성
	 * @param map
	 */	
	public void insertNotification(Map<String, Object> map) {
		insert("CTMA01DAO.insertNotification", map);
	}

	/**
	 * 알림 수정
	 * @param map
	 */	
	public void updateNotification(Map<String, Object> map) {
		insert("CTMA01DAO.updateNotification", map);
	}

}
