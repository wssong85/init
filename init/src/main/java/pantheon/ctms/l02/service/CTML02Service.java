package pantheon.ctms.l02.service;

import java.util.List;
import java.util.Map;

public interface CTML02Service {
	
	/**
	 * 공통코드 리스트 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception;
	
	/**
	 * To do List 그리드 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGridByTodoList(Map<String, String> map) throws Exception;
	
	public void updateGridByTodoList(List<Map<String, Object>> list) throws Exception;

}
