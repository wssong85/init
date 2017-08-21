package pantheon.sdb.f09.service;

import java.util.List;
import java.util.Map;

public interface SDBF09Service {
	public List<Map<String, String>> selectSopPart(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception;
	public void insertSopInfo(Map<String, String> param) throws Exception;
	public void deleteSopInfo(Map<String, String> param) throws Exception;
}
