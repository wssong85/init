package pantheon.edc.h01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EDCH01Service {
	
	public List<Map<String, Object>> selectDmFileDetailList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectEdcLabDtaList(Map<String, Object> param) throws Exception;
	
	Map<String, Object> selectLabTemplate(Map<String, String> param) throws Exception;
	
	public Map<String, Object> selectLabListByExcel(HttpServletRequest request, Map<String, String> param ) throws Exception;
	
	public void insertLabData(List<Map<String, Object>> param) throws Exception;
	
	public void insertLabCfValue(Map<String, Object> param) throws Exception;
	
}
