package pantheon.com.a02.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.a02.dao.COMA02DAO;
import pantheon.com.a02.service.COMA02Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMA02Service")
public class COMA02ServiceImpl implements COMA02Service{

	@Resource(name = "COMA02DAO")
	private COMA02DAO coma02DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name = "ATRAIL_CM_PROGRM")
	protected EgovPropertyService atrailCmProgrm;
	
	@Resource(name = "ATRAIL_CM_BUTTON")
	protected EgovPropertyService atrailCmButton;
	
	@Resource(name = "ATRAIL_CM_ROLE_LMTT")
	protected EgovPropertyService atrailCmRoleLmtt;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public List<Map<String, Object>> selectCmProgrm(Map<String, String> map) throws Exception {
		return coma02DAO.selectCmProgrm(map);
	}

	@Override
	public void insertCmProgrm(List<Map<String, Object>> list) throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(coma02DAO.selectCmProgrmForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0201.msg.1"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				coma02DAO.insertCmProgrm(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmProgrm, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				if(coma02DAO.selectCmButtonForDelete(iMap) > 0 && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0201.msg.2"));
				}
				
				if(coma02DAO.selectCmProgrmForDulCheckByEssntlAt(iMap) > 0 && iMap.get("USE_YN") != null && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmProgrm, null, null);
				coma02DAO.updateCmProgrmByPk(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				if(coma02DAO.selectCmButtonForDelete(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0201.msg.2"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmProgrm, null, null);
				coma02DAO.updateCmProgrmForDelete(iMap);
				
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectCmButtonByProgrmId(Map<String, String> map) throws Exception {
		
		if(true) {
			throw new UnsupportedOperationException();
		}
		
		return coma02DAO.selectCmButtonByProgrmId(map);
		
	}

	@Override
	public void insertCmButton(List<Map<String, Object>> list) throws Exception {
		
		if(true) {
			throw new UnsupportedOperationException();
		}
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(coma02DAO.selectCmButtonForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0201.msg.3"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				coma02DAO.insertCmButton(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmButton, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmButton, null, null);
				coma02DAO.updateCmButton(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmButton, null, null);
				coma02DAO.updateCmButtonForDelete(iMap);
				
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectCmRoleLmttByProgrmId(Map<String, Object> map) throws Exception {
		return coma02DAO.selectCmRoleLmttByProgrmId(map);
	}

	@Override
	public void insertCmRoleLmttByPk(List<Map<String, Object>> list) throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		List<Map<String, Object>> listProgrm = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listRole = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapTmp = null;
		
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("GUBUN").equals("PROGRM_ITEM")) {
				
				mapTmp = new HashMap<String, Object>();
				
				for(String mapkey : iMap.keySet()) {
					mapTmp.put(mapkey, iMap.get(mapkey));
				}
				
				listProgrm.add(mapTmp);
				
			} else if(iMap.get("GUBUN").equals("ROLE_ITEM")){
				
				mapTmp = new HashMap<String, Object>();
				
				for(String mapkey : iMap.keySet()) {
					mapTmp.put(mapkey, iMap.get(mapkey));
				}
				
				listRole.add(mapTmp);
				
			}
			
		}
		
		//제한권한 추가,수정
		if(listRole.size() > 0) {
			
			for(Map<String, Object> iMap : listProgrm) {
				
				for(Map<String, Object> jMap : coma02DAO.selectCmRoleLmttByProgrmId(iMap)) {
					
					comz06Service.createCmDtaAtrailForDeleteByObject(jMap, atrailCmRoleLmtt, null, null);
					
				}
				
				coma02DAO.deleteCmRoleLmttByProgrmId(iMap);
				
			}
			
			for(Map<String, Object> iMap : listProgrm) {
				
				for(Map<String, Object> jMap : listRole) {
					
					jMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
					jMap.put("PROGRM_ID", iMap.get("PROGRM_ID"));
					
					coma02DAO.insertCmRoleLmttByPk(jMap);
					
					//Audit 신규 이력
					comz06Service.createCmDtaAtrailForInsertByObject(jMap, atrailCmRoleLmtt, null, null);
					
				}
				
			}
			
		}
		//프로그램화면 제한 권한 삭제
		else {
			
			for(Map<String, Object> iMap : listProgrm) {
				
				//삭제 이력
				for(Map<String, Object> jMap : coma02DAO.selectCmRoleLmttByProgrmId(iMap)) {
					
					comz06Service.createCmDtaAtrailForDeleteByObject(jMap, atrailCmRoleLmtt, null, null);
					
				}
				
				//제한 권한 삭제
				coma02DAO.deleteCmRoleLmttByProgrmId(iMap);
				
			}
			
		}
		
		
	}

	@Override
	public List<Map<String, Object>> selectCmRoleByFixingAtForComboBox(Map<String, String> map) throws Exception {
		return coma02DAO.selectCmRoleByFixingAtForComboBox(map);
	}

}