package pantheon.ctms.j06.service;

import java.util.List;
import java.util.Map;

public interface DMCJ06Service {
	
	public List<Map<String, Object>> selectRsrchManage(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectRsrUserInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 연구자 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchManage(List<Map<String, Object>> list) throws Exception;

}
