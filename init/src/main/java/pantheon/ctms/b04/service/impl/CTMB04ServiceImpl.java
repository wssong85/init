package pantheon.ctms.b04.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.ctms.b04.dao.CTMB04DAO;
import pantheon.ctms.b04.service.CTMB04Service;

@Service("CTMB04Service")
public class CTMB04ServiceImpl implements CTMB04Service{
	@Resource(name = "CTMB04DAO")
	private CTMB04DAO ctmb04DAO;
	
	@Resource(name = "CTMS_CO_TASK_TRUST_SEQ")
	private EgovIdGnrService ctmsCoTaskTrustSeq;
	
	@Override
	public List<Map<String, Object>> selectTaskTrustInsttList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb04DAO.selectTaskTrustInsttList(map);
	}

	@Override
	public void insertTaskTrustInstt(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("SN",ctmsCoTaskTrustSeq.getNextStringId());
				ctmb04DAO.insertTaskTrustInstt(iMap);
			}else if(iMap.get("CURD").equals("U")){
				ctmb04DAO.updateTaskTrustInstt(iMap);
			}else if(iMap.get("CURD").equals("D")) {
				ctmb04DAO.deleteTaskTrustInstt(iMap); 
			}
		}	
	}
}

