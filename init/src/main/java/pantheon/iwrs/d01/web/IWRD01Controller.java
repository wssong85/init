package pantheon.iwrs.d01.web;

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
import pantheon.iwrs.d01.service.IWRD01Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * IP 현황 처리 컨트롤러 클래스
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
public class IWRD01Controller {
	@Resource(name = "IWRD01Service")
	private IWRD01Service iwrd01Service;
	
	/**
	 * ip현황 페이지 출력
	 * @param request
	 * @param response
	 * @return 
	 */
	@IncludedInfo(name="IP현황", order = 8050 ,gid = 110)
	@RequestMapping("/iwrs/d01/IWRD0101.do")
	public String IWRD0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/iwrs/d01/IWRD0101";
	}
	
	/**
	 * 배송요청 확인 데이터 select
	 * @param request
	 * @param response
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/d01/selectDrugStockInfo.do")
	public Map<String, Object> selectDrugStockInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("task_code", Util.getUserMap().get("TASK_SN"));
		try{
			List<Map<String, String>> list = iwrd01Service.selectDrugStockInfo(map);
			result.put("result", "ok");
			result.put("list", list);
		}catch(Exception ex){
			result.put("result", "fail");
			result.put("message", ex.getLocalizedMessage());
		}
		
		return result;
	}
}
