/**
 *  @author yak3142
 *
 */
package pantheon.edc.a01.service;

import java.util.List;
import java.util.Map;

public interface EDCA01Service{
	
	public List<Map<String, Object>> selectTaskList(Map<String, Object> map) throws Exception;
	
	public String selectCmProgrmForHomeMenu(Map<String, Object> map) throws Exception;
	
	public int selectCtmsDmcTaskRoleForDupCheck(Map<String, String> map) throws Exception;
	
}