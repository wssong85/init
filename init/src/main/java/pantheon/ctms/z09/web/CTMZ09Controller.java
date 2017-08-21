package pantheon.ctms.z09.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z03.service.CTMZ03Service;


@Controller
public class CTMZ09Controller {
	
	@Resource(name="CTMZ03Service")
	private CTMZ03Service ctmz03Service;

	@Resource(name="PantheonCommonService")
	private PantheonCommonService CommonService;
	
	/** EmailService */
	@Resource(name = "PantheonMailService")
	private PantheonMailService PantheonMailService;
	
	//EMAIL
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	/**
	 * 개시미팅 보고서 목록 CTMZ0302
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z09/CTMZ0903.do")
	public String CTMZ0304(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z09/CTMZ0903";
	}

	/**
	 * 개시미팅 준비기록 CTMZ0901
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z09/CTMZ0901.do")
	public String CTMZ0901(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		Map<String, Object> crudMap  = ctmz03Service.selectReportCrudInfo(map);
		model.addAttribute("CRUD"     , crudMap.get("CRUD"     ));
		model.addAttribute("REPORT_SN", crudMap.get("REPORT_SN"));
		model.addAttribute("result"   , map);
		return "/pantheon/ctms/z09/CTMZ0901";
	}
	
	/**
	 * 개시미팅 준비기록 CTMZ0902
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z09/CTMZ0902.do")
	public String CTMZ0902(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		Map<String, Object> crudMap  = ctmz03Service.selectReportCrudInfo(map);
		model.addAttribute("CRUD"     , crudMap.get("CRUD"     ));
		model.addAttribute("REPORT_SN", crudMap.get("REPORT_SN"));
		model.addAttribute("result"   , map);
		return "/pantheon/ctms/z09/CTMZ0902";
	}

}
