package pantheon.ctms.r01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.r01.dao.CTMR01DAO;
import pantheon.ctms.r01.service.CTMR01Service;

@Service("CTMR01Service")
public class CTMR01ServiceImpl implements CTMR01Service{

	@Resource(name = "CTMR01DAO")
	private CTMR01DAO ctmr01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMS_PROTOCOL_MAX")
	private EgovIdGnrService ctmsProtocolMax;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CM_PROTOCOL")
	protected EgovPropertyService atrailProtocol;


	@Override
	public List<Map<String, Object>> selectProtocolList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmr01DAO.selectProtocolList(map);
	}

	@Override
	public void insertProtocolList(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")) {
				iMap.put("SN", ctmsProtocolMax.getNextStringId());
				ctmr01DAO.insertProtocolList(iMap); 
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailProtocol, null, null);
			}else if(iMap.get("CRUD").equals("D")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailProtocol, null, null);
				ctmr01DAO.deleteProtocolList(iMap); 
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailProtocol, null, null);
				ctmr01DAO.updateProtocolList(iMap); 
				
			}
			
		}		
		
	}
	
	

}

	



















