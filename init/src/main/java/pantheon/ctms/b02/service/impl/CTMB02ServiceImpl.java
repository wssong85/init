package pantheon.ctms.b02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import pantheon.ctms.b02.dao.CTMB02DAO;
import pantheon.ctms.b02.service.CTMB02Service;


@Service("CTMB02Service")
public class CTMB02ServiceImpl implements CTMB02Service{

	@Resource(name = "CTMB02DAO")
	private CTMB02DAO ctmb02DAO;

	@Override
	public List<Map<String, Object>> selectPmsTask_NoList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb02DAO.selectPmsTask_NoList(map);
	}

	@Override
	public List<Map<String, Object>> selectPmsSummaryGrid(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb02DAO.selectPmsSummaryGrid(map);
	}

	@Override
	public List<Map<String, Object>> selectPmsProtocolGrid(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb02DAO.selectPmsProtocolGrid(map);
	}

	@Override
	public List<Map<String, Object>> selectPmsAnnualGrid(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmb02DAO.selectPmsAnnualGrid(map);
	}

	@Override
	public List<Map<String, Object>> selectPmsStatusGrid(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmb02DAO.selectPmsStatusGrid(map);
	}



	

				
}

	
		
	
	
	



	



















