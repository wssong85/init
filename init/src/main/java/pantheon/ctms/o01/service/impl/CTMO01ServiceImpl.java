package pantheon.ctms.o01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.o01.dao.CTMO01DAO;
import pantheon.ctms.o01.service.CTMO01Service;

@Service("CTMO01Service")
public class CTMO01ServiceImpl implements CTMO01Service{

	@Resource(name = "CTMO01DAO")
	private CTMO01DAO CTMO01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMS_RSRCH_INSTT_MAX") //조사연구기관
	private EgovIdGnrService ctmsRsrchInsttMax;
	
	@Resource(name = "CTMS_RSRCH_RSRCCT_MAX") //연구비
	private EgovIdGnrService ctmsRsrchRsrcctMax;
	
	@Resource(name = "CTMS_RSRCH_DLBRT_MAX") //IRB심의
	private EgovIdGnrService ctmsRsrchDlbrtMax;
	
	@Resource(name = "CTMS_RSRCH_WRTCNS_MAX") //동의서
	private EgovIdGnrService ctmsRsrchWrtcnsMax;
	
	@Resource(name = "CTMS_RSRCH_VER_MAX") //버전관리
	private EgovIdGnrService ctmsRsrchVerMax;
	
	/** EgovPropertyService */	
	@Resource(name = "ATRAIL_CTMS_RSRCHUSER") //연구자정보
	protected EgovPropertyService atrailRsrchUser;
	
	@Resource(name = "ATRAIL_CTMS_RSRCH_INSTT") //조사연구기관
	protected EgovPropertyService atrailRsrchInstt;
	
	@Resource(name = "ATRAIL_CTMS_CNTRCT_MANAGE") //계약관리
	protected EgovPropertyService atrailCntrctManage;
	
	@Resource(name = "ATRAIL_CTMS_RSRCH_RSRCCT") //연구비
	protected EgovPropertyService atrailRsrchRsrcct;
	
	@Resource(name = "ATRAIL_CTMS_RSRCH_DLBRT") //IRB심의
	protected EgovPropertyService atrailRsrchdlbrt;
	
	@Resource(name = "ATRAIL_CTMS_RSRCH_WRTCNS") //동의서
	protected EgovPropertyService atrailrsrchWrtcns;
	
	@Resource(name = "ATRAIL_CTMS_RSRCH_VER") //버전관리
	protected EgovPropertyService atrailRsrchVer;
	
	@Resource(name = "ATRAIL_CM_USERTASK") //과제 사용자
	protected EgovPropertyService atrail_cm_usertask;

	
	
	//연구자정보 조회
	@Override
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMO01DAO.selectRsrchUserInfo(map);
	}
	
	//연구자정보 저장
	@Override
	public void updateRsrchUserInfo(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("U")){	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchUser, null, null);
				CTMO01DAO.updateRsrchUserInfo(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_usertask, null, null);
				CTMO01DAO.updateActive(iMap);
			}		
		}
	}
	
	//조사연구기관 조회
	@Override
	public List<Map<String, Object>> selectRsrchInstt(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMO01DAO.selectRsrchInstt(map);
	}
	
	//조사연구기관 저장
	@Override
	public void insertRsrchInstt(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {	
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchInstt, null, null);
			iMap.put("SN", ctmsRsrchInsttMax.getNextStringId());
			CTMO01DAO.insertRsrchInstt(iMap);
		}
		
	}
	
	//계약관리 조회
	@Override
	public List<Map<String, Object>> selectCntrctManage(Map<String, String> map)
			throws Exception {
		
		return CTMO01DAO.selectCntrctManage(map);
	}

	//계약관리 저장
	@Override
	public void updateCntrctManage(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {		
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCntrctManage, null, null);
			CTMO01DAO.updateCntrctManage(iMap);
		}
		
	}
	
	//연구비 조회
	@Override
	public List<Map<String, Object>> selectResearchFunds(Map<String, String> map)
			throws Exception {
		return CTMO01DAO.selectResearchFunds(map);
	}
	
	//연구비 저장
	@Override
	public void insertResearchFunds(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				iMap.put("SN", ctmsRsrchRsrcctMax.getNextStringId());				
				CTMO01DAO.insertResearchFunds(iMap);	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchRsrcct, null, null);
			}else if(iMap.get("CRUD").equals("U")){		
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchRsrcct, null, null);
				CTMO01DAO.updateResearchFunds(iMap);				
			}else{				
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchRsrcct, null, null);
				CTMO01DAO.deleteResearchFunds(iMap);				
			}
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCntrctManage, null, null);
			CTMO01DAO.updatePymntCnt(iMap);
		}
		
	}
	
	//IRB심의 조회
	@Override
	public List<Map<String, Object>> selectRsrchDlbrt(Map<String, String> map)
			throws Exception {
		return CTMO01DAO.selectRsrchDlbrt(map);
	}
	
	//IRB심의 저장 
	@Override
	public void insertRsrchDlbrt(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				iMap.put("SN", ctmsRsrchDlbrtMax.getNextStringId());
				CTMO01DAO.insertRsrchDlbrt(iMap);		
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchdlbrt, null, null);
			}else if(iMap.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchdlbrt, null, null);
				CTMO01DAO.updateRsrchDlbrt(iMap);
			}else{
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchdlbrt, null, null);
				CTMO01DAO.deleteRsrchDlbrt(iMap);
			}				
		}		
	}
		
	//동의서 조회
	@Override
	public List<Map<String, Object>> selectRsrchWrtcns(Map<String, String> map)
			throws Exception {
		return CTMO01DAO.selectRsrchWrtcns(map);
	}
	 
	//동의서 저장 
	@Override
	public void insertRsrchWrtcns(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				iMap.put("SN", ctmsRsrchWrtcnsMax.getNextStringId());				
				CTMO01DAO.insertRsrchWrtcns(iMap);	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailrsrchWrtcns, null, null);
			}else if(iMap.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailrsrchWrtcns, null, null);
				CTMO01DAO.updateRsrchWrtcns(iMap);
			}else{
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailrsrchWrtcns, null, null);
				CTMO01DAO.deleteRsrchWrtcns(iMap);
			}
				
		}
		
	}
	
	//버전관리 조회
	@Override
	public List<Map<String, Object>> selectRsrchVer(Map<String, String> map)
			throws Exception {
		return CTMO01DAO.selectRsrchVer(map);
	}
		
	//버전관리 저장 
	@Override
	public void insertRsrchVer(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				iMap.put("SN", ctmsRsrchVerMax.getNextStringId());				
				CTMO01DAO.insertRsrchVer(iMap);	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchVer, null, null);
			}else if(iMap.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchVer, null, null);
				CTMO01DAO.updateRsrchVer(iMap);
			}else{
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRsrchVer, null, null);
				CTMO01DAO.deleteRsrchVer(iMap);
			}
				
		}
		
	}
}

	



















