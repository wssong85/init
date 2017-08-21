package pantheon.ctms.j10.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.j10.dao.DMCJ10DAO;
import pantheon.ctms.j10.service.DMCJ10Service;

@Service("DMCJ10Service")
public class DMCJ10ServiceImpl implements DMCJ10Service{

	@Resource(name = "DMCJ10DAO")
	private DMCJ10DAO DMCJ10DAO;

	@Override
	public List<Map<String, Object>> selectContractList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ10DAO.selectContractList(map);
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeListByIRB_AT(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ10DAO.selectCommonCodeListByIRB_AT(map);
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeListByCNTRCT_SE(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ10DAO.selectCommonCodeListByCNTRCT_SE(map);
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeListBySTTUS(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ10DAO.selectCommonCodeListBySTTUS(map);
	}

	
	
	

}

	



















