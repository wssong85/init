package pantheon.ctms.j02.service;

import java.util.List;
import java.util.Map;

public interface DMCJ02Service {
	
	public List<Map<String, Object>> selectAllNoticeList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectNoticeByPopup(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectRoleId(Map<String, String> map) throws Exception;
	
	public void insertNoticeManageData(List<Map<String, Object>> list) throws Exception;	
	
	public void insertNoticeAuthor(List<Map<String, Object>> list) throws Exception;	
	
}
