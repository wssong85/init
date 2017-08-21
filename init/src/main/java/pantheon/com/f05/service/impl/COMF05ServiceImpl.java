package pantheon.com.f05.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.f05.dao.COMF05DAO;
import pantheon.com.f05.service.COMF05Service;

@Service("COMF05Service")
public class COMF05ServiceImpl implements COMF05Service{

	@Resource(name ="COMF05DAO")
	private COMF05DAO comf05DAO;
	
//	@Resource(name="databaseSecurityMetadataSource")
//	private EgovReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource; 
	
	@Override
	public List<Map<String, Object>> selectCmProgrmConectListByPk(Map<String, String> map) throws Exception {
		return comf05DAO.selectCmProgrmConectListByPk(map);
	}

	@Override
	public int selectCmProgrmConectListCountByPk(Map<String, String> map)throws Exception {
		return comf05DAO.selectCmProgrmConectListCountByPk(map);
	}

	@Override
	public void insertCmProgrmConect(Map<String, String> map) throws Exception {
//		HttpSession hs = Util.getHttpSession();
		
		comf05DAO.insertCmProgrmConect(map);
	}
	
}
