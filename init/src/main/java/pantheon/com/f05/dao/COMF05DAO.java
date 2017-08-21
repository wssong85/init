package pantheon.com.f05.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 프로그램이력 관리를 위한 데이터 접근 클래스
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
@Repository("COMF05DAO")
public class COMF05DAO extends EgovComAbstractDAO{

	/**
	 * 프로그램 이력 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmProgrmConectListByPk(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMF05DAO.selectCmProgrmConectListByPk", map);
	}

	/**
	 * 프로그램 이력 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmProgrmConectListCountByPk(Map<String, String> map) {
		return (int) select("COMF05DAO.selectCmProgrmConectListCountByPk", map);
	}

	/**
	 * 프로그램 이력 입력
	 * @param map
	 */
	public void insertCmProgrmConect(Map<String, String> map) {
		insert("COMF05DAO.insertCmProgrmConect", map);
	}
	
	/**
	 * 프로그램 이력 aop 에서  전체화면 의 CRUD 권한을 확인하기 위해 list 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmUserRoleListForAspect(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMF05DAO.selectCmUserRoleListForAspect", map);
	}
	
	
	/**
	 * 프로그램 이력 aop 에서  특정 화면 CRUD 권한 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectCmRoleAuthorForAspect(Map<String, Object> map) {
		return (Map<String, String>) select("COMF05DAO.selectCmRoleAuthorForAspect", map);
	}
}
