package pantheon.ctms.j05.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("DMCJ05DAO")
public class DMCJ05DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(DMCJ05DAO.class);
    //계약 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInstitutionInfo(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ05DAO.selectInstitutionInfo", map);
	}
	
	//계약 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInstt_tyByCommonCode(Map<String, String> map) {
		return (List<Map<String, Object>>) list("DMCJ05DAO.selectInstt_tyByCommonCode", map);
	}
	
	
	
	
}

