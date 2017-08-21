package pantheon.com.f01.web;

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

import pantheon.com.f01.service.COMF01Service;
import pantheon.com.utl.Util;

/**
 * 통합사용자관리 처리하는 컨트롤러 클래스
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
public class COMF01Controller {
	
	@Resource(name = "COMF01Service")
	private COMF01Service comf01Service;
	
	/**
	 * 신규등록 화면 호출
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/f01/popupCOMF0102.do")
	public String popupComf0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "pantheon/com/f01/COMF0102";
	}
	
	/**
	 * 통합사용자관리 화면 호출 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/f01/COMF0101.do")
	public String comf0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "pantheon/com/f01/COMF0101";
	}
	
	/**
	 * 통합사용자관리 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f01/selectCmUserListByUser.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCmUserListByUser(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			int count = comf01Service.selectCmUserListCountByUser(map);
			List<Map<String, Object>> cmUserInfo = comf01Service.selectCmUserListByUser(map);
			
			result.put("success", true);
			result.put("result", cmUserInfo);
			result.put("count", count);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 사용자 역할 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f01/selectCmUserRoleByUserId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectCmUserRoleByUserId(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> list = comf01Service.selectCmUserRoleByUserId(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 사용자 역할 입력
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f01/insertCmUserRoleByUserId.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmUserRoleByUserId(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			comf01Service.insertCmUserRoleByUserId(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 신규유저 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f01/insertCmUserForCreate.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmUserForCreate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comf01Service.insertCmUserForCreate(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 외부사용자 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f01/updateCmUserByUserSeCode02.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCmUserByUserSeCode02(HttpServletRequest request, HttpServletResponse response,
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comf01Service.updateCmUserByUserSeCode02(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
}
