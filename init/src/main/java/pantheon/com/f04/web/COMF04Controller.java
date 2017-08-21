package pantheon.com.f04.web;

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

import pantheon.com.f04.service.COMF04Service;
import pantheon.com.utl.Util;

/**
 * 접속이력 처리하는 컨트롤러 클래스
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
public class COMF04Controller {
	@Resource(name = "COMF04Service")
	private COMF04Service comf04Service;
	
	@RequestMapping(value="/com/f04/COMF0401.do")
	public String comf0401(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/f04/COMF0401";
	}
	
	/**
	 * 접속이력 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/f04/selectCmSysConectListByCondition.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmSysConectListByCondition(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		try {
			count = comf04Service.selectCmSysConectListCountByCondition(map);
			list = comf04Service.selectCmSysConectListByCondition(map);
			result.put("success", true);
			result.put("count", count);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
