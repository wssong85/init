package pantheon.ctms.r02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.r02.dao.CTMR02DAO;
import pantheon.ctms.r02.service.CTMR02Service;

@Service("CTMR02Service")
public class CTMR02ServiceImpl implements CTMR02Service{

	@Resource(name = "CTMR02DAO")
	private CTMR02DAO ctmr02DAO;

	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMS_PMS_YRYCREPRTL_MAX")
	private EgovIdGnrService ctmsPmsYrycreprtlMax;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CM_PMSRT")
	protected EgovPropertyService atrailPmsRt;
	
	@Override
	public List<Map<String, Object>> selectAnnualReportList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmr02DAO.selectAnnualReportList(map);
	}

	@Override
	public void insertAnnualReport(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("C")) {
				iMap.put("SN", ctmsPmsYrycreprtlMax.getNextStringId());
				ctmr02DAO.insertAnnualReport(iMap); //계약정보
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailPmsRt, null, null);
//				
//				if(true) {
//					throw new Exception("gg");
//				}
			}else if(iMap.get("CRUD").equals("D")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailPmsRt, null, null);
				ctmr02DAO.deleteAnnualReport(iMap);
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailPmsRt, null, null);
				ctmr02DAO.updateAnnualReport(iMap);				
			}			
		}			
	}

	
		
	
	
	

}

	



















