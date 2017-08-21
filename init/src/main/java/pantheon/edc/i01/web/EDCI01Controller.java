package pantheon.edc.i01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.annotation.IncludedInfo;
import pantheon.com.utl.Util;
import pantheon.com.z09.service.COMZ09Service;
import pantheon.edc.i01.service.EDCI01Service;

/**
 * Blind 관리를 처리하는 컨트롤러 클래스
 * @author 오동근
 * @since 2016.03.03
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.03  오동근          최초 생성
 *  
 */
@Controller
@RequestMapping("/edc/i01")
public class EDCI01Controller {
	
	@Resource(name = "EDCI01Service")
	EDCI01Service edci01Service;
	
	@Resource(name = "COMZ09Service")
	private COMZ09Service comz09Service;
	
	@IncludedInfo(name="pantheon Blind (연구자)목록", order = 6530, gid = 110)
	@RequestMapping("/EDCI0101.do")
	public String EDCI0101(ModelMap model, HttpServletRequest request, Map<String, Object> searchMap) throws Exception {
		return "/pantheon/edc/i01/EDCI0101";
	}
	
	@IncludedInfo(name="pantheon Blind (현업)목록", order = 6540, gid = 110)
	@RequestMapping("/EDCI0102.do")
	public String EDCI0102(ModelMap model, HttpServletRequest request, Map<String, Object> searchMap) throws Exception {
		return "/pantheon/edc/i01/EDCI0102";
	}

	@RequestMapping("/popupEDCI0103.do")
	public String popupEDCI0103(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/i01/EDCI0103";
	}

	@RequestMapping("/popupEDCI0104.do")
	public String popupEDCI0104(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/i01/EDCI0104";
	}

	@RequestMapping("/popupEDCI0105.do")
	public String popupEDCI0105(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/i01/EDCI0105";
	}

	@RequestMapping("/popupEDCI0106.do")
	public String popupEDCI0106(@RequestParam Map<String, Object> map, ModelMap model) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/i01/EDCI0106";
	}
	
	/**
	 * Blind 목록(연구자) 관리 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectResearchSubjectList.do")
	public @ResponseBody Map<String , Object> seletResearchSubjectList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edci01Service.selectResearchSubjectList(map);
			
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * Blind 목록(현업) 관리 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectFieldSubjectList.do")
	public @ResponseBody Map<String , Object> selectFieldSubjectList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edci01Service.selectFieldSubjectList(map);
			
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	

	/**
	 * 결재 요청 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/insertEdcSanctnRequstByEdcSanClineDetailInfo.do")
	public @ResponseBody Map<String, Object> insertEdcSanctnRequstByEdcSanClineDetailInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody Map<String, Object> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			edci01Service.insertEdcSanctnRequstByEdcSanClineDetailInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * 눈가림 해제 승인 popup 창 select
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCfSubject.do")
	public @ResponseBody Map<String , Object> selectCfSubject(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			result = edci01Service.selectCfSubject(map);
			
			result.put("success", true);
			result.put("result", result);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * 눈가림 즉시해제 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEdcCfSubjectByBlindSttusCd.do")
	public @ResponseBody Map<String, Object> updateCmSanctnProcessByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			//BLIND 상태코드 '승인'으로 변경
			edci01Service.updateEdcCfSubjectByBlindSttusCd(map);
			
			result.put("message", "눈가림 해제가 완료되었습니다.");
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 눈가림 해제 요청 결제 처리 후 결제완료 건인 경우 SMS 전송
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/updateCmSanctnRslt.do")
	public @ResponseBody Map<String, Object> updateCmSanctnRslt(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		
		try {
			param = (Map<String, String>) edci01Service.updateScanProcess(map);
			
			if("02".equals(param.get("STTUS_CODE"))) {
				result.put("message", "승인이 완료되었습니다.");	
			} else if("03".equals(param.get("STTUS_CODE"))) {
				result.put("message", "반려가 완료되었습니다.");
			} else if("05".equals(param.get("STTUS_CODE"))) {
				result.put("message", "취소가 완료되었습니다.");
			}
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 눈가림 즉시해제 승인번호 받기
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEdcCfSubjectBySendInfo.do")
	public @ResponseBody Map<String, Object> updateEdcCfSubjectBySendInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		System.out.println(this.getClass().getSimpleName()+"  ====> "+map);
		
		try {
			//눈가림 즉시해제 승인번호 전송
			edci01Service.updateEdcCfSubjectBySendInfo(map);
			//param = edci01Service.selectSendInfo(map);		//SMS or mail 전송에 필요한 데이터 가져오기

			result.put("message", "승인번호가 전송되었습니다.");
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
