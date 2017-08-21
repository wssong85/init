package pantheon.edc.k02.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.edc.k01.service.EDCK01Service;
import pantheon.edc.k02.service.EDCK02Service;

@Controller
public class EDCK02Controller {
	@Resource(name = "EDCK02Service")
	private EDCK02Service edck02Service;
	@Resource(name = "EDCK01Service")
	private EDCK01Service edck01Service;
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;

	/**
	 * 과제목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0201.do")
	public String EDCk0201(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0201");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0201";
	}

	/**
	 * CRF 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0202.do")
	public String EDCK0202(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0202");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0202";
	}

	/**
	 * CRF 목록 - 신규 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0202Sub01.do")
	public String popupEDCK0202Sub01(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0202Sub01");
		model.addAllAttributes(edck02Service.selectCRFVersion(map));
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC033");
		model.addAttribute("EDC033", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0202Sub01";
	}

	/**
	 * CRF 목록 - 변경 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0202Sub02.do")
	public String popupEDCK0202Sub02(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0202Sub02");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC031");
		model.addAttribute("EDC031", pantheonCommonService.selectQueryDataList2(map));
		model.addAttribute("detail", edck02Service.selectChangeReason(map));
		return "/pantheon/edc/k02/EDCK0202Sub02";
	}

	/**
	 * Template 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0203.do")
	public String EDCK0203(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0203");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0203";
	}

	/**
	 * Group 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0204.do")
	public String EDCK0204(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0204");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "DOMAIN");
		model.addAttribute("DOMAIN", pantheonCommonService.selectQueryDataList2(map));
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC037");
		model.addAttribute("EDC037", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC039");
		model.addAttribute("EDC039", pantheonCommonService.selectQueryDataList2(map));

		Map<String, Object> m = edck02Service.selectTaskType(map);
		map.put("BLIND_CODE", m.get("BLIND_CODE"));
		map.put("CODE", "EDC016");
		model.addAttribute("EDC016", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0204";
	}

	/**
	 * Codelist 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0204Sub01.do")
	public String popupEDCK0204Sub01(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0204Sub01");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0204Sub01";
	}

	/**
	 * SUPP Variable 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0205.do")
	public String popupEDCK0205(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0205");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC036");
		model.addAttribute("EDC036", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC037");
		model.addAttribute("EDC037", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC038");
		model.addAttribute("EDC038", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0205";
	}

	/**
	 * User Variable 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0206.do")
	public String popupEDCK0206(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0206");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC036");
		model.addAttribute("EDC036", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC037");
		model.addAttribute("EDC037", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC038");
		model.addAttribute("EDC038", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0206";
	}

	/**
	 * Visit 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0207.do")
	public String EDCK0207(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0207");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC018");
		model.addAttribute("EDC018", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC016");
		model.addAttribute("EDC016", pantheonCommonService.selectQueryDataList2(map));

		Map<String, Object> m = edck02Service.selectTaskType(map);
		map.put("BLIND_CODE", m.get("BLIND_CODE"));
		map.put("CODE", "EDC034");
		model.addAttribute("EDC034", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0207";
	}

	/**
	 * Dictionary 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0208.do")
	public String EDCK0208(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0208");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "VISIT");
		model.addAttribute("VISIT", pantheonCommonService.selectQueryDataList2(map));
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "GROUP");
		model.addAttribute("GROUP", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0208";
	}

	/**
	 * Layout 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0209.do")
	public String EDCK0209(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0209");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "VISIT");
		model.addAttribute("VISIT", pantheonCommonService.selectQueryDataList2(map));

		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC041");
		model.addAttribute("EDC041", pantheonCommonService.selectQueryDataList2(map));

		return "/pantheon/edc/k02/EDCK0209";
	}

	/**
	 * 동일 Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0209Sub01.do")
	public String popupEDCK0209Sub01(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0209Sub01");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0209Sub01";
	}

	/**
	 * 입력방식 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0209Sub02.do")
	public String popupEDCK0209Sub02(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0209Sub02");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0209Sub02";
	}

	/**
	 * Description 설정
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0210.do")
	public String popupEDCK0210(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0210");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC042");
		model.addAttribute("EDC042", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC043");
		model.addAttribute("EDC043", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC044");
		model.addAttribute("EDC044", pantheonCommonService.selectQueryDataList2(map));
		model.addAttribute("detail", edck02Service.selectDescription(map));
		return "/pantheon/edc/k02/EDCK0210";
	}

	/**
	 * Layout Table 설정
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0211.do")
	public String popupEDCK0211(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0211");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0211";
	}

	/**
	 * Edit Check 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0212.do")
	public String EDCK0212(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0212");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0212";
	}

	/**
	 * Edit Check 상세
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0213.do")
	public String EDCK0213(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		try {
			System.out.println("EDCK0213");
			map.put("QUERY", "selectEDCCodeList");
			map.put("FLAG", "VISIT");
			model.addAttribute("VISIT", pantheonCommonService.selectQueryDataList2(map));
			map.put("FLAG", "COMMON");
			map.put("CODE", "EDC011");
			model.addAttribute("EDC011", pantheonCommonService.selectQueryDataList2(map));
			map.put("CODE", "EDC012");
			model.addAttribute("EDC012", pantheonCommonService.selectQueryDataList2(map));
			map.put("CODE", "EDC013");
			model.addAttribute("EDC013", pantheonCommonService.selectQueryDataList2(map));
			model.addAttribute("detail", edck02Service.selectEditCheckDetail(map));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "/pantheon/edc/k02/EDCK0213";
	}

	/**
	 * T-Domain 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0214.do")
	public String EDCK0214(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0214");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "ARM_CODE");
		model.addAttribute("ARM_CODE", pantheonCommonService.selectQueryDataList2(map));
		map.put("FLAG", "ARM_LABEL");
		model.addAttribute("ARM_LABEL", pantheonCommonService.selectQueryDataList2(map));
		map.put("FLAG", "ELEMENT_CODE");
		model.addAttribute("ELEMENT_CODE", pantheonCommonService.selectQueryDataList2(map));
		map.put("FLAG", "ELEMENT_LABEL");
		model.addAttribute("ELEMENT_LABEL", pantheonCommonService.selectQueryDataList2(map));
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC032");
		model.addAttribute("EDC032", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0214";
	}

	/**
	 * T-Domain 목록 - Arm 코드 목록 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/popupEDCK0214Sub01.do")
	public String popupEDCK0214Sub01(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("popupEDCK0214Sub01");
		model.addAllAttributes(map);
		return "/pantheon/edc/k02/EDCK0214Sub01";
	}

	/**
	 * Coding 설정
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k02/EDCK0218.do")
	public String EDCK0218(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0218");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC057");
		model.addAttribute("EDC057", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC041");
		model.addAttribute("EDC041", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC050");
		model.addAttribute("EDC050", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k02/EDCK0218";
	}

	/**
	 * 과제 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectStudyList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectStudyList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck01Service.selectStudyList(map));
			result.put("count", edck01Service.selectStudyListCount(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 과제 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectCRFList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectCRFList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Group 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectGroupList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectGroupList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectGroupList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Group목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertGroupList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertGroupList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertGroupList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectVariableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectVariableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectVariableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Group 내 Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectGroupInsideList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectGroupInsideList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectGroupInsideList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Group목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertGroupInsideList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertGroupInsideList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertGroupInsideList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit 내 Group 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectVisitInsideList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectVisitInsideList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectVisitInsideList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit 내 Group목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertVisitInsideList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertVisitInsideList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertVisitInsideList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Dictionary 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectDictionary.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDictionary(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectDictionary(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Dictionary 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertDictionary.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertDictionary(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertDictionary(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * EDC 버전 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertEDCVersion.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertEDCVersion(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//사용자정보를 받아온다.
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));

			edck02Service.insertEDCVersion(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 사용자 Variable 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectUserVariableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectUserVariableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectUserVariableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * User Variable Detail 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectUserVariableDetail.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectUserVariableDetail(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectUserVariableDetail(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 사용자 Variable 옵션 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectUserVariableOptionList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectUserVariableOptionList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectUserVariableOptionList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * User Variable 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertUserVariable.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertUserVariable(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//사용자정보를 받아온다.
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			edck02Service.insertUserVariable(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit 정보 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectVisitInfoList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectVisitInfoList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectVisitInfoList(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit 설정 group목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectGroupListForVisit.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectVisitGroupList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectGroupListForVisit(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit 정보 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertVisitInfoList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertVisitInfoList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertVisitInfoList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Element목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectElementList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectElementList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("success", true);
			result.put("result", edck02Service.selectElementList(map));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Element목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertElementList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertElementList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertElementList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Arm목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectArmList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectArmList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectArmList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Arm목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertArmList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertArmList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertArmList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * InclusionList/ExclusionList 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectInclusionList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectInclusionList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectInclusionList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Inclusion/Exclusion Detail 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectInclusionDetail.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectInclusionDetail(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectInclusionDetail(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * InclusionList/ExclusionList 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertInclusionList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertInclusionList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertInclusionList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * InclusionList/ExclusionList 버전 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertInclusionVersion.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertInclusionVersion(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//사용자정보를 받아온다.
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));

			edck02Service.insertInclusionVersion(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * TrialSummary 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectTrialSummaryList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectTrialSummaryList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectTrialSummaryList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * TrialSummary 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertTrialSummary.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertTrialSummary(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertTrialSummary(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * TrialSummary 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/updateChangeReason.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateChangeReason(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));

			edck02Service.updateChangeReason(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Arm 코드 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectArmCodeList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectBaseInfoArmList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectArmCodeList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Arm 코드 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertArmCodeList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertArmCode(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertArmCodeList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Layout 설정할 Group Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectGroupListForLayout.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectGroupListForLayout(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectGroupListForLayout(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Group Layout 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectLayoutList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectLayoutList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectLayoutList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * CDISC CodeList 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectCDISCCodeList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCDISCCodeList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectCDISCCodeList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Layout 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertLayoutList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertLayoutList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertLayoutList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Edit check 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectAllEditCheckList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEditCheckList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectAllEditCheckList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Edit check 비활성화 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectDisableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDisableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectDisableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 동일 Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectSameVariable.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectSameVariable(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectSameVariable(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Task Blind Pk 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectTaskBlindPk.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectTaskBlindPk(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck02Service.selectTaskBlindPk(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Task Blind Pk 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/updateTaskBlindPk.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateTaskBlindPk(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.updateTaskBlindPk(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Edit Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectEditVariableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEditVariableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectEditVariableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Edit Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectEditSeqList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectEditSeqList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectEditSeqList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * EditCheck 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertEditCheck.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertEditCheck(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Object editceck_sn = edck02Service.insertEditCheck(map);
			result.put("success", true);
			result.put("EDITCECK_SN", editceck_sn);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Coding 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectCodingList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCodingList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectCodingList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Coding Variable 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/insertCodingList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertCodingList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edck02Service.insertCodingList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 선택한 코딩의 Variable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectCodingVariableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCodingVariableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectCodingVariableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Dictionary Version 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectDictionaryVersionList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectDictionaryVersionList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectDictionaryVersionList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * AllVariable 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectAllVariableList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectAllVariableList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectAllVariableList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Variable se code 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k02/selectVariableSECodeList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectVariableSECodeList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edck02Service.selectVariableSECodeList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
