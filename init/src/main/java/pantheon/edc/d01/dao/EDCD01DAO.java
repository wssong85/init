package pantheon.edc.d01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * QUERY 관리를 위한 데이터 접근 클래스
 * 
 * @author 오동근
 * @since 2016.05.31
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.31 오동근 최초 생성
 */
@Repository("EDCD01DAO")
public class EDCD01DAO extends EgovComAbstractDAO{
	
	/**
	 * Query 업로드 양식 기초 데이터 select
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectQueryTemplate(Map<String, String> param) throws Exception {
		return (List<Map<String, String>>) list("EDCD01DAO.selectQueryTemplate", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectQueryListByPre(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCD01DAO.selectQueryListByPre", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGetEdcVer(Map<String, Object> param) throws Exception{
		return (Map<String, Object>) select("EDCD01DAO.selectGetEdcVer", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectQueryListByOpen(Map<String, Object> param) throws Exception{
		param.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, Object>>) list("EDCD01DAO.selectQueryListByOpen", param);
	}
	
	@SuppressWarnings("unchecked")
	public void updateCmQueryByQuerySttus(Map<String, Object> param) throws Exception{
		update("EDCD01DAO.updateCmQueryByQuerySttus", param);
	}
	
	@SuppressWarnings("unchecked")
	public void updateCmQueryByUseAt(Map<String, Object> param) throws Exception{
		update("EDCD01DAO.updateCmQueryByUseAt", param);
	}
	
	public void insertQueryMst(Map<String, Object> map) throws Exception{
		insert("EDCD01DAO.insertQueryMst", map);
	}
	
	public void insertCfQuery(Map<String, Object> map) throws Exception{
		insert("EDCD01DAO.insertCfQuery", map);
	}

}
