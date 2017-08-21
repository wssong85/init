package pantheon.edc.f01.service;

import java.util.List;
import java.util.Map;

public interface EDCF01Service {
	
	public List<Map<String, Object>> selectEdcCrInsttForm(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectEdcCrSubject(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectEdcCfVisit(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectEdcCfGroup(Map<String, Object> param) throws Exception;
	
	public void updateSdvSttusBySite(List<Map<String, Object>> param) throws Exception;
	
	public void updateSdvCmplSttusBySite(List<Map<String, Object>> param) throws Exception;
	
}
