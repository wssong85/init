package pantheon.ctms.z14.web;

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
public class CTMZ14Controller {
	
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
	 * 내용 확인서 목록 CTMZ1402
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z14/CTMZ1402.do")
	public String CTMZ1402(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z14/CTMZ1402";
	}

	/**
	 * 내용확인 보고서 조회 CTMZ1401
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z14/CTMZ1401.do")
	public String CTMZ1401(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		Map<String, Object> crudMap  = ctmz03Service.selectReportCrudInfo(map);
		model.addAttribute("CRUD"     , crudMap.get("CRUD"     ));
		model.addAttribute("REPORT_SN", crudMap.get("REPORT_SN"));
		model.addAttribute("result"   , map);
		return "/pantheon/ctms/z14/CTMZ1401";
	}
	
}
