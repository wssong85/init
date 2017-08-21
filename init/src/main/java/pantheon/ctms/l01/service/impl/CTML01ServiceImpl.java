package pantheon.ctms.l01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.ctms.l01.dao.CTML01DAO;
import pantheon.ctms.l01.service.CTML01Service;

@Service("CTML01Service")
public class CTML01ServiceImpl implements CTML01Service{

	@Resource(name = "CTML01DAO")
	private CTML01DAO CTML01DAO;
	
	@Resource(name = "CTMS_ST_MILESTONE_SEQ")
	private EgovIdGnrService milestoneSeq;
	
	@Override
	public List<Map<String, Object>> selectCommonCodeList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectCommonCodeList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCRAList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectCRAList(map);
	}

	@Override
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectInsttList(map);
	}

	@Override
	public List<Map<String, Object>> selectMileStonePlanList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectMileStonePlanList(map);
	}

	@Override
	public void insertMileStonePlanInfo(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				iMap.put("SN", milestoneSeq.getNextStringId());
				CTML01DAO.insertMileStonePlanInfo(iMap);
			}
			else if(iMap.get("CURD").equals("U")) {
				CTML01DAO.updateMileStonePlanInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				CTML01DAO.deleteMileStonePlanInfo(iMap);
			}
			
		}		
	}
	
	@Override
	public Map<String, Object> selectTaskInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectTaskInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectMilestoneYearInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectMilestoneYearInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectMilestonerPlanBarList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectMilestonerPlanBarList(map);
	}

	@Override
	public Map<String, Object> selectMilestoneColWidthInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTML01DAO.selectMilestoneColWidthInfo(map);
	}

}
