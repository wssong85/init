package pantheon.ctms.j01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.ctms.j01.dao.DMCJ01DAO;
import pantheon.ctms.j01.service.DMCJ01Service;


@Service("DMCJ01Service")
public class DMCJ01ServiceImpl implements DMCJ01Service{

	@Resource(name = "DMCJ01DAO")
	private DMCJ01DAO dmcj01DAO;

	@Override
	public List<Map<String, Object>> selectTaskRegStatusList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj01DAO.selectTaskRegStatusList(map);
	}

	@Override
	public List<Map<String, Object>> selectTaskProgressList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj01DAO.selectTaskProgressList(map);
	}

	@Override
	public List<Map<String, Object>> selectTaskNoticeList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj01DAO.selectTaskNoticeList(map);
	}


}



