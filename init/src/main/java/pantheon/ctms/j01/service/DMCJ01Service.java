package pantheon.ctms.j01.service;

import java.util.List;
import java.util.Map;

public interface DMCJ01Service {

	public List<Map<String, Object>> selectTaskRegStatusList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectTaskProgressList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectTaskNoticeList(Map<String, String> map) throws Exception;
	
}
