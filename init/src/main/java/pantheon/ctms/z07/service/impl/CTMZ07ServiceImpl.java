package pantheon.ctms.z07.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.r01.dao.CTMR01DAO;
import pantheon.ctms.r01.service.CTMR01Service;
import pantheon.ctms.z01.dao.CTMZ01DAO;
import pantheon.ctms.z01.service.CTMZ01Service;
import pantheon.ctms.z07.dao.CTMZ07DAO;
import pantheon.ctms.z07.service.CTMZ07Service;

@Service("CTMZ07Service")
public class CTMZ07ServiceImpl implements CTMZ07Service{

	@Resource(name = "CTMZ07DAO")
	private CTMZ07DAO ctmz07DAO;

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
	 * 시험전 방문보고서 목록 조회
	 */
	@Override
	public List<Map<String, Object>> selectTitleList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz07DAO.selectTitleList(map);
	}

	/**
	 * 시험전 방문보고서 MAIN 조회
	 */
	@Override
	public Map<String, Object> selectPreTrialVisitReport(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub		
		return ctmz07DAO.selectPreTrialVisitReport(map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT1 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitReport1(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz07DAO.selectVisitReport1(map);
	}
	
	/**
	 * 시험전 방문보고서 VISIT2 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitReport2(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz07DAO.selectVisitReport2(map);
	}
	
	/**
	 * 시험전 방문보고서 ITEM 조회
	 */
	@Override
	public List<Map<String, Object>> selectItemReport(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz07DAO.selectItemReport(map);
	}

	/**
	 * 시험전 방문보고서 저장
	 */
	@Override
	public void insertPreTrialVisitReport(List<Map<String, Object>> list) throws Exception {		
		Map<String, Object> map = new HashMap<String, Object>();
		Object reportSn = null;
		
		String from_visit_de = null;
		String to_visit_de = null;
		
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("DATA_SE").equals("A")){ //MAIN
				if(list.get(i).get("CRUD").equals("U")){
					reportSn = list.get(i).get("REPORT_SN");
					map.put("REPORT_SN",list.get(i).get("REPORT_SN"));
				}//if
				map.put("MILESTONE_SN",list.get(i).get("MILESTONE_SN"));
				map.put("TASK_SN",list.get(i).get("TASK_SN"));
				map.put("REPORT_TYPE",list.get(i).get("REPORT_TYPE"));
				map.put("REPORT_SE",list.get(i).get("REPORT_SE"));
				map.put("JOB_SE",list.get(i).get("JOB_SE"));
				map.put("INSTT_CODE",list.get(i).get("INSTT_CODE"));
				map.put("RSRCHMAN_ID",list.get(i).get("RSRCHMAN_ID"));
				map.put("REMARK_A",list.get(i).get("REMARK_A"));
				map.put("ITEM_A",list.get(i).get("ITEM_A"));
				map.put("ITEM_B",list.get(i).get("ITEM_B"));
				map.put("ITEM_C",list.get(i).get("ITEM_C"));
				map.put("LAST_UPDUSR",list.get(i).get("LAST_UPDUSR"));
				map.put("CRUD",list.get(i).get("CRUD"));
				map.put("DATA_SE",list.get(i).get("DATA_SE"));
				map.put("PURPS",list.get(i).get("PURPS"));
				map.put("CHARGER_ID",list.get(i).get("CHARGER_ID"));
				
			}//if
		}//for
		
		////////////////////////CTMS_ST_REPORT_MAIN//////////////////////////////
		if(map.get("DATA_SE").equals("A")){ //MAIN
			if(map.get("CRUD").equals("C")){
				reportSn = ctms_st_report_main_seq.getNextStringId();
				map.put("REPORT_SN", reportSn);
				ctmz07DAO.insertMainPreReport(map);
				comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
			}else if(map.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
				ctmz07DAO.updateMainPreReport(map);				
			}
		}
		
		for(Map<String, Object> iMap : list) {
		////////////////////////CTMS_ST_REPORT_VISIT//////////////////////////////	
			if(iMap.get("DATA_SE").equals("B")){
				if(iMap.get("CRUD").equals("C")){
					iMap.put("REPORT_SN", reportSn);	
					iMap.put("VISIT_SN", ctms_st_report_visit_seq.getNextStringId());
					
					if(iMap.containsKey("FROM_VISIT_DE")){
						from_visit_de = (String) iMap.get("FROM_VISIT_DE");
						iMap.put("FROM_VISIT_DE", from_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");
					}
					if(iMap.containsKey("TO_VISIT_DE")){
						to_visit_de = (String) iMap.get("TO_VISIT_DE");
						iMap.put("TO_VISIT_DE", to_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");	
					}
					//System.out.println("iMapInsert11111:::::::::::::::::::::"+iMap);
					ctmz07DAO.insertVisitPreReport(iMap);    
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_visit, null, null);
					
				}else if(iMap.get("CRUD").equals("U")){
					if(iMap.containsKey("FROM_VISIT_DE")){
						from_visit_de = (String) iMap.get("FROM_VISIT_DE");
						iMap.put("FROM_VISIT_DE", from_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");
					}
					if(iMap.containsKey("TO_VISIT_DE")){
						to_visit_de = (String) iMap.get("TO_VISIT_DE");
						iMap.put("TO_VISIT_DE", to_visit_de.replaceAll("/", "").replaceAll("-", "")+"000000");	
					}
					//System.out.println("iMapUpdate22222:::::::::::::::::::::"+iMap);
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz07DAO.updateVisitPreReport(iMap);
				}
		////////////////////////CTMS_ST_REPORT_ITEM/////////////////////////////	
			}else if(iMap.get("DATA_SE").equals("C")){
				if(iMap.get("CRUD").equals("C")){
					iMap.put("ITEM_SN", ctms_st_report_item_seq.getNextStringId());
					iMap.put("REPORT_SN", reportSn);
					ctmz07DAO.insertItemPreReport(iMap);	
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_item, null, null);
				}else if(iMap.get("CRUD").equals("U")){
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_item, null, null);
					ctmz07DAO.updateItemPreReport(iMap);	
				}
			}		
		}
	}

	/**
	 * 결재번호 저장
	 */
	@Override
	public void updateApproval(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		for(Map<String, Object> iMap : list) {			
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_main, null, null);
			ctmz07DAO.updateApproval(iMap);
		}
	}

	/**
	 * 결재번호 조회
	 */	
	@Override
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz07DAO.selectApprovalInfo(map);
	}
	

	
	
	

}

	



















