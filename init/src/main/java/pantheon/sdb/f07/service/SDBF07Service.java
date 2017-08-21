package pantheon.sdb.f07.service;

import java.util.List;
import java.util.Map;

public interface SDBF07Service {
	public List<Map<String, String>> selectAssessmentSettingInfo(Map<String, String> param) throws Exception;
	public void insertAssessmentInfo(Map<String, String> param) throws Exception;
	public void deleteAssessmentInfo(Map<String, String> param) throws Exception;
}
