package pantheon.iwrs.b01.web;

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
import pantheon.iwrs.b01.service.IWRB01Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;

/**
 * 트리거 처리 컨트롤러 클래스
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
public class IWRB01Controller {
	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;
	
	/**
	 * 트리거 화면 출력
	 * @param req
	 * @param resp
	 * @return 
	 */
	@IncludedInfo(name="트리거관리", order = 8020 ,gid = 110)
	@RequestMapping("/iwrs/b01/IWRB0101.do")
	public String IWRB0101(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/iwrs/b01/IWRB0101";
	}
	
	/**
	 * 트리거 등록
	 * @param req
	 * @param resp
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/iwrs/b01/insertTriggerInfo.do")
	public Map<String, Object> insertTriggerInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("param", req.getParameter("data"));
			
			iwrb01Service.insertTriggerInfo(map);
			result.put("message", "등록하였습니다.");
			result.put("result", true);
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("result", false);
		}
		
		return result;
	}
	
	/**
	 * 트리거 정보 수정
	 * @param req
	 * @param resp
	 * @return 
	 */
	@RequestMapping("/iwrs/b01/updateTriggerInfo.do")
	public Map<String, Object> updateTirggerInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("param", req.getParameter("data"));
			iwrb01Service.updateTriggerInfo(map);
			result.put("message", "등록하였습니다.");
			result.put("result", true);
		} catch (Exception e) {
			result.put("message", Util.getPantheonErrorMessage(e, this));
			result.put("result", false);
		}
		
		return result;
	}
	
	/**
	 * 트리거 정보 select
	 * @param req
	 * @param resp
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/b01/selectTriggerInfo.do")
	public Map<String, Object> selectTriggerInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			List<Map<String, String>> list = iwrb01Service.selectTriggerInfo(map);
			for(Map<String, String> deli : list){
				deli.put("APPLCDE", EgovDateUtil.convertDate(deli.get("APPLCDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			result.put("list", list);
			result.put("result", true);
		} catch (Exception e) {
			result.put("result", false);
			result.put("message", "트리거 현황을 정상적으로 가져오지 못하겠습니다.");
		}
		return result;
	}
	
	/**
	 * 트리거에서 배송 요청 발생
	 * @param req
	 * @param resp
	 * @return 
	 */
	@RequestMapping("/iwrs/b01/insertRequestDelivery.do")
	public void insertRequestDelivery(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> param = new HashMap<String, String>();
		try{
			iwrb01Service.insertRequestDelivery(param);
		}catch(Exception e){
			System.err.println(e.getLocalizedMessage());
		}
	}
	
	/**
	 * 해당 과제에서 사용되는 IP Type Select
	 * @param req
	 * @param resp
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/iwrs/b01/selectIpType.do")
	public List<Map<String, String>> selectIpType(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		List<Map<String, String>> list = null;
		try{
			Map<String, String> map = new HashMap<String, String>();
			map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
			list = iwrb01Service.selectIpType(map);
			
			System.err.println(list);
		}catch(Exception e){
			
		}
		
		return list;
	}
	
	@RequestMapping("/iwrs/b01/popupIwrb0102.do")
	public String popupIwrb0102(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		req.setAttribute("callbackFunction", req.getParameter("callbackFunction"));
		return "/pantheon/iwrs/b01/IWRB0102";
	}
	
	@ResponseBody
	@RequestMapping("/iwrs/b01/selectUserInfo.do")
	public Map<String, Object> selectUserInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		try{
			param.put("USER_ID", req.getParameter("USER_ID"));
			param.put("PASSWORD", req.getParameter("PASSWORD"));
			
			if(!Util.getUserMap().get("USER_ID").equals(req.getParameter("USER_ID"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(param);
				
				if(cnt > 0){
					result.put("result", "true");
				}else{
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}	
			}
		}catch(Exception e){
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
