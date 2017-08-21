package pantheon.ctms.b01.web;

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













import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.ctms.b01.service.CTMB01Service;


@Controller
public class CTMB01Controller {
	
	@Resource(name="CTMB01Service")
	private CTMB01Service ctmb01Service;

	/**
	 * 임상과제 Summary 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="임상과제및 과제정보", order = 7030 ,gid = 110)
	@RequestMapping(value="/ctms/b01/CTMB0101.do")
	public String ctmb0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);		
		
		return "/pantheon/ctms/b01/CTMB0101";
	}
	
	/**
	 * 임상과제  TASK_NO  조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b01/selectClinicalAssignmentList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectClinicalAssignmentList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;		
		try {
			//map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			list = ctmb01Service.selectClinicalAssignmentList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	/**
	 * 임상과제 Summary 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b01/selectclinicalbyGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectclinicalbyGrid(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("selectclinicalbyGrid========================================================"+map);

		try {
			list = ctmb01Service.selectclinicalbyGrid(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	/**
	 * 임상과제 Status 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/b01/CTMB0102.do")
	public String ctmb0102(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		request.setAttribute("map", map);		
		return "/pantheon/ctms/b01/CTMB0102";
	}
	
}
