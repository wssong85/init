package pantheon.com.z09.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.com.z09.dao.COMZ09DAO;
import pantheon.com.z09.service.COMZ09Service;
import pantheon.iwrs.b01.dao.IWRB01DAO;

@Service("COMZ09Service")
public class COMZ09ServiceImpl implements COMZ09Service{
	
	@Resource(name = "COMZ09DAO")
	private COMZ09DAO comz09DAO;
	
	@Resource(name = "CM_SANCLINE_SEQ")
	private EgovIdGnrService cmSanclineSeq;
	
	@Resource(name = "CM_SANCLINE_DETAIL_SEQ")
	private EgovIdGnrService cmSanclineDetailSeq;
	
	@Resource(name = "CM_SANCTN_REQUST_SEQ")
	private EgovIdGnrService cmSanctnRequstSeq;
	
	@Resource(name = "CM_SANCTN_PROCESS_SEQ")
	private EgovIdGnrService cmSanctnProcessSeq;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_CM_SANCLINE")
	protected EgovPropertyService atrailCmSancline;
	
	@Resource(name = "ATRAIL_CM_SANCLINE_DETAIL")
	protected EgovPropertyService atrailCmSanclineDetail;
	
	@Resource(name = "ATRAIL_CM_SANCTN_REQUST")
	protected EgovPropertyService atrailCmSanCtnRequst;
	
	@Resource(name = "ATRAIL_CM_SANCTN_PROCESS")
	protected EgovPropertyService atrailCmSanCtnProcess;
	
	@Resource(name = "IWRB01DAO")
	private IWRB01DAO iwrb01DAO;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public void insertCmSanClineByPk(Map<String, String> map) throws Exception {
		if(true) {
			throw new UnsupportedOperationException();
		}

		comz09DAO.insertCmSanClineByPk(null);
	}

	@Override
	public List<Map<String, Object>> selectCmSanClineListByPk(Map<String, String> map) throws Exception {
		return comz09DAO.selectCmSanClineListByPk(map);
	}

	@Override
	public void insertCmSanClineDetailByPk(Map<String, String> map) throws Exception {
		if(true) {
			throw new UnsupportedOperationException();
		}
		comz09DAO.insertCmSanClineDetailByPk(null);
	}

	@Override
	public List<Map<String, Object>> selectCmSanClineDetailListByPk(Map<String, String> map) throws Exception {
		return comz09DAO.selectCmSanClineDetailListByPk(map);
	}

	@Override
	public List<Map<String, String>> selectCmJobUserListForAll(Map<String, String> map) throws Exception {
		return comz09DAO.selectCmJobUserListForAll(map);
	}

	@Override
	public List<Map<String, String>> selectCmSanClineListForComboBox(Map<String, String> map) throws Exception {
		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		return comz09DAO.selectCmSanClineListForComboBox(map);
	}

