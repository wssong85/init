package pantheon.com.c01.web;

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

import pantheon.com.c01.service.COMC01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;

/**
 * CDISC 컨트롤러 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
@Controller
public class COMC01Controller {

	@Resource(name = "COMC01Service")
	private COMC01Service comc01Service;
	
	@RequestMapping(value="/com/c01/COMC0101.do")
	public String comc0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/c01/COMC0101";
	}
	
	@RequestMapping(value="/com/c01/COMC0102.do")
	public String comc0102(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "pantheon/com/c01/COMC0102";
	}
	
	/**
	 * CDISC 엑셀 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c01/selectExcellForCdisc.do", method=RequestMethod.POST)
	public @ResponseBody String selectExcellForCdisc(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		String result = null;
		
		try {
			Map<String, Object> mapCdisc = comc01Service.selectExcellForCdisc(request);
			result = "{\"success\": true"
					+ ",\"listDomain\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapCdisc.get("listDomain")) 
					+ ",\"listVariable\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapCdisc.get("listVariable"))
					+ ",\"listTerminology\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapCdisc.get("listTerminology"))
					+ ",\"listAllData\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapCdisc.get("listAllData"))
					+ ",\"failCountDomain\" : " + String.valueOf(mapCdisc.get("failCountDomain"))
					+ ",\"failCountVariable\" : " + String.valueOf(mapCdisc.get("failCountVariable"))
					+ ",\"failCountTerminology\" : " + String.valueOf(mapCdisc.get("failCountTerminology"))
					+ "}";

		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	/**
	 * CDISC 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/insertCdiscByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCdiscByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			comc01Service.insertCdiscByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * CDISC RULE 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectCdiscRuleList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCdiscRuleList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comc01Service.selectCdiscRuleList();
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * CDISC DOMAIN 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectCdiscDomnListByCdiscRuleSn.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCdiscDomnListByCdiscRuleSn(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			
			count = comc01Service.selectCdiscDomnListCountByCdiscRuleSn(map);
			list = comc01Service.selectCdiscDomnListByCdiscRuleSn(map);
			
			result.put("success", true);
			result.put("result", list);
			result.put("count", count);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * CDISC Vriable 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectCdiscDomnVriablListByCdiscDomnSn.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCdiscDomnVriablListByCdiscDomnSn(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc01Service.selectCdiscDomnVriablListCountByCdiscDomnSn(map);
			list = comc01Service.selectCdiscDomnVriablListByCdiscDomnSn(map);
			result.put("success", true);
			result.put("result", list);
			result.put("count", count);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * CDISC Terminal 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectCdiscClCodeByCdiscRuleSn.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCdiscClCodeByCdiscRuleSn(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc01Service.selectCdiscClCodeCountByCdiscRuleSn(map);
			list = comc01Service.selectCdiscClCodeByCdiscRuleSn(map);
			result.put("success", true);
			result.put("result", list);
			result.put("count", count);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

}
