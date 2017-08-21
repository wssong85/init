package pantheon.ctms.j05.service;

import java.util.List;
import java.util.Map;

public interface DMCJ05Service {
	
	public List<Map<String, Object>> selectInstitutionInfo(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectInstt_tyByCommonCode(Map<String, String> map) throws Exception;
	

}
