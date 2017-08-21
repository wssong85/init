package pantheon.edc.a01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.edc.a01.service.EDCA01Service;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class EDCA01Controller {
	
	@Resource(name = "EDCA01Service")
	EDCA01Service edca01Service;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/edc/system/EDCA0101.do")
	public String systemEDCA0101(ModelMap model, HttpServletRequest request) throws Exception {
		
		String strModuleCode = request.getParameter("MODULE_CODE");
		String strTaskNo = request.getParameter("TASK_NO");
		String strTaskSn = request.getParameter("TASK_SN");
		String strRoleId = request.getParameter("ROLE_ID");
		String strTaskTyCode = request.getParameter("TASK_TY_CODE");
		String strTaskNoByDirectPath = "";
//		Map<String, String> loginMap = null;
		
		//directPath로 들어왔다면
		if(Util.getHttpSession().getAttribute("directPath") != null) {
			Map<String, String> mapDirectPath = (Map<String, String>) Util.getHttpSession().getAttribute("directPath"); 
			strModuleCode = mapDirectPath.get("MODULE_CODE");
			strTaskNoByDirectPath = mapDirectPath.get("TASK_NO");
			
			request.getSession().setAttribute("directPath", null);
		}
		
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;
		String strHomeUrl = null;
		
		if(strModuleCode == null) {
			return "redirect:/com/i01/intro.do";
		}
		
		map = new HashMap<String, Object>();
		
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		map.put("MODULE_CODE", strModuleCode);
		map.put("TASK_NO", strTaskNoByDirectPath);
		
		try {
			
			list = edca01Service.selectTaskList(map);
			strHomeUrl = edca01Service.selectCmProgrmForHomeMenu(map);
			
			//과제가 조회가 안됬을 경우
//			if(list.size() == 0) {
//				return "redirect:/com/i01/intro.do";
//			}
			//과제가 1개밖에 없을 경우
			if(list.size() == 1) {
				
				for(Map<String, Object> iMap : list) {
					
					//과제 세션 추가
					EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_NO", EgovStringUtil.isNullToString(iMap.get("TASK_NO"))));
					EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_SN", EgovStringUtil.isNullToString(iMap.get("TASK_SN"))));
					EgovStringUtil.isNullToString(Util.getUserMap().put("ROLE_ID", EgovStringUtil.isNullToString(iMap.get("ROLE_ID"))));
					EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_TY_CODE", EgovStringUtil.isNullToString(iMap.get("TASK_TY_CODE"))));
				}
				
				return "redirect:" + strHomeUrl;
				
			}
			
			//과제 번호까지 줬을 경우
			if(strTaskNo != null && strTaskSn != null && strRoleId != null) {
				
				//과제 세션 추가
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_NO", strTaskNo));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_SN", strTaskSn));
				EgovStringUtil.isNullToString(Util.getUserMap().put("ROLE_ID", strRoleId));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_TY_CODE", strTaskTyCode));

//				Util.getHttpSession().setAttribute("loginMap", loginMap);
				
				return "redirect:" + strHomeUrl;
			}
			
		} catch (Exception e) {
			
			return "redirect:/com/i01/intro.do";
			
		}
		
		model.addAttribute("MODULE_CODE", strModuleCode);
		return "pantheon/edc/a01/EDCA0101";
	}
	
	@RequestMapping(value="/edc/a01/selectTaskList.do")
	public @ResponseBody Map<String , Object> selectTaskList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		param.put("USER_ID", Util.getUserMap().get("USER_ID"));
		
		try {
			list = edca01Service.selectTaskList(param);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	@RequestMapping(value="/edc/a01/selectCtmsDmcTaskRoleForDupCheck.do")
	public @ResponseBody Map<String , Object> selectCtmsDmcTaskRoleForDupCheck(HttpServletRequest request, @RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		int count = 0;
		try {
			count = edca01Service.selectCtmsDmcTaskRoleForDupCheck(map);
			
			result.put("success", true);
			result.put("count", count);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
}