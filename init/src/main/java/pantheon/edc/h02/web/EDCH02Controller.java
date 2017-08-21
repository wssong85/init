package pantheon.edc.h02.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.edc.h02.service.EDCH02Service;


@Controller
@RequestMapping("/edc/h02")
public class EDCH02Controller {
	
	@Resource(name = "EDCH02Service")
	EDCH02Service EDCH02Service;
	
	@RequestMapping("/EDCH0201.do")
	public String EDCH0201(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		model.addAllAttributes(map);
		return "/pantheon/edc/h02/EDCH0201";
	}
	
	/**
	 * LAB 파일 목록 조회
	 * @param map
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectLabSubjectList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectLabSubjectList(@RequestParam Map<String, Object> map, 
			ModelMap model, HttpServletRequest request) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try{
			list = EDCH02Service.selectLabSubjectList(map);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));			
		}
		
		return result;
	}
}
