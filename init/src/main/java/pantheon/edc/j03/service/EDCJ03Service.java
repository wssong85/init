package pantheon.edc.j03.service;

import java.util.List;
import java.util.Map;

public interface EDCJ03Service {
	
	public List<Map<String, Object>> selectAeList(Map<String, Object> param) throws Exception;
	
}
