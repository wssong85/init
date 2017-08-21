package pantheon.sdb.c03.service;

import java.util.List;
import java.util.Map;

public interface SDBC03Service {
	public List<Map<String, String>> selectUploadHistory(Map<String, String> param) throws Exception;
}
