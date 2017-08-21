package pantheon.ctms.b03.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;













import javax.annotation.Resource;

import org.springframework.stereotype.Service;










import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.b03.dao.CTMB03DAO;
import pantheon.ctms.b03.service.CTMB03Service;



@Service("CTMB03Service")
public class CTMB03ServiceImpl implements CTMB03Service{
	@Resource(name = "CTMB03DAO")
	private CTMB03DAO ctmb03DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMS_NIS_MAX")
	private EgovIdGnrService ctmsNisTaskMax;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_TO_NIS_TASK")
	protected EgovPropertyService atrailNisTask;
	
	@Override
	public List<Map<String, Object>> selectNISTask_NoList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb03DAO.selectNISTask_NoList(map);
	}

	@Override
	public List<Map<String, Object>> selectAssignmentbyNisGrid(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmb03DAO.selectAssignmentbyNisGrid(map);
	}

	@Override
	public void insertAssignmentbyNisGrid(List<Map<String, Object>> list)
			throws Exception {
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")) {
				iMap.put("SN", ctmsNisTaskMax.getNextStringId());
				ctmb03DAO.insertAssignmentbyNisGrid(iMap); 				
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailNisTask, null, null);
			}else if(iMap.get("CRUD").equals("D")){
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailNisTask, null, null);
				ctmb03DAO.deleteAssignmentbyNisGrid(iMap);
			}else{
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailNisTask, null, null);
				ctmb03DAO.updateAssignmentbyNisGrid(iMap);
				
			}
			
		}	
		
	}

	@Override
	public List<Map<String, Object>> selectNisStatusGrid(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmb03DAO.selectNisStatusGrid(map);
	}	
	
}
