package realtime.shopping.user.service;

import java.util.Map;

public interface UserService {

	int apiSelectTbUserCountForCheck(Map<String, Object> map);

	Map<String, Object> apiSelectTbUserByPK(Map<String, Object> map);
}
