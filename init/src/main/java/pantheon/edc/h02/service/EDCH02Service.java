package pantheon.edc.h02.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EDCH02Service {
	
	public List<Map<String, Object>> selectLabSubjectList(Map<String, Object> param) throws Exception;
	
}
