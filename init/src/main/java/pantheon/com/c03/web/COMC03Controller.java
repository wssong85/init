package pantheon.com.c03.web;

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

import pantheon.com.c03.service.COMC03Service;
import pantheon.com.utl.Util;

/**
 * KCD 컨트롤러 클래스
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
public class COMC03Controller {
	
	@Resource(name = "COMC03Service")
	private COMC03Service comc03Service;
	
	@RequestMapping(value="/com/c03/COMC0301.do")
	public String comc0301(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/c03/COMC0301";
	}
	
	@RequestMapping(value="/com/c03/COMC0302.do")
	public String comc0302(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "/pantheon/com/c03/COMC0302";
	}

	/**
	 * KCD 엑셀 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c03/selectExcellForKcd.do", method=RequestMethod.POST)
	public @ResponseBody String selectExcellForKcd(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		try {
			Map<String, Object> mapKcd = comc03Service.selectExcellForKcd(request);
			result = "{\"success\": true, \"count\": " + mapKcd.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapKcd.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	/**
	 * KCD 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c03/insertEdcCrKcdByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertEdcCrKcdByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			comc03Service.insertEdcCrKcdByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 사전목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c03/selectEdcCrMdicByDicarySeCode.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrMdicByDicarySeCode(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comc03Service.selectEdcCrMdicByDicarySeCode(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * KCD 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c03/selectEdcCrKcdByKcdSn.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrKcdByKcdSn(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc03Service.selectEdcCrKcdCountByKcdSn(map);
			list = comc03Service.selectEdcCrKcdByKcdSn(map);
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