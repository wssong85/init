package pantheon.edc.e01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("EDCE01DAO")
public class EDCE01DAO extends EgovComAbstractDAO{

	/**
	 * eSign Visit 목록
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectESignVisitList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCE01DAO.selectESignVisitList", param);
	}
	
	/**
	 * eSign Subject 목록
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectESignSubjectList(Map<String, Object> param) throws Exception {
		return (List<Map<String, Object>>) list("EDCE01DAO.selectESignSubjectList", param);
	}
	
	
	public void updateESignVisit(Map<String, String> param) throws Exception {
		update("EDCE01DAO.updateESignVisit", param);
	}
	
	public void updateESignSubject(Map<String, String> param) throws Exception {
		update("EDCE01DAO.updateESignSubject", param);
	}
}
