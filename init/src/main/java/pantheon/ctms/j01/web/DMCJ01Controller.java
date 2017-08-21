package pantheon.ctms.j01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.j01.service.DMCJ01Service;
import pantheon.ctms.a01.service.CTMA01Service;

@Controller
public class DMCJ01Controller {
	
	@Resource(name="DMCJ01Service")
	private DMCJ01Service DMCJ01Service;
	
	@Resource(name = "CTMA01Service")
	private CTMA01Service ctma01Service;

	/**
	 * DM Center Home
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value="/ctms/j01/DMCJ0101.do")
	public String DMCJ0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j01/DMCJ0101";
	}
	
	@RequestMapping(value="/ctms/j01/popupDMCJ0102.do")
	public String DMCJ0102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/j01/DMCJ0102";
	}
	
	/**
	 * DMC Home 정보 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j01/selectDmcHomeInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectDmcHomeInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> taskStatus   = null;
		List<Map<String, Object>> notification = null;
		List<Map<String, Object>> noticeList   = null;

		try {
			taskStatus   = DMCJ01Service.selectTaskRegStatusList(map);
			noticeList   = DMCJ01Service.selectTaskNoticeList(map);
			notification = ctma01Service.selectNotifyDmcList(map);
			result.put("success", true);
			result.put("taskStatus"  , taskStatus  );
			result.put("noticeList"  , noticeList  );
			result.put("notification", notification);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * 과제별 진행 List 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/j01/selectTaskProgressList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectTaskProgressList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		List<Map<String, Object>> taskList = null;

		try {
			taskList = DMCJ01Service.selectTaskProgressList(map);
			result.put("success", true);
			result.put("taskList", taskList  );
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
}
