package pantheon.ctms.j04.service.impl;

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
import pantheon.ctms.j04.dao.DMCJ04DAO;
import pantheon.ctms.j04.service.DMCJ04Service;


@Service("DMCJ04Service")
public class DMCJ04ServiceImpl implements DMCJ04Service{
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMA01Service")
	private CTMA01Service ctma01service;
	
	@Resource(name = "CTMS_REQUEST_FORM_MAX")
	private EgovIdGnrService ctmsRequestFormMax;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CO_REQUEST_FORM")
	protected EgovPropertyService atrailRequestForm;

	@Resource(name = "DMCJ04DAO")
	private DMCJ04DAO DMCJ04DAO;

	@Override
	public List<Map<String, Object>> selectRequestList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ04DAO.selectRequestList(map);
	}
	
	//유저정보조회
	@Override
	public List<Map<String, Object>> selectUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ04DAO.selectUserInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCommonCodeList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ04DAO.selectCommonCodeList(map);
	}

	@Override
	public int selectRequestListByCount(Map<String, String> map) throws Exception {		
		return DMCJ04DAO.selectRequestListByCount(map);
	}

	@Override
	public void insertRequestForm(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {			
			if(iMap.get("CRUD").equals("U")){					
				DMCJ04DAO.updateRequestFormBySttus(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailRequestForm, null, null);
				
				Map<String, Object> map = new HashMap<String, Object>();
				String requestNo = "CTMH0102" + iMap.get("SN").toString() + iMap.get("TASK_SN").toString(); //CTMG0102 연구자등록 요청 화면ID
				map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
				map.put("JOB_TYPE"  , "G1");
				map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
				map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
				map.put("LINK_URL"  , "/ctms/h01/CTMH0101.do");  //URL Link
				map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
				map.put("LINK_VALUE", "");  //EDC,1,1
				
				if("02".equals(iMap.get("APPROVAL"))){ //승인
					map.put("NOTIFY_SJ" , "Request form이 승인 되었습니다.");  //알림 제목
				}
				else if("03".equals(iMap.get("APPROVAL"))){ //반려
					map.put("NOTIFY_SJ" , "Request form이 반려 되었습니다.");  //알림 제목
				}
				
				ctma01service.updateNotification(map);
			}
		}
		
	}


	


	
	
	
	

}

	



















