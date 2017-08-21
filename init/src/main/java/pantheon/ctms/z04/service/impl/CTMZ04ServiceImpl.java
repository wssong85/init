package pantheon.ctms.z04.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z04.dao.CTMZ04DAO;
import pantheon.ctms.z04.service.CTMZ04Service;

@Service("CTMZ04Service")
public class CTMZ04ServiceImpl implements CTMZ04Service {
	@Resource(name = "CTMZ04DAO")
	private CTMZ04DAO ctmz04DAO;
	
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
	 * 모니터링 계획 저장
	 */
	@Override
	public void insertMonitoringPlanReport(List<Map<String, Object>> list)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("CRUD").equals("U")){
				map.put("REPORT_SN",list.get(i).get("REPORT_SN"));
			}			  
			map.put("MILESTONE_SN",list.get(i).get("MILESTONE_SN"));		
			map.put("TASK_SN",list.get(i).get("TASK_SN"));	
			map.put("REPORT_SE",list.get(i).get("REPORT_SE"));		
			map.put("JOB_SE",list.get(i).get("JOB_SE"));
			map.put("INSTT_CODE",list.get(i).get("INSTT_CODE")); 		
			map.put("RSRCHMAN_ID",list.get(i).get("RSRCHMAN_ID"));	
			map.put("PURPS",list.get(i).get("PURPS"));	 			
			map.put("ITEM_B",list.get(i).get("ITEM_B"));	 			
			map.put("ITEM_C",list.get(i).get("ITEM_C")); 			
			map.put("ITEM_D",list.get(i).get("ITEM_D"));		 	
			map.put("ITEM_E",list.get(i).get("ITEM_E")); 			
			map.put("ITEM_F",list.get(i).get("ITEM_F")); 			
			map.put("SETLE_NO",list.get(i).get("SETLE_NO"));	 		
			map.put("FRST_CREAT_DE",list.get(i).get("FRST_CREAT_DE"));	 	
			map.put("LAST_UPDT_DE",list.get(i).get("LAST_UPDT_DE"));	 	
			map.put("LAST_UPDUSR",list.get(i).get("LAST_UPDUSR"));	 	
			map.put("CHARGER_ID",list.get(i).get("CHARGER_ID"));
			map.put("REPORT_TYPE",list.get(i).get("REPORT_TYPE"));
			map.put("CRUD",list.get(i).get("CRUD"));
			
		}
		if(map.get("CRUD").equals("C")){
			map.put("REPORT_SN", ctms_st_report_main_seq.getNextStringId());
			ctmz04DAO.insertMonitoringPlanReport(map);
			comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
		}else{			
			comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
			ctmz04DAO.updateMonitoringPlanReport(map);
			
		}
		
	}

	/**
	 * 모니터링 목록 조회
	 */
	@Override
	public List<Map<String, Object>> selectMonitoringGrid(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz04DAO.selectMonitoringGrid(map);
	}
	
	/**
	 * 모니터링 MAIN 조회
	 */
	@Override
	public Map<String, Object> selectMonitoringMain(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub		
		return ctmz04DAO.selectMonitoringMain(map);
	}
	
	/**
	 * 모니터링 VISIT 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoGrid1(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz04DAO.selectVisitInfoGrid1(map);
	}
	
	/**
	 * 모니터링 VISIT 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoGrid2(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz04DAO.selectVisitInfoGrid2(map);
	}
	
	/**
	 * CTMS_ST_REPORT_ITEM 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoItem(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz04DAO.selectVisitInfoItem(map);
	}
	
	/**
	 * VISIT_ODR 조회
	 */	
	@Override
	public Map<String, Object> selectVisitOdr(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub		
		return ctmz04DAO.selectVisitOdr(map);
	}
	
	@Override
	public Map<String, Object> selectvisitOdrPrevious(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub		
		return ctmz04DAO.selectvisitOdrPrevious(map);
	}
	
	
	/**
	 * 모니터링 결재번호 저장
	 */
	@Override
	public void updateApproval(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		for(Map<String, Object> iMap : list) {			
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_main, null, null);
			ctmz04DAO.updateApproval(iMap);
		}
	}
	
	/**
	 * 모니터링 결재번호
	 */
	@Override
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz04DAO.selectApprovalInfo(map);
	}

	/**
	 * 모니터링 방문보고서 저장
	 */
	@Override
	public void insertMonitoringVisitReport(List<Map<String, Object>> list)	throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		Object reportSn = null;
		
		String from_visit_de = null;
		String to_visit_de = null;
		
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("DATA_SE").equals("A")){ //MAIN
				if(list.get(i).get("CRUD").equals("U")){
					reportSn = list.get(i).get("REPORT_SN");
					map.put("REPORT_SN",reportSn);
				}
				map.put("MILESTONE_SN",list.get(i).get("MILESTONE_SN"));		
				map.put("TASK_SN",list.get(i).get("TASK_SN"));	
				map.put("REPORT_SE",list.get(i).get("REPORT_SE"));		
				map.put("JOB_SE",list.get(i).get("JOB_SE"));
				map.put("INSTT_CODE",list.get(i).get("INSTT_CODE")); 		
				map.put("RSRCHMAN_ID",list.get(i).get("RSRCHMAN_ID"));
				map.put("VISIT_ODR",list.get(i).get("VISIT_ODR"));			
				map.put("PURPS",list.get(i).get("PURPS"));	 
				map.put("CHARGER_ID",list.get(i).get("CHARGER_ID"));
				map.put("ITEM_A",list.get(i).get("ITEM_A"));
				map.put("ITEM_B",list.get(i).get("ITEM_B"));	 			
				map.put("ITEM_C",list.get(i).get("ITEM_C")); 			
				map.put("ITEM_D",list.get(i).get("ITEM_D"));		 	
				map.put("ITEM_E",list.get(i).get("ITEM_E")); 			
				map.put("ITEM_F",list.get(i).get("ITEM_F")); 
				map.put("ITEM_G",list.get(i).get("ITEM_G"));
				map.put("ITEM_H",list.get(i).get("ITEM_H"));
				map.put("ITEM_I",list.get(i).get("ITEM_I"));
				map.put("ITEM_J",list.get(i).get("ITEM_J"));
				map.put("ITEM_K",list.get(i).get("ITEM_K"));
				map.put("COL_A",list.get(i).get("COL_A"));
				map.put("COL_C",list.get(i).get("COL_C"));
				map.put("COL_D",list.get(i).get("COL_D"));				
				map.put("SETLE_NO",list.get(i).get("SETLE_NO"));	 		
				map.put("FRST_CREAT_DE",list.get(i).get("FRST_CREAT_DE"));	 	
				map.put("LAST_UPDT_DE",list.get(i).get("LAST_UPDT_DE"));	 	
				map.put("LAST_UPDUSR",list.get(i).get("LAST_UPDUSR"));	 	
				map.put("CHARGER_ID",list.get(i).get("CHARGER_ID"));
				map.put("REPORT_TYPE",list.get(i).get("REPORT_TYPE"));
				map.put("CRUD",list.get(i).get("CRUD"));
				map.put("DATA_SE",list.get(i).get("DATA_SE"));
				map.put("REMARK_A",list.get(i).get("REMARK_A"));
				map.put("REMARK_B",list.get(i).get("REMARK_B"));
				
			}
			if(list.get(i).get("DATA_SE").equals("D")){ //이전회차 조사대상자 정보
				if(list.get(i).get("CRUD").equals("U")){
					
					map2.put("REPORT_SN",list.get(i).get("ODT_REPORT_SN"));
					map2.put("MILESTONE_SN",list.get(i).get("ODT_MILESTONE_SN"));		
					map2.put("TASK_SN",list.get(i).get("TASK_SN"));	
					map2.put("REPORT_SE",list.get(i).get("REPORT_SE"));		
					map2.put("JOB_SE",list.get(i).get("JOB_SE"));
					map2.put("INSTT_CODE",list.get(i).get("INSTT_CODE"));
					map2.put("ITEM_B",list.get(i).get("ITEM_B"));	 			
					map2.put("ITEM_C",list.get(i).get("ITEM_C")); 			
					map2.put("ITEM_D",list.get(i).get("ITEM_D"));
					map2.put("ITEM_F",list.get(i).get("ITEM_F")); 
					map2.put("LAST_UPDUSR",list.get(i).get("LAST_UPDUSR"));
					map2.put("CRUD",list.get(i).get("CRUD"));
					map2.put("VISIT_ODR",list.get(i).get("VISIT_ODR"));
					map2.put("DATA_SE",list.get(i).get("DATA_SE"));
					map2.put("REPORT_TYPE",list.get(i).get("REPORT_TYPE"));
				}
				
			}
		}
		
		if(map.get("DATA_SE").equals("A")){ //MAIN
			if(map.get("CRUD").equals("C")){
				reportSn = ctms_st_report_main_seq.getNextStringId();
				 map.put("REPORT_SN", reportSn);
				ctmz04DAO.insertMonitoringPlanReport(map);
				comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
			}else if(map.get("CRUD").equals("U")){
				System.out.println("map==============================================="+map);
				comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
				ctmz04DAO.updateMonitoringPlanReport(map);
			}
		}
		if(map2.get("DATA_SE").equals("D")){ //이전회차 조사대상자 정보		
			if(map2.get("CRUD").equals("U")){				
				comz06Service.createCmDtaAtrailForUpdateByObject(map2, atrail_ctms_st_report_main, null, null);
				ctmz04DAO.updateOdrPrevious(map2);
			}
				
			
			
		}
		
		
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				if(iMap.get("DATA_SE").equals("B")){		
					iMap.put("VISIT_SN", ctms_st_report_visit_seq.getNextStringId());	
					iMap.put("REPORT_SN", reportSn);
					
					if(iMap.containsKey("FROM_VISIT_DE")){
						from_visit_de = (String) iMap.get("FROM_VISIT_DE");
						iMap.put("FROM_VISIT_DE", from_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");
					}
					if(iMap.containsKey("TO_VISIT_DE")){
						to_visit_de = (String) iMap.get("TO_VISIT_DE");
						iMap.put("TO_VISIT_DE", to_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");	
					}				
					
					ctmz04DAO.insertVisitInfoGrid(iMap);    
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_visit, null, null);
				}else if(iMap.get("DATA_SE").equals("C")){
					iMap.put("ITEM_SN", ctms_st_report_item_seq.getNextStringId());
					iMap.put("REPORT_SN", reportSn);
					ctmz04DAO.insertItemInfoGrid(iMap);	
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_item, null, null);
				}
			}else if(iMap.get("CRUD").equals("U")){
				if(iMap.get("DATA_SE").equals("B")){	
					
					if(iMap.containsKey("FROM_VISIT_DE")){
						from_visit_de = (String) iMap.get("FROM_VISIT_DE");
						iMap.put("FROM_VISIT_DE", from_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");
					}
					if(iMap.containsKey("TO_VISIT_DE")){
						to_visit_de = (String) iMap.get("TO_VISIT_DE");
						iMap.put("TO_VISIT_DE", to_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");	
					}
				
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz04DAO.updatePlanVisitInfo(iMap);
				}else if(iMap.get("DATA_SE").equals("C")){					
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_item, null, null);
					ctmz04DAO.updateVisitReportItem(iMap);
				}
				
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
				ctmz04DAO.deletePlanVisitInfo(iMap);				
			}
			
		}
	}
	
}
