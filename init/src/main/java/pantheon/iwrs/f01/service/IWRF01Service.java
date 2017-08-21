package pantheon.iwrs.f01.service;

import java.util.List;
import java.util.Map;

public interface IWRF01Service {
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception;
	public int selectQueryCnt(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception;
}
