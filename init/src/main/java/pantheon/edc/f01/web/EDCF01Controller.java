package pantheon.edc.f01.web;

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

import pantheon.com.utl.Util;
import pantheon.edc.f01.service.EDCF01Service;


@Controller
@RequestMapping("/edc/f01")
public class EDCF01Controller {
	
	@Resource(name = "EDCF01Service")
	EDCF01Service EDCF01Service;
	
	@RequestMapping("/EDCF0101.do")
	public String EDCF0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/f01/EDCF0101";
	}
	
	@RequestMapping("/EDCF0102.do")
	public String EDCF0102(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/f01/EDCF0102";
	}
	
	@RequestMapping("/EDCF0103.do")
	public String EDCF0103(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/f01/EDCF0103";
	}
	
	@RequestMapping("/EDCF0104.do")
	public String EDCF0104(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/f01/EDCF0104";
	}
	
	
	/**
	 * Site 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcCrInsttForm.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcCrInsttForm(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCF01Service.selectEdcCrInsttForm(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	
	/**
	 * Subject 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcCrSubject.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcCrSubject(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCF01Service.selectEdcCrSubject(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	
	/**
	 * Visit 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcCfVisit.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcCfVisit(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCF01Service.selectEdcCfVisit(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	
	/**
	 * CRF 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcCfGroup.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEdcCfGroup(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCF01Service.selectEdcCfGroup(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	@RequestMapping(value="/updateSdvSttusBySite.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateSdvSttusBySite(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			EDCF01Service.updateSdvSttusBySite(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping(value="/updateSdvCmplSttusBySite.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateSdvCmplSttusBySite(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			EDCF01Service.updateSdvCmplSttusBySite(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}
