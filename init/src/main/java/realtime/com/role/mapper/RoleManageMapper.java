package realtime.com.role.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("RoleManageMapper")
public interface RoleManageMapper {

	List<Map<String, Object>> selectTbProgramList(Map<String, Object> map);

	void deleteTbProgram(Map<String, Object> iMap);

	void updateTbProgram(Map<String, Object> iMap);

	void insertTbProgram(Map<String, Object> iMap);

	List<Map<String, Object>> selectTbMenuList(Map<String, Object> map);

	void insertTbMenu(Map<String, Object> iMap);

	void updateTbMenu(Map<String, Object> iMap);

	void deleteTbMenu(Map<String, Object> iMap);
	
	List<Map<String, Object>> selectTbUpMenuList(Map<String, Object> map);

	void insertTbUpMenu(Map<String, Object> iMap);

	void updateTbUpMenu(Map<String, Object> iMap);

	void deleteTbUpMenu(Map<String, Object> iMap);

	void deleteTbRoles(Map<String, Object> iMap);

	void updateTbRoles(Map<String, Object> iMap);

	void insertTbRoles(Map<String, Object> iMap);

	List<Map<String, Object>> selectTbRolesList(Map<String, Object> map);
	
	List<Map<String, Object>> selectTbMenuListForRoleCombine(Map<String, Object> map);
	
	List<Map<String, Object>> selectTbMenuProgramByRole(Map<String, Object> map);

	List<Map<String, Object>> selectTbMenuProgramListByRole(Map<String, Object> map);

	void deleteTbMenuProgramByRole(Object object);

	void insertTbMenuProgram(Map<String, Object> iMap);
	
	List<Map<String, Object>> selectTbMenuProgramForUserMenu(String str);
	
}
