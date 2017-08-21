package pantheon.ctms.j07.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 과제별 권한관리를 위한 데이터 접근 클래스
 * @author 김복민
 * @since 2016.04.25
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.04.25  김복민          최초 생성
 *  
 */
@Repository("DMCJ07DAO")
public class DMCJ07DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ07DAO.class);

    //권한별 프로그램ID 및 버튼 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleByProgAndBtnList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ07DAO.selectRoleByProgAndBtnList", map);
	}
	
    //과제별 역할권한 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTaskByBtnList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ07DAO.selectTaskByBtnList", map);
	}

    //old 과제별 역할권한 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOldTaskByBtnList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ07DAO.selectOldTaskByBtnList", map);
	}

	/**
	 * old 과제별 역할권한 삭제
	 * @param str
	 * @return
	 */
	public int deleteOldTaskByBtnList(Map<String, String> map) {
		return delete("DMCJ07DAO.deleteOldTaskByBtnList", map);
	}

	/**
	 * new 과제별 역할권한 저장
	 * @param map
	 */
	public void insertTaskByBtnList(Map<String, Object> map) {
		insert("DMCJ07DAO.insertTaskByBtnList", map);
	}

}
