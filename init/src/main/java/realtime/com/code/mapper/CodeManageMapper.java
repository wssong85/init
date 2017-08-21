package realtime.com.code.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CodeManageMapper")
public interface CodeManageMapper {
	
	List<Map<String, Object>> selectTbGroupCodeList(Map<String, Object> map);
	
	void insertTbGroupCode(Map<String, Object> map);
	
	void updateTbGroupCode(Map<String, Object> map);
	
	void deleteTbGroupCode(Map<String, Object> map);
	
	List<Map<String, Object>> selectTbDetailCodeList(Map<String, Object> map);
	
	void insertTbDetailCode(Map<String, Object> map);
	
	void updateTbDetailCode(Map<String, Object> map);

	void deleteTbDetailCode(Map<String, Object> map); 
}
