package pantheon.com.z09.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovMessageSource;
import pantheon.com.h01.service.COMH01Service;
import pantheon.com.utl.Util;
import pantheon.com.z09.service.COMZ09Service;

/**
 * 결재선 처리하는 컨트롤러 클래스
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
public class COMZ09Controller {
	
	@Resource(name = "COMZ09Service")
	private COMZ09Service comz09Service;
	
	@Resource(name = "COMH01Service")
	private COMH01Service comh01Service;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	/**
	 * 결재선입력 화면 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/z09/popupCOMZ0901.do")
	public String popupComz0901(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		model.addAttribute("REQUST_NM", map.get("REQUST_NM"));
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "/pantheon/com/z09/COMZ0901";
	}
	
	/**
	 * 결재선설정 화면 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/z09/popupCOMZ0902.do")
	public String popupComz0902(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		
		if(map != null && map.get("callbackFunction") != null) {
			model.addAttribute("callbackFunction", map.get("callbackFunction"));	
		}
		model.addAllAttributes(map);
		return "/pantheon/com/z09/COMZ0902";
	}
	
	/**
	 * 결재화면 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/z09/popupCOMZ0903.do")
	public String popupComz0903(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		try {
			if(map != null && map.get("GUBUN") != null) {
				model.addAttribute("GUBUN", map.get("GUBUN"));
			}
			
			if(map != null && map.get("CALLBACK_TRUE") != null) {
				model.addAttribute("CALLBACK_TRUE", map.get("CALLBACK_TRUE"));
			}
		} catch (Exception e) {
			Util.recordThrow(this, e);
		}
		
//		model.addAttribute("GUBUN", "Y");
		model.addAttribute("REQUST_NO", map.get("REQUST_NO"));
		model.addAttribute("callbackFunction", map.get("callbackFunction"));
		return "/pantheon/com/z09/COMZ0903";
	}
	
	/**
	 * 전자서명 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/z09/popupCOMZ0904.do")
	public String popupComz0904(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map, ModelMap model) throws Exception{
		
		if(map != null && map.get("callbackFunction") != null) {
			model.addAttribute("callbackFunction", map.get("callbackFunction"));	
		}
		
		return "/pantheon/com/z09/COMZ0904";
	}
	
	/**
	 * 내부유저 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/selectCmJobUserListForAll.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmJobUserListForAll(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comz09Service.selectCmJobUserListForAll(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재선 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/selectCmSanClineListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmSanClineListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comz09Service.selectCmSanClineListByPk(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재선 상세 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/selectCmSanClineDetailListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmSanClineDetailListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comz09Service.selectCmSanClineDetailListByPk(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재선 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/selectCmSanClineListForComboBox.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmSanClineListForComboBox(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = comz09Service.selectCmSanClineListForComboBox(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재처리 목록 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/selectCmSanctnProcessListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmSanctnProcessListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = comz09Service.selectCmSanctnProcessListByPk(map);
			
//			for(Map<String, Object> iMap : list) {
//				iMap.put("SANCTN_DT", EgovDateUtil.convertDate(EgovStringUtil.nullConvert(iMap.get("SANCTN_DT")), null, null, null));
//			}
			
			if(list.size() == 0) {
				result.put("success", false);
			} else {
				result.put("success", true);
			}
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * 결재선 저장(신규)
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/insertSanClineForCreate.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertSanClineForCreate(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			String strSanclineSeq = comz09Service.insertSanClineForCreate(list);
			result.put("success", true);
			result.put("SANCLINE_SN", strSanclineSeq);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재선 저장(수정)
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/insertSanClineForUpdate.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertSanClineForUpdate(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comz09Service.insertSanClineForUpdate(list);
			result.put("success", true);
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
	@RequestMapping(value="/com/z09/insertCmSanctnRequstByCmSanClineDetailInfo.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertCmSanctnRequstByCmSanClineDetailInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			result.put("REQUST_NO", comz09Service.insertCmSanctnRequstByCmSanClineDetailInfo(list));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 결재 처리 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/z09/updateCmSanctnProcessByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCmSanctnProcessByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//계정 유효성 체크(만약 제대로 입력 안하면 계정잠근다.)
			comh01Service.selectCmUserForContractReq(map);
			
			String seqRequst = comz09Service.updateCmSanctnProcessByPk(map);
			
			if("02".equals(map.get("STTUS_CODE"))) {
				result.put("message", egovMessageSource.getPantheonExceptionMessage("comz09.message.9"));	
			} else if("03".equals(map.get("STTUS_CODE"))) {
				result.put("message", egovMessageSource.getPantheonExceptionMessage("comz09.message.10"));
			} else if("05".equals(map.get("STTUS_CODE"))) {
				result.put("message", egovMessageSource.getPantheonExceptionMessage("comz09.message.11"));
			}
			
			result.put("success", true);
			result.put("REQUST_NO", seqRequst);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
