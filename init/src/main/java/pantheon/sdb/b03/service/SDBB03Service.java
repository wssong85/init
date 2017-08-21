package pantheon.sdb.b03.service;

import java.util.List;
import java.util.Map;


public interface SDBB03Service {
	/**
	 * 의약품 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */

	

	public Map<String, Object> selectOrganInfo(Map<String, String> param) throws Exception;

	public List<Map<String, Object>> selectOrganList(Map<String, String> map) throws Exception;

	public void insertOrganList(Map<String, String> iMap) throws Exception;

	public List<Map<String, Object>> selectOrganListPop(Map<String, String> map)throws Exception;
}
