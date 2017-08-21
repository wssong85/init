package pantheon.ctms.j03.web;

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
import pantheon.com.utl.Util;
import pantheon.ctms.j03.service.DMCJ03Service;
import pantheon.ctms.l01.service.CTML01Service;


@Controller
public class DMCJ03Controller {

	@Resource(name="DMCJ03Service")
	private DMCJ03Service DMCJ03Service;
	
	@Resource(name="CTML01Service")
	private CTML01Service CTML01Service;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * 교육관리 메인 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/DMCJ0301.do")
	public String DMCJ0301(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception{
		model.addAttribute("SCREEN_ID", "DMCJ0301");
		return "/pantheon/ctms/j03/DMCJ0301";
	}

	/**
	 * 교육관리 상세 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/popupDMCJ0302.do")
	public String popupDMCJ0302(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception{
		model.addAttribute("SCREEN_ID", "DMCJ0302");
		return "/pantheon/ctms/j03/DMCJ0302";
	}

	/**
	 * 교육관리 Role 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/popupDMCJ0303.do")
	public String popupDMCJ0303(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map,
			ModelMap model) throws Exception{
		model.addAttribute("SCREEN_ID", "DMCJ0303");
		return "/pantheon/ctms/j03/DMCJ0303";
	}

	/**
	 * 교육관리 모듈별 교육여부 개인별   조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/popupDMCJ0304.do")
	public String popupDMCJ0304(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, 
			ModelMap model) throws Exception{
		model.addAttribute("SCREEN_ID", "DMCJ0304");
		return "/pantheon/ctms/j03/DMCJ0304";
	}

	/**
	 * 교육 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/selectEduMgrList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectEduMgrList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> list  = null;
		List<Map<String, Object>> ctms031  = null; //연락처구분코드     CTMS031
		int count = 0;

		try {
			count = DMCJ03Service.selectEduMgrCount(map);
			list = DMCJ03Service.selectEduMgrList(map);
			
//			map.put("CMMN_CLCODE", "CTMS031");
			map.put("CMMN_CLCODE", "COM007");
			ctms031 = CTML01Service.selectCommonCodeList(map);

			result.put("success", true   );
			result.put("count"  , count  );
			result.put("result" , list   );
			result.put("com007", ctms031);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 교육 정보 상세 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/selectEduInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectEduInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		Map<String, Object> eduInfo  = null;
		List<Map<String, Object>> roleList  = null;

		try {
			eduInfo  = DMCJ03Service.selectEduMgrInfo(map);
			roleList = DMCJ03Service.selectEduRoleList(map);
			result.put("success" , true    );
			result.put("eduInfo" , eduInfo );
			result.put("roleList", roleList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 교육 정보 등록
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/insertEduInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertEduInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String edcMgrSeqNo = null;
		System.out.println("==============map==================="+list);
		try {
			edcMgrSeqNo = DMCJ03Service.insertEduInfo(list);
			result.put("success", true);
			result.put("edcSn"  , edcMgrSeqNo);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 교육 정보 등록
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/insertEduRoleInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertEduRoleInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			DMCJ03Service.insertEduRoleInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 교육 정보 상세 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j03/selectEducationList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectEducationList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> eduList  = null;

		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			System.out.println("map : "+map);
			eduList = DMCJ03Service.selectUserByEducationList(map);
			result.put("success", true   );
			result.put("eduList", eduList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
/*-------------------------------------------------------------------------------------------------------------------------------*/

}



