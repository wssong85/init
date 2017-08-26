package realtime.com.user.service;

import java.util.List;
import java.util.Map;

public interface UserManageService {
	
	List<Map<String, Object>> selectTbUserMetaData() throws Exception;

	List<Map<String, Object>> selectTbUserList() throws Exception;
	
	void multiTbUser(List<Map<String, Object>> list) throws Exception;
}
