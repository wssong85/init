package pantheon.edc.j01.service;

import java.util.List;
import java.util.Map;

public interface EDCJ01Service {
	
	public List<Map<String, Object>> selectSaeRepList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> selectSaeRep(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> selectSaeRepAetList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectSaeRepDreAList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectSaeRepDreBList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectSaeRepHstcsList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectSaeRepDreHstcsList(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectSaeRepInspctList(Map<String, Object> param) throws Exception;
	
	public void insertSaeList(Map<String, Object> param) throws Exception;
	

}
