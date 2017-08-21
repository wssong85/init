package pantheon.ctms.g01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * 연구자등록을 위한 데이터 접근 클래스
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
@Repository("CTMG01DAO")
public class CTMG01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMG01DAO.class);

    //연구자 count 조회
	public int selectRsrchuserCount(Map<String, String> map) {
		return (int) select("CTMG01DAO.selectRsrchuserCount", map);
	}

    //연구자 List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRsrchuserList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMG01DAO.selectRsrchuserList", map);
	}
	
    //과제&연구자 맵핑 확인.
	public int selectTaskUserCount(Map<String, Object> map) {
		return (int) select("CTMG01DAO.selectTaskUserCount", map);
	}

	/*==========================================================================================================*/
	//표준시간대 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMG01DAO.standardTimeList", map);
	}
	
	//연구자ID 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmUser(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMG01DAO.selectCmUser", map);
	}
	
	//연구자 정보 저장
	public void insertRsrchUserInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertRsrchUserInfo", map);
	}
	
	//사용자 정보 저장
	public void insertUserInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertUserInfo", map);
	}
	
	//기관 정보 저장
	public void insertInsttInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertInsttInfo", map);
	}
	
	//사용자role 정보 저장
	public void insertUserRoleInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertUserRoleInfo", map);
	}
	
	//사용자 과제role 정보 저장
	public void insertTaskUserRoleInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertTaskUserRoleInfo", map);
	}
		
	//사용자role 정보 수정
	public void updateUserRoleInfo(Map<String, Object> map) {
		update("CTMG01DAO.updateUserRoleInfo", map);
	}
	
	
	//사용자 과제정보 저장전 삭제
	public void deleteTaskUserRoleInfo(Map<String, Object> map) {
		delete("CTMG01DAO.deleteTaskUserRoleInfo", map);
	}
	
	//사용자 과제정보 저장
	public void insertUserTaskInfo(Map<String, Object> map) {
		insert("CTMG01DAO.insertUserTaskInfo", map);
	}
		
	//사용자  정보 수정
	public void updateUserInfo(Map<String, Object> map) {
		update("CTMG01DAO.updateUserInfo", map);
	}
	
	//과제사용자  정보 삭제
	public void deleteTaskUserInfo(Map<String, Object> map) {
		update("CTMG01DAO.deleteTaskUserInfo", map);
	}
	
}
