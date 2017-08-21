package realtime.com.user.service;

import java.util.List;
import java.util.Map;

public interface UserManageService {

	List<Map<String, Object>> selectTbUserList(Map<String, Object> map) throws Exception;
	
	void changeTbUser(List<Map<String, Object>> list) throws Exception;
}
