package pantheon.com.a01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.a01.dao.COMA01DAO;
import pantheon.com.a01.service.COMA01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.sample.service.SampleService;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMA01Service")
public class COMA01ServiceImpl implements COMA01Service{

	@Resource(name = "COMA01DAO")
	private COMA01DAO coma01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COMA01Service")
	private COMA01Service coma01Service;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;

	@Resource(name = "ATRAIL_CM_MENU")
	protected EgovPropertyService atrailCmMenu;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "SampleService")
    private SampleService sampleService;
    
	
	@Override
	public int deleteCmMenuForMenuId(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException("UnsupportedOperationException");
	}

	@Override
	public int updateCmMenuForMenuId(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException("UnsupportedOperationException");
	}

	@Override
	public int deleteCmMenuForUpperMenuId(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException("UnsupportedOperationException");
	}

	@Override
	public int updateCmMenuForUpperMenuId(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException("UnsupportedOperationException");
	}

	@Override
	public List<Map<String, Object>> selectCmMenuListByUpperMenuId(Map<String, String> map) throws Exception {
		return coma01DAO.selectCmMenuListByUpperMenuId(map);
	}

	@Override
	public List<Map<String, Object>> selectCmMenuListForUpperMenuId(Map<String, String> map) throws Exception {
		//메시지 테스트
//		sampleService.insertSample(null);
//		if(true) {
//			throw new Exception("GG");
//			throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
//		}
		
		return coma01DAO.selectCmMenuListForUpperMenuId(map);
	}

	@Override
	public void insertCmMenuForUpperMenu(List<Map<String, Object>> list) throws Exception {
//		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(coma01DAO.selectCmMenuForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.2"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_ENG_NM")))) {
					iMap.put("MENU_ENG_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_JAPAN_NM")))) {
					iMap.put("MENU_JAPAN_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_CHINA1_NM")))) {
					iMap.put("MENU_CHINA1_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_CHINA2_NM")))) {
					iMap.put("MENU_CHINA2_NM", iMap.get("MENU_NM"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				coma01DAO.insertCmMenu(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmMenu, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				if(coma01DAO.selectCmMenuForDelete(iMap) > 0 && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.3"));
				}
				
				if(coma01DAO.selectCmProgrmForDulCheckByEssntlAt(iMap) > 0 && iMap.get("USE_YN") != null && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmMenu, null, null);
				coma01DAO.updateCmMenuForUpperMenuId(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				if(coma01DAO.selectCmMenuForDelete(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.3"));
				}
				
				if(coma01DAO.selectCmProgrmForDulCheckByEssntlAt(iMap) > 0 && iMap.get("USE_YN") != null && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmMenu, null, null);
				coma01DAO.updateCmMenuForDelete(iMap);
				
			}
		}
	}

	@Override
	public void insertCmMenuByUpperMenu(List<Map<String, Object>> list)throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(coma01DAO.selectCmMenuForDupCheck(iMap) > 0) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.2"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_ENG_NM")))) {
					iMap.put("MENU_ENG_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_JAPAN_NM")))) {
					iMap.put("MENU_JAPAN_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_CHINA1_NM")))) {
					iMap.put("MENU_CHINA1_NM", iMap.get("MENU_NM"));
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("MENU_CHINA2_NM")))) {
					iMap.put("MENU_CHINA2_NM", iMap.get("MENU_NM"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				coma01DAO.insertCmMenu(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmMenu, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				if(coma01DAO.selectCmProgrmForDulCheckByEssntlAt(iMap) > 0 && iMap.get("USE_YN") != null && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmMenu, null, null);
				coma01DAO.updateCmMenuForMenuId(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				if(coma01DAO.selectCmProgrmForDulCheckByEssntlAt(iMap) > 0 && iMap.get("USE_YN") != null && "N".equals(iMap.get("USE_YN"))) {
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("coma0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmMenu, null, null);
				coma01DAO.updateCmMenuForDelete(iMap);
				
			}
		}
	}

}