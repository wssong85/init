package pantheon.edc.j02.service;

import java.util.List;
import java.util.Map;

public interface EDCJ02Service {
	
	public List<Map<String, Object>> selectAtrailList(Map<String, Object> param) throws Exception;

}
