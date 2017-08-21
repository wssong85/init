package pantheon.edc.k01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EDCK01Service {
	public List<Map<String, Object>> selectStudyList(Map<String, Object> param) throws Exception;

	public String selectStudyListCount(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectBaseInfo(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectCheckTaskNo(Map<String, Object> param) throws Exception;

	public Map<String, Object> insertBaseInfo(HttpServletRequest request, Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectProductList(Map<String, Object> param) throws Exception;

}
