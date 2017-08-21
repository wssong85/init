package pantheon.iwrs.a01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.iwrs.a01.dao.IWRA01DAO;
import pantheon.iwrs.a01.service.IWRA01Service;

@Service("IWRA01Service")
public class IWRA01ServiceImpl implements IWRA01Service {
	@Resource(name = "IWRA01DAO")
	private IWRA01DAO iwra01Dao;
	
	@Override
	public List<Map<String, String>> selectNotification() throws Exception{
		return iwra01Dao.selectNotification();
	}
}
