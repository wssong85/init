package pantheon.com.a01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.a01.service.COMA01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;

/**
 * 공통쿼리  처리하는 컨트롤러 클래스
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
public class COMA01Controller {
	
	@Resource(name = "COMA01Service")
	private COMA01Service coma01Service;
	
	/**
	 * 메뉴관리 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/a01/COMA0101.do")
	public String coma0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "pantheon/com/a01/COMA0101";
	}
	
	/**
	 * 상위메뉴 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a01/selectCmMenuListForUpperMenuId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmMenuListForUpperMenuId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma01Service.selectCmMenuListForUpperMenuId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 상위메뉴 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a01/insertCmMenuForUpperMenu.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmMenuForUpperMenu(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			coma01Service.insertCmMenuForUpperMenu(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 메뉴 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a01/selectCmMenuListByUpperMenuId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmMenuListByUpperMenuId(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = coma01Service.selectCmMenuListByUpperMenuId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 하위메뉴 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/a01/insertCmMenuByUpperMenu.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmMenuByUpperMenu(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			coma01Service.insertCmMenuByUpperMenu(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}
