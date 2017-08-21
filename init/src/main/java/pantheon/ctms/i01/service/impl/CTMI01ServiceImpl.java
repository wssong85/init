package pantheon.ctms.i01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.i01.dao.CTMI01DAO;
import pantheon.ctms.i01.service.CTMI01Service;

@Service("CTMI01Service")
public class CTMI01ServiceImpl implements CTMI01Service{

    @Resource(name = "CTMI01DAO")
	private CTMI01DAO CTMI01DAO;
	
	@Override
	public List<Map<String, Object>> selectCalMilestoneList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMI01DAO.selectCalMilestoneList(map);
	}
	

}
