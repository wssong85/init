package pantheon.com.z05.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.string.EgovStringUtil;

/**
 * 우편번호 (오픈API) 처리하는 컨트롤러 클래스
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
public class COMZ05Controller {

	@RequestMapping(value="/com/anonymous/popupCOMZ0501.do")
	public String comz0501(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "/pantheon/com/z05/COMZ0501";
	}
	
	/**
	 * 우편번호를 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/com/anonymous/selectAddrApi.do", method=RequestMethod.POST)
    public @ResponseBody Map<String, Object> getAddrApi(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	if(!map.containsKey("keyword") || EgovStringUtil.isEmpty(map.get("keyword"))) {
			result.put("success", false);
			result.put("message", "keyword is null");
			return result;	
    	}
		
		String apiUrl = "http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage=1"+
				"&countPerPage=1000&keyword="+map.get("keyword")+"&confmKey="+EgovProperties.getProperty("juso.confirmkey");
		
		String[] arrStr = {"roadAddr", "roadAddrPart1", "roadAddrPart2", "jibunAddr", "engAddr", "zipNo", "admCd", "rnMgtSn", "bdMgtSn"};
		
		try {
			result.put("success", true);
			result.put("result", Util.getListByXml(apiUrl, null, arrStr, "juso"));
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
    }
}
