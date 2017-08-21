package pantheon.edc.i01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.utl.service.PantheonSmsService;
import pantheon.edc.i01.dao.EDCI01DAO;
import pantheon.iwrs.b01.dao.IWRB01DAO;
import pantheon.edc.i01.service.EDCI01Service;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.com.z09.service.COMZ09Service;

/**
 * Blind관리를 처리하는 비지니스 구현 클래스
 * @author 오동근
 * @since 2016.03.03
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.03  오동근          최초 생성
 *  
 */
@Service("EDCI01Service")
public class EDCI01ServiceImpl implements EDCI01Service{
	
	@Resource(name = "EDCI01DAO")
    EDCI01DAO edci01DAO;	
	
	@Resource(name = "CM_SANCTN_REQUST_SEQ")
	private EgovIdGnrService cmSanctnRequstSeq;
	
	@Resource(name = "ATRAIL_CM_SANCTN_REQUST")
	protected EgovPropertyService atrailCmSanCtnRequst;
	
	@Resource(name = "ATRAIL_CM_SANCTN_PROCESS")
	protected EgovPropertyService atrailCmSanCtnProcess;
	
	@Resource(name = "ATRAIL_CM_SANCLINE_DETAIL")
	protected EgovPropertyService atrailCmSanclineDetail;
	
	@Resource(name = "ATRAIL_EDC_CF_SUBJECT")
	protected EgovPropertyService atrailEdcCfSubject;
	
	@Resource(name = "IWRB01DAO")
	private IWRB01DAO iwrb01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "PantheonSmsService")
	private PantheonSmsService pantheonSmsService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesSmsService")
	protected EgovPropertyService propertiesSmsService;
	@Resource(name = "CM_SANCTN_PROCESS_SEQ")
	private EgovIdGnrService cmSanctnProcessSeq;
	
	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;

	@Resource(name = "COMZ09Service")
	private COMZ09Service comz09Service;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Override
	public List<Map<String, Object>> selectResearchSubjectList(	Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edci01DAO.selectResearchSubjectList(param);
	}

	@Override
	public List<Map<String, Object>> selectFieldSubjectList( Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edci01DAO.selectFieldSubjectList(param);
	}

	@Override
	public Map<String, Object> selectTaskBlindPk(Map<String, Object> param) throws Exception {
		return edci01DAO.selectTaskBlindPk(param);
	}
	
	//눈가림 해제 요청
	@Override
	public void insertEdcSanctnRequstByEdcSanClineDetailInfo(Map<String, Object> list) throws Exception {
		
		Map<String, String> mapUsrInfo = new HashMap<String, String>();
		mapUsrInfo.put("USER_ID", (String) list.get("USER_ID"));
		mapUsrInfo.put("PASSWORD", (String) list.get("PASSWORD"));
		
		//사용자 ID, PW 체크
		if(iwrb01DAO.selectUserInfo(mapUsrInfo) == 0) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("edci0103.msg.checkIdPw"));
		}
		
		//CM_SANCLINE_DETAIL info Search
		list.put("REQUST_NM", "Blind 해제 요청");
		list.put("REQUST_COMMENT", list.get("RELIS_RESN"));
		list.put("UPDATE_ID", list.get("USER_ID"));
		List<Map<String, Object>> listSanclineDetail = edci01DAO.selectCmSanclineDetail(list);
		
		//결재Porcess
		String reqNo = comz09Service.insertCmSanctnRequstByCmSanClineDetailInfo(listSanclineDetail);
		System.out.println("################## Process Atrail End ");
		//결제 요청자를  기안자로 강제 insert
		String sanctnNo = edci01DAO.selectCmSanctnProcessBySeq();
		list.put("REQUST_NO", reqNo);
		list.put("SANCTN_NO", sanctnNo);
		list.put("SANCTN_COMMENT", list.get("RELIS_RESN"));
		list.put("SANCTN_ORDR", 1);
		list.put("SANCTN_CODE", "01");
		list.put("STTUS_CODE", "02");
		list.put("USE_YN", "Y");
		
		edci01DAO.insertCmSanctnProcessDraft(list);
		comz06Service.createCmDtaAtrailForInsertByObject(list, atrailCmSanCtnProcess, null, null);
