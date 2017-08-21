package pantheon.sdb.b02.web;

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
import pantheon.sdb.b02.service.SDBB02Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovDateUtil;

@Controller
public class SDBB02Controller {
	@Resource(name="SDBB02Service")
	private SDBB02Service sdbb02Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@IncludedInfo(name="거래선 리스트", order = 9060 ,gid = 110)
	@RequestMapping(value="/sdb/b02/SDBB0201.do")
	public String sdbb0301(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/sdb/b02/SDBB0201";	 	
	}
	
	@IncludedInfo(name="거래선 등록", order = 9070 ,gid = 110)
	@RequestMapping(value="/sdb/b02/SDBB0202.do")
	public String sdbb0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("=======");
//		System.out.println(request.getRequestURI());
		String delngln_code = request.getParameter("DELNGLN_CODE");			
		request.setAttribute("req_delngln_code", delngln_code);
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> map2 = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType2 = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB003");
		map.put("task_code", "1");
		map.put("type", "type");
		map2.put("CMMN_CLCODE", "SDB002");
		map2.put("task_code", "1");
		map2.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			printType2 = comd01Service.selectCmCmmnCodeListByPk(map2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("printType2", printType2);
		
		return "/pantheon/sdb/b02/SDBB0202";	 	
	}
	
	@RequestMapping(value="/sdb/b02/popupSDBB0203.do")
	public String popupSdbb0203(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txtdelngln_code = request.getParameter("DELNGLN_CODE");		
		request.setAttribute("DELNGLN_CODE", txtdelngln_code);

		return "/pantheon/sdb/b02/SDBB0203";
	}
	
	@RequestMapping(value="/sdb/b02/popupSDBB0204.do")
	public String popupSdbb0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "/pantheon/sdb/b02/SDBB0204";
	}

	
	/**
	 * 기관 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b02/selectOrganInfo.do")
	public Map<String, Object> selectOrganInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String delngln_code = req.getParameter("DELNGLN_CODE");			
		param.put("DELNGLN_CODE", delngln_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = sdbb02Service.selectOrganInfo(param);
		
		try {			
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	/**
	 * 거래선 등록/수정/삭제
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/b02/insertOrgan.do")
	public Map<String, Object> insertOrgan(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		System.out.println("=======================ddddd");
		System.out.println(req.getParameter("data"));
		try {
			
			System.out.println("@@@AJax Insert!!!!!");
			param.put("data", req.getParameter("data"));		
			String d_code = sdbb02Service.insertOrgan(param);
			result.put("success", true);
			result.put("d_code", d_code);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
			
	}
	
	
	
	
	/**
	 * 기관 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/selectOrganList.do")
	public @ResponseBody Map<String , Object> selectOrganList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb02Service.selectOrganList(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	
	/**
	 * 기관 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b02/selectDelnglnInfo.do")
	public Map<String, Object> selectDelnglnInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String delngln_code = req.getParameter("DELNGLN_CODE");			
		param.put("DELNGLN_CODE", delngln_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			map = sdbb02Service.selectDelnglnInfo(param);
			
			if(map.get("CNTRCT_PD") != null){
				map.put("CNTRCT_PD", EgovDateUtil.convertDate(String.valueOf(map.get("CNTRCT_PD")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				
			}
			if(map.get("CNTRCT_PD_END") != null){
				map.put("CNTRCT_PD_END", EgovDateUtil.convertDate(String.valueOf(map.get("CNTRCT_PD_END")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("EFECT_OCCRRNCDE") != null){
				map.put("EFECT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(map.get("EFECT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("PRMISNDE") != null){
				map.put("PRMISNDE", EgovDateUtil.convertDate(String.valueOf(map.get("PRMISNDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("CMTDE") != null){
				map.put("CMTDE", EgovDateUtil.convertDate(String.valueOf(map.get("CMTDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}			
			
			result.put("success", true);
			result.put("result", map);	
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
	
	
	/**
	 * 기관 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/selectCntrctInfo.do")
	public @ResponseBody Map<String , Object> selectCntrctInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb02Service.selectCntrctInfo(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 담당자 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/selectChagerListInfo.do")
	public @ResponseBody Map<String , Object> selectChagerListInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = sdbb02Service.selectChagerListInfo(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
	
	/**
	 * 담당자  상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "/sdb/b02/selectChagerInfo.do")
	public Map<String, Object> selectChagerInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, Object> param = new HashMap<String, Object>();
		String delngln_code = req.getParameter("DELNGLN_CODE");			
		param.put("DELNGLN_CODE", delngln_code);
		//Map<String, Object> result = new HashMap<String, Object>();		
		Map<String, Object> result = sdbb02Service.selectChagerInfo(param);
		
		try {			
			result.put("success", "true");
				
		} catch (Exception e) {
			result.put("success", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		System.out.println("@@@33333 Info!!!!!");
		System.out.println(result);
		return result;
		
	}
		
	
	/**
	 * 취급의약품 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/b02/insertProduct.do")
	public Map<String, Object> insertProduct(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb02Service.insertProduct(iMap);
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 취급의약품 삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	@RequestMapping(value="/sdb/b02/insertProductDel.do")
	public @ResponseBody Map<String, Object> insertProductDel(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> iMap) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			sdbb02Service.insertProductDel(iMap);
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 기관 상세조회
	 * @param request
	 * @param response 
	 * @return map
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/sdb/b02/selectProductInfo.do")
	public  @ResponseBody Map<String , Object> selectProductInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {			
		
		Map<String, String> param = new HashMap<String, String>();
		String delngln_code = req.getParameter("DELNGLN_CODE");			
		param.put("DELNGLN_CODE", delngln_code);
		//Map<String, Object> result = new HashMap<String, Object>();	
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = sdbb02Service.selectProductInfo(param);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
		
	}
	/**
	 * 기관 삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/delOrgan.do")
	public @ResponseBody Map<String, Object> delOrgan(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		Map<String, String> param = new HashMap<String, String>();
		System.out.println("@@@AJax Insert!!!!!");
		
		String txtmode 			= req.getParameter("MODE");
		String txtdelngln_code 	= req.getParameter("DELNGLN_CODE");
		
		param.put("MODE", txtmode);
		param.put("DELNGLN_CODE", txtdelngln_code);
		
		
		boolean flag = sdbb02Service.delOrgan(param, txtmode);
		
		System.out.println(flag);
		Map<String, Object> map = new HashMap<String, Object>();		
		if (flag) {
			map.put("result", "ok");
			//map.put("PRDUCT_CODE", txtprduct_code);
		} else {
			map.put("result", "fail");
			map.put("errmsg", "");
		}
		
		System.out.println("==============Controller");
		System.out.println(map);
		return map;	
	}
	

	
	
	/**
	 * 계약서 삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/delCtFile.do")
	public @ResponseBody Map<String, Object> delCtFile(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			sdbb02Service.delCtFile(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}	
	
	
	/**
	 * 의약품 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/selectProductList.do")
	public @ResponseBody Map<String , Object> selectProductList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			list = sdbb02Service.selectProductList(map);
			result.put("success", true);
			result.put("count", sdbb02Service.selectProductListCount(map));
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	/**
	 * 등록된의약품 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/b02/selectProductListReg.do")
	public @ResponseBody Map<String , Object> selectProductListReg(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("@@@AJAX sdb!!!!!");
		try {
			System.out.println(map);
			list = sdbb02Service.selectProductListReg(map);
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	
}
