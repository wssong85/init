package realtime.shopping.user.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.shopping.user.mapper.UserMapper;
import realtime.shopping.user.service.UserService;

@Service("UserService")
public class UserServiceImpl implements UserService{

	@Resource(name = "UserMapper")
	private UserMapper userMapper;

	@Override
	public int apiSelectTbUserCountForCheck(Map<String, Object> map) {
		return userMapper.selectTbUserCountForCheck(map);
	}

	@Override
	public Map<String, Object> apiSelectTbUserByPK(Map<String, Object> map) {
		return userMapper.selectTbUserByPK(map);
	}
}
