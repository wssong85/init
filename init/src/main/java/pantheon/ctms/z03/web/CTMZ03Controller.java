package pantheon.ctms.z03.web;

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

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.z03.service.CTMZ03Service;


@Controller
public class CTMZ03Controller {
	
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
	 * 연구기관 방문 목록 CTMZ0302
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z03/CTMZ0304.do")
	public String CTMZ0304(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		model.addAttribute("result", map);
		return "/pantheon/ctms/z03/CTMZ0304";
	}

	/**
	 * 연구기관 방문 보고서 CTMZ0302
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z03/CTMZ0302.do")
	public String CTMZ0302(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		Map<String, Object> crudMap  = ctmz03Service.selectReportCrudInfo(map);
		model.addAttribute("CRUD"     , crudMap.get("CRUD"     ));
		model.addAttribute("REPORT_SN", crudMap.get("REPORT_SN"));
		model.addAttribute("result"   , map);
		return "/pantheon/ctms/z03/CTMZ0302";
	}

	/**
	 * 방문 후속조치 보고서 CTMZ0303
	 * @param request
	 * @param seponse
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ctms/z03/CTMZ0303.do")
	public String CTMZ0303(HttpServletRequest request, HttpServletResponse seponse, @RequestParam Map<String, String> map, ModelMap model) throws Exception {
		Map<String, Object> crudMap   = ctmz03Service.selectReportCrudInfo(map);
		map.put("REPORT_SE"  , "C01");
		map.put("REPORT_TYPE", "P"  );
		Map<String, Object> titleMap  = ctmz03Service.selectReportTitleInfo(map);
		System.out.println("CTMZ0303 map : "+map);
		System.out.println("CTMZ0303 titleMap : "+titleMap);
		model.addAttribute("CRUD"     , crudMap.get("CRUD"     ));
		model.addAttribute("REPORT_SN", crudMap.get("REPORT_SN"));
		model.addAttribute("result"   , map                     );
		model.addAttribute("title"    , titleMap                );
		return "/pantheon/ctms/z03/CTMZ0303";
	}

	/**
	 * 보고서 목록 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z03/selectSiteVisitList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectSiteVisitList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;
			
			Map<String, String> param = new HashMap<String, String>();			
			param.put("QUERY", "selectCmCmmCodeByCmmnClcode");
			param.put("CMMN_CLCODE", "CTMS039");
			
		try {
			list = ctmz03Service.selectSiteVisitList(map);
			
			for(Map<String, Object> deli : list){	
				deli.put("FRST_CREAT_DE", EgovDateUtil.convertDate((String) deli.get("FRST_CREAT_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				deli.put("OPRTN_DE", EgovDateUtil.convertDate((String) deli.get("OPRTN_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}

			result.put("param"  , CommonService.selectQueryDataList(param));
			result.put("success", true);
			result.put("list"   , list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}

	/**
	 * 연구기관 방문 보고서 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z03/selectVisitReportInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitReportInfo(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> info = null;
			List<Map<String, Object>> item = null;
			System.out.println("REPORT_SN : "+map.get("REPORT_SN"));
		try {
			info = ctmz03Service.selectReportMainInfo(map); //기본 정보 조회
			info.put("OPRTN_DATE" , EgovDateUtil.convertDate((String) info.get("OPRTN_DATE" ), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			info.put("EXPECT_DATE", EgovDateUtil.convertDate((String) info.get("EXPECT_DATE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));

			if("G02".equals(info.get("REPORT_SE"))){ //시험개시방문보고서 일 경우 : 스크리닝 개시 예정일, 모집기한
				info.put("COL_B_DE", EgovDateUtil.convertDate((String) info.get("COL_B_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				info.put("COL_C_DE", EgovDateUtil.convertDate((String) info.get("COL_C_DE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
			}
			
			item = ctmz03Service.selectReportItemList(map);
			for(Map<String, Object> deli : item){
				if(!EgovStringUtil.isEmpty((String)deli.get("DTE_DATE"))){ //일정 및 일자가 있는경우.
					deli.put("DTE_DATE", EgovDateUtil.convertDate((String) deli.get("DTE_DATE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",null));
				}
			}

			result.put("success", true);
			result.put("info", info);
			result.put("item", item);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}
	
	/**
	 * VISIT조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z03/selectVisitInfoGrid.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectVisitInfoGrid(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;	
		try {
			list = ctmz03Service.selectVisitInfoGrid(map);
			result.put("success", true);
			result.put("result", list);	
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}		
		return result;
	}

	/**
	 * 보고서 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z03/insertVisitReport.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertVisitReport(HttpServletRequest request, HttpServletResponse response, @RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String reportSn = null;
		try {
			reportSn = ctmz03Service.insertVisitReport(list);
			result.put("REPORT_SN", reportSn);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * 보고서 결제요청번호 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/z03/updateReportApprovalSn.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateReportApprovalSn(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("updateReportApprovalSn : "+map);
		try {
			ctmz03Service.updateReportApprovalSn(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

}
