package pantheon.sdb.c01.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.sdb.c01.service.SDBC01Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Controller
public class SDBC01Controller {
	@Resource(name="SDBC01Service")
	private SDBC01Service sdbc01Service;                                                           
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "SDB_SOURCE_SEQ")
	private EgovIdGnrService sdbSourceSeq;
	
	@IncludedInfo(name="Study 조회/리스트", order = 9110 ,gid = 110)
	@RequestMapping(value="/sdb/c01/SDBC0101.do")
	public String sdbc0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/c01/SDBC0101";	 	
	}
	
	@IncludedInfo(name="Study 등록/수정/삭제", order = 9120 ,gid = 110)
	@RequestMapping(value="/sdb/c01/SDBC0102.do")
	public String sdbc0102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txtprtcl_no = request.getParameter("PRTCL_NO");
		request.setAttribute("PRTCL_NO", txtprtcl_no);
		//공통코드
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> map2 = new HashMap<String, String>();
		Map<String, String> map3 = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType3 = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB004");
		map.put("task_code", "1");
		map.put("type", "type");
		map2.put("CMMN_CLCODE", "SDB005");
		map2.put("task_code", "1");
		map2.put("type", "type");
		map3.put("CMMN_CLCODE", "SDB044");
		map3.put("task_code", "1");
		map3.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			printType2 = comd01Service.selectCmCmmnCodeListByPk(map2);
			printType3 = comd01Service.selectCmCmmnCodeListByPk(map3);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("printType2", printType2);
		request.setAttribute("printType3", printType3);
		
		return "/pantheon/sdb/c01/SDBC0102"; 	
	}
	
	@RequestMapping(value="/sdb/c01/popupSDBC0103.do")
	public String popupSdbc0103(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("===============111");
		
		return "/pantheon/sdb/c01/SDBC0103";
	}	
	
	@RequestMapping(value="/sdb/c01/SDBC0104.do")
	public String sdbc0104(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/sdb/c01/SDBC0104";
	}
	@RequestMapping(value="/sdb/c01/SDBC0106.do")
	public String sdbc0106(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/sdb/c01/SDBC0106";
	}
	
	@RequestMapping(value="/sdb/c01/SDBC0107.do")
	public String sdbc0107(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String txtltrtre_no = request.getParameter("LTRTRE_NO");
		String txt_new_ltrtre_no;

		try {
			txt_new_ltrtre_no = sdbSourceSeq.getNextStringId();
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			txt_new_ltrtre_no="";
			e.printStackTrace();
		}
		
		request.setAttribute("NEW_LTRTRE_NO", txt_new_ltrtre_no);
		request.setAttribute("LTRTRE_NO", txtltrtre_no);		
		
		return "/pantheon/sdb/c01/SDBC0107";
	}
	@RequestMapping(value="/sdb/c01/SDBC0108.do")
	public String sdbc0108(HttpServletRequest request, HttpServletResponse response) throws Exception{	
		
		return "/pantheon/sdb/c01/SDBC0108";
	}
	
	@RequestMapping(value="/sdb/c01/SDBC0109.do")
	public String sdbc0109(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String txtetc_info_no = request.getParameter("ETC_INFO_NO");
		String txt_new_tec_info_no;
		System.out.println("=============이전");
		
			
		try {
			txt_new_tec_info_no = sdbSourceSeq.getNextStringId();
			System.out.println("===============1123123====="+txtetc_info_no);
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			txt_new_tec_info_no="";
			e.printStackTrace();
		}
		
		request.setAttribute("NEW_ETC_INFO_NO", txt_new_tec_info_no);
		request.setAttribute("ETC_INFO_NO", txtetc_info_no);
		return "/pantheon/sdb/c01/SDBC0109";
	}
	
	@RequestMapping(value="/sdb/c01/SDBC0110.do")
	public String sdbc0110(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/sdb/c01/SDBC0110";
	}
	
	/**
	 * Study 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@RequestMapping(value="/sdb/c01/selectTrialList.do")
	public @ResponseBody Map<String, Object> selectTrialList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		
		List<Map<String, Object>> list = null;
		System.out.println("Trial Control start");
		try{
			list = sdbc01Service.selectTrialList(map);
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * Study 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/selectStudyInfo.do")
	public  Map<String, Object> selectStudyInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc01Service.selectStudyInfo(param);
			//날짜형식변경
			if(map.get("MFDS_CONFM_DTE") != null){
				map.put("MFDS_CONFM_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("MFDS_CONFM_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			if(map.get("FRT_PATNT_OCCRRNCDE") != null){
				map.put("FRT_PATNT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(map.get("FRT_PATNT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			if(map.get("LAST_PATNT_OCCRRNCDE") != null){
				map.put("LAST_PATNT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(map.get("LAST_PATNT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			if(map.get("RYMSLMDONG_CTRL_DATA_TRNSMISDE") != null){
				map.put("RYMSLMDONG_CTRL_DATA_TRNSMISDE", EgovDateUtil.convertDate(String.valueOf(map.get("RYMSLMDONG_CTRL_DATA_TRNSMISDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			if(map.get("SAFEHELTH_DTA_LOCK_DTE") != null){
				map.put("SAFEHELTH_DTA_LOCK_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("SAFEHELTH_DTA_LOCK_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Protocol 리스트 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c01/selectStudyList.do")
	public @ResponseBody Map<String, Object> selectStudyList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		System.out.println(map);
		List<Map<String, Object>> list = null;
		System.out.println("StudyList Control start");
		try{
			list = sdbc01Service.selectStudyList(map);
			result.put("success", true);
			result.put("count", sdbc01Service.selectStudyListCount(map));
			result.put("result", list);
		} catch(Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	
	/**
	 * Study 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/insertStudyInfo.do")
	public Map<String, Object> insertStudyInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {

		System.out.println("============== Study insert Controller");
		System.out.println(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbc01Service.insertStudyInfo(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Spontaneous 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@RequestMapping(value="/sdb/c01/selectSpontaneousList.do")
	public @ResponseBody Map<String, Object> selectSpontaneousList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();		
		
		List<Map<String, Object>> list = null;
		System.out.println("Spontaneous Control start");
		try{
			list = sdbc01Service.selectSpontaneousList(map);
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * Literature 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c01/selectLiteratureList.do")
	public @ResponseBody Map<String, Object> selectLiteratureList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
		
		try{
			list = sdbc01Service.selectLiteratureList(map);
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Literature 리스트 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/selectLiteratureInfo.do")
	public  Map<String, Object> selectLiteratureInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("=========1==============etc controll");
		System.out.println(param);
		try{
			map = sdbc01Service.selectLiteratureInfo(param);
			
			
			if(map.get("PBLCATE_DTE") != null){
				map.put("PBLCATE_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("PBLCATE_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Literature 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/insertLiteratureInfo.do")
	public Map<String, Object> insertLiteratureInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {

		System.out.println("==============Controller");
		System.out.println(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbc01Service.insertLiteratureInfo(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * Etc 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c01/selectEtcList.do")
	public @ResponseBody Map<String, Object> selectEtcList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
		
		try{
			list = sdbc01Service.selectEtcList(map);
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Etc 리스트 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/selectEtcInfo.do")
	public  Map<String, Object> selectEtcInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("=========1==============etc controll");
		System.out.println(param);
		try{
			map = sdbc01Service.selectEtcInfo(param);
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	

	/**
	 * Etc 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c01/insertEtcInfo.do")
	public Map<String, Object> insertEtcInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {

		System.out.println("==============Controller");
		System.out.println(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbc01Service.insertEtcInfo(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
	/**
	 * ICSR 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c01/selectICSRList.do")
	public @ResponseBody Map<String, Object> selectICSRList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
		
		try{
			list = sdbc01Service.selectICSRList(map);
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
}