	@Override
	public String insertSanClineForCreate(List<Map<String, Object>> list) throws Exception {
		
		String strSanclineSeq = cmSanclineSeq.getNextStringId();
		
		//마스터 입력
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("CURD").equals("M")) {
				iMap.put("SANCLINE_SN", strSanclineSeq);
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz09DAO.insertCmSanClineByPk(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSancline, null, null);
			}
			
		}
		
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("CURD").equals("X")) {
				iMap.put("SANCLINE_SN", strSanclineSeq);
				iMap.put("DETAIL_SN", cmSanclineDetailSeq.getNextStringId());
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz09DAO.insertCmSanClineDetailByPk(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSanclineDetail, null, null);
			}
			
		}
		
		return strSanclineSeq;
	}

	@Override
	public void insertSanClineForUpdate(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("CURD").equals("M")) {
				
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmSancline, null, null);
				comz09DAO.updateCmSanClineByPk(iMap);
				
				List<Map<String, Object>> tmpList = comz09DAO.selectCmSanclineDetailListForInsert(iMap);
				
				for(Map<String, Object> jMap : tmpList) {
					comz06Service.createCmDtaAtrailForDeleteByObject(jMap, atrailCmSanclineDetail, null, null);
				}
				
				comz09DAO.deleteCmSanclineDetailListForInsert(iMap);
				
			}
			
		}
		
		for(Map<String, Object> iMap : list) {
			
			if(iMap.get("CURD").equals("X")) {
				
				iMap.put("DETAIL_SN", cmSanclineDetailSeq.getNextStringId());
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz09DAO.insertCmSanClineDetailByPk(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSanclineDetail, null, null);
				
			}
			
		}
	}

	@Override
	public String insertCmSanctnRequstByCmSanClineDetailInfo(List<Map<String, Object>> list) throws Exception {
		
		String seqRequst = cmSanctnRequstSeq.getNextStringId();
		
		//결재요청 입력
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("REQUST_NO", seqRequst);
		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		map.put("RQESTER_ID", Util.getUserMap().get("USER_ID"));
		map.put("USE_YN", "Y");
		map.put("STTUS_CODE", "01");
		map.put("REQUST_NM", list.get(0).get("REQUST_NM"));
		map.put("REQUST_COMMENT", list.get(0).get("REQUST_COMMENT"));
		comz09DAO.insertCmSanctnRequstByCmSanClineDetailInfo(map);
		comz06Service.createCmDtaAtrailForInsertByObject(map, atrailCmSanCtnRequst, null, null);
		
		//결재처리 입력
		for(Map<String, Object> iMap : list) {
			
			//기안자는 승인상태
			if("01".equals(iMap.get("SANCTN_CODE"))) {
				iMap.put("STTUS_CODE", "02");
			}
			//참조는 확인상태
			else if("06".equals(iMap.get("SANCTN_CODE"))){
				iMap.put("STTUS_CODE", "04");
			}
			//기안자 외는 요청상태로 한다.
			else {
				iMap.put("STTUS_CODE", "01");
			}
			
			iMap.put("REQUST_NO", seqRequst);
			iMap.put("SANCTN_NO", cmSanctnProcessSeq.getNextStringId());
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("SANCTNER_ID", iMap.get("CONFMER_ID"));
			iMap.put("USE_YN", "Y");
			comz09DAO.insertCmSanctnProcessByCmSanClineDetailInfo(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSanCtnProcess, null, null);
		}
		
		return seqRequst;
	}

	@Override
	public List<Map<String, Object>> selectCmSanctnProcessListByPk(Map<String, String> map) throws Exception {
		return comz09DAO.selectCmSanctnProcessListByPk(map);
	}

	@Override
	public String updateCmSanctnProcessByPk(Map<String, String> map) throws Exception {
		
		if(iwrb01DAO.selectUserInfo(map) == 0) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.12"));
		}
		
		//결재요청 번호
		String seqRequst = "";
		
		//반려
		if("03".equals(map.get("STTUS_CODE"))) {
			
			if(comz09DAO.selectCmSanctnProcessCountByPk(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.13"));
			}
			
			if("".equals(EgovStringUtil.nullConvert(map.get("SANCTN_COMMENT")))) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.14"));
			}
			
			if(comz09DAO.selectCmSanctnRequstCountByPk(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.15"));
			}
			
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmSanCtnRequst, null, null);
			comz09DAO.updateCmSanCtnRequstByPk(map);
			
			if(comz09DAO.selectCmSanctnProcessCountByPk3(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.13"));
//				throw new Exception("요청상태가 아닙니다.");
			}
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmSanCtnProcess, null, null);
			comz09DAO.updateCmSanctnProcessByPk(map);
			
			/*
			 * 반려 후 진행중으로 새로 입력은 주석처리 일단 함.
			//진행중으로 새로 입력
			Map<String, Object> map2 = new HashMap<String, Object>();
			seqRequst = cmSanctnRequstSeq.getNextStringId();
			map2.put("REQUST_NO", seqRequst);
			map2.put("USE_YN", "Y");
			map2.put("STTUS_CODE", "01");
			map2.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			map2.put("RQESTER_ID", Util.getUserMap().get("USER_ID"));
			map2.put("REQUST_NM", map.get("REQUST_NM"));
			
			comz09DAO.insertCmSanctnRequstByCmSanClineDetailInfo(map2);
			comz06Service.createCmDtaAtrailForInsertByObject(map2, atrailCmSanCtnRequst, null, null);
			
			//현재 처리 현황 조회
			List<Map<String, Object>> processList = comz09DAO.selectCmSanctnProcessListForUpdate(map);
			
			for(Map<String, Object> iMap : processList) {
				
				//기안자는 승인상태
				if("01".equals(iMap.get("SANCTN_CODE"))) {
					iMap.put("STTUS_CODE", "02");
				}
				//참조는 확인상태
				else if("06".equals(iMap.get("SANCTN_CODE"))){
					iMap.put("STTUS_CODE", "04");
				}
				//기안자 외는 요청상태로 한다.
				else {
					iMap.put("STTUS_CODE", "01");
				}
				
				iMap.put("REQUST_NO", seqRequst);
				iMap.put("SANCTN_NO", cmSanctnProcessSeq.getNextStringId());
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			
				//입력
				comz09DAO.insertCmSanctnProcessByCmSanClineDetailInfo(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmSanCtnProcess, null, null);
			}
			*/
			
		}
		//승인
		else if("02".equals(map.get("STTUS_CODE"))) {
			
			if(comz09DAO.selectCmSanctnProcessCountByPk(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.13"));
//				throw new Exception("요청상태가 없습니다.");
			}
			
			if(comz09DAO.selectCmSanctnProcessCountByPk3(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.16"));
//				throw new Exception("요청상태가 아닙니다.");
			}
			
			if(comz09DAO.selectCmSanctnRequstCountByPk(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.15"));
//				throw new Exception("결재가 진행중이 아닙니다.");
			}
			
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmSanCtnProcess, null, null);
			comz09DAO.updateCmSanctnProcessByPk(map);
			
			if(comz09DAO.selectCmSanctnProcessCountByPk(map) == 0) {
			
				map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				
				comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmSanCtnRequst, null, null);
				comz09DAO.updateCmSanCtnRequstByPk(map);
			}
		}
		//취소
		else if("05".equals(map.get("STTUS_CODE"))) {
			
			if(comz09DAO.selectCmSanctnProcessCountByPk2(map) != 1) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.17"));
//				throw new Exception("승인 및 반려가 이미 진행되었습니다.");
			}
			
			if(comz09DAO.selectCmSanctnRequstCountByPk(map) == 0) {
				throw new Exception(egovMessageSource.getPantheonExceptionMessage("comz09.message.15"));
//				throw new Exception("결재가 진행중이 아닙니다.");
			}
			
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			map.put("USE_YN", "Y");
			
			//취소로 수정
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmSanCtnRequst, null, null);
			comz09DAO.updateCmSanCtnRequstByPk(map);
		}
		
		//이메일 서비스 작성
		/*
		Map<String, String> mailMap = new HashMap<String, String>();
		map.put("HTML_NM", propertiesService.getString("MAIL_TEST_TEMPLATE"));
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		map.put("URL", "52.2.72.199:8080");
		pantheonMailService.sendMail(map, Util.getUserMap().get("EMAIL"), 
				Util.getUserMap().get("USER_NM"), 
				map.get("REQUST_NM") + 
				"##" +map.get("REQUST_NO"));
		*/
		
		return seqRequst;
	}
}
