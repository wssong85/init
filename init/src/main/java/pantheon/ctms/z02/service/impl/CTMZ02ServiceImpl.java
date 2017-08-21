package pantheon.ctms.z02.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z02.dao.CTMZ02DAO;
import pantheon.ctms.z02.service.CTMZ02Service;


@Service("CTMZ02Service")
public class CTMZ02ServiceImpl implements CTMZ02Service{

	@Resource(name = "CTMZ02DAO")
	private CTMZ02DAO ctmz02DAO;

	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMS_ST_REPORT_MAIN_SEQ")
	private EgovIdGnrService ctms_st_report_main_seq;
	
	@Resource(name = "CTMS_ST_REPORT_ITEM_SEQ")
	private EgovIdGnrService ctms_st_report_item_seq;
	
	@Resource(name = "CTMS_ST_REPORT_VISIT_SEQ")
	private EgovIdGnrService ctms_st_report_visit_seq;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CTMS_ST_REPORT_MAIN")
	protected EgovPropertyService atrail_ctms_st_report_main;
	
	@Resource(name = "ATRAIL_CTMS_ST_REPORT_ITEM")
	protected EgovPropertyService atrail_ctms_st_report_item;
	
	@Resource(name = "ATRAIL_CTMS_ST_REPORT_VISIT")
	protected EgovPropertyService atrail_ctms_st_report_visit;
	
	
	/**
	 * 기관정보 그리드 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz02DAO.selectVisitInfo(map);
	}
	
	/**
	 * 개시방문 준비보고서 저장
	 */
	@Override
	public void insertPlanVisitReport(List<Map<String, Object>> list) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Object reportSn = null;
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("DATA_SE").equals("A")){					
				if(list.get(i).get("CRUD").equals("U")){
					reportSn = list.get(i).get("REPORT_SN");
					map.put("REPORT_SN", list.get(i).get("REPORT_SN"));
				}
					
				map.put("TASK_SN", list.get(i).get("TASK_SN"));
				map.put("MILESTONE_SN", list.get(i).get("MILESTONE_SN"));
				map.put("RSRCHMAN_ID", list.get(i).get("RSRCHMAN_ID"));
				map.put("REPORT_TYPE", list.get(i).get("REPORT_TYPE"));
				map.put("INSTT_CODE", list.get(i).get("INSTT_CODE"));
				map.put("OPRTN_DE", list.get(i).get("OPRTN_DE"));
				map.put("PLACE", list.get(i).get("PLACE"));
				map.put("CHARGER_ID", list.get(i).get("CHARGER_ID"));
				map.put("REMARK_A", list.get(i).get("REMARK_A"));
				map.put("JOB_SE", list.get(i).get("JOB_SE"));
				map.put("LAST_UPDUSR", list.get(i).get("LAST_UPDUSR"));
				map.put("REPORT_SE", list.get(i).get("REPORT_SE"));
				map.put("DATA_SE", list.get(i).get("DATA_SE"));
				map.put("CRUD", list.get(i).get("CRUD"));
				
			}			
		}
		//////////////CTMS_ST_REPORT_MAIN///////////////////////
		if(map.get("DATA_SE").equals("A")){
			if(map.get("CRUD").equals("C")){
				reportSn = ctms_st_report_main_seq.getNextStringId();
				map.put("REPORT_SN", reportSn);
				ctmz02DAO.insertPlanVisitReport(map);
				comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
			}else if(map.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
				ctmz02DAO.updatePlanVisitReport(map);    //보고서 준비기록 CTMS_ST_REPORT_MAIN		
			}
		}		
		
		////////////////CTMS_ST_REPORT_VISIT/////////////////////
		for(Map<String, Object> iMap : list) {
			if(iMap.get("DATA_SE").equals("B")){
				if(iMap.get("CRUD").equals("C")) {
					iMap.put("VISIT_SN", ctms_st_report_visit_seq.getNextStringId());
					iMap.put("REPORT_SN", reportSn);
					ctmz02DAO.insertPlanVisitInfo(iMap);    //보고서 준비기록 CTMS_ST_REPORT_VISIT	
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_visit, null, null);
				}else if(iMap.get("CRUD").equals("U")){
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz02DAO.updatePlanVisitInfo(iMap);    //보고서 준비기록 CTMS_ST_REPORT_VISIT		
				}else{
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz02DAO.deletePlanVisitInfo(iMap);
				}
			}
		}
	}	
	
	
	/**
	 * 개시방문 보고서 참석자 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz02DAO.selectVisitInfoGrid(map);
	}
	
	/**
	 * 개시방문 보고서 Main 조회
	 */
	@Override
	public Map<String, Object> selectVisitInfoMain(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz02DAO.selectVisitInfoMain(map);
	}

	/**
	 * 개시방문 보고서 결재순번 수정
	 */
	@Override
	public void updateApproval(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {	
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_main, null, null);
			ctmz02DAO.updateApproval(iMap);
		}
	}

	@Override
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz02DAO.selectApprovalInfo(map);
	}

	/**
	 * 방문보고서 저장
	 */
	@Override
	public void insertVisitReport(List<Map<String, Object>> list)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Object reportSn = null;		
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("DATA_SE").equals("A")){		
				if(list.get(i).get("CRUD").equals("U")){
					reportSn = list.get(i).get("REPORT_SN");
					map.put("REPORT_SN", list.get(i).get("REPORT_SN"));
				}
				map.put("TASK_SN", list.get(i).get("TASK_SN"));
				map.put("MILESTONE_SN", list.get(i).get("MILESTONE_SN"));
				map.put("RSRCHMAN_ID", list.get(i).get("RSRCHMAN_ID"));
				map.put("REPORT_TYPE", list.get(i).get("REPORT_TYPE"));
				map.put("INSTT_CODE", list.get(i).get("INSTT_CODE"));
				map.put("OPRTN_DE", list.get(i).get("OPRTN_DE"));				
				map.put("CHARGER_ID", list.get(i).get("CHARGER_ID"));
				map.put("REMARK_A", list.get(i).get("REMARK_A"));
				map.put("JOB_SE", list.get(i).get("JOB_SE"));
				map.put("LAST_UPDUSR", list.get(i).get("LAST_UPDUSR"));
				map.put("REPORT_SE", list.get(i).get("REPORT_SE"));
				map.put("DATA_SE", list.get(i).get("DATA_SE"));
				map.put("CRUD", list.get(i).get("CRUD"));				
			}			
		}
		
		/////////////////////CTMS_ST_REPORT_MAIN//////////////////////////
		if(map.get("DATA_SE").equals("A")){
			if(map.get("CRUD").equals("C")){
				reportSn = ctms_st_report_main_seq.getNextStringId();
				map.put("REPORT_SN", reportSn);
				ctmz02DAO.insertPlanVisitReport(map);
				comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
			}else if(map.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
				ctmz02DAO.updatePlanVisitReport(map);
			}
		}
		
		for(Map<String, Object> iMap : list){
			//////////////////CTMS_ST_REPORT_VISIT/////////////////////////
			if(iMap.get("DATA_SE").equals("B")){
				if(iMap.get("CRUD").equals("C")) { //저장
					iMap.put("VISIT_SN", ctms_st_report_visit_seq.getNextStringId());
					iMap.put("REPORT_SN", reportSn);
					ctmz02DAO.insertPlanVisitInfo(iMap);   
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_visit, null, null);
				}else if(iMap.get("CRUD").equals("U")){ //수정
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);					
					ctmz02DAO.updatePlanVisitInfo(iMap);    
				}else{ //삭제
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz02DAO.deletePlanVisitInfo(iMap);
				}
		    ////////////////////CTMS_ST_REPORT_ITEM//////////////////////////
			}else if(iMap.get("DATA_SE").equals("C")){
				if(iMap.get("CRUD").equals("C")){
					iMap.put("REPORT_SN", reportSn);
					ctmz02DAO.insertPlanVisitItem(iMap);	//보고서 준비기록 CTMS_ST_REPORT_ITEM
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_item, null, null);
				}else if(iMap.get("CRUD").equals("U")){
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_item, null, null);
					ctmz02DAO.updateVisitReportItem(iMap);    //보고서 작성 CTMS_ST_REPORT_ITEM
				}
			}
		}
	}
	/**
	 * CTMS_ST_REPORT_ITEM 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz02DAO.selectVisitInfoItem(map);
	}

	
	
	

}

	



















