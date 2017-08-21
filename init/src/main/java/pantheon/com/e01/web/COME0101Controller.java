package pantheon.com.e01.web;

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

import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;

/**
 * 인터페이스 처리하는 컨트롤러 클래스
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
public class COME0101Controller {

	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@RequestMapping(value="/com/e01/COME0101.do")
	public String come0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/e01/COME0101";
	}
	
	/**
	 * 인터페이스 조회한다.
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/e01/selectCmIntrfcByCondition.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmIntrfcByCondition(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		
		try {
			count = come01Service.selectCmIntrfcListCountByCondition(map);
			list = come01Service.selectCmIntrfcListByCondition(map);
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
