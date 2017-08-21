package realtime.com.role.service;

import java.util.List;
import java.util.Map;

public interface RoleManageService {

	void multiTbProgram(List<Map<String, Object>> list) throws Exception;

	List<Map<String, Object>> selectTbProgramList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectTbMenuList(Map<String, Object> map) throws Exception;

	void multiTbMenu(List<Map<String, Object>> list) throws Exception;

	List<Map<String, Object>> selectTbUpMenuList(Map<String, Object> map) throws Exception;

	void multiTbUpMenu(List<Map<String, Object>> list) throws Exception;

	List<Map<String, Object>> selectTbRolesList(Map<String, Object> map) throws Exception;

	void multiTbRoles(List<Map<String, Object>> list) throws Exception;

}
