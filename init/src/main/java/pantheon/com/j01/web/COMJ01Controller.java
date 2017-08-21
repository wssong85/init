package pantheon.com.j01.web;

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

import pantheon.com.j01.service.COMJ01Service;
import pantheon.com.utl.Util;

/**
 * ATRAIL 처리하는 컨트롤러 클래스
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
public class COMJ01Controller {
	@Resource(name="COMJ01Service")
	private COMJ01Service comj01Service;
	
	
	/**
	 * ATRAIL 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/j01/COMJ0101.do")
	public String comj0101(HttpServletRequest request, HttpServletResponse response) throws Exception{

		return "/pantheon/com/j01/COMJ0101";
	}
	
	
	/**
	 * ATRAIL 조건검색
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/j01/selectCmDtaAtrailListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmDtaAtrailListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		try {
			count = comj01Service.selectCmDtaAtrailListCountByPk(map);
			list = comj01Service.selectCmDtaAtrailListByPk(map);
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
