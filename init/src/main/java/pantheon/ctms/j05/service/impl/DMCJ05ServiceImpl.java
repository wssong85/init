package pantheon.ctms.j05.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.j05.dao.DMCJ05DAO;
import pantheon.ctms.j05.service.DMCJ05Service;

@Service("DMCJ05Service")
public class DMCJ05ServiceImpl implements DMCJ05Service{

	@Resource(name = "DMCJ05DAO")
	private DMCJ05DAO DMCJ05DAO;

	@Override
	public List<Map<String, Object>> selectInstitutionInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ05DAO.selectInstitutionInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectInstt_tyByCommonCode(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ05DAO.selectInstt_tyByCommonCode(map);
	}
	
	

	
	
	

}

	



















