package pantheon.edc.e01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.h01.service.COMH01Service;
import pantheon.com.utl.Util;
import pantheon.edc.e01.service.EDCE01Service;
import pantheon.iwrs.b01.service.IWRB01Service;

@Controller
@RequestMapping("/edc/e01")
public class EDCE01Controller {
	
	@Resource(name = "EDCE01Service")
	EDCE01Service edce01Service;
	
	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;
	
	@Resource(name = "COMH01Service")
	private COMH01Service comh01Service;
	
	@RequestMapping("/EDCE0101.do")
	public String EDCE0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/e01/EDCE0101";
	}
	
	@RequestMapping("/EDCE0102.do")
	public String EDCE0102(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/e01/EDCE0102";
	}
	
	@RequestMapping("/popupEDCE0103.do")
	public String EDCE0103(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		String snList = request.getParameter("rows");
		String type = request.getParameter("type");
		request.setAttribute("snList", snList);
		request.setAttribute("type", type);
		model.addAllAttributes(map);
		
		return "/pantheon/edc/e01/EDCE0103";
	}
	
	/**
	 * eSign Subject 목록
	 * 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectESignVisitList.do")
	public @ResponseBody Map<String, Object> selectEdcVisitList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;

		try {
			list = edce01Service.selectESignVisitList(param);
			result.put("success", true);
			result.put("result", list);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;
	}
	
	/**
	 * eSign Visit 목록
	 * 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectESignSubjectList.do")
	public @ResponseBody Map<String, Object> selectESignSubjectList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;

		try {
			list = edce01Service.selectESignSubjectList(param); 
			result.put("success", true);
			result.put("result", list);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;
	}
	
	
	/**
	 * eSign 전자서명 사용자 계정 확인 및 전자서명 상태 update
	 * @param req
	 * @param resp
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/updateEltsgn.do")
	public Map<String, Object> selectUserInfo(HttpServletRequest req, HttpServletResponse resp,@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			// 사용자 계정 패스워드 확인 및 실패시 계정 잠김 처리
			comh01Service.selectCmUserForContractReq(map);
			String[] snList;
			String sn = "";
			sn = map.get("SN");
			
			if(!Util.getUserMap().get("USER_ID").equals(map.get("USER_ID"))){
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			}else{
				int cnt = iwrb01Service.selectUserInfo(map);
				
				if(cnt > 0){
					snList = sn.split(",");
					
					for(String s : snList){
						map.put("UPDATE_SN", s);
						if(map.get("TYPE").equals("VISIT")){
							edce01Service.updateESignVisit(map);
						}else{
							edce01Service.updateESignSubject(map);
						}
					}
					
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
