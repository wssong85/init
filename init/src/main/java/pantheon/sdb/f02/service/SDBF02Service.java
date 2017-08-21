package pantheon.sdb.f02.service;

import java.util.List;
import java.util.Map;

public interface SDBF02Service {
	public List<Map<String, String>> selectLiteratureList(Map<String, String> param) throws Exception;
	public void insertLiteratureInfo(Map<String, String> param) throws Exception;
}
