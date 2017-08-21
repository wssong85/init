package pantheon.ctms.f01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.ctms.f01.service.CTMF01Service;



@Controller
public class CTMF01Controller {

	@Resource(name="CTMF01Service")
	private CTMF01Service ctmf01Service;
	
	/**
	 * Paper계약 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="Paper계약 리스트 화면", order = 7010 ,gid = 110)
	@RequestMapping(value="/ctms/f01/CTMF0103.do")
	public String CTMF0103(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/f01/CTMF0103";
	}
	
	
	/**
	 * Paper계약 리스트 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/selectPaperContractList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectPaperContractList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> irbList = null;
		List<Map<String, Object>> sttus = null;
		System.out.println("PAPER========================================================"+map);

		try {
			list = ctmf01Service.selectPaperContractList(map);	
			irbList = ctmf01Service.selectCommonCodeListByIRB_AT(map);
			sttus = ctmf01Service.selectCommonCodeListBySTTUS(map);
			result.put("USER_ID", Util.getUserMap().get("USER_ID"));
			result.put("success", true);
			result.put("irbList", irbList);	
			result.put("sttus", sttus);		
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	
	/**
	 * 아이디 중복체크 팝업
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/popupCTMF0106.do")
	public String popupCTMF0106(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/f01/CTMF0106";
	}
	
	/**
	 * 아이디 중복체크
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/selectRsrchUSerOverlap.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectRsrchUserOverlap(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = ctmf01Service.selectRsrchUserOverlap(map);
			result.put("success", true);	
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 계약서 팝업 출력
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value="/ctms/f01/popupCTMF0104.do")
	public String CTMF0104(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		System.out.println("map==============================================="+map);
		map.put("parent_value", request.getParameter("parent_value"));		
		request.setAttribute("map", map);
		
		return "/pantheon/ctms/f01/CTMF0104";
	}

	/**
	 * PDF 팝업 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/CTMF0105.do")
	public String CTMF0105(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		Map<String, String> map = new HashMap<String, String>();
		System.out.println("map==============================================="+map);
		map.put("pdf_info", request.getParameter("pdf_info"));		
		request.setAttribute("map", map);		
				
		return "/pantheon/ctms/f01/CTMF0105";
	}

	
	/**
	 * 계약서 팝업 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/selectContractPopUpList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectContractPopUpList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("POP========================================================"+map.get("FILE_MASTR_SN"));

		try {
			list = ctmf01Service.selectContractPopUpList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * Paper계약 계약정보 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/insertPaperContractByCNT.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertPaperContractByCNT(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		
		try {
			ctmf01Service.deleteTaskUserRoleInfo(list);
			ctmf01Service.insertPaperContractByCNT(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
/*-------------------------------------------------------------------------------------------------------------------------------*/
	/**
	 * 테스트 화면
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/popuptest.do")
	public String ctmsTest(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/f01/CTMSTest";
	}

	/**
	 * 계약관리 - 전체 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/CTMF0101.do")
	public String CTMF0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/f01/CTMF0101";
	}
	
	/**
	 * 계약관리 - 전체 리스트 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/f01/selectTotalcontractListGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTotalContractList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = ctmf01Service.selectTotalContractList(map);
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 계약관리 - 전자계약 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/f01/CTMF0102.do")
	public String CTMF0102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/f01/CTMF0102";
	}

	/**
	 * 계약관리 - 전자계약 리스트 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/f01/selectElectContractList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectElectContractList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("==============map===================="+map.get("TASK_NO"));
		try {
			list = ctmf01Service.selectElectContractList(map);
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
	@RequestMapping(value="/ctms/f01/updateElectContractStatus.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateElectContractStatus(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			ctmf01Service.updateElectContractStatus(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}



