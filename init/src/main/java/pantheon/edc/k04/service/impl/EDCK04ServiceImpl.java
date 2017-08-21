package pantheon.edc.k04.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.edc.k04.dao.EDCK04DAO;
import pantheon.edc.k04.service.EDCK04Service;


@Service("EDCK04Service")
public class EDCK04ServiceImpl implements EDCK04Service{
	
	@Resource(name = "EDCK04DAO")
    EDCK04DAO EDCK04DAO;

	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;

	/**
	 * DB Freezing selectTaskInfo
	 */
	@Override
	public List<Map<String, Object>> selectEdcTaskList( Map<String, Object> param) throws Exception {
		
		return EDCK04DAO.selectEdcTaskList(param);
	}

	/**
	 * DB Freezing selectEdcSiteList
	 */
	@Override
	public List<Map<String, Object>> selectEdcSiteList( Map<String, Object> param) throws Exception {
		
		return EDCK04DAO.selectEdcSiteList(param);
	}

	/**
	 * DB Freezing selectEdcSubInsttList
	 */
	@Override
	public List<Map<String, Object>> selectEdcSubInsttList( Map<String, Object> param) throws Exception {
		
		return EDCK04DAO.selectEdcSubInsttList(param);
	}

	/**
	 * DB Freezing selectTaskInfo
	 */
	@Override
	public List<Map<String, Object>> selectTaskInfo( Map<String, Object> param) throws Exception {
		
		List<Map<String, Object>> tmp = EDCK04DAO.selectTaskInfo(param);

		return tmp;
//		return EDCK04DAO.selectTaskInfo(param);
	}
	
	/**
	 * DB Freezing updateEdcCrTaskReqNo
	 */
	@Override
	public void updateEdcCrTaskReqNo(Map<String, Object> param) throws Exception {
		
		EDCK04DAO.updateEdcCrTaskReqNo(param);
	}
	
	/**
	 * DB Freezing 결제상태 select
	 */
	@Override
	public void updateEdcCrTaskFrzStt(Map<String, Object> param) throws Exception{

		Map<String, Object> sancCtnRequstRslt = EDCK04DAO.selectSttSanc(param);
		sancCtnRequstRslt.put("TASK_SN", param.get("TASK_SN"));
		sancCtnRequstRslt.put("REQUST_NO", param.get("REQUST_NO"));
		sancCtnRequstRslt.put("UPDATE_ID", param.get("UPDATE_ID"));
		
		if(sancCtnRequstRslt.get("STTUS_CODE").equals("02")){		//결재상태가 '승인'인 건
			if(sancCtnRequstRslt.get("REQUST_NM").equals("Temp Freezing")){
				sancCtnRequstRslt.put("FREEZING_STTUS_CODE", "02");
			}else if(sancCtnRequstRslt.get("REQUST_NM").equals("Temp Freezing 해제")){
				sancCtnRequstRslt.put("FREEZING_STTUS_CODE", "03");
			}else if(sancCtnRequstRslt.get("REQUST_NM").equals("DB Freezing 요청")){
				sancCtnRequstRslt.put("FREEZING_STTUS_CODE", "01");
			}else if(sancCtnRequstRslt.get("REQUST_NM").equals("DB Freezing 해제 요청")){
				sancCtnRequstRslt.put("FREEZING_STTUS_CODE", "03");
			}else{
				return;
			}
			EDCK04DAO.updateEdcCrTaskFrzStt(sancCtnRequstRslt);
			EDCK04DAO.insertEdcFreezingHist(sancCtnRequstRslt);
			
			if(sancCtnRequstRslt.get("REQUST_NM").equals("Temp Freezing")){//Temp Freezing 결재 완료 후
				
				List<Map<String, Object>> sndMailList = EDCK04DAO.selectCmUserRoleList(sancCtnRequstRslt);				
				
				for(int i=0; i<sndMailList.size(); i++){
					Map<String, Object> tmp = new HashMap<String, Object>();
					tmp = sndMailList.get(i);
					
					String mailAddr = (String)tmp.get("EMAIL");
					String userNm = (String)tmp.get("USER_NM");
					
					//메일발송
					Map<String, String> map = new HashMap<String, String>();
					//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
					map.put("HTML_NM", propertiesMailService.getString("TEST_MAIL_TEMPLATE"));
					map.put("TASK_NO", (String)sancCtnRequstRslt.get("TASK_NO"));
					map.put("RSLT_MSG", "Temp Freezing이 완료되었습니다. 과제번호 : "+sancCtnRequstRslt.get("TASK_NO"));
					//html에는 el식 기준으로 작성하면 변환됨
					map.put("URL", "52.2.72.199:8080");
					pantheonMailService.sendMail(map, "skyi@cj.net", userNm, "Temp Freezing 완료 알림");
					//pantheonMailService.sendMail(map, mailAddr, userNm, "Temp Freezing 완료 알림");
				}
			}
		}
	}

	/**
	 * DB Freezing selectEdcFrzngHist
	 */
	@Override
	public List<Map<String, Object>> selectEdcFrzngHist( Map<String, Object> param) throws Exception {
		
		return (List<Map<String, Object>>)EDCK04DAO.selectEdcFrzngHist(param);

	}
	
	/**
	 * DB Freezing updateFrzEdcCrInsttFrm
	 */
	@Override
	public void updateFrzEdcCrInsttFrm(List<Map<String, Object>> param) throws Exception {
		for(Map<String, Object> iMap : param) {
			EDCK04DAO.updateFrzEdcCrInsttFrm(iMap);
			EDCK04DAO.updateFrzEdcCfSubject(iMap);
		}
	}
	
	/**
	 * DB Freezing updateEdcCrTaskReqNo
	 */
	@Override
	public void updateSubFrzEdcCrInsttFrm(List<Map<String, Object>> param) throws Exception {
		for(Map<String, Object> iMap : param) {
			EDCK04DAO.updateSubFrzEdcCrInsttFrm(iMap);
			
			Map<String, Object> cntFrz = EDCK04DAO.selectChkFrzSubGrp(iMap);
//			System.out.println("cntFrz.get(NOT_YET) : "+cntFrz.get("NOT_YET"));
//			System.out.println("cntFrz.get(SUB_COMP) : "+cntFrz.get("SUB_COMP"));
//			System.out.println("cntFrz.get(TTL_COMP) : "+cntFrz.get("TTL_COMP"));
//			System.out.println("cntFrz.get(TTL_CNT) : "+cntFrz.get("TTL_CNT"));
//			if(cntFrz.get("NOT_YET").equals(cntFrz.get("TTL_CNT")) || ("0".equals(cntFrz.get("NOT_YET")) && "0".equals(cntFrz.get("SUB_COMP")) && "0".equals(cntFrz.get("TTL_COMP"))) ){
////			if( (cntFrz.get("NOT_YET") == cntFrz.get("TTL_CNT")) ||  (((int)cntFrz.get("NOT_YET") == 0 ) && ((int)cntFrz.get("SUB_COMP") == 0) && ((int)cntFrz.get("TTL_COMP")) == 0) ){
//				iMap.put("FREEZING_STTUS_CODE", "01");
//			}else if(cntFrz.get("TTL_COMP").equals(cntFrz.get("TTL_CNT"))){
//				iMap.put("FREEZING_STTUS_CODE", "03");
//			}else{
//				iMap.put("FREEZING_STTUS_CODE", "02");
//			}
			
			iMap.put("FREEZING_STTUS_CODE", cntFrz.get("FREEZING_STTUS_CODE"));
			
			EDCK04DAO.updateFrzEdcCrInsttFrm(iMap);
		}
	}
}
