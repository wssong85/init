package pantheon.sdb.f08.service;

import java.util.List;
import java.util.Map;



public interface SDBF08Service {

	public List<Map<String, Object>> selectReconciliationList(Map<String, String> map) throws Exception;

}
