package pantheon.edc.j01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.edc.j01.service.EDCJ01Service;
import egovframework.com.cmm.annotation.IncludedInfo;

@Controller
@RequestMapping("/edc/j01")
public class EDCJ01Controller {
	
	@Resource(name = "EDCJ01Service")
	EDCJ01Service edcj01Service;
	
	@Resource(name = "PantheonCommonService")
	PantheonCommonService pantheonCommonService;
	
	@IncludedInfo(name="pantheon 이상반응 정상범위 관리목록", order = 6550, gid = 110)
	@RequestMapping("/EDCJ0101.do")
	public String EDCJ0101(ModelMap model, HttpServletRequest request, Map<String, Object> searchMap) throws Exception {
		return "/pantheon/edc/j01/EDCJ0101";
	}
	/**
	 * 이상반응 정상범위 관리 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepList.do")
	public @ResponseBody Map<String , Object> seletSaeRepList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			System.out.println("@@@SaeRep List!!!!!");
			list = edcj01Service.selectSaeRepList(map);
			System.out.println("return resultList 값 : " + list.toString());
			
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * 이상반응 신속보고 상세 조회
	 * @param map
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/EDCJ0102.do")
	public String EDCJ0102(@RequestParam Map<String, Object> map, HttpServletRequest request, ModelMap model) throws Exception {
		System.out.println("이상반응 상세!!!!!");
		try{
			model.addAttribute("result", edcj01Service.selectSaeRep(map));
			model.addAttribute("aetResult", edcj01Service.selectSaeRepAetList(map));
			
			Map<String, String> param = new HashMap<String, String>();
			param.put("QUERY", "selectEDCCodeList");
			param.put("FLAG", "COMMON");
			param.put("CODE", "EDC028");
			model.addAttribute("EDC028", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "SDB045");
			model.addAttribute("SDB045", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC029");
			model.addAttribute("EDC029", pantheonCommonService.selectQueryDataList(param));
			
			param.put("CODE", "EDC020");
			model.addAttribute("EDC020", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC021");
			model.addAttribute("EDC021", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC022");
			model.addAttribute("EDC022", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC023");
			model.addAttribute("EDC023", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC025");
			model.addAttribute("EDC025", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "EDC026");
			model.addAttribute("EDC026", pantheonCommonService.selectQueryDataList(param));
			param.put("CODE", "SDB012");
			model.addAttribute("SDB012", pantheonCommonService.selectQueryDataList(param));
			
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
		return "/pantheon/edc/j01/EDCJ0102";
	}
	
	/**
	 * 이상반응 신속보고 상세 약물정보 조회 목록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepDreAList.do")
	public @ResponseBody Map<String , Object> selectSaeRepDreAList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = edcj01Service.selectSaeRepDreAList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 이상반응 신속보고 상세 기타병용약물 조회 목록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepDreBList.do")
	public @ResponseBody Map<String , Object> selectSaeRepDreBList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = edcj01Service.selectSaeRepDreBList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 이상반응 신속보고 상세 주요 병력 및 동반 질환 조회 목록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepHstcsList.do")
	public @ResponseBody Map<String , Object> selectSaeRepHstcsList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = edcj01Service.selectSaeRepHstcsList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 이상반응 신속보고 상세 이상약물반응 관련 약물 과거력 조회 목록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepDreHstcsList.do")
	public @ResponseBody Map<String , Object> selectSaeRepDreHstcsList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = edcj01Service.selectSaeRepDreHstcsList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 이상반응 신속보고 상세 원인규명을 위한 검사결과 조회 목록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectSaeRepInspctList.do")
	public @ResponseBody Map<String , Object> selectSaeRepInspctList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = edcj01Service.selectSaeRepInspctList(map);
			result.put("success", true);
			result.put("result", list);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 이상반응 신속보고 저장
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertSaeRep.do")
	public @ResponseBody Map<String , Object> insertSaeRep(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("DB Insert Start!");
		try{
			edcj01Service.insertSaeList(map);
			result.put("success", true);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

}
