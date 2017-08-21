package pantheon.ctms.j03.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 교육관리 등록을 위한 데이터 접근 클래스
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
@Repository("DMCJ03DAO")
public class DMCJ03DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ03DAO.class);

    //교육관리 count 조회
	public int selectEduMgrCount(Map<String, String> map) {
		return (int) select("DMCJ03DAO.selectEduMgrCount", map);
	}

    //교육관리 List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEduMgrList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ03DAO.selectEduMgrList", map);
	}
	
    //교육관리 상세 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEduMgrInfo(Map<String, String> map) {
		return (Map<String, Object>) select("DMCJ03DAO.selectEduMgrInfo", map);
	}

    //교육관리 List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEduRoleList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ03DAO.selectEduRoleList", map);
	}

	//교육관리 정보 저장
	public void insertEduMgrInfo(Map<String, Object> map) {
		insert("DMCJ03DAO.insertEduMgrInfo", map);
	}

	//교육관리 정보 수정
	public void updateEduMgrInfo(Map<String, Object> map) {
		insert("DMCJ03DAO.updateEduMgrInfo", map);
	}
	
	//교육관리 정보 삭제
	public void deleteEduMgrInfo(Map<String, Object> map) {
		insert("DMCJ03DAO.deleteEduMgrInfo", map);
	}

    //old 교육관리 역할 정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOldEduRoleList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ03DAO.selectOldEduRoleList", map);
	}

	//교육관리 역할 정보 저장
	public void insertEduRoleInfo(Map<String, Object> map) {
		insert("DMCJ03DAO.insertEduRoleInfo", map);
	}

	//교육관리 역할 정보 삭제
	public void deleteEduRoleInfo(Map<String, String> map) {
		insert("DMCJ03DAO.deleteEduRoleInfo", map);
	}

	//교육관리 Module별 교육여부 no 처리
	public void updateEduAtModule(Map<String, Object> map) {
		insert("DMCJ03DAO.updateEduAtModule", map);
	}
	
	//교육관리 Module, Task_sn별 교육여부 no 처리
	public void updateEduAtTaskSn(Map<String, Object> map) {
		insert("DMCJ03DAO.updateEduAtTaskSn", map);
	}
	
	//교육관리 List 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserByEducationList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ03DAO.selectUserByEducationList", map);
	}

}
