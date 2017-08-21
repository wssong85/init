package pantheon.com.common.web;

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

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;

/**
 * 공통쿼리 처리하는 컨트롤러 클래스
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
public class PantheonCommonController {
	
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;
	
	/**
	 * 리포트디자이너를 불러온다.
	 * @param request
	 * @param response
	 * @param map {MRD_NAME: ''}
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/system/CommonRD.do", method=RequestMethod.POST)
	public String systemRd(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		if(map == null) {
			return "redirect:/com/i01/intro.do";
		}
		
		if(!map.containsKey("MRD_NAME")) {
			return "redirect:/com/i01/intro.do";
		}
		Map<String, String> rdMap = new HashMap<String, String>();
		rdMap.put("MRD", map.get("MRD_NAME"));
		map.remove("MRD_NAME");
		rdMap.put("PARAM", Util.getStrForRdByString(map));
		
		model.addAttribute("RD", rdMap);
		return "pantheon/com/rd/CommonRD";
	}

	
	/**
	 * 리스트를 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/common/selectQueryDataList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectQueryDataList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<Map<String, Object>> list = null;
		
		try {
			list = pantheonCommonService.selectQueryDataList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 1ROW 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/common/selectQueryData.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectQueryData(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>(); 
		Map<String, Object> retMap = null;
		
		try {
			retMap = pantheonCommonService.selectQueryData(map);
			result.put("success", true);
			result.put("result", retMap);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * COUNTING
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/common/selectQueryListCount.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectQueryListCount(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>(); 
		int retInt = 0;
		
		try {
			retInt = pantheonCommonService.selectQueryListCount(map);
			result.put("success", true);
			result.put("result", retInt);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

}
