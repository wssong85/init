package pantheon.edc.d01.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.edc.d01.service.EDCD01Service;

/**
 * Query 관리를 처리하는 컨트롤러 클래스
 * 
 * @author 오동근
 * @since 2016.05.31
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.31 오동근 최초 생성
 */
@Controller
@RequestMapping("/edc/d01")
public class EDCD01Controller {
	
	@Resource(name = "EDCD01Service")
	EDCD01Service edcd01Service;
	
	@RequestMapping("/EDCD0101.do")
	public String EDCD0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/d01/EDCD0101";
	}
	
	@RequestMapping("/EDCD0102.do")
	public String EDCD0102(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/d01/EDCD0102";
	}
	
	@RequestMapping("/popupEDCD0105.do")
	public String popupEDCD0105(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/d01/EDCD0105";
	}
	
	@RequestMapping("/selectDownTemplate.do")
	public @ResponseBody Map<String, Object> selectDownTemplate(@RequestParam Map<String, String> map, 
			ModelMap model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			result = edcd01Service.selectQueryTemplate(map);
			
			result.put("success", true);
	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 파일다운로드
	 * @param request
	 * @param response
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectOpenFile.do", produces="text/plain;charset=UTF-8")
	public void selectOpenFile(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		File uFile = new File(map.get("FILE_PATH"));
		int fSize = (int) uFile.length();
		
		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			String mimetype = "text/html";
			
			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			String userAgent 	= request.getHeader("User-Agent");
			String filename = map.get("FILE_NAME") + ".xls";
			if(userAgent.indexOf("MSIE") > -1){
				filename = URLEncoder.encode(filename, "utf-8");
			}else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
				filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "\\ ");
		    }else{
		    	filename = new String(filename.getBytes("utf-8"), "iso-8859-1");
			}
			response.setHeader("Content-Disposition", "attachment; filename=\""+ filename + "\"");
			response.setContentLength(fSize);
			
			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
			uFile.delete();
		} else {
			//setContentType을 프로젝트 환경에 맞추어 변경
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"+ map.get("FILE_NAME") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
			uFile.delete();
		}
	}
	
	/**
	 * Query 목록[예비] 검색
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectQueryListByPre.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectQueryListByPre(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = edcd01Service.selectQueryListByPre(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	/**
	 * Query 목록[오픈] 검색
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectQueryListByOpen.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectQueryListByOpen(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("################ map : "+map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = edcd01Service.selectQueryListByOpen(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
	
	/**
	 * Query 목록 쿼리 발행
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateCmQueryByQuerySttus.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateCmQueryByQuerySttus(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edcd01Service.updateCmQueryByQuerySttus(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Query 목록 쿼리 삭제
	 * @param request
	 * @param response
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateCmQueryByUseAt.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateCmQueryByUseAt(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("=============>>>>>>>>> map : "+list);
		try {
			edcd01Service.updateCmQueryByUseAt(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/selectQueryListByExcel.do")
	public @ResponseBody String selectQueryListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		String result = null;
		
		try {
			Map<String, Object> resultMap = edcd01Service.selectQueryListByExcel(request);
			result = "{\"success\": true, \"count\": " + resultMap.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)resultMap.get("list"))+"}";
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	@RequestMapping(value="/insertCfQuery.do")
	public @ResponseBody Map<String, Object> insertCfQuery(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			edcd01Service.insertCfQuery(list);;
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	

}
