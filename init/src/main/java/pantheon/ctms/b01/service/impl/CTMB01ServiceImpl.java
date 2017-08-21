package pantheon.ctms.b01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.b01.dao.CTMB01DAO;
import pantheon.ctms.b01.service.CTMB01Service;
import pantheon.ctms.r02.dao.CTMR02DAO;
import pantheon.ctms.r02.service.CTMR02Service;

@Service("CTMB01Service")
public class CTMB01ServiceImpl implements CTMB01Service{

	@Resource(name = "CTMB01DAO")
	private CTMB01DAO ctmb01DAO;

	@Override
	public List<Map<String, Object>> selectClinicalAssignmentList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb01DAO.selectClinicalAssignmentList(map);
	}

	@Override
	public List<Map<String, Object>> selectclinicalbyGrid(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb01DAO.selectclinicalbyGrid(map);
	}

				
}

	
		
	
	
	



	



















