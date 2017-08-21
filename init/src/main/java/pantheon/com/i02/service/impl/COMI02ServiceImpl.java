package pantheon.com.i02.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.h01.dao.COMH01DAO;
import pantheon.com.i02.dao.COMI02DAO;
import pantheon.com.i02.service.COMI02Service;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMI02Service")
public class COMI02ServiceImpl implements COMI02Service{
	
	@Resource(name = "COMI02DAO")
	private COMI02DAO comi02DAO;
	
	@Resource(name = "ATRAIL_CM_USER")
	protected EgovPropertyService atrailCmUser;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "COMH01DAO")
	private COMH01DAO comh01DAO;
	
	/** EmailService */
	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public Map<String, String> selectCmUserForFindId(Map<String, String> map) throws Exception {
		return comi02DAO.selectCmUserForFindId(map);
	}

	@Override
	public void updateCmUserForSendTmpMail(Map<String, String> map) throws Exception {
		if(comi02DAO.selectCmUserForSendTmpMail(map) > 0 ) {

			map.put("PASSWORD_CODE", Util.getStrRnd());
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, null);
			comi02DAO.updateCmUserForSendTmpMail(map);
			
			Map<String, String> sendMap = new HashMap<String, String>();
			//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
			sendMap.put("HTML_NM", propertiesMailService.getString("PASSWORD_MAIL_TEMPLATE"));
			//html에는 el식 기준으로 작성하면 변환됨
			sendMap.put("USER_NM", map.get("USER_NM"));
			
			HttpServletRequest req = Util.getHttpServletRequest();
			sendMap.put("URL", req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()  + "/com/anonymous/COMI0204.do?PASSWORD_CODE=" + map.get("PASSWORD_CODE"));
//			pantheonMailService.sendMail(sendMap, map.get("EMAIL"), map.get("USER_NM"), "[판테온시스템]비밀번호변경 안내드립니다.");
			pantheonMailService.sendMail(sendMap, map.get("EMAIL"), map.get("USER_NM"), egovMessageSource.getPantheonMessageByOriginal("comi02.message.15"));
		} else {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.14"));
		}
	}

	@Override
	public void updateCmUserForChgPassword(Map<String, String> map) throws Exception {
		if(comi02DAO.selectCmUserForChgPassword(map) > 0) {
//			throw new Exception("기존 패스워드와 동일합니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.16"));
		}
		
		map.put("ACNT_LOCK_AT", "N");
		map.put("LOGIN_FAILR_CO", "0");
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&ID CHECK&" + Util.getHttpServletRequest().getRemoteAddr());
		
		if(comi02DAO.updateCmUserForChgPassword(map) == 0) {
//			throw new Exception("아이디 또는 비밀번호가 일치하지 않습니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.17"));
		} 
	}

	@Override
	public void updateCmUserForChgPasswordByPasswordCode(Map<String, String> map) throws Exception {
		if(comi02DAO.selectCmUserCountByPasswordCode(map) == 0) {
//			throw new Exception("패스워드코드가 초기화 되었습니다. 다시 비밀번호 변경 신청을 하십시오.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.18"));
		}
		
		if(comi02DAO.selectCmUserForChgPassword(map) > 0) {
//			throw new Exception("기존 패스워드와 동일합니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.19"));
		}

		//updateCmUserForChgPasswordByPasswordCode 이력
		map.put("ACNT_LOCK_AT", "N");
		map.put("LOGIN_FAILR_CO", "0");
		//updateCmuserByPasswordCode 이력
		map.put("PASSWORD_CODE", "");
		
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&ID CHECK&" + Util.getHttpServletRequest().getRemoteAddr());
		
		if(comi02DAO.updateCmUserForChgPasswordByPasswordCode(map) == 0) {
//			throw new Exception("아이디 또는 비밀번호가 일치하지 않습니다.");
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comi02.message.17"));
		}
		
		comi02DAO.updateCmuserByPasswordCode(map);
	}

	@Override
	public String updateCmUserForMainClick(Map<String, String> map) throws Exception {
		String strRnd = Util.getStrRnd();
		
		map.put("PASSWORD_CODE", strRnd);
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		map.put("USER_NM", Util.getUserMap().get("USER_NM"));
		map.put("EMAIL", Util.getUserMap().get("EMAIL"));
		
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, "CONVERT_PROGRM_NM&ID CHECK&" + Util.getHttpServletRequest().getRemoteAddr());
		comi02DAO.updateCmUserForSendTmpMail(map);
		
		return strRnd;
	}
}
