package pantheon.ctms.c01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.c01.dao.CTMC01DAO;
import pantheon.ctms.c01.service.CTMC01Service;

@Service("CTMC01Service")
public class CTMC01ServiceImpl implements CTMC01Service{

	@Resource(name = "CTMC01DAO")
	private CTMC01DAO CTMC01DAO;
	
	@Override
	public List<Map<String, Object>> selectInvestInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMC01DAO.selectInvestInfoList(map);
	}

}
