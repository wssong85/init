package pantheon.com.f01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.intercept.EgovReloadableFilterInvocationSecurityMetadataSource;
import pantheon.com.f01.dao.COMF01DAO;
import pantheon.com.f01.service.COMF01Service;
import pantheon.com.i02.service.COMI02Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMF01Service")
public class COMF01ServiceImpl implements COMF01Service{

	@Resource(name = "COMF01DAO")
	private COMF01DAO comf01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COMI02Service")
	private COMI02Service comi02Service;
	
	@Resource(name = "ATRAIL_CM_USER_ROLE")
	protected EgovPropertyService atrailCmUserRole;
	
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrailCmUser;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
//	@Resource(name="databaseSecurityMetadataSource")
//	private EgovReloadableFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource; 
	
	@Override
	public List<Map<String, Object>> selectCmUserListByUser(Map<String, String> map) throws Exception {
		return comf01DAO.selectCmUserListByUser(map);
	}

	@Override
	public int selectCmUserListCountByUser(Map<String, String> map) throws Exception {
		return comf01DAO.selectCmUserListCountByUser(map);
	}

	@Override
	public List<Map<String, Object>> selectCmUserRoleByUserId(Map<String, String> map) throws Exception {
		return comf01DAO.selectCmUserRoleByUserId(map);
	}

	@Override
	public void insertCmUserRoleByUserId(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("CURD").equals("C")) {
				
				if(comf01DAO.selectCmUserRoleForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comf0101.msg.3"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comf01DAO.insertCmUserRoleByUserId(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmUserRole, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmUserRole, null, null);
				comf01DAO.updateCmUserRoleByUserId(iMap);
				
			} else if(iMap.get("CURD").equals("D")) {
				
				comz06Service.createCmDtaAtrailForDeleteByObject(iMap, atrailCmUserRole, null, null);
				comf01DAO.deleteCmUserRoleByUserId(iMap);
				
			}
			
		}
		
		//스프링 시큐리티 url mapping 권한 재설정
//		databaseSecurityMetadataSource.reload();
	}

	@SuppressWarnings("unchecked")
	@Override
	public void insertCmUserForCreate(Map<String, String> map) throws Exception {
		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		map.put("PASSWORD", Util.getStrPasswordRnd());
		
		comf01DAO.insertCmUserForCreate(map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmUser, null, null);
		
		comf01DAO.insertCmUserRoleByUserId((Map<String, Object>)(Object)map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmUserRole, null, null);
		
		if("Y".equals(map.get("SEND"))) {
			comi02Service.updateCmUserForSendTmpMail(map);			
		}
		
		//스프링 시큐리티 url mapping 권한 재설정
//		databaseSecurityMetadataSource.reload();
	}

	@Override
	public void updateCmUserByUserSeCode02(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			
			if("".equals(EgovStringUtil.isNullToString(iMap.get("EMAIL"))) || "".equals(EgovStringUtil.isNullToString(iMap.get("TELNO")))
					|| "".equals(EgovStringUtil.isNullToString(iMap.get("USER_NM")))) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comf0101.msg.6"));
			}
			
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmUser, null, null);
			comf01DAO.updateCmUserByUserSeCode02(iMap);
		}
		
	}
}
