package pantheon.ctms.r01.service;

import java.util.List;
import java.util.Map;

public interface CTMR01Service {
	
	public List<Map<String, Object>> selectProtocolList(Map<String, String> map) throws Exception;
	
	/**
	 * Protocol 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertProtocolList(List<Map<String, Object>> list) throws Exception;

}
