package pantheon.com.j01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * ATRAIL 관리를 위한 데이터 접근 클래스
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
@Repository("COMJ01DAO")
public class COMJ01DAO extends EgovComAbstractDAO{
	
	/**
	 * ATRAIL 목록 조회
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmDtaAtrailListByPk(Map<String, String> map) throws Exception {
//		map.put("LOCALE", Util.getStrLocale());
		map.put("LOCALE", "kr");
		return (List<Map<String, Object>>) list("COMJ01DAO.selectCmDtaAtrailListByPk", map);
	}
	
	/**
	 * ATRAIL 목록 카운팅
	 * @param map
	 * @return
	 */
	public int selectCmDtaAtrailListCountByPk(Map<String, String> map) {
		return (int) select("COMJ01DAO.selectCmDtaAtrailListCountByPk", map);
	}
	
	/**
	 * ATRAIL 목록 조회(CLOB)
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmDtaAtrailListByPkForClob(Map<String, String> map) throws Exception {
//		map.put("LOCALE", Util.getStrLocale());
		map.put("LOCALE", "kr");
		return (List<Map<String, Object>>) list("COMJ01DAO.selectCmDtaAtrailListByPkForClob", map);
	}
	
	/**
	 * ATRAIL 목록 카운팅(CLOB)
	 * @param map
	 * @return
	 */
	public int selectCmDtaAtrailListCountByPkForClob(Map<String, String> map) {
		return (int) select("COMJ01DAO.selectCmDtaAtrailListCountByPkForClob", map);
	}
	
	
}
