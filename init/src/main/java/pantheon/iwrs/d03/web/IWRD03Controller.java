package pantheon.iwrs.d03.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.iwrs.d03.service.IWRD03Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * IP Error Log 처리 컨트롤러 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
@Controller
public class IWRD03Controller {
	@Resource(name = "IWRD03Service")
	private IWRD03Service iwrd03Service;
	
	/**
	 * IP Error Log 페이지 오픈
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="IP ERROR LOG", order = 8070 ,gid = 110)
	@RequestMapping("/iwrs/d03/IWRD0301.do")
	public String IWRD0301(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/iwrs/d03/IWRD0301";
	}
	
	/**
	 * IP Error Log Data Select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("iwrs/d03/selectErrorLog")
	public Map<String, Object> selectErrorLog(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		try{
			List<Map<String, String>> list = iwrd03Service.selectErrorLog(map);
			result.put("result", "ok");
			result.put("list", list);
		}catch(Exception ex){
			result.put("result", "fail");
			result.put("message", ex.getLocalizedMessage());
		}
		
		return result;
	}
}
