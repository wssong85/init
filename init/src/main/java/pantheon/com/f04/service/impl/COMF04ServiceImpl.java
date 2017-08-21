package pantheon.com.f04.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.f04.dao.COMF04DAO;
import pantheon.com.f04.service.COMF04Service;

@Service("COMF04Service")
public class COMF04ServiceImpl implements COMF04Service{
	
	@Resource(name = "COMF04DAO")
	private COMF04DAO comf04DAO;
	
	@Override
	public void insertCmSysConectByLogin(Map<String, String> map)
			throws Exception {
		comf04DAO.insertCmSysConectByLogin(map);		
	}

	@Override
	public int selectCmSysConectListCountByCondition(Map<String, String> map)
			throws Exception {
		return comf04DAO.selectCmSysConectListCountByCondition(map);
	}

	@Override
	public List<Map<String, Object>> selectCmSysConectListByCondition(
			Map<String, String> map) throws Exception {
		return comf04DAO.selectCmSysConectListByCondition(map);
	}

}
