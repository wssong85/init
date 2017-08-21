package pantheon.edc.k03.web;

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

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.edc.k03.service.EDCK03Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * Lab 정상범위 관리를 처리하는 컨트롤러 클래스
 * @author 오동근
 * @since 2016.02.29
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.29  오동근          최초 생성
 *  
 */
@Controller
@RequestMapping("/edc/k03")
public class EDCK03Controller {
	
	@Resource(name = "EDCK03Service")
	EDCK03Service edck03Service;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "PantheonCommonService")
	PantheonCommonService pantheonCommonService;
	
	@IncludedInfo(name="pantheon Lab 정상범위 관리 목록", order = 6520, gid = 110)
	@RequestMapping("/EDCK0301.do")
	public String EDCK0301(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/k03/EDCK0301";
	}
	
	@RequestMapping("/EDCK0302.do")
	public String EDCK0302(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/k03/EDCK0302";
	}
	
	@RequestMapping("/popupEDCK0303.do")
	public String popupEDCK0303(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/k03/EDCK0303";
	}
	
	@RequestMapping("/popupEDCK0302.do")
	public String popupEDCK0302(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/k03/EDCK0302Pop";
	}
	
	/**
	 * Lab 정상범위 관리 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectLabList.do")
	public @ResponseBody Map<String , Object> seletLabList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edck03Service.selectLabList(map);
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * Lab 정상범위 관리 상세
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/selectLab.do")
	public String selectLab(@RequestParam Map<String, Object> map, HttpServletRequest request, ModelMap model) throws Exception {
		model.addAttribute("param",  map.get("crud"));
		model.addAttribute("result", edck03Service.selectLab(map));
		return "/pantheon/edc/k03/EDCK0302";
	}
	
	/**
	 * Lab 정상범위 관리 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertLab.do")
	public @ResponseBody Map<String, Object> insertLab(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			param.put("USER_ID", Util.getUserMap().get("USER_ID"));
			edck03Service.insertLab(param);
			result.put("success", true);
			result.put("message", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * Lab 정상범위 관리 저장
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateLab.do")
	public @ResponseBody Map<String, Object> updateLab(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			param.put("USER_ID", Util.getUserMap().get("USER_ID"));
			edck03Service.updateLab(param);
			result.put("success", true);
			result.put("message", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	@RequestMapping(value="/selectAnalysisList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectAnalysisList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> list = null;
		
		try {
			list = edck03Service.selectAnalysisList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
	
	@RequestMapping("/selectDownTemplate.do")
	public @ResponseBody Map<String, Object> selectDownTemplate(@RequestParam Map<String, String> map, 
			ModelMap model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			result = edck03Service.selectLabTemplate(map);
			
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
	 * Data Upload와 동시에 Lab 파일을 읽어 유효성을 체크를 한 후 결과값을 리턴한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/selectLabListByExcel.do")
	public @ResponseBody String selectLabListByExcel(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)		throws Exception {
		String result = null;
		String moduleKnd = "EDC";
		try {
			String mstrSn = comz02Service.insertDmFileMstr(request, moduleKnd);
			map.put("FILE_MASTR_SN", mstrSn);
			
			List<Map<String, Object>> detailInfo = comz02Service.selectDmFileDetailListByPk(map);
			
			for(Map<String, Object> data : detailInfo){
				map.put("DETAIL_SN", data.get("DETAIL_SN").toString());
			
				Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(map);
				String filePath = fileInfo.get("DWLD_PHYSIC_COURS") + fileInfo.get("UPLOAD_FILE_NM");
				map.put("filePath", filePath);
				File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
				int fSize = (int) uFile.length();
				
				if (fSize > 0) {
					Map<String, Object> resultMap = edck03Service.selectLabListByExcel(request, map);
					result = "{\"success\": true, \"count\": " + resultMap.get("count") + ", \"result\" : " + Util.geStrJsonByString((List<Map<String, String>>)resultMap.get("list"))+"}";
				}
			}
			
		} catch (Exception e) {
			result = "{\"success\": false, \"message\" : " + e.getLocalizedMessage() +"}";
		}
		
		return result;
	}
	
	@RequestMapping(value="/insertLabData.do")
	public @ResponseBody Map<String, Object> insertLabData(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			edck03Service.insertLabData(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	

}
