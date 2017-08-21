package pantheon.edc.k04.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.edc.k04.service.EDCK04Service;
import egovframework.com.cmm.annotation.IncludedInfo;


@Controller
@RequestMapping("/edc/k04")
public class EDCK04Controller {
	
	@Resource(name = "EDCK04Service")
	EDCK04Service edck04Service;
	
	@Resource(name = "PantheonCommonService")
	PantheonCommonService pantheonCommonService;
	
	//Site
	@RequestMapping("/EDCK0401.do")
	public String EDCK0401(ModelMap model, HttpServletRequest request, Map<String, Object> searchMap) throws Exception {
		return "/pantheon/edc/k04/EDCK0401";
	}
	
	@RequestMapping("/EDCK0402.do")
	public String EDCK0402(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/k04/EDCK0402";
	}
	
	//Site
	@RequestMapping("/EDCK0403.do")
	public String EDCK0403(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/k04/EDCK0403";
	}
	
	//List
	@RequestMapping("/EDCK0404.do")
	public String EDCK0404(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/k04/EDCK0404";
	}
	
	//List
	@RequestMapping("/EDCK0405.do")
	public String EDCK0405(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("############# TASK_SN : "+map.get("TASK_SN"));
		model.addAllAttributes(map);
		return "/pantheon/edc/k04/EDCK0405";
	}
	
	/**
	 * Data Freezing selectEdcTaskList
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcTaskList.do")
	public @ResponseBody Map<String, Object> selectEdcTaskList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = edck04Service.selectEdcTaskList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	/**
	 * Data Freezing selectEdcSiteList
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcSiteList.do")
	public @ResponseBody Map<String, Object> selectEdcSiteList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = edck04Service.selectEdcSiteList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	/**
	 * Data Freezing updateFrzEdcCrInsttFrm
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateFrzEdcCrInsttFrm.do")
	public @ResponseBody Map<String, Object> updateFrzEdcCrInsttFrm(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edck04Service.updateFrzEdcCrInsttFrm(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * Data Freezing selectEdcSubInsttList
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcSubInsttList.do")
	public @ResponseBody Map<String, Object> selectEdcSubInsttList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = edck04Service.selectEdcSubInsttList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	/**
	 * DB Freezing selectTaskInfo
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectTaskInfo.do")
	public @ResponseBody Map<String , Object> selectTaskInfo(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("######################## TASK_SN : "+map.get("TASK_SN"));
		try {
			list = edck04Service.selectTaskInfo(map);

			result.put("success", true);
			result.put("result", list);
//			
//			for(String mapkey: result.keySet()) {
//				System.out.print(mapkey + " : " + result.get(mapkey));
//			}
//			
//			if(true) {
//				throw new Exception("gg");
//			}
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * 결재 요청 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEdcCrTaskReqNo.do")
	public @ResponseBody Map<String, Object> updateEdcCrTaskReqNo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, Object> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edck04Service.updateEdcCrTaskReqNo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재 완료 후 상태 update
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEdcCrTaskFrzStt.do")
	public @ResponseBody Map<String, Object> updateEdcCrTaskFrzStt(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, Object> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edck04Service.updateEdcCrTaskFrzStt(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * DB Freezing selectEdcFrzngHist
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectEdcFrzngHist.do")
	public @ResponseBody Map<String , Object> selectEdcFrzngHist(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edck04Service.selectEdcFrzngHist(map);

			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * 결재 완료 후 상태 update
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@RequestMapping(value="/updateSubFrzEdcCrInsttFrm.do")
	public @ResponseBody Map<String, Object> updateSubFrzEdcCrInsttFrm(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edck04Service.updateSubFrzEdcCrInsttFrm(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}
