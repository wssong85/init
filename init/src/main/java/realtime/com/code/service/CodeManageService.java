package realtime.com.code.service;

import java.util.List;
import java.util.Map;

public interface CodeManageService {

	List<Map<String, Object>> selectTbGroupCodeList(Map<String, Object> map) throws Exception;

	void multiTbGroupCode(List<Map<String, Object>> list) throws Exception;

	List<Map<String, Object>> selectTbDetailCodeList(Map<String, Object> map) throws Exception;

	void multiTbDetailCode(List<Map<String, Object>> list) throws Exception;

}
