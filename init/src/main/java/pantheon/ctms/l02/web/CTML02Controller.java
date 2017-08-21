package pantheon.ctms.l02.web;

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

import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.ctms.l02.service.CTML02Service;

@Controller
public class CTML02Controller {
	
	@Resource(name="CTML02Service")
	private CTML02Service CTML02Service;

	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	/**
	 * To do List 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@IncludedInfo(name="To do List", order = 7060 ,gid = 110)
	@RequestMapping(value="/ctms/l02/CTML0201.do")
	public String CTML0201(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/ctms/l02/CTML0201";
	}
	/**
	 * To do List 그리드 데이터 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l02/selectGridByTodoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectGridByTodoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;	
		Map<String, String> param1 = new HashMap<String, String>();
		Map<String, String> param2 = new HashMap<String, String>();
		
		param1.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //NIS,PMS
		param1.put("CMMN_CLCODE", "CTMS037");
		param2.put("QUERY", "selectCmCmmCodeByCmmnClcode"); //임상
		param2.put("CMMN_CLCODE", "CTMS038");

		try {
			list = CTML02Service.selectGridByTodoList(map);	
			
			for(Map<String, Object> deli : list){				
				deli.put("PLAN_BEGIN", EgovDateUtil.convertDate((String) deli.get("PLAN_BEGIN"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("PLAN_END", EgovDateUtil.convertDate((String) deli.get("PLAN_END"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("EXECUT_BEGIN", EgovDateUtil.convertDate((String) deli.get("EXECUT_BEGIN"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("EXECUT_END", EgovDateUtil.convertDate((String) deli.get("EXECUT_END"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}
			
			result.put("success", true);		
			result.put("param1", CommonService.selectQueryDataList(param1));
			result.put("param2", CommonService.selectQueryDataList(param2));;
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	/**
	 * To do List 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l02/updateGridByTodoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateGridByTodoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			CTML02Service.updateGridByTodoList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
