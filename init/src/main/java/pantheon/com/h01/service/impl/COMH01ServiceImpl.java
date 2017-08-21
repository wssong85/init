package pantheon.com.h01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.f01.dao.COMF01DAO;
import pantheon.com.h01.dao.COMH01DAO;
import pantheon.com.h01.dao.NTCOMH01DAO;
import pantheon.com.h01.service.COMH01Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMH01Service")
public class COMH01ServiceImpl implements COMH01Service{

	@Resource(name = "COMH01DAO")
	private COMH01DAO comh01DAO;
	
	@Resource(name = "COMF01DAO")
	private COMF01DAO comf01DAO;
	
	@Resource(name = "NTCOMH01DAO")
	private NTCOMH01DAO ntcomh01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "NTCOMZ06Service")
	private COMZ06Service ntcomz06Service;
	
	@Resource(name = "ATRAIL_CM_RSRCHUSER")
	protected EgovPropertyService atrailCmRsrchuser;
	
	@Resource(name = "ATRAIL_CM_JOBUSER")
	protected EgovPropertyService atrailCmJobuser;
	
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrailCmUser;
	
	@Resource(name = "ATRAIL_CM_USER_ROLE")
	protected EgovPropertyService atrailCmUserRole;
	
	@Resource(name = "ATRAIL_CTMS_CNTRCT_MANAGE")
	protected EgovPropertyService atrailCtmsCntrctManage;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public int selectEdcCrTaskCountForDupCheckByTaskNo(String str) throws Exception {
		return comh01DAO.selectEdcCrTaskCountForDupCheckByTaskNo(str);
	}

	@Override
	public void insertCmUserForJoin(Map<String, String> map) throws Exception {
		comh01DAO.insertCmUserForJoin(map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&전자 계약&" + Util.getHttpServletRequest().getRemoteAddr());
	}

	@SuppressWarnings("unchecked")
	@Override
	public void insertCmRsrchuserForJoin(Map<String, String> map) throws Exception {
		map.put("UPDATE_ID", map.get("USER_ID"));
		
		comh01DAO.insertCmUserForJoin(map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&전자 계약&" + Util.getHttpServletRequest().getRemoteAddr());
		
		comh01DAO.insertCmRsrchuserForJoin(map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmRsrchuser, null, "CONVERT_PROGRM_NM&전자 계약&" + Util.getHttpServletRequest().getRemoteAddr());
		
		map.put("ROLE_ID", "ROLE_PI");
		map.put("USE_YN", "Y");
		
		comf01DAO.insertCmUserRoleByUserId((Map<String, Object>)(Object)map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmUserRole, null, "CONVERT_PROGRM_NM&전자 계약&" + Util.getHttpServletRequest().getRemoteAddr());
		
	}

	@Override
	public List<Map<String, Object>> selectCmStdTimeForJoin() throws Exception {
		return comh01DAO.selectCmStdTimeForJoin();
	}

	@Override
	public int updateCtmsCoCntrctManageForJoin(Map<String, String> map) throws Exception {
		
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCtmsCntrctManage, null, null);
		int ret = comh01DAO.updateCtmsCoCntrctManageForJoin(map);
		
		return ret;
	}

	@Override
	public void insertCtmsCoCntrctManageForJoin(Map<String, String> map) throws Exception {
//		map.put("TASK_NO", "CJ_A00_101");
		map.put("TASK_NO", EgovStringUtil.isNullToString(Util.getHttpSession().getAttribute("JOIN_TASK_NO")));
		map.put("TASK_SN", comh01DAO.selectEdcCrTaskForTaskSn(map));
		map.put("CNTRCT_SN", comh01DAO.selectCtmsCoCntrctManageForSeq());
		map.put("LAST_UPDUSR", map.get("USER_ID"));
		comh01DAO.insertCtmsCoCntrctManageForJoin(map);
		comz06Service.createCmDtaAtrailForInsertByString(map, atrailCtmsCntrctManage, null, "CONVERT_PROGRM_NM&전자 계약&" + Util.getHttpServletRequest().getRemoteAddr());
	}

	@Override
	public int selectCmUserCountForDupCheck(String str) throws Exception {
		return comh01DAO.selectCmUserCountForDupCheck(str);
	}

	@Override
	public Map<String, String> selectCmUserByReqUserId(String str) throws Exception {
		return comh01DAO.selectCmUserByReqUserId(str);
	}

	@Override
	public void selectCmUserForContractReq(Map<String, String> map) throws Exception {
		
		//아이디 확인
		if(comh01DAO.selectCmUserByUserId(map) == 0) {
//			throw new Exception("사용자 아이디를 확인해 주십시오.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comh01.message.3"));
		}
		
		//아이디 삭제 여부 확인
		if(comh01DAO.selectCmUserByUseYn(map) == 0) {
//			throw new Exception("삭제된 사용자 입니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comh01.message.4"));
		}
		
		//아이디 계정 잠금 여부 확인
		if(comh01DAO.selectCmUserByAcntLockAt(map) > 0) {
//			throw new Exception("계정이 잠겨있습니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comh01.message.5"));
		}
		
		//아이디 존재 여부
		if(comh01DAO.selectCmUserForContractReq(map) == 0) {
			
			Map<String, String> mapUser = comh01DAO.selectCmUserForAcntLockAt(map);			
			
			int loginFailrCo = Integer.parseInt(EgovStringUtil.isNullToString(mapUser.get("LOGIN_FAILR_CO"))) + 1;
			
			map.put("LOGIN_FAILR_CO", EgovStringUtil.isNullToString(loginFailrCo));
			
			if(loginFailrCo > 2) {
				map.put("ACNT_LOCK_AT", "Y");
			} else {
				map.put("ACNT_LOCK_AT", "N");
			}
			
			//비트랜잭션 audit trail
			ntcomz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&ID CHECK&" + Util.getHttpServletRequest().getRemoteAddr());
			
			//비트랜잭션 사용자 로그인횟수 update
			ntcomh01DAO.updateCmUserForAcntLockAt(map);
			
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comh01.message.6") + comh01DAO.selectCmUserForLoginFailrCo(map));
			
//			throw new Exception("비밀번호를 확인해 주십시오. 실패횟수 :" + comh01DAO.selectCmUserForLoginFailrCo(map));
		}
		
		map.put("LOGIN_FAILR_CO", "0");
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&ID CHECK&" + Util.getHttpServletRequest().getRemoteAddr());
		comh01DAO.updateCmUserForLoginFailrCo(map);
	}

	@Override
	public int selectCmRsrchuserCountByUserId(String str)throws Exception {
		return comh01DAO.selectCmRsrchuserCountByUserId(str);
	}

	@Override
	public int selectCmUserCountForEmail(String str) throws Exception {
		return comh01DAO.selectCmUserCountForEmail(str);
	}
}
