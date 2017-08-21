package pantheon.ctms.j11.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.j11.service.DMCJ11Service;



@Controller
public class DMCJ11Controller {

	@Resource(name="DMCJ11Service")
	private DMCJ11Service DMCJ11Service;

	/**
	 * 기관조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/popupDMCJ1103.do")
	public String popupDMCJ1103(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j11/DMCJ1103";
	}

	/**
	 * 기관 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectInsttList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectInsttList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = DMCJ11Service.selectInsttList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * To do기관 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectTodoListInsttInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTodoListInsttInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = DMCJ11Service.selectTodoListInsttInfo(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	

	/**
	 * 사용자 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/popupDMCJ1104.do")
	public String popupDMCJ1104(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j11/DMCJ1104";
	}

	/**
	 * 사용자 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectTaskUserList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskUserList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("PLAN========================================================"+map);

		try {
			list = DMCJ11Service.selectTaskUserList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 반려사유 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/popupDMCJ1102.do")
	public String popupDMCJ1102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j11/DMCJ1102";
	}

	/**
	 * 반려사유 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectReturnReasonInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectReturnReasonInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("PLAN========================================================"+map);

		try {
			list = DMCJ11Service.selectReturnReasonInfo(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 전자계약 상태 변경
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/insertReturnReasonInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertReturnReasonInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)		throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			DMCJ11Service.insertReturnReasonInfo(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
/*-------------------------------------------------------------------------------------------------------------------------------*/
	/**
	 * 과제조회 팝업
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="ctms/j11/popupDMCJ1106.do")
	public String popupDMCJ1106(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j11/DMCJ1106";
	}
	
	/**
	 * 과제정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/popupSelectTaskList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> taskCode = null;
		try {
			list = DMCJ11Service.selectTaskList(map);
			taskCode = DMCJ11Service.selectCommonCodeList(map);	
			result.put("success", true);
			result.put("taskCode", taskCode);	
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}	
	/**
	 * 사용자권한조회 팝업
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/j11/popupDMCJ1107.do")
	public String popupDMCJ1107(@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("roleResult", map);
		return "/pantheon/ctms/j11/DMCJ1107";
	}
	
	/**
	 * 사용자권한조회 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectUserRoleInfoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectUserRoleInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> roleCode = null;
		try {
			list = DMCJ11Service.selectUserRoleInfoList(map);
			roleCode = DMCJ11Service.selectCommonCodeList(map);	
			result.put("success", true);
			result.put("roleCode", roleCode);	
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}	
	
	/**
	 * 연구등록에서 승인된 연구자 조회 팝업
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/j11/popupDMCJ1108.do")
	public String popupDMCJ1108(@RequestParam Map<String, String> map, ModelMap model) throws Exception{		
		return "/pantheon/ctms/j11/DMCJ1108";
	}
	
	/**
	 * 연구등록에서 승인된 연구자 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectRsrchUserInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchUserInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = DMCJ11Service.selectRsrchUserInfo(map);	
			
			result.put("success", true);			
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}	
	
	
	/**
	 * 파일업로드 팝업 출력
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/j11/popupDMCJ1105.do")
	public String popupDMCJ1105(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("PROGRAM_ID", request.getParameter("PROGRAM_ID"));	
		map.put("FILE_SN", request.getParameter("FILE_SN"));	
		request.setAttribute("map", map);
		return "/pantheon/ctms/j11/DMCJ1105";
	}
	
	/**
	 * 파일업로드 (샘플)
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ctms/j11/insertDmFileMstr.do", method=(RequestMethod.POST))
	public @ResponseBody String multipartProcess(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
			throws Exception {		
//		Map<String, Object> result = new HashMap<String, Object>();			
//		List<Map<String, Object>> file_sn = null;
//		String moduleKnd = map.get("moduleKnd");
//		if(moduleKnd == "")	moduleKnd = "CTMS";

		String result = null;

		try {
			String mstrSn = DMCJ11Service.insertDmFileMstr(request, map);
//			file_sn = DMCJ11Service.selectDmFileMasterForSN(map);
			result = "{\"success\": true, \"result\": \"" + mstrSn + "\"}";
//			result.put("FILE_SN", file_sn);
		} catch (Exception e) {
			result = "{\"success\": false, \"message\": \"" + e.getLocalizedMessage() + "\"}";
		}
		
		return result;
	}
	
	/**
	 * 파일 상세업로드
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ctms/j11/insertDmFileDetail.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> D(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)
					throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			String mstrSn = DMCJ11Service.insertDmFileDetail(request, "CTMS", "205");
			result.put("result", mstrSn);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 파일 상세정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j11/selectDmFileDetail.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectDmFileDetail(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		Map<String, Object> fileInfo  = null;

		try {
			fileInfo  = DMCJ11Service.selectDmFileDetailInfo(map);
			result.put("success" , true    );
			result.put("fileInfo", fileInfo);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
}



