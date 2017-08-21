package pantheon.com.z03.dao;

import java.util.Map; 

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 메일 및 SMS를 위한 데이터 접근 클래스
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
@Repository("COMZ03DAO")
public class COMZ03DAO extends EgovComAbstractDAO{

	public void insertMmsMsgForLms(Map<String, String> map) {
		insert("COMZ03DAO.insertMmsMsgForLms", map);
	}

	public void insertComTheMailDsptchManage(Map<String, String> map) {
		insert("COMZ03DAO.insertComTheMailDsptchManage", map);
	}
	/////////////////암호화 테스트/////////////
	public int selectComPasswordTest(Map<String, String> map) {
		return (Integer) select("COMZ03DAO.selectComPasswordTest", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, String> selectComEncTest(Map<String, String> map) {
		return (Map<String, String>) select("COMZ03DAO.selectComEncTest", map);
	}
	
	public int updateComPasswordTest(Map<String, String> map) {
		return update("COMZ03DAO.updateComPasswordTest", map);
	}
	
	public int updateComEmailTest(Map<String, String> map) {
		return update("COMZ03DAO.updateComEmailTest", map);
	}
}
