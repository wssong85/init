package pantheon.ctms.j06.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.impl.PantheonMailServiceImpl;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.a01.service.CTMA01Service;
import pantheon.ctms.j06.dao.DMCJ06DAO;
import pantheon.ctms.j06.service.DMCJ06Service;

@Service("DMCJ06Service")
public class DMCJ06ServiceImpl implements DMCJ06Service {
	private static final Logger log = LoggerFactory.getLogger(PantheonMailServiceImpl.class);
	
	@Resource(name = "DMCJ06DAO")
	private DMCJ06DAO dmcj06DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CTMA01Service")
	private CTMA01Service ctma01service;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CM_USERTASK")
	protected EgovPropertyService atrail_cm_usertask;

	@Override
	public List<Map<String, Object>> selectRsrchManage(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj06DAO.selectRsrchManage(map);
	}

	@Override
	public List<Map<String, Object>> selectRsrUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj06DAO.selectRsrUserInfo(map);
	}

	@Override
	public void insertRsrchManage(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("U")) {
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_cm_usertask, null, null);
				dmcj06DAO.updateRsrchManage(iMap);
				
				Map<String, Object> map = new HashMap<String, Object>();
				String requestNo = "CTMG0102" + iMap.get("USER_ID").toString() + iMap.get("TASK_SN").toString(); //CTMG0102 연구자등록 요청 화면ID
				map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
				map.put("JOB_TYPE"  , "H1");
				map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
				map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
				map.put("LINK_URL"  , "/ctms/g01/CTMG0101.do");  //URL Link
				map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
				map.put("LINK_VALUE", "");  //EDC,1,1
				
				if("03".equals(iMap.get("APPROVAL"))){ //승인
					map.put("NOTIFY_SJ" , "연구자 등록이 완료 되었습니다.");  //알림 제목
				}
				else if("04".equals(iMap.get("APPROVAL"))){ //반려
					map.put("NOTIFY_SJ" , "연구자 등록이 완료 되었습니다.");  //알림 제목
				}
				
				ctma01service.updateNotification(map);

			}else{				
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_cm_usertask, null, null);
				dmcj06DAO.deleteUserTask(iMap);
				
				Map<String, Object> map = new HashMap<String, Object>();
				String requestNo = "CTMG0102" + iMap.get("USER_ID").toString() + iMap.get("TASK_SN").toString(); //CTMG0102 연구자등록 요청 화면ID
				map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
				map.put("JOB_TYPE"  , "H1");
				map.put("NOTIFY_SJ" , "연구자 등록이 삭제 되었습니다.");  //알림 제목
				map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
				map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
				map.put("LINK_URL"  , "/ctms/g01/CTMG0101.do");  //URL Link
				map.put("LINK_KEY"  , "");  //MODULE,TASK_SN,EDC_SN
				map.put("LINK_VALUE", "");  //EDC,1,1
				
				ctma01service.updateNotification(map);
			}				
		}	
	}

}

	



















