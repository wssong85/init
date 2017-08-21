package pantheon.edc.g01.web;

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
import pantheon.edc.g01.service.EDCG01Service;


@Controller
@RequestMapping("/edc/g01")
public class EDCG01Controller {
	
	@Resource(name = "EDCG01Service")
	EDCG01Service EDCG01Service;
	
	@RequestMapping("/EDCG0101.do")
	public String EDCG0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/g01/EDCG0101";
	}
	
	@RequestMapping("/EDCG0102.do")
	public String EDCG0102(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception{
		model.addAllAttributes(map);
		return "/pantheon/edc/g01/EDCG0102";
	}
	
	@RequestMapping("/EDCG0103.do")
	public String EDCG0103(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception{
		model.addAllAttributes(map);
		return "/pantheon/edc/g01/EDCG0103";
	}
	
	@RequestMapping("/popupEDCG0104.do")
	public String popupEDCG0104(@RequestParam Map<String, Object> map, ModelMap model) throws Exception{
		model.addAllAttributes(map);
		return "/pantheon/edc/g01/EDCG0104";
	}
	
	@RequestMapping("/popupEDCG0105.do")
	public String popupEDCG0105(@RequestParam Map<String, Object> map, ModelMap model) throws Exception{
		model.addAllAttributes(map);
		return "/pantheon/edc/g01/EDCG0105";
	}
	
	/**
	 * 병력 Coding List
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCsList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCsList(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCG01Service.selectCsList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());			
		}
		
		return result;
	}
	
	/**
	 * PV_CFIRM_CODE 변경
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEdcCfVriablByPvCraCnfirmCode.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateEdcCfVriablByPvCraCnfirmCode(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, Object> map) throws Exception{
			Map<String, Object> result = new HashMap<String, Object>();			
			try{
				EDCG01Service.updateEdcCfVriablByPvCraCnfirmCode(map);
				
				result.put("success", true);
			}catch (Exception e){
				result.put("success", false);
				result.put("message", Util.getPantheonErrorMessage(e, this));
			}
			
		return result;
	}

	/**
	 * Dicionary Tooltip data
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/selectDicaryInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDicaryInfo(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCG01Service.selectDicaryInfo(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());			
		}
		
		return result;
	}
	
	@RequestMapping(value="/insertCmQueryByCra.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertCmQueryByCra(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, Object> map) throws Exception{
			Map<String, Object> result = new HashMap<String, Object>();			
			try{
				EDCG01Service.insertCmQueryByCra(map);
				
				result.put("success", true);
			}catch (Exception e){
				result.put("success", false);
				result.put("message", Util.getPantheonErrorMessage(e, this));
			}
			
		return result;
	}
	
	@RequestMapping(value="/selectDistinctAbnRctList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDistinctAbnRctList(@RequestParam Map<String, Object> map,
			ModelMap model, HttpServletRequest request) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCG01Service.selectDistinctAbnRctList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e){
			result.put("sueecss", false);
			result.put("message", e.getLocalizedMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/selectDistinctDAbnRct.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDistinctDAbnRct(@RequestParam Map<String, Object> map,
			ModelMap model, HttpServletRequest request) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCG01Service.selectDistinctDAbnRct(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e){
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		return result;
	}
}
