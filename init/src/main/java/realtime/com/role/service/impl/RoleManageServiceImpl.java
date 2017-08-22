package realtime.com.role.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.role.mapper.RoleManageMapper;
import realtime.com.role.service.RoleManageService;

@Service("RoleManageService")
public class RoleManageServiceImpl implements RoleManageService{

	@Resource(name = "RoleManageMapper")
	private RoleManageMapper roleManageMapper;

	@Override
	public void multiTbProgram(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.insertTbProgram(iMap);;
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.updateTbProgram(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.deleteTbProgram(iMap);
				
			}
			
		}
	}

	@Override
	public List<Map<String, Object>> selectTbProgramList(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbProgramList(map);
	}

	@Override
	public List<Map<String, Object>> selectTbMenuList(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbMenuList(map);
	}

	@Override
	public void multiTbMenu(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.insertTbMenu(iMap);;
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.updateTbMenu(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.deleteTbMenu(iMap);
				
			}
			
		}
	}

	@Override
	public List<Map<String, Object>> selectTbUpMenuList(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbUpMenuList(map);
	}

	@Override
	public void multiTbUpMenu(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.insertTbUpMenu(iMap);;
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.updateTbUpMenu(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.deleteTbUpMenu(iMap);
				
			}
			
		}
	}

	@Override
	public List<Map<String, Object>> selectTbRolesList(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbRolesList(map);
	}

	@Override
	public void multiTbRoles(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.insertTbRoles(iMap);;
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.updateTbRoles(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				roleManageMapper.deleteTbRoles(iMap);
				
			}
			
		}
		
	}

	@Override
	public List<Map<String, Object>> selectTbMenuListForRoleCombine(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbMenuListForRoleCombine(map);
	}

	@Override
	public List<Map<String, Object>> selectTbMenuProgramListByRole(Map<String, Object> map) throws Exception {
		return roleManageMapper.selectTbMenuProgramListByRole(map);
	}

	@Override
	public void insertTbMenuProgramForAll(List<Map<String, Object>> list) throws Exception {
		
		int count = 0;
		for(Map<String, Object> iMap : list) {
			
			if(count == 0) {
				roleManageMapper.deleteTbMenuProgramByRole(iMap);
			}
			
			roleManageMapper.insertTbMenuProgram(iMap);
			
			count++;
		}
		
	}
	
}