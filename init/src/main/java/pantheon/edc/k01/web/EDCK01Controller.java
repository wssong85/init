package pantheon.edc.k01.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.edc.k01.service.EDCK01Service;

@Controller
public class EDCK01Controller {
	@Resource(name = "EDCK01Service")
	private EDCK01Service edck01Service;
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;

	/**
	 * 과제목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k01/EDCK0101.do")
	public String EDCK0101(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0101");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC014");
		model.addAttribute("EDC014", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k01/EDCK0101";
	}

	/**
	 * 과제기본정보
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/edc/k01/EDCK0102.do")
	public String edck0102(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		System.out.println("EDCK0102");
		model.addAttribute("detail", edck01Service.selectBaseInfo(map));
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC015");
		model.addAttribute("EDC015", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC017");
		model.addAttribute("EDC017", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC030");
		model.addAttribute("EDC030", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/k01/EDCK0102";
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
	@RequestMapping(value = "/edc/k01/selectStudyList.do", method = (RequestMethod.POST))
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
	 * 중복확인
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k01/selectCheckTaskNo.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCheckTaskNo(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck01Service.selectCheckTaskNo(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * 기본 정보 등록
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k01/insertBaseInfo.do", method = (RequestMethod.POST))
	public void insertBaseInfo(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> map) throws Exception {
		JSONObject jsonObject = new JSONObject();
		PrintWriter writer = response.getWriter();
		try {
			Map<String, Object> m = edck01Service.insertBaseInfo(request, map);
			response.setContentType("text/plain");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			jsonObject.put("success", true);
			jsonObject.put("result", m);
			writer.print(jsonObject);
			writer.flush();
		} catch (Exception e) {
			jsonObject.put("success", false);
			jsonObject.put("message", e.getLocalizedMessage());
		} finally {
			try {
				writer.close();
			} catch (Exception e2) {
				throw e2;
			}
		}
	}

	/**
	 * 제품 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edc/k01/selectProductList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectTrialSummaryList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edck01Service.selectProductList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

}
