package pantheon.ctms.b01.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;





import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMB01DAO")
public class CTMB01DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMB01DAO.class);
    
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClinicalAssignmentList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB01DAO.selectClinicalAssignmentList", map);
	}
	

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectclinicalbyGrid(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMB01DAO.selectclinicalbyGrid", map);
	}
	
	
	/*/pms 연차보고서 수정
	public void updateAnnualReport(Map<String, Object> map) {
		insert("CTMB01DAO.updateAnnualReport", map);
	}*/
}

