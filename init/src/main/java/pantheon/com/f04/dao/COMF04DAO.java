package pantheon.com.f04.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 접속이력 관리를 위한 데이터 접근 클래스
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
@Repository("COMF04DAO")
public class COMF04DAO extends EgovComAbstractDAO{
	
	/**
	 * 접속이력 입력
	 * @param map
	 */
	public void insertCmSysConectByLogin(Map<String, String> map) {
		insert("COMF04DAO.insertCmSysConectByLogin", map);
	}
	
	/**
	 * 접속이력 목록 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmSysConectListCountByCondition(Map<String, String> map) {
		return (int) select("COMF04DAO.selectCmSysConectListCountByCondition", map);
	}
	
	/**
	 * 접속이력 목록 조회 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmSysConectListByCondition(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMF04DAO.selectCmSysConectListByCondition", map);
	}
}
