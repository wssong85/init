package pantheon.ctms.j03.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.j03.dao.DMCJ03DAO;
import pantheon.ctms.j03.service.DMCJ03Service;


@Service("DMCJ03Service")
public class DMCJ03ServiceImpl implements DMCJ03Service{

	@Resource(name = "DMCJ03DAO")
	private DMCJ03DAO DMCJ03DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_DMC_EDC_MGR")
	protected EgovPropertyService atrailDmcEdcMgr;
	
	@Resource(name = "ATRAIL_DMC_EDC_ROLE")
	protected EgovPropertyService atrailDmcEdcRole;
	
	//교육관리 seq
	@Resource(name = "CTMS_DMC_EDC_MANAGE_SEQ")
	private EgovIdGnrService edcMgrSeq;

	//교육 역할 seq
	@Resource(name = "CTMS_DMC_EDC_ROLE_SEQ")
	private EgovIdGnrService edcRoleSeq;
	
	@Override
	public int selectEduMgrCount(Map<String, String> map) throws Exception {
		return DMCJ03DAO.selectEduMgrCount(map);
	}

	@Override
	public List<Map<String, Object>> selectEduMgrList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ03DAO.selectEduMgrList(map);
	}

	@Override
	public Map<String, Object> selectEduMgrInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ03DAO.selectEduMgrInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectEduRoleList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ03DAO.selectEduRoleList(map);
	}

	@Override
	public String insertEduInfo(List<Map<String, Object>> list) throws Exception {
		String edcMgrSeqNo = null;
		String taskSn = null;
		System.out.println("list.size() : "+list.size());
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				edcMgrSeqNo = edcMgrSeq.getNextStringId();
				iMap.put("EDC_SN", edcMgrSeqNo);
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				
				taskSn = (String)iMap.get("TASK_SN");
				if(EgovStringUtil.isEmpty(taskSn)){
					DMCJ03DAO.updateEduAtModule(iMap);
				}
				else{
					DMCJ03DAO.updateEduAtTaskSn(iMap);
				}
				
				DMCJ03DAO.insertEduMgrInfo(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailDmcEdcMgr, null, null);
			}
			else if(iMap.get("CURD").equals("U")) {
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailDmcEdcMgr, null, null);
				DMCJ03DAO.updateEduMgrInfo(iMap);
			}
			else if(iMap.get("CURD").equals("D")) {
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailDmcEdcMgr, null, null);
				DMCJ03DAO.deleteEduMgrInfo(iMap);
			}
		}
		return edcMgrSeqNo;
	}
	
	@Override
	public void insertEduRoleInfo(List<Map<String, Object>> list) throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("EDC_SN", String.valueOf(list.get(0).get("EDC_SN")));
		map.put("MODULE", String.valueOf(list.get(0).get("MODULE")));
		
		List<Map<String, Object>> oldList = DMCJ03DAO.selectOldEduRoleList(map);
		
		if(oldList.size() > 0){
			for(Map<String, Object> iMap : oldList) {
				comz06Service.createCmDtaAtrailForDeleteByObject(iMap, atrailDmcEdcRole, null, null);
			}
			DMCJ03DAO.deleteEduRoleInfo(map);
		}

		for(Map<String, Object> iMap : list) {
			iMap.put("ROLE_SN", edcRoleSeq.getNextStringId());
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			DMCJ03DAO.insertEduRoleInfo(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailDmcEdcRole, null, null);
		}
	}
	
	@Override
	public List<Map<String, Object>> selectUserByEducationList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ03DAO.selectUserByEducationList(map);
	}

}
