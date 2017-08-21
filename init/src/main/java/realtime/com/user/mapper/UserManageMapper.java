package realtime.com.user.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserManageMapper")
public interface UserManageMapper {
	
	List<Map<String, Object>> selectTbUserList(Map<String, Object> map);

	void insertTbUser(Map<String, Object> map);
	
	void insertTbUserDetail(Map<String, Object> map);
	
	void updateTbUserDetail(Map<String, Object> map);
	
	void deleteTbUser(Map<String, Object> map);
	
	void deleteTbUserDetail(Map<String, Object> map);
}
