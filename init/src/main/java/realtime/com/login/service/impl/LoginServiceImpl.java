package realtime.com.login.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.login.mapper.LoginMapper;
import realtime.com.login.service.LoginService;

@Service("LoginService")
public class LoginServiceImpl implements LoginService{

	@Resource(name = "LoginMapper")
	private LoginMapper loginMapper;
	
	@Override
	public Map<String, Object> actionLogin(Map<String, Object> map) throws Exception {
		return loginMapper.selectTbUsersByPk(map);
	}
}
