package pantheon.ctms.z08.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z08.dao.CTMZ08DAO;
import pantheon.ctms.z08.service.CTMZ08Service;

@Service("CTMZ08Service")
public class CTMZ08ServiceImpl implements CTMZ08Service{

	@Resource(name = "CTMZ08DAO")
	private CTMZ08DAO ctmz08DAO;

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
	 * 시험책임자 적합성 점검표 목록 조회
	 */
	@Override
	public List<Map<String, Object>> selectTitleList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz08DAO.selectTitleList(map);
	}

	/**
	 * 시험책임자 적합성 점검표 MAIN 조회
	 */
	@Override
	public Map<String, Object> selectTrialVisitReport(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub		
		return ctmz08DAO.selectTrialVisitReport(map);
	}
		
	/**
	 * 시험책임자 적합성 점검표 ITEM 조회
	 */
	@Override
	public List<Map<String, Object>> selectItemReport(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz08DAO.selectItemReport(map);
	}

	/**
	 * 시험책임자 적합성 점검표 저장
	 */
	@Override
	public void insertPreTrialVisitReport(List<Map<String, Object>> list) throws Exception {		
		Map<String, Object> map = new HashMap<String, Object>();
		Object reportSn = null;
				
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
				map.put("OPRTN_DE",list.get(i).get("OPRTN_DE"));
				map.put("ITEM_A",list.get(i).get("ITEM_A"));
				map.put("ITEM_B",list.get(i).get("ITEM_B"));
				map.put("ITEM_C",list.get(i).get("ITEM_C"));
				map.put("ITEM_D",list.get(i).get("ITEM_D"));
				map.put("ITEM_E",list.get(i).get("ITEM_E"));
				map.put("ITEM_F",list.get(i).get("ITEM_F"));
				map.put("ITEM_G",list.get(i).get("ITEM_G"));
				map.put("ITEM_H",list.get(i).get("ITEM_H"));
				map.put("REMARK_A",list.get(i).get("REMARK_A"));
				map.put("COL_A",list.get(i).get("COL_A"));
				map.put("COL_B",list.get(i).get("COL_B"));
				map.put("COL_C",list.get(i).get("COL_C"));
				map.put("COL_D",list.get(i).get("COL_D"));
				map.put("COL_E",list.get(i).get("COL_E"));
				map.put("COL_F",list.get(i).get("COL_F"));
				map.put("COL_H",list.get(i).get("COL_H"));
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
				ctmz08DAO.insertMainPreReport(map);
				comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
			}else if(map.get("CRUD").equals("U")){
				System.out.println("REPORT_UPDATE::::::::::::::::::::::::::::::::::::::::"+map);
				comz06Service.createCmDtaAtrailForUpdateByObject(map, atrail_ctms_st_report_main, null, null);
				ctmz08DAO.updateMainPreReport(map);				
			}
		}
		
		for(Map<String, Object> iMap : list) {
		////////////////////////CTMS_ST_REPORT_ITEM/////////////////////////////	
			 if(iMap.get("DATA_SE").equals("C")){
				if(iMap.get("CRUD").equals("C")){
					iMap.put("ITEM_SN", ctms_st_report_item_seq.getNextStringId());
					iMap.put("REPORT_SN", reportSn);
					ctmz08DAO.insertItemPreReport(iMap);	
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_item, null, null);
				}else if(iMap.get("CRUD").equals("U")){
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_item, null, null);
					ctmz08DAO.updateItemPreReport(iMap);	
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
			ctmz08DAO.updateApproval(iMap);
		}
	}

	/**
	 * 결재번호 조회
	 */	
	@Override
	public List<Map<String, Object>> selectApprovalInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz08DAO.selectApprovalInfo(map);
	}
	

	
	
	

}

	



















