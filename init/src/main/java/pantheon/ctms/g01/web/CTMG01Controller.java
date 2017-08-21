package pantheon.ctms.g01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.g01.service.CTMG01Service;



@Controller
public class CTMG01Controller {

	@Resource(name="CTMG01Service")
	private CTMG01Service CTMG01Service;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	/**
	 * Investigational Infomation
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctms/g01/CTMG0101.do")
	public String CTMG0101(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception {
		//model.addAttribute("SCREEN_ID", "CTMG0101");
		//model.addAttribute("USER_ID", Util.getUserMap().get("USER_ID"));
		return "/pantheon/ctms/g01/CTMG0101";
	}

	/**
	 * 연구자 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/g01/selectRsrchuserList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchuserList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null;
		Map<String, String> param = new HashMap<String, String>(); //role 공통코드
		Map<String, String> param2 = new HashMap<String, String>(); //role 공통코드
		List<Map<String, Object>> stdTime  = null; //표준시간대
		int count = 0;
		try {
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "DMCJ03");
			param2.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param2.put("CMMN_CLCODE", "CTMS030");
			stdTime = CTMG01Service.standardTimeList(map);
			
			count = CTMG01Service.selectRsrchuserCount(map);
			list = CTMG01Service.selectRsrchuserList(map);
			result.put("success", true );
			result.put("count"  , count);
			result.put("result" , list );
			result.put("roleCode", CommonService.selectQueryDataList(param));
			result.put("ctms030", CommonService.selectQueryDataList(param2));
			result.put("stdTime", stdTime);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}


/*-------------------------------------------------------------------------------------------------------------------------------*/

	/**
	 * 연구자등록 입력팝업 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/g01/popupCTMG0102.do")
	public String popupCTMG0102(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception{
		
		return "/pantheon/ctms/g01/CTMG0102";
	}
	
	
	/**
	 * 연구자정보 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/g01/insertRsrchUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertRsrchUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTMG01Service.deleteTaskUserRoleInfo(list);
			CTMG01Service.insertRsrchUserInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 연구자 ID 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/g01/selectCmUser.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectCmUser(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list  = null;
		try {
			list = CTMG01Service.selectCmUser(map);
			result.put("success", true );		
			result.put("result" , list );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
}



