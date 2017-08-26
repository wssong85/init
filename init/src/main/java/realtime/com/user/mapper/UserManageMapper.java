package realtime.com.user.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserManageMapper")
public interface UserManageMapper {
	
	List<Map<String, Object>> selectTbUserMetaData();
	
	List<Map<String, Object>> selectTbUserDetailMetaData();
	
	List<Map<String, Object>> selectTbUserList(String id);
	
	Map<String, Object> selectTbUserDetail(String id);

	void insertTbUser(String query);
	
	void insertTbUserDetail(String query);
	
	void updateTbUser(String query);
	
	void updateTbUserDetail(String query);
	
	void deleteTbUser(Map<String, Object> map);
	
	void deleteTbUserDetail(Map<String, Object> map);
}
