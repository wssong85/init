package pantheon.ctms.a01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.a01.service.CTMA01Service;
import pantheon.ctms.a01.dao.CTMA01DAO;

@Service("CTMA01Service")
public class CTMA01ServiceImpl implements CTMA01Service{
	@Resource(name = "CTMA01DAO")
	private CTMA01DAO CTMA01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "CTMS_DMC_NOTICE")
	private EgovIdGnrService ctmsDmcNotice;
	
	@Resource(name = "CTMS_ST_NOTIFY_SEQ")
	private EgovIdGnrService ctmsNotification;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CTMS_DMC_NOTICE")
	protected EgovPropertyService atrailCtmsDmcNotice;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CTMS_ST_NOTIFY")
	protected EgovPropertyService atrailCtmsNotification;
	
	@Override
	public Map<String, Object> selectNoticeInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMA01DAO.selectNoticeInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectNotice(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMA01DAO.selectNotice(map);
	}

	@Override
	public int updateNotice(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public void insertNotice(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("C")){
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				iMap.put("SN", ctmsDmcNotice.getNextStringId());
	
				CTMA01DAO.insertNotice(iMap);	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCtmsDmcNotice, null, null);				
			}else if(iMap.get("CRUD").equals("U")){
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
	
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCtmsDmcNotice, null, null);
				CTMA01DAO.updateNotice(iMap);	
			}else{
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCtmsDmcNotice, null, null);
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				CTMA01DAO.deleteNotice(iMap);	
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectNoticeByCount(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMA01DAO.selectNoticeByCount(map);
	}

/*-------------------------------------------------------------------------------------------------------------------------*/
	
	@Override
	public List<Map<String, Object>> selectNotifyCtmsList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("LOGIN_ID" , Util.getUserMap().get("USER_ID"));
		return CTMA01DAO.selectNotifyCtmsList(map);
	}

	@Override
	public List<Map<String, Object>> selectNotifyDmcList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMA01DAO.selectNotifyDmcList(map);
	}

	@Override
	public void insertNotification(Map<String, Object> map) throws Exception{	
		// TODO Auto-generated method stub
/*        CTMS036
		  A1:연차심의
		 ,B1:ToDo
		 ,C1:개시보고서
		 ,C2:방문보고서
		 ,C3:모니터링보고서
		 ,D1:전자계약요청
		 ,E1:SAE발생
		 ,F1:NIS연구종료요청
		 ,G1:신청자RequestForm
		 ,H1:연구자등록완료
		 ,H2:연구자등록요청
		 ,G2:RequestForm
		 ,I1:Designer승인요청
		 ,I2:DBfreezing승인요청
		 ,I3:DBdefrosting승인요청
		 ,J1:승인완료
		 ,K1:무작위배정해제요청
		 ,K2:무작위배정해체
		 ,L1:SDV Complate
		 ,M1:DM Query
*/
		map.put("NOTIFY_SN" , ctmsNotification.getNextStringId());
		map.put("UPDATE_ID" , Util.getUserMap().get("USER_ID"));
//		map.put("REQUEST_SN", "CTMA01011234"); //요청번호(화면ID+해당업무순번)
//		map.put("JOB_TYPE"  , "C"); //
//		map.put("NTCN_SJ"   , "");  //알림 제목
//		map.put("CHARGER_ID", "");  //담당자 ID 알림 조회 담당자. 전체 조회시 null
//		map.put("LINK_URL"  , "");  //URL Link
//		map.put("LINK_KEY", "");    //MODULE,TASK_SN,EDC_SN
//		map.put("LINK_VALUE", "");  //EDC,1,1
		CTMA01DAO.insertNotification(map);
		comz06Service.createCmDtaAtrailForInsertByObject(map, atrailCtmsNotification, null, null);
	}

	@Override
	public void updateNotification(Map<String, Object> map) throws Exception{	
		// TODO Auto-generated method stub
		String jobType = map.get("JOB_TYPE").toString();
		map.put("PLUSDAYS", "");

		Map<String, Object> notifyInfo = CTMA01DAO.selectNotifyInfo(map);
		
		if("H1".equals(jobType) || "G1".equals(jobType)){ //연구자 등록 완료, Request form 승인
			if(notifyInfo != null){
				//기존 알림 USE_AT = 'N' 처리
				comz06Service.createCmDtaAtrailForUpdateByObject(notifyInfo, atrailCtmsNotification, null, null);
				CTMA01DAO.updateNotification(notifyInfo);
				map.put("CHARGER_ID", notifyInfo.get("CHARGER_ID")); //요청자, 담당자
			}
			else{
				map.put("CHARGER_ID", map.get("USER_ID")); //요청자, 담당자
			}
			
			map.put("PLUSDAYS"  , "3"); //3일간 알림
		}
		
		map.put("NOTIFY_SN" , ctmsNotification.getNextStringId());
		map.put("UPDATE_ID" , Util.getUserMap().get("USER_ID"));
		
		CTMA01DAO.insertNotification(map);
		comz06Service.createCmDtaAtrailForInsertByObject(map, atrailCtmsNotification, null, null);
	}

}
