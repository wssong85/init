package pantheon.edc.a01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.edc.a01.dao.EDCA01DAO;
import pantheon.edc.a01.service.EDCA01Service;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("EDCA01Service")
public class EDCA01ServiceImpl extends EgovAbstractServiceImpl implements EDCA01Service{
	
	@Resource(name = "EDCA01DAO")
    private EDCA01DAO edca01DAO;

	@Override
	public List<Map<String, Object>> selectTaskList(Map<String, Object> param) throws Exception {
		param.put("USER_ID", Util.getUserMap().get("USER_ID"));
		return edca01DAO.selectTaskList(param);
	}

	@Override
	public String selectCmProgrmForHomeMenu(Map<String, Object> param)throws Exception {
		return edca01DAO.selectCmProgrmForHomeMenu(param);
	}

	@Override
	public int selectCtmsDmcTaskRoleForDupCheck(Map<String, String> map) throws Exception {
		return edca01DAO.selectCtmsDmcTaskRoleForDupCheck(map);
	}
	
	
	

}
