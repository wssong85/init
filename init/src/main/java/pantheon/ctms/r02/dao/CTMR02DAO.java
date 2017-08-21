package pantheon.ctms.r02.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;



import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CTMR02DAO")
public class CTMR02DAO extends EgovComAbstractDAO{
	private static final Logger log = LoggerFactory.getLogger(CTMR02DAO.class);
    //pms 연차보고서 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAnnualReportList(Map<String, String> map) {
		return (List<Map<String, Object>>) list("CTMR02DAO.selectAnnualReportList", map);
	}
	
   //pms 연차보고서 입력
	public void insertAnnualReport(Map<String, Object> map) {
		insert("CTMR02DAO.insertAnnualReport", map);
	}	
	
	//pms 연차보고서 수정
	public void updateAnnualReport(Map<String, Object> map) {
		update("CTMR02DAO.updateAnnualReport", map);
	}
	
	//pms 연차보고서 수정
	public void deleteAnnualReport(Map<String, Object> map) {
		update("CTMR02DAO.deleteAnnualReport", map);
	}
}

