package pantheon.edc.k05.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.k05.dao.EDCK05DAO;
import pantheon.edc.k05.service.EDCK05Service;

@Service("EDCK05Service")
public class EDCK05Servicelmpl implements EDCK05Service{

	@Resource(name = "EDCK05DAO")
	private EDCK05DAO EDCK05DAO;
	
	@Resource(name = "ATRAIL_EDC_CR_TASK")
	protected EgovPropertyService atrailDmcEdcCrTaskRole;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
//	@Resource(name="databaseSecurityMetadataSource")
//	private EgovReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource; 
	
	@Override
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return EDCK05DAO.selectIRBBasicInfoList(map);
	}

	@Override
	public List<Map<String, Object>> selectIRBBasicEndInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return EDCK05DAO.selectIRBBasicEndInfoList(map);
	}

	@Override
	public void insertIRBBasicInfo(List<Map<String, Object>> list) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		map.put("ROLE_ID"  , String.valueOf(list.get(0).get("ROLE_ID"  )));
		map.put("PROGRM_ID", String.valueOf(list.get(0).get("PROGRM_ID")));
		map.put("TASK_SN"  , String.valueOf(list.get(0).get("TASK_SN"  )));

		for(Map<String, Object> iMap : list) {
			System.out.println("CRUD check : "+iMap.get("CURD"));
			if(iMap.get("CURD").equals("U")) {
				
				List<Map<String, Object>> oldList = EDCK05DAO.selectOldTaskByBtnList(map);
				
				if(oldList.size() > 0){
					
					for(Map<String, Object> iMap1 : oldList) {					
						comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailDmcEdcCrTaskRole, null, null);
					}
				}
				
				EDCK05DAO.updateIRBBasicInfo(iMap);
			}
		}	
		//스프링 시큐리티 url mapping 권한 재설정
//		databaseSecurityMetadataSource.reload();
			
	}

}
