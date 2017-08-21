package pantheon.sdb.d02.service;

import java.util.List;
import java.util.Map;

public interface SDBD02Service {
	public int selectReportDelayCount(Map<String, String> param) throws Exception;
	public List<Map<String, String>> selectReportDelayList(Map<String, String> param) throws Exception;
}
