package pantheon.ctms.j10.service;

import java.util.List;
import java.util.Map;

public interface DMCJ10Service {
	
	public List<Map<String, Object>> selectContractList(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectCommonCodeListByIRB_AT(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectCommonCodeListByCNTRCT_SE(Map<String, String> map) throws Exception;
	
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(Map<String, String> map) throws Exception;

}