//		
//		String seqRequst = cmSanctnRequstSeq.getNextStringId();
//		
//		list.put("REQUST_NO", seqRequst);
//		list.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
//		
//		edci01DAO.updateEdcCfSubjectByInfo(list);
//		
//		//결재요청 입력
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("REQUST_NO", seqRequst);
//		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
//		map.put("RQESTER_ID", Util.getUserMap().get("USER_ID"));
//		map.put("USE_YN", "Y");
//		map.put("STTUS_CODE", "01");
//		map.put("REQUST_NM", list.get("REQUST_NM"));
//		comz09DAO.insertCmSanctnRequstByCmSanClineDetailInfo(map);
//		comz06Service.createCmDtaAtrailForInsertByObject(map, atrailCmSanCtnRequst, null, null);
//		
//		List<Map<String, Object>> list2 = edci01DAO.selectCmSanclineDetailInfo(list);
//		
//		//결재처리 입력
//		for(Map<String, Object> iMap : list2) {
//			
//			//기안자는 승인상태
//			if("01".equals(iMap.get("SANCTN_CODE"))) {
//				iMap.put("STTUS_CODE", "02");
//			}
//			//참조는 확인상태
//			else if("06".equals(iMap.get("SANCTN_CODE"))){
//				iMap.put("STTUS_CODE", "04");
//			}
//			//기안자 외는 요청상태로 한다.
//			else {
//				iMap.put("STTUS_CODE", "01");
//			}
//			
//			iMap.put("REQUST_NO", seqRequst);
//			iMap.put("SANCTN_NO", cmSanctnProcessSeq.getNextStringId());
//			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
//			iMap.put("SANCTNER_ID", iMap.get("CONFMER_ID"));
//			iMap.put("USE_YN", "Y");
//			comz09DAO.insertCmSanctnProcessByCmSanClineDetailInfo(iMap);
//			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSanCtnProcess, null, null);
//		}
		System.out.println("@@@@@@@@@@@@@@@@@@ SUBJECT_NO : "+list.get("SUBJECT_NO"));
		
		list.put("BLIND_STTUS_CODE", "02");
		//comz06Service.createCmDtaAtrailForInsertByObject(list, atrailCmSanCtnRequst, null, null);
		comz06Service.createCmDtaAtrailForUpdateByObject(list, atrailEdcCfSubject, null, null);
		edci01DAO.updateEdcCfSubjectByInfo(list);
	}
	
	//눈가림 해제 승인 popup 창 select
	@Override
	public Map<String, Object> selectCfSubject( Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return edci01DAO.selectCfSubject(param);
	}
	
	//눈가림 즉시해제 저장
	@Override
	public void updateEdcCfSubjectByBlindSttusCd(Map<String, Object> param) throws Exception{
		Map<String, String> mapInfo = new HashMap<String, String>();
		mapInfo.put("USER_ID", (String) param.get("USER_ID"));
		mapInfo.put("PASSWORD", (String) param.get("PASSWORD"));
		mapInfo.put("INSTT_FORM_SN", (String) param.get("INSTT_FORM_SN"));
		mapInfo.put("SUBJECT_NO", (String) param.get("SUBJECT_NO"));
		mapInfo.put("RELIS_CONFM_NO", (String) param.get("RELIS_CONFM_NO"));
		
		//승인번호 체크
		if(edci01DAO.selectRelisConfmNoInfo(mapInfo) == 0) {
			throw new Exception("승인번호가 잘못되었습니다. 다시 확인해주세요.");
		}
		
		//사용자 ID, PW 체크
		if(iwrb01DAO.selectUserInfo(mapInfo) == 0) {
			throw new Exception("사용자 아이디와 비밀번호를 다시 확인해 주세요.");
		}

		param.put("BLIND_STTUS_CODE", "04");
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfSubject, null, null);
		edci01DAO.updateEdcCfSubjectByBlindSttusCd(param);		
	}
	
	//결재 Process
	@Override
	public Map<String, String> updateScanProcess(Map<String, String> map) throws Exception{
		Map<String, Object> param = new HashMap<String, Object>();
		
		String seqRequst = comz09Service.updateCmSanctnProcessByPk(map);	//결제처리
		map.put("REQUST_NO", seqRequst);
		
		param = (Map)edci01DAO.selectSendInfo(map);		//SMS or mail 전송에 필요한 데이터 가져오기

		//인증번호 생성
		double mkRndmNo=Math.floor(Math.random()*1000000)+1000000;
		
		if(mkRndmNo>1000000){
			mkRndmNo = mkRndmNo - 1000000;
		} 
		
		map.put("RELIS_CONFM_NO", mkRndmNo+"");
		
		String sendSmsSttus = "N";		
		//결재 상태가 승인, 반려인 경우 결재 상신자에게 SMS 발송
		if(param.get("STTUS_CODE")=="02"){

			param.put("BLIND_STTUS_CODE", "03");
			comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfSubject, null, null);
			edci01DAO.updateEdcCfSubjectByBlindSttusCd(param);		//subject의 BLIND_STTUS_CODE를 '승인'으로 수정
			
			map.put("RSLT_MSG", "흥인");
			sendSmsSttus = "Y";
		}else if(param.get("STTUS_CODE")=="03"){
			map.put("RSLT_MSG", "반려");
			sendSmsSttus = "Y";
		}
		
		map.put("SUBJECT", "눈가림해제요청결과");		//SMS 전송제목
		
		if(sendSmsSttus.equals("Y")){
			insertSmsService(map);			//SMS 발송
		}
		
		return map;
	}

	//SMS or EMAIL 전송시 필요한 데이터들 가져오기
	@Override
	public Map<String, String> selectSendInfo(Map<String, String> param) throws Exception{
		Map<String, String> rtn = new HashMap<String, String>();
		rtn = edci01DAO.selectSendInfo(param);
		return rtn;
	}
	
	//눈가림 즉시해제 승인번호 전송
	public void updateEdcCfSubjectBySendInfo(Map<String, String> map) throws Exception{
		//인증번호 생성
		double mkRndmNo=Math.floor(Math.random()*1000000)+1000000;
		
		if(mkRndmNo>1000000){
			mkRndmNo = mkRndmNo - 1000000;
		} 
		String rNum = String.format("%.0f", mkRndmNo);
		
		//param = edci01Service.selectSendInfo(map);		//SMS or mail 전송에 필요한 데이터 가져오기
		map.put("RELIS_CONFM_NO", rNum);		//승인번호			
		map.put("SUBJECT", "눈가림 즉시해제 인증번호");		//SMS 전송제목
		map.put("RSLT_MSG", "눈가림 즉시 해제 승인번호 : ");				//msg
		
		if("SMS".equals(map.get("SEND_TYPE"))){
			insertSmsService(map);
		}else if("EMAIL".equals(map.get("SEND_TYPE"))){
			sendMail(map);
		}
		
		//comz06Service.createCmDtaAtrailForUpdateByObject(map, atrailEdcCfSubject, null, null);
		edci01DAO.updateEdcCfSubjectByCnfmNo(map);
	}
	
	//SMS 전송
	public void insertSmsService(Map<String, String> param) throws Exception{
		
		Map<String, String> map = new HashMap<String, String>();

		//송신자 전화번호
		System.out.println("before sendSMS");
		map.put("SUBJECT_NO", param.get("SUBJECT_NO"));
		map.put("RELIS_CONFM_NO", param.get("RELIS_CONFM_NO"));
		//map.put("SUBJECT", param.get("SUBJECT"));
		map.put("HTML_NM", propertiesSmsService.getString("SANCTN_RSLT_SMS_TEMPLATE"));
		map.put("URL", "52.2.72.199:8080");
		
		pantheonSmsService.insertSmsService(map, "01038547314", param.get("SUBJECT"));
	}
	
	//EMAIL 전송
	public void sendMail(Map<String, String> param) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
		map.put("HTML_NM", propertiesMailService.getString("SANCTN_RSLT_MAIL_TEMPLATE"));//SANCTN_RSLT_MAIL_TEMPLATE
		//html에는 el식 기준으로 작성하면 변환됨
		map.put("URL", "52.2.72.199:8080");
		//pantheonMailService.sendMail(map, param.get("EMAIL"), param.get("USER_NM"), param.get("SUBJECT"));
		pantheonMailService.sendMail(map, "sk.yi@cj.net", "s", "메일발송테스트");
	}
}
