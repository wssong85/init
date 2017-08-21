package pantheon.ctms.z03.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z03.dao.CTMZ03DAO;
import pantheon.ctms.z03.service.CTMZ03Service;

@Service("CTMZ03Service")
public class CTMZ03ServiceImpl implements CTMZ03Service{

	@Resource(name = "CTMZ03DAO")
	private CTMZ03DAO ctmz03DAO;
	
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
	 * 보고서 목록 조회
	 */
	@Override
	public List<Map<String, Object>> selectSiteVisitList(Map<String, String> map)	throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectSiteVisitList(map);
	}

	/**
	 * 보고서 신규여부 조회
	 */
	@Override
	public Map<String, Object> selectReportCrudInfo(Map<String, String> map)	throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectReportCrudInfo(map);
	}

	/**
	 * 보고서 상단 Title정보 조회
	 */
	@Override
	public Map<String, Object> selectReportTitleInfo(Map<String, String> map)	throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectReportTitleInfo(map);
	}

	/**
	 * 보고서 정보 조회
	 */
	@Override
	public Map<String, Object> selectReportMainInfo(Map<String, String> map)	throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectReportMainInfo(map);
	}
	
	/**
	 * 보고서 항목 조회
	 */
	@Override
	public List<Map<String, Object>> selectReportItemList(Map<String, String> map)	throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectReportItemList(map);
	}
	
	/**
	 * 참석자 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitInfoGrid(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz03DAO.selectVisitInfoGrid(map);
	}

	/**
	 * 보고서 데이터 저장
	 */
	@Override
	public String insertVisitReport(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String reportSn = null;
		System.out.println("list list==========================================="+list);
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("DATA_SE").equals("A")){
				
				map.put("REPORT_SN"   , list.get(i).get("REPORT_SN"   ));
				map.put("MILESTONE_SN", list.get(i).get("MILESTONE_SN"));
				map.put("TASK_SN"     , list.get(i).get("TASK_SN"     ));
				map.put("REPORT_TYPE" , list.get(i).get("REPORT_TYPE" ));
				map.put("REPORT_SE"   , list.get(i).get("REPORT_SE"   ));
				map.put("JOB_SE"      , list.get(i).get("JOB_SE"      ));
				map.put("RSRCHMAN_ID" , list.get(i).get("RSRCHMAN_ID" ));
				map.put("INSTT_CODE"  , list.get(i).get("INSTT_CODE"  ));
				map.put("OPRTN_DE"    , list.get(i).get("OPRTN_DE"    ));
				map.put("EXPECT_DE"   , list.get(i).get("EXPECT_DE"   ));
				map.put("PLACE"       , list.get(i).get("PLACE"       ));
				map.put("RSPOFC"      , list.get(i).get("RSPOFC"      ));
				map.put("CHARGER_ID"  , list.get(i).get("CHARGER_ID"  ));
				map.put("COL_A"       , list.get(i).get("COL_A"       ));
				map.put("COL_B"       , list.get(i).get("COL_B"       ));
				map.put("COL_C"       , list.get(i).get("COL_C"       ));
				map.put("COL_D"       , list.get(i).get("COL_D"       ));
				map.put("COL_E"       , list.get(i).get("COL_E"       ));
				map.put("COL_F"       , list.get(i).get("COL_F"       ));
				map.put("COL_H"       , list.get(i).get("COL_H"       ));
				map.put("PURPS"       , list.get(i).get("PURPS"       ));
				map.put("VISIT_ODR"   , list.get(i).get("VISIT_ODR"   ));
				map.put("ITEM_A"      , list.get(i).get("ITEM_A"      ));
				map.put("ITEM_B"      , list.get(i).get("ITEM_B"      ));
				map.put("ITEM_C"      , list.get(i).get("ITEM_C"      ));
				map.put("ITEM_D"      , list.get(i).get("ITEM_D"      ));
				map.put("ITEM_E"      , list.get(i).get("ITEM_E"      ));
				map.put("ITEM_F"      , list.get(i).get("ITEM_F"      ));
				map.put("ITEM_G"      , list.get(i).get("ITEM_G"      ));
				map.put("ITEM_H"      , list.get(i).get("ITEM_H"      ));
				map.put("ITEM_I"      , list.get(i).get("ITEM_I"      ));
				map.put("ITEM_J"      , list.get(i).get("ITEM_J"      ));
				map.put("ITEM_K"      , list.get(i).get("ITEM_K"      ));
				map.put("SETLE_NO"    , list.get(i).get("SETLE_NO"    ));
				map.put("REMARK_A"    , list.get(i).get("REMARK_A"    ));
				map.put("REMARK_B"    , list.get(i).get("REMARK_B"    ));

				if(list.get(i).get("CRUD").equals("C")){
					reportSn = ctms_st_report_main_seq.getNextStringId();
					map.put("REPORT_SN", reportSn);
					ctmz03DAO.insertReportMain(map);
					comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
				}
				else if(list.get(i).get("CRUD").equals("U")){
					reportSn = map.get("REPORT_SN").toString();
					comz06Service.createCmDtaAtrailForInsertByObject(map, atrail_ctms_st_report_main, null, null);
					ctmz03DAO.updateReportMain(map);
				}
			}			
		}

		for(Map<String, Object> iMap : list) {
			if(iMap.get("DATA_SE").equals("B")){
				if(iMap.get("CRUD").equals("C")) {
					iMap.put("REPORT_SN", reportSn);
					ctmz03DAO.insertReportItem(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_item, null, null);
				}
				else if(iMap.get("CRUD").equals("U")) {
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_item, null, null);
					ctmz03DAO.updateReportItem(iMap);
				}
			}
		}
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("DATA_SE").equals("C")){
				if(iMap.get("CRUD").equals("C")) {
					iMap.put("REPORT_SN", reportSn);
					iMap.put("VISIT_SN", ctms_st_report_visit_seq.getNextStringId());
					ctmz03DAO.insertReportVisit(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_ctms_st_report_visit, null, null);
				}
				else if(iMap.get("CRUD").equals("U")) {
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz03DAO.updateReportVisit(iMap);
				}
				else if(iMap.get("CRUD").equals("D")) {
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_visit, null, null);
					ctmz03DAO.deleteReportVisit(iMap);
				}
			}
		}
		
		return reportSn;
		
	}
	
	/**
	 * 보고서 결제요청번호 저장
	 */
	@Override
	public void updateReportApprovalSn(Map<String, Object> iMap) throws Exception {
		comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_ctms_st_report_main, null, null);
		ctmz03DAO.updateReportApprovalSn(iMap);
	}

}


