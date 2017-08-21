package realtime.com.user.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.user.mapper.UserManageMapper;
import realtime.com.user.service.UserManageService;

@Service("UserManageService")
public class UserManageServiceImpl implements UserManageService {
	
	@Resource(name = "UserManageMapper")
	private UserManageMapper userManageMapper;

	@Override
	public List<Map<String, Object>> selectTbUserList(Map<String, Object> map) throws Exception {
		
		return userManageMapper.selectTbUserList(map);
	}

	@Override
	public void changeTbUser(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> map : list) {
			
			if("C".equals(map.get("CRUD"))) {
				
				userManageMapper.insertTbUser(map);
				userManageMapper.insertTbUserDetail(map);
				
			} else if("U".equals(map.get("CRUD"))) {
				
				userManageMapper.updateTbUserDetail(map);
				
			} else if("D".equals(map.get("CRUD"))) {
				
				userManageMapper.deleteTbUserDetail(map);
				userManageMapper.deleteTbUser(map);
			}
		}
	}
}
