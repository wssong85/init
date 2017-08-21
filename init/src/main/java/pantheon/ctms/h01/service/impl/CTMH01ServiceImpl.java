package pantheon.ctms.h01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.a01.service.CTMA01Service;
import pantheon.ctms.h01.dao.CTMH01DAO;
import pantheon.ctms.h01.service.CTMH01Service;
import pantheon.ctms.r01.dao.CTMR01DAO;


@Service("CTMH01Service")
public class CTMH01ServiceImpl implements CTMH01Service{
	
	@Resource(name = "CTMR01DAO")
	private CTMR01DAO ctmr01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMA01Service")
	private CTMA01Service ctma01service;
	
	@Resource(name = "CTMS_REQUEST_FORM_MAX")
	private EgovIdGnrService ctmsRequestFormMax;
	

	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CO_REQUEST_FORM")
	protected EgovPropertyService atrailRequestForm;
	
	@Resource(name = "ATRAIL_DM_FILE_DETAIL")
	protected EgovPropertyService atrailDmFileDetail;	
	
	@Resource(name = "CTMH01DAO")
	private CTMH01DAO ctmh01DAO;

	@Override
	public List<Map<String, Object>> selectRequestList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmh01DAO.selectRequestList(map);
	}
	
	//유저정보조회
	@Override
	public List<Map<String, Object>> selectUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmh01DAO.selectUserInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCommonCodeList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmh01DAO.selectCommonCodeList(map);
	}

	@Override
	public List<Map<String, Object>> selectRequestFileNm(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmh01DAO.selectRequestFileNm(map);
	}
	
	//Request Form 저장/수정/삭제
	@Override
	public void insertRequestForm(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("C")){
				String snSeq = ctmsRequestFormMax.getNextStringId();
				iMap.put("SN", snSeq);				
				ctmh01DAO.insertRequestForm(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRequestForm, null, null);

				if("01".equals(iMap.get("STTUS"))){//요청
					Map<String, Object> map = new HashMap<String, Object>();
					String requestNo = "CTMH0102" + snSeq + iMap.get("TASK_SN").toString();
					map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
					map.put("JOB_TYPE"  , "G2");
					map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
					map.put("NOTIFY_SJ" , "Request form 요청입니다.");  //알림 제목
					map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
					map.put("LINK_URL"  , "/ctms/j04/DMCJ0401.do");  //URL Link
					map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
					map.put("LINK_VALUE", "");  //EDC,1,1
					ctma01service.insertNotification(map);
				}
			}else if(iMap.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailRequestForm, null, null);
				ctmh01DAO.updateRequestForm(iMap);

				if("01".equals(iMap.get("STTUS"))){ //요청
					Map<String, Object> map = new HashMap<String, Object>();
					String requestNo = "CTMH0102" + iMap.get("SN") + iMap.get("TASK_SN").toString();
					map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
					map.put("JOB_TYPE"  , "G2");
					map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
					map.put("NOTIFY_SJ" , "Request form 요청입니다.");  //알림 제목
					map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
					map.put("LINK_URL"  , "/ctms/j04/DMCJ0401.do");  //URL Link
					map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
					map.put("LINK_VALUE", "");  //EDC,1,1
					ctma01service.insertNotification(map);
				}
			}else if(iMap.get("CRUD").equals("D")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailRequestForm, null, null);
				ctmh01DAO.deleteRequestForm(iMap);
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailRequestForm, null, null);
				ctmh01DAO.updateRequestFormBySttus(iMap);
			}
		}
	}
	
	//UploadFile 삭제
	@Override
	public void insertFileUpload(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("D")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailDmFileDetail, null, null);				
				ctmh01DAO.deleteUploadFile(iMap);
			}			
		}		
	}

	@Override
	public int selectRequestListByCount(Map<String, String> map) throws Exception {		
		return ctmh01DAO.selectRequestListByCount(map);
	}
	


	
	
	
	

}

	



















