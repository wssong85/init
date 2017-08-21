package pantheon.edc.e01.service;

import java.util.List;
import java.util.Map;

public interface EDCE01Service {
	
	public List<Map<String, Object>> selectESignVisitList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectESignSubjectList(Map<String, Object> param) throws Exception;
	
	public void updateESignVisit(Map<String, String> param) throws Exception;
	
	public void updateESignSubject(Map<String, String> param) throws Exception;
}
