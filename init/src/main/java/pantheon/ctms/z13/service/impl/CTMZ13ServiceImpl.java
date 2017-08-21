package pantheon.ctms.z13.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z13.dao.CTMZ13DAO;
import pantheon.ctms.z13.service.CTMZ13Service;

@Service("CTMZ13Service")
public class CTMZ13ServiceImpl implements CTMZ13Service{

	@Resource(name = "CTMZ13DAO")
	private CTMZ13DAO CTMZ13DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_CTMS_PROGRS_ROLE")
	protected EgovPropertyService atrailCtmsProgrsRole;
	
	@Resource(name = "CTMS_ST_PROGRS_CN_SEQ")
	private EgovIdGnrService ctmsStProgrsCnSeq;
	
	@Override
	public List<Map<String, Object>> selectIRBBasicInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMZ13DAO.selectIRBBasicInfoList(map);
	}

	@Override
	public void insertIRBBasicInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			System.out.println("CRUD check : "+iMap.get("CURD"));
			if(iMap.get("CURD").equals("C")) {
				iMap.put("SN", ctmsStProgrsCnSeq.getNextStringId());
				CTMZ13DAO.insertIRBBasicInfo(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCtmsProgrsRole, null, null);
			}
			else if(iMap.get("CURD").equals("U")) {
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCtmsProgrsRole, null, null);
				CTMZ13DAO.updateIRBBasicInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				comz06Service.createCmDtaAtrailForDeleteByObject(iMap, atrailCtmsProgrsRole, null, null);
				CTMZ13DAO.deleteIRBBasicInfo(iMap);
			}
		}		
	}

	@Override
	public List<Map<String, Object>> selectUserInfoList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMZ13DAO.selectUserInfoList(map);
	}


}
