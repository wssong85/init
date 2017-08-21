package pantheon.sdb.f08.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



import pantheon.sdb.f08.dao.SDBF08DAO;
import pantheon.sdb.f08.service.SDBF08Service;

@Service("SDBF08Service")
public class SDBF08ServiceImpl implements SDBF08Service {
	@Resource(name = "SDBF08DAO")
	private SDBF08DAO sdbf08DAO;
	
	
	@Override
	public List<Map<String, Object>> selectReconciliationList(Map<String, String> map) throws Exception{
		
		return sdbf08DAO.selectReconciliationList(map);
	}
}
