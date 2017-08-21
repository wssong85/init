package pantheon.com.i01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.f04.service.COMF04Service;
import pantheon.com.h01.dao.COMH01DAO;
import pantheon.com.h01.dao.NTCOMH01DAO;
import pantheon.com.i01.dao.COMI01DAO;
import pantheon.com.i01.service.COMI01Service;
import pantheon.com.i01.web.LoginVO;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMI01Service")
public class COMI01ServiceImpl implements COMI01Service{

	@Resource(name = "COMI01DAO")
	private COMI01DAO comi01DAO;
	
	@Resource(name = "COMF04Service")
	private COMF04Service comf04Service;
	
	@Resource(name = "NTCOMH01DAO")
	private NTCOMH01DAO ntcomh01DAO;
	
	@Resource(name = "CM_SYS_CONECT_SEQ")
	private EgovIdGnrService cmSysConectSeq;
	
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrailCmUser;
	
	@Resource(name = "NTCOMZ06Service")
	private COMZ06Service ntcomz06Service;
	
	@Resource(name = "COMH01DAO")
	private COMH01DAO comh01DAO;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public LoginVO actionLogin(LoginVO vo) throws Exception {
		LoginVO loginVO = comi01DAO.actionLogin(vo);
		if(loginVO == null) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Map<String, String> mapCmSysConect = new HashMap<String, String>();
			
			//접속이력 등록
			if(comi01DAO.selectCmUserForCmSysConect(vo) > 0) {
				mapCmSysConect.put("CONECT_SN", cmSysConectSeq.getNextStringId());
				mapCmSysConect.put("USER_ID", vo.getUserId());
				mapCmSysConect.put("CONECT_SE", "02");
				mapCmSysConect.put("CONECT_IP", request.getRemoteAddr());
			} else {
				mapCmSysConect.put("CONECT_SN", cmSysConectSeq.getNextStringId());
				mapCmSysConect.put("USER_ID", "UNKNOWN");
				mapCmSysConect.put("CONECT_SE", "03");
				mapCmSysConect.put("CONECT_IP", request.getRemoteAddr());
			}
			comf04Service.insertCmSysConectByLogin(mapCmSysConect);
			
		}
		return loginVO;
	}

	@Override
	public List<Map<String, Object>> selectCmMenuForModuleCode(Map<String, String> map) throws Exception {
		List<Map<String, Object>> list = comi01DAO.selectCmMenuForModuleCode(map);
		return list;
	}

	@Override
	public List<Map<String, String>> selectCmMenuByModuleCode(Map<String, Object> map) throws Exception {
		return comi01DAO.selectCmMenuByModuleCode(map);
	}

	@Override
	public List<Map<String, String>> selectCmMenuForLeftMenu(Map<String, String> map) throws Exception {
		return comi01DAO.selectCmMenuForLeftMenu(map);
	}

	@Override
	public List<Map<String, String>> selectCmMenuDistinctForLeftMenu(Map<String, String> map) throws Exception {
		return comi01DAO.selectCmMenuDistinctForLeftMenu(map);
	}
	
	@Override
	public List<Map<String, String>> selectDistinctTaskByLeftMenu(Map<String, String> map) throws Exception {
		return comi01DAO.selectDistinctTaskByLeftMenu(map);
	}
	
	@Override
	public List<Map<String, String>> selectTaskByLeftMenu(Map<String, String> map) throws Exception {
		return comi01DAO.selectTaskByLeftMenu(map);
	}
	
	@Override
	public int selectTaskByMenuCnt(Map<String, String> map) throws Exception {
		return comi01DAO.selectTaskByMenuCnt(map);
	}

	@Override
	public boolean selectCmUserForPasswordChangeDe(Map<String, String> map) throws Exception {
		int ret = comi01DAO.selectCmUserForPasswordChangeDe(map);
		
		if(ret > 90) {
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
			
			//비트랜잭션 계정 잠금
			ntcomh01DAO.updateCmUserForAcntLockAt(map);
			
//			throw new Exception("비밀번호 변경시한이 90일이 넘어서 계정이 잠겼습니다. 관리자에게 문의해 주십시오.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("login.message.6"));
		}
		
		if(ret > 75) {
			return false;
		}
		
		return true;
	}

	@Override
	public List<Map<String, String>> selectCmProgrmForHeaderAllModule(Map<String, String> map) throws Exception {
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		return comi01DAO.selectCmProgrmForHeaderAllModule(map);
	}

	@Override
	public List<Map<String, String>> selectCmProgrmForHeaderTaskModule(Map<String, String> map) throws Exception {
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		return comi01DAO.selectCmProgrmForHeaderTaskModule(map);
	}

}
