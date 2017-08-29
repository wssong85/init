package realtime.com.user.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserManageMapper")
public interface UserManageMapper {
	
	List<Map<String, Object>> selectTbUserMetaData();
	
	List<Map<String, Object>> selectTbUserDetailMetaData();
	
	List<Map<String, Object>> selectTbUserList(String id);
	
	void insertTbUser(String query);
	
	void updateTbUser(String query);
	
	void deleteTbUser(Map<String, Object> map);
	
	Map<String, Object> selectTbUserDetail(String id);
	
	void insertTbUserDetail(String query);
	
	void updateTbUserDetail(String query);
	
	void deleteTbUserDetail(Map<String, Object> map);
	
	void insertTbAuth(Map<String, Object> map);
	
	void updateTbAuth(Map<String, Object> map);
	
	void deleteTbAuth(Map<String, Object> map);
}
