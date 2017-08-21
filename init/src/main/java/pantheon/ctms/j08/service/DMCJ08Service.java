package pantheon.ctms.j08.service;

import java.util.List;
import java.util.Map;

public interface DMCJ08Service {
	
	public List<Map<String, Object>> selectTaskUserInfo(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> standardTimeList(Map<String, String> map) throws Exception;	
	
	public List<Map<String, Object>> selectUserRoleInfo(Map<String, String> map) throws Exception;	
	
	public List<Map<String, Object>> selectUserRoleId(Map<String, String> map) throws Exception;	
	
	public List<Map<String, Object>> selectOverlapUserInfo(Map<String, String> map) throws Exception;	
	
	public List<Map<String, Object>> selectRoleId(Map<String, String> map) throws Exception;	
	
	public void insertTaskUserInfo(List<Map<String, Object>> list) throws Exception;
	
	public void insertTaskUser(List<Map<String, Object>> list) throws Exception;
	
	
	
	public void deleteTaskUserByRole(List<Map<String, Object>> list) throws Exception;
	
	
	
}
