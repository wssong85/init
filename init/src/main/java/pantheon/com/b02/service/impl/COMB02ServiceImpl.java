package pantheon.com.b02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.b02.dao.COMB02DAO;
import pantheon.com.b02.service.COMB02Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMB02Service")
public class COMB02ServiceImpl implements COMB02Service{
	
	@Resource(name = "COMB02DAO")
	private COMB02DAO comb02DAO;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;

	@Resource(name = "ATRAIL_CM_ROLE_AUTHOR")
	protected EgovPropertyService atrailCmRoleAuthor;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
//	@Resource(name="databaseSecurityMetadataSource")
//	private EgovReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource; 
	
	@Override
	public List<Map<String, Object>> selectCmMenuForDefaultGrid(Map<String, String> map) throws Exception {
		
		//제한
		if("0".equals(map.get("LOAD_FLAG"))) {
			
			return comb02DAO.selectCmMenuForDefaultGridForFixingAt(map);
			
		}
		//일반
		else {
			
			return comb02DAO.selectCmMenuForDefaultGrid(map);
			
		}
		
	}
	
	@Override
	public List<Map<String, Object>> selectCmRoleAuthorByRoleId(Map<String, String> map) throws Exception {
		
		//제한
		if("0".equals(map.get("LOAD_FLAG"))) {
			
			return comb02DAO.selectCmRoleAuthorByRoleIdForFixingAt(map);
			
		}
		//일반
		else {
			
			return comb02DAO.selectCmRoleAuthorByRoleId(map);
			
		}
		
	}

	@Override
	public void insertCmRoleAuthorByRoleId(List<Map<String, Object>> list) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		List<Map<String, Object>> oldList = null;
		
		//제한
		if("0".equals(String.valueOf(list.get(0).get("LOAD_FLAG")))) {
			oldList = comb02DAO.selectCmRoleAuthorListByRoleIdAndFixingAtY(String.valueOf(list.get(0).get("ROLE_ID")));
		} 
		//일반
		else {
			oldList = comb02DAO.selectCmRoleAuthorListByRoleIdAndFixingAtN(String.valueOf(list.get(0).get("ROLE_ID")));
		}
				
		
		for(Map<String, Object> iMap : oldList) {
			
			comz06Service.createCmDtaAtrailForDeleteByObject(iMap, atrailCmRoleAuthor, null, null);
			comb02DAO.deleteCmRoleAuthorByRoleId(iMap);
			
		}
		
		for(Map<String, Object> iMap : list) {
			
			if(!iMap.containsKey("PROGRM_ID")) {
				
				continue;
				
			}
			
			comb02DAO.insertCmRoleAuthorByRoleId(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmRoleAuthor, null, null);
			
		}
		
		List<Map<String, Object>> listHomeCheck = comb02DAO.selectCmProgrmForDupCheckHome(String.valueOf(list.get(0).get("ROLE_ID")));
		
		//구분값을 INSERT 값으로 넣는다.
		for(Map<String, Object> jMap : listHomeCheck) {
			
			jMap.put("GUBUN", "INSERT");
			
		}
		
		for(Map<String, Object> jMap : listHomeCheck) {
			
			for(Map<String, Object> iMap : list) {
				
				//만약 iMap에서 PROGRM_ID(HOME)가 있다면 인서트 하지 않도록 구분값 변경
				if(jMap.get("PROGRM_ID").equals(iMap.get("PROGRM_ID"))) {
				
					jMap.put("GUBUN", "");
					
				}
				
			}
			
		}
		
		for(Map<String, Object> jMap : listHomeCheck) {
			
			if("INSERT".equals(jMap.get("GUBUN"))) {
				
				jMap.put("ROLE_ID", String.valueOf(list.get(0).get("ROLE_ID")));
				jMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				jMap.put("USE_YN", "Y");
				comb02DAO.insertCmRoleAuthorByRoleId(jMap);
				comz06Service.createCmDtaAtrailForInsertByObject(jMap, atrailCmRoleAuthor, null, null);
				
			}
			
		}
		
		//스프링 시큐리티 url mapping 권한 재설정
//		databaseSecurityMetadataSource.reload();
		
	}



	@Override
	public List<Map<String, String>> selectCmRoleByFixingAtNForComboBox(Map<String, String> map) throws Exception {
		return comb02DAO.selectCmRoleByFixingAtNForComboBox(map);
	}

	@Override
	public List<Map<String, String>> selectCmRoleByFixingAtYForComboBox(Map<String, String> map) throws Exception {
		return comb02DAO.selectCmRoleByFixingAtYForComboBox(map);
	}
}