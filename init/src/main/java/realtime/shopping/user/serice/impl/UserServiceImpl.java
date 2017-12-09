package realtime.shopping.user.serice.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.user.mapper.UserManageMapper;
import realtime.shopping.user.mapper.UserMapper;
import realtime.shopping.user.serice.UserService;

@Service("UserService")
public class UserServiceImpl implements UserService{

	@Resource(name = "UserMapper")
	private UserMapper userMapper;

	@Override
	public int apiSelectTbUserCountForCheck(Map<String, Object> map) {
		return userMapper.selectTbUserCountForCheck(map);
	}

	
}
