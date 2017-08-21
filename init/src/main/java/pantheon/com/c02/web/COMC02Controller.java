package pantheon.com.c02.web;

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

import pantheon.com.c02.service.COMC02Service;
import pantheon.com.utl.Util;


/**
 * Medical dictionary 컨트롤러 클래스
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
public class COMC02Controller {
	
	@Resource(name = "COMC02Service")
	private COMC02Service comc02Service;
	
	@RequestMapping(value="/com/c02/COMC0201.do")
	public String comc0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/c02/COMC0201";
	}
	
	@RequestMapping(value="/com/c02/COMC0202.do")
	public String comc0202(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/c02/COMC0202";
	}
	
	@RequestMapping(value="/com/c02/COMC0203.do")
	public String comc0203(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/c02/COMC0203";
	}
	
	@RequestMapping(value="/com/c02/COMC0204.do")
	public String comc0204(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/c02/COMC0204";
	}
	
	@RequestMapping(value="/com/c02/COMC0205.do")
	public String comc0205(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "pantheon/com/c02/COMC0205";
	}
	
	@RequestMapping(value="/com/c02/COMC0206.do")
	public String comc0206(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "pantheon/com/c02/COMC0206";
	}
	
	@RequestMapping(value="/com/c02/COMC0207.do")
	public String comc0207(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "pantheon/com/c02/COMC0207";
	}
	
	@RequestMapping(value="/com/c02/COMC0208.do")
	public String comc0208(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "pantheon/com/c02/COMC0208";
	}
	
	/**
	 * ATC 엑셀 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c02/selectAtcListByExcel.do", method=RequestMethod.POST)
	public @ResponseBody String selectAtcListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		
		try {
			Map<String, Object> mapAtc = comc02Service.selectAtcListByExcel(request);
			result = "{\"success\": true, \"count\": " + mapAtc.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapAtc.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	/**
	 * ATC 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/insertEdcCrAtcByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertEdcCrAtcByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			comc02Service.insertEdcCrAtcByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * ATC 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectEdcCrAtcByDicaryVer.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrAtcByDicaryVer(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc02Service.selectEdcCrAtcCountByDicaryVer(map);
			list = comc02Service.selectEdcCrAtcByDicaryVer(map);
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
	 * WHOART 엑셀 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c02/selectWhoartListByExcel.do", method=RequestMethod.POST)
	public @ResponseBody String selectWhoartListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		
		try {
			Map<String, Object> mapWhoart = comc02Service.selectWhoartListByExcel(request);
			result = "{\"success\": true, \"count\": " + mapWhoart.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapWhoart.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}

	/**
	 * WHOART 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/insertEdcCrWhoartByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertEdcCrWhoartByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comc02Service.insertEdcCrWhoartByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * WHOART 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c01/selectEdcCrWhoartByDicaryVer.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrWhoartByDicaryVer(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc02Service.selectEdcCrWhoartCountByDicaryVer(map);
			list = comc02Service.selectEdcCrWhoartByDicaryVer(map);
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
	 * MedDRA 엑셀조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c02/selectMeddraListByExcel.do", method=RequestMethod.POST)
	public @ResponseBody String selectMeddraListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		
		try {
			Map<String, Object> mapMeddra = comc02Service.selectMeddraListByExcel(request);
			result = "{\"success\": true, \"count\": " + mapMeddra.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapMeddra.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	/**
	 * MedDRA 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c02/insertEdcCrMeddraByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertEdcCrMeddraByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comc02Service.insertEdcCrMeddraByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * MedDRA 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c02/selectEdcCrMeddraByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrMeddraByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = comc02Service.selectEdcCrMeddraCountByPk(map);
			list = comc02Service.selectEdcCrMeddraByPk(map);
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
	 * KIMS 엑셀 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/com/c02/selectKimsListByExcel.do", method=RequestMethod.POST)
	public @ResponseBody String selectKimsListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		
		try {
			Map<String, Object> mapKims = comc02Service.selectKimsListByExcel(request);
			result = "{\"success\": true, \"count\": " + mapKims.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)mapKims.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	/**
	 * KIMS 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c02/insertEdcCrKimsByExcelList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertEdcCrKimsByExcelList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comc02Service.insertEdcCrKimsByExcelList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * KIMS 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/c02/selectEdcCrKimsByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectEdcCrKimsByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		try {
			count = comc02Service.selectEdcCrKimsCountByPk(map);
			list = comc02Service.selectEdcCrKimsByPk(map);
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
