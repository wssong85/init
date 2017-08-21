package pantheon.ctms.g01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.ctms.a01.service.CTMA01Service;
import pantheon.ctms.g01.dao.CTMG01DAO;
import pantheon.ctms.g01.service.CTMG01Service;

@Service("CTMG01Service")
public class CTMG01ServiceImpl implements CTMG01Service{

	@Resource(name = "CTMG01DAO")
	private CTMG01DAO CTMG01DAO;
	
	@Resource(name = "CTMA01Service")
	private CTMA01Service ctma01service;

	@Override
	public int selectRsrchuserCount(Map<String, String> map)
			throws Exception {
		return CTMG01DAO.selectRsrchuserCount(map);
	}

	@Override
	public List<Map<String, Object>> selectRsrchuserList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return CTMG01DAO.selectRsrchuserList(map);
	}
/*----------------------------------------------------------------------------------------------------------*/
	@Override
	public List<Map<String, Object>> standardTimeList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMG01DAO.standardTimeList(map);
	}

	@Override
	public void insertRsrchUserInfo(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {	
			if(iMap.get("CRUD").equals("C")){
				CTMG01DAO.insertInsttInfo(iMap);
				CTMG01DAO.insertRsrchUserInfo(iMap);
				CTMG01DAO.insertUserInfo(iMap);	
				CTMG01DAO.insertUserRoleInfo(iMap);	
				CTMG01DAO.insertTaskUserRoleInfo(iMap);	
				CTMG01DAO.insertUserTaskInfo(iMap);
				
				if("02".equals(iMap.get("CONFM_SE").toString())){
					
					/* CTMS036
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
					 ,I1:Designer 승인요청
					 ,I2:DB freezing 승인요청
					 ,I3:DB defrosting 승인요청
					 ,J1:승인완료
					 ,K1:무작위배정해제요청
					 ,K2:무작위배정해체
					 ,L1:SDV Complate
					 ,M1:DM Query
					*/
					//알림 생성
					Map<String, Object> map = new HashMap<String, Object>();
					String requestNo = "CTMG0102" + iMap.get("USER_ID").toString() + iMap.get("TASK_SN").toString();
					map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
					map.put("JOB_TYPE"  , "H2");
					map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
					map.put("NOTIFY_SJ" , "연구자 등록 요청입니다.");  //알림 제목
					map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
					map.put("LINK_URL"  , "/ctms/j06/DMCJ0601.do");  //URL Link
					map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
					map.put("LINK_VALUE", "");  //EDC,1,1
					ctma01service.insertNotification(map);
				}
				
			}else if(iMap.get("CRUD").equals("U")){
				CTMG01DAO.updateUserInfo(iMap);
				CTMG01DAO.updateUserRoleInfo(iMap);
				CTMG01DAO.insertTaskUserRoleInfo(iMap);
				CTMG01DAO.insertUserTaskInfo(iMap);
				
				int cnt = CTMG01DAO.selectTaskUserCount(iMap);
				
				if(cnt == 0){
					//알림 생성
					Map<String, Object> map = new HashMap<String, Object>();
					String requestNo = "CTMG0102" + iMap.get("USER_ID").toString() + iMap.get("TASK_SN").toString();
					map.put("REQUEST_SN", requestNo); //요청번호(화면ID+해당업무순번 또는 중복 불가능한 값)
					map.put("JOB_TYPE"  , "H2");
					map.put("TASK_SN"   , iMap.get("TASK_SN").toString());
					map.put("NOTIFY_SJ" , "연구자 등록 요청입니다.");  //알림 제목
					map.put("CHARGER_ID", Util.getUserMap().get("USER_ID"));  //담당자 ID 알림 조회 담당자. 전체 조회시 null
					map.put("LINK_URL"  , "/ctms/j06/DMCJ0601.do");  //URL Link
					map.put("LINK_KEY"  , "");    //MODULE,TASK_SN,EDC_SN
					map.put("LINK_VALUE", "");  //EDC,1,1
					ctma01service.insertNotification(map);
				}
			}else{
				CTMG01DAO.deleteTaskUserInfo(iMap);
			}
			
		}
		
	}

	@Override
	public List<Map<String, Object>> selectCmUser(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return CTMG01DAO.selectCmUser(map);
	}

	@Override
	public void deleteTaskUserRoleInfo(List<Map<String, Object>> list)
			throws Exception {
		// TODO Auto-generated method stub
		for(Map<String, Object> iMap : list) {	
			CTMG01DAO.deleteTaskUserRoleInfo(iMap);
		}
	}

	

}
