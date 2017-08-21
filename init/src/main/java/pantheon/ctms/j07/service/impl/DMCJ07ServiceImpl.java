package pantheon.ctms.j07.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.j07.dao.DMCJ07DAO;
import pantheon.ctms.j07.service.DMCJ07Service;

@Service("DMCJ07Service")
public class DMCJ07ServiceImpl implements DMCJ07Service{

	@Resource(name = "DMCJ07DAO")
	private DMCJ07DAO DMCJ07dao;
	
	@Resource(name = "ATRAIL_DMC_TASK_ROLE")
	protected EgovPropertyService atrailDmcTaskRole;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Override
	public List<Map<String, Object>> selectRoleByProgAndBtnList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ07dao.selectRoleByProgAndBtnList(map);
	}

	@Override
	public List<Map<String, Object>> selectTaskByBtnList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ07dao.selectTaskByBtnList(map);
	}

	@Override
	public void insertTaskByBtnInfo(List<Map<String, Object>> list) throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("ROLE_ID"  , String.valueOf(list.get(0).get("ROLE_ID"  )));
		map.put("PROGRM_ID", String.valueOf(list.get(0).get("PROGRM_ID")));
		map.put("TASK_SN"  , String.valueOf(list.get(0).get("TASK_SN"  )));

		List<Map<String, Object>> oldList = DMCJ07dao.selectOldTaskByBtnList(map);
		
		if(oldList.size() > 0){
			for(Map<String, Object> iMap : oldList) {
				comz06Service.createCmDtaAtrailForDeleteByObject(iMap, atrailDmcTaskRole, null, null);
			}
			DMCJ07dao.deleteOldTaskByBtnList(map);
		}
		
		for(Map<String, Object> iMap : list) {
			if(!iMap.containsKey("PROGRM_ID")) {
				continue;
			}
			
			DMCJ07dao.insertTaskByBtnList(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailDmcTaskRole, null, null);
		}
		
	}

}
