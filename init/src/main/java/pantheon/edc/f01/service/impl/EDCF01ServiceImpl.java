package pantheon.edc.f01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.f01.dao.EDCF01DAO;
import pantheon.edc.f01.service.EDCF01Service;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service("EDCF01Service")
public class EDCF01ServiceImpl implements EDCF01Service{

	@Resource(name = "EDCF01DAO")
	EDCF01DAO EDCF01DAO;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_CF_GROUP")
	protected EgovPropertyService atrailEdcCfGroupRole;
	
	public List<Map<String, Object>> selectEdcCrInsttForm(Map<String, Object> param) throws Exception{
//		Map<String, Object> rtnEdcVer = EDCF01DAO.selectGetEdcVer(param);
//		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return (List<Map<String, Object>>)EDCF01DAO.selectEdcCrInsttForm(param);
	}
	
	public List<Map<String, Object>> selectEdcCrSubject(Map<String, Object> param) throws Exception{
//		Map<String, Object> rtnEdcVer = EDCF01DAO.selectGetEdcVer(param);
//		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return (List<Map<String, Object>>)EDCF01DAO.selectEdcCrSubject(param);
	}
	
	public List<Map<String, Object>> selectEdcCfVisit(Map<String, Object> param) throws Exception{
		Map<String, Object> rtnEdcVer = EDCF01DAO.selectGetEdcVer(param);
		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return (List<Map<String, Object>>)EDCF01DAO.selectEdcCfVisit(param);
	}
	
	public List<Map<String, Object>> selectEdcCfGroup(Map<String, Object> param) throws Exception{
		Map<String, Object> rtnEdcVer = EDCF01DAO.selectGetEdcVer(param);
		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return (List<Map<String, Object>>)EDCF01DAO.selectEdcCfGroup(param);
	}
	
	public void updateSdvSttusBySite(List<Map<String, Object>> param) throws Exception{
		for(Map<String, Object> iMap : param){
			List<Map<String, Object>> oldList = EDCF01DAO.selectEdcCfGroupOldList(iMap);
			
			for(Map<String, Object> jMap : oldList){
				comz06Service.createCmDtaAtrailForUpdateByObject(jMap, atrailEdcCfGroupRole, null, null);
			}
			EDCF01DAO.updateSdvSttusBySite(iMap);
		}
	}
	
	public void updateSdvCmplSttusBySite(List<Map<String, Object>> param) throws Exception{
		for(Map<String, Object> iMap : param){
			List<Map<String, Object>> oldList = EDCF01DAO.selectEdcCfGroupOldList(iMap);
			
			for(Map<String, Object> jMap : oldList){
				comz06Service.createCmDtaAtrailForUpdateByObject(jMap, atrailEdcCfGroupRole, null, null);
				EDCF01DAO.updateSdvCmplSttusBySite(jMap);
			}
//			EDCF01DAO.updateSdvCmplSttusBySite(iMap);
		}
	}
}
