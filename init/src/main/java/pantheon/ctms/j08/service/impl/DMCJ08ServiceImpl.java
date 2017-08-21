package pantheon.ctms.j08.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.j08.dao.DMCJ08DAO;
import pantheon.ctms.j08.service.DMCJ08Service;


@Service("DMCJ08Service")
public class DMCJ08ServiceImpl implements DMCJ08Service{

	@Resource(name = "DMCJ08DAO")
	private DMCJ08DAO DMCJ08DAO;

	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "CM_TASK_USER_ROLE_SEQ")
	private EgovIdGnrService cm_task_user_role_seq;
	
	/** EgovPropertyService */
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrail_cm_user;
	
	@Resource(name = "ATRAIL_CM_BCNCUSER")
	protected EgovPropertyService atrail_cm_bcncuser;
	
	@Resource(name = "ATRAIL_CM_INSTT")
	protected EgovPropertyService atrail_cm_instt;
	
	@Resource(name = "ATRAIL_CM_USERTASK")
	protected EgovPropertyService atrail_cm_usertask;
	
	@Resource(name = "ATRAIL_CM_USER_ROLE")
	protected EgovPropertyService atrail_cm_user_role;
	
	@Resource(name = "ATRAIL_CM_TASK_USER_ROLE")
	protected EgovPropertyService atrail_cm_task_user_role;
	
	
	
	
	
	@Override
	public List<Map<String, Object>> selectTaskUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ08DAO.selectTaskUserInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ08DAO.selectCommonCodeList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectOverlapUserInfo(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ08DAO.selectOverlapUserInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> selectUserRoleId(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return DMCJ08DAO.selectUserRoleId(map);
	}
	
	@Override
	public void insertTaskUserInfo(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CRUD").equals("D")) {
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_cm_user, null, null);
				DMCJ08DAO.deleteTaskUserInfo(iMap); 
			}			
		}			
	}
	//사용자정보 저장
	@Override
	public void insertTaskUser(List<Map<String, Object>> list)
			throws Exception {		
		
		for(Map<String, Object> iMap : list) {
			//iMap.put("PASSWORD", getStrPasswordRnd()); //PASSWORD RANDOM 생성			
			iMap.put("PASSWORD", "1234"); //PASSWORD RANDOM 생성
			if(iMap.get("CRUD").equals("C")){
				if(iMap.get("INSTT_TY").equals("02") || iMap.get("INSTT_TY").equals("03")){ //기관유형이 수탁기관,기타이면..
					DMCJ08DAO.insertCm_Instt(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_instt, null, null);
					DMCJ08DAO.insertBcncUser(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_bcncuser, null, null);	
					DMCJ08DAO.insertCm_User(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_user, null, null);					
				}
				System.out.println("PASSWORD::::::::::::::::::::::::::::"+iMap.get("PASSWORD"));
				DMCJ08DAO.insertTaskUser(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_usertask, null, null);				
			}else if(iMap.get("CRUD").equals("U")){
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrail_cm_user, null, null);
				DMCJ08DAO.updateCm_User(iMap);
				
			}
			DMCJ08DAO.insertUserByRole(iMap);	
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_user_role, null, null);
			
			iMap.put("ROLE_SN", cm_task_user_role_seq.getNextStringId());
			DMCJ08DAO.insertTaskUserByRole(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrail_cm_task_user_role, null, null);
			
			
		}
		
		
	}

	@Override
	public List<Map<String, Object>> standardTimeList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub		
		return DMCJ08DAO.standardTimeList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectRoleId(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub		
		return DMCJ08DAO.selectRoleId(map);
	}
	
	//사용자 역할 삭제
	@Override
	public void deleteTaskUserByRole(List<Map<String, Object>> list)
			throws Exception {
		for(Map<String, Object> iMap : list) {
			DMCJ08DAO.deleteTaskUserByRole(iMap);
		}
		
	}
	
	//사용자 role 정보 조회
	@Override
	public List<Map<String, Object>> selectUserRoleInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return DMCJ08DAO.selectUserRoleInfo(map);
	}
	
	/**
	 * 랜덤문자 패스워드 생성
	 * 
	 * @return
	 */
	public static String getStrPasswordRnd() throws Exception {
		Random rnd = new Random();

		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < 10; i++) {
			if (rnd.nextBoolean()) {
				buf.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		return buf.toString() + "!@12";
	}

}

	
		

	
	

	


	
	
	



	



















