package pantheon.edc.g01.service;

import java.util.List;
import java.util.Map;

public interface EDCG01Service {
	
	public List<Map<String, Object>> selectCsList(Map<String, Object> param) throws Exception;
	
	public void updateEdcCfVriablByPvCraCnfirmCode(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectDicaryInfo(Map<String, Object> param) throws Exception;
	
	public void insertCmQueryByCra(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectDistinctAbnRctList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectDistinctDAbnRct(Map<String, Object> param) throws Exception;
}
