package pantheon.sdb.f07.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("SDBF07DAO")
public class SDBF07DAO extends EgovComAbstractDAO {
	public List<Map<String, String>> selectAssessmentSettingInfo(Map<String, String> param) throws Exception{
		return (List<Map<String, String>>) list("SDBF07.selectAssessmentSettingInfo", param);
	}
	
	public void insertAssessmentInfo(Map<String, String> param) throws Exception{
		insert("SDBF07.insertAssessmentInfo", param);
	}
	
	public void updateAssessmentInfo(Map<String, String> param) throws Exception{
		update("SDBF07.updateAssessmentInfo", param);
	}
	
	public void deleteAssessmentInfo(Map<String, String> param) throws Exception{
		update("SDBF07.deleteAssessmentInfo", param);
	}
}
