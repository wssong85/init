package pantheon.edc.d01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EDCD01Service {
	
	public Map<String, Object> selectQueryTemplate(Map<String, String> param) throws Exception;
	
	public List<Map<String, Object>> selectQueryListByPre(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectQueryListByOpen(Map<String, Object> param) throws Exception;
	
	public void updateCmQueryByQuerySttus(List<Map<String, Object>> param) throws Exception;
	
	public void updateCmQueryByUseAt(List<Map<String, Object>> param) throws Exception;
	
	public Map<String, Object> selectQueryListByExcel(HttpServletRequest request) throws Exception;
	
	public void insertCfQuery(List<Map<String, Object>> param) throws Exception;

}
