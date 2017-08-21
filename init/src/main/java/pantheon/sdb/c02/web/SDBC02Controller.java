package pantheon.sdb.c02.web;

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
import pantheon.sdb.c02.service.SDBC02Service;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Controller
public class SDBC02Controller {
	@Resource(name="SDBC02Service")
	private SDBC02Service sdbc02Service;
	
	@Resource(name = "COMD01Service")
	private COMD01Service comd01Service;
	
	@Resource(name = "SDB_CHANGE_REASON_SEQ")
	private EgovIdGnrService sdbChangereasonseq;
	
	@RequestMapping(value="/sdb/c02/SDBC0201.do")
	public String sdbc0201(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> map2 = new HashMap<String, String>();
		Map<String, String> map32 = new HashMap<String, String>();		
		Map<String, String> map44 = new HashMap<String, String>();
		Map<String, String> map34 = new HashMap<String, String>();
		Map<String, String> map35 = new HashMap<String, String>();
		Map<String, String> map07 = new HashMap<String, String>();
		Map<String, String> map08 = new HashMap<String, String>();
		Map<String, String> map09 = new HashMap<String, String>();
		Map<String, String> map36 = new HashMap<String, String>();
		Map<String, String> map10 = new HashMap<String, String>();
		Map<String, String> map11 = new HashMap<String, String>();
		Map<String, String> map6 = new HashMap<String, String>();
		Map<String, String> map76 = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType32 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType44 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType34 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType35 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType07 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType08 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType09 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType36 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType10 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType11 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType6 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType76 = new ArrayList<Map<String, Object>>();
		
		map.put("CMMN_CLCODE", "SDB033");
		map.put("task_code", "1");
		map.put("type", "type");
		
		map2.put("CMMN_CLCODE", "SDB070");
		map2.put("task_code", "1");
		map2.put("type", "type");
		
		map32.put("CMMN_CLCODE", "SDB032");
		map32.put("task_code", "1");
		map32.put("type", "type");
		
		map44.put("CMMN_CLCODE", "SDB044");
		map44.put("task_code", "1");
		map44.put("type", "type");
		
		map34.put("CMMN_CLCODE", "SDB034");
		map34.put("task_code", "1");
		map34.put("type", "type");
		
		map35.put("CMMN_CLCODE", "SDB035");
		map35.put("task_code", "1");
		map35.put("type", "type");
		
		map07.put("CMMN_CLCODE", "SDB007");
		map07.put("task_code", "1");
		map07.put("type", "type");
		
		map08.put("CMMN_CLCODE", "SDB008");
		map08.put("task_code", "1");
		map08.put("type", "type");
		
		map09.put("CMMN_CLCODE", "SDB009");
		map09.put("task_code", "1");
		map09.put("type", "type");
		
		map36.put("CMMN_CLCODE", "SDB036");
		map36.put("task_code", "1");
		map36.put("type", "type");
		
		map10.put("CMMN_CLCODE", "SDB010");
		map10.put("task_code", "1");
		map10.put("type", "type");
		
		map11.put("CMMN_CLCODE", "SDB011");
		map11.put("task_code", "1");
		map11.put("type", "type");
		
		map6.put("CMMN_CLCODE", "SDB006");
		map6.put("task_code", "1");
		map6.put("type", "type");
		
		map76.put("CMMN_CLCODE", "SDB076");
		map76.put("task_code", "1");
		map76.put("type", "type");
		
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			printType2 = comd01Service.selectCmCmmnCodeListByPk(map2);			
			printType32 = comd01Service.selectCmCmmnCodeListByPk(map32);
			printType44 = comd01Service.selectCmCmmnCodeListByPk(map44);
			printType34 = comd01Service.selectCmCmmnCodeListByPk(map34);
			printType35 = comd01Service.selectCmCmmnCodeListByPk(map35);
			printType07 = comd01Service.selectCmCmmnCodeListByPk(map07);
			printType08 = comd01Service.selectCmCmmnCodeListByPk(map08);
			printType09 = comd01Service.selectCmCmmnCodeListByPk(map09);
			printType36 = comd01Service.selectCmCmmnCodeListByPk(map36);
			printType10 = comd01Service.selectCmCmmnCodeListByPk(map10);
			printType11 = comd01Service.selectCmCmmnCodeListByPk(map11);
			printType6 = comd01Service.selectCmCmmnCodeListByPk(map6);
			printType76 = comd01Service.selectCmCmmnCodeListByPk(map76);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		request.setAttribute("printType2", printType2);
		request.setAttribute("printType32", printType32);
		request.setAttribute("printType44", printType44);
		request.setAttribute("printType34", printType34);
		request.setAttribute("printType35", printType35);
		request.setAttribute("printType07", printType07);
		request.setAttribute("printType08", printType08);
		request.setAttribute("printType09", printType09);
		request.setAttribute("printType36", printType36);
		request.setAttribute("printType10", printType10);
		request.setAttribute("printType11", printType11);
		request.setAttribute("printType6", printType6);
		request.setAttribute("printType76", printType76);
		
		return "/pantheon/sdb/c02/SDBC0201";
	}	
	
	@RequestMapping(value="/sdb/c02/SDBC0202.do")
	public String sdbc0202(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB012");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		
		return "/pantheon/sdb/c02/SDBC0202";
	}

	@RequestMapping(value="/sdb/c02/SDBC0203.do")
	public String sdbc0203(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB033");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		
		return "/pantheon/sdb/c02/SDBC0203";
	}
	
	@RequestMapping(value="/sdb/c02/SDBC0204.do")
	public String sdbc0204(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map44 = new HashMap<String, String>();
		Map<String, String> map12 = new HashMap<String, String>();
		Map<String, String> map65 = new HashMap<String, String>();
		Map<String, String> map30 = new HashMap<String, String>();
		Map<String, String> map23 = new HashMap<String, String>();
		Map<String, String> map24 = new HashMap<String, String>();
		Map<String, String> map25 = new HashMap<String, String>();
		Map<String, String> map26 = new HashMap<String, String>();
		Map<String, String> map21 = new HashMap<String, String>();
		List<Map<String, Object>> printType44 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType12 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType65 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType30 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType23 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType24 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType25 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType26 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType21 = new ArrayList<Map<String, Object>>();
		
		map44.put("CMMN_CLCODE", "SDB044");
		map44.put("task_code", "1");
		map44.put("type", "type");
		map12.put("CMMN_CLCODE", "SDB012");
		map12.put("task_code", "1");
		map12.put("type", "type");
		map65.put("CMMN_CLCODE", "SDB030");
		map65.put("task_code", "1");
		map65.put("type", "type");
		map30.put("CMMN_CLCODE", "SDB030");
		map30.put("task_code", "1");
		map30.put("type", "type");
		map23.put("CMMN_CLCODE", "SDB023");
		map23.put("task_code", "1");
		map23.put("type", "type");
		map24.put("CMMN_CLCODE", "SDB024");
		map24.put("task_code", "1");
		map24.put("type", "type");
		map25.put("CMMN_CLCODE", "SDB025");
		map25.put("task_code", "1");
		map25.put("type", "type");
		map26.put("CMMN_CLCODE", "SDB026");
		map26.put("task_code", "1");
		map26.put("type", "type");
		map21.put("CMMN_CLCODE", "SDB021");
		map21.put("task_code", "1");
		map21.put("type", "type");
		
		try {
			printType44 = comd01Service.selectCmCmmnCodeListByPk(map44);
			printType12 = comd01Service.selectCmCmmnCodeListByPk(map12);
			printType65 = comd01Service.selectCmCmmnCodeListByPk(map65);
			printType30 = comd01Service.selectCmCmmnCodeListByPk(map30);
			printType23 = comd01Service.selectCmCmmnCodeListByPk(map23);
			printType24 = comd01Service.selectCmCmmnCodeListByPk(map24);
			printType25 = comd01Service.selectCmCmmnCodeListByPk(map25);
			printType26 = comd01Service.selectCmCmmnCodeListByPk(map26);
			printType21 = comd01Service.selectCmCmmnCodeListByPk(map21);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType44", printType44);
		request.setAttribute("printType12", printType12);
		request.setAttribute("printType65", printType65);
		request.setAttribute("printType30", printType30);
		request.setAttribute("printType23", printType23);
		request.setAttribute("printType24", printType24);
		request.setAttribute("printType25", printType25);
		request.setAttribute("printType26", printType26);
		request.setAttribute("printType21", printType21);
		
		return "/pantheon/sdb/c02/SDBC0204";
	}
	
	@RequestMapping(value="/sdb/c02/SDBC0205.do")
	public String sdbc0205(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);

		return "/pantheon/sdb/c02/SDBC0205";
	}
	
	@RequestMapping(value="/sdb/c02/SDBC0206.do")
	public String sdbc0206(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map73 = new HashMap<String, String>();
		Map<String, String> map12 = new HashMap<String, String>();
		Map<String, String> map13 = new HashMap<String, String>();
		Map<String, String> map65 = new HashMap<String, String>();
		Map<String, String> map15 = new HashMap<String, String>();
		Map<String, String> map16 = new HashMap<String, String>();
		Map<String, String> map76 = new HashMap<String, String>();
		
		List<Map<String, Object>> printType73 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType12 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType13 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType65 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType15 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType16 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> printType76 = new ArrayList<Map<String, Object>>();
		
		map73.put("CMMN_CLCODE", "SDB073");
		map73.put("task_code", "1");
		map73.put("type", "type");
		map12.put("CMMN_CLCODE", "SDB012");
		map12.put("task_code", "1");
		map12.put("type", "type");
		map13.put("CMMN_CLCODE", "SDB013");
		map13.put("task_code", "1");
		map13.put("type", "type");
		map65.put("CMMN_CLCODE", "SDB065");
		map65.put("task_code", "1");
		map65.put("type", "type");
		map15.put("CMMN_CLCODE", "SDB015");
		map15.put("task_code", "1");
		map15.put("type", "type");
		map16.put("CMMN_CLCODE", "SDB016");
		map16.put("task_code", "1");
		map16.put("type", "type");
		map76.put("CMMN_CLCODE", "SDB076");
		map76.put("task_code", "1");
		map76.put("type", "type");
		
		try {
			printType73 = comd01Service.selectCmCmmnCodeListByPk(map73);
			printType12 = comd01Service.selectCmCmmnCodeListByPk(map12);
			printType13 = comd01Service.selectCmCmmnCodeListByPk(map13);
			printType65 = comd01Service.selectCmCmmnCodeListByPk(map65);
			printType15 = comd01Service.selectCmCmmnCodeListByPk(map15);
			printType16 = comd01Service.selectCmCmmnCodeListByPk(map16);
			printType76 = comd01Service.selectCmCmmnCodeListByPk(map76);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType73", printType73);
		request.setAttribute("printType12", printType12);
		request.setAttribute("printType13", printType13);
		request.setAttribute("printType65", printType65);
		request.setAttribute("printType15", printType15);
		request.setAttribute("printType16", printType16);
		request.setAttribute("printType76", printType76);
		
		return "/pantheon/sdb/c02/SDBC0206";
	}
	
	@RequestMapping(value="/sdb/c02/SDBC0207.do")
	public String sdbc0207(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB073");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		
		return "/pantheon/sdb/c02/SDBC0207";
	}
	
	@RequestMapping(value="/sdb/c02/SDBC0208.do")
	public String sdbc0208(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txthrmflns_case_code = request.getParameter("HRMFLNS_CASE_CODE");
		String txtprduct_code = request.getParameter("PRDUCT_CODE");		
		String txtfollow_no = request.getParameter("FOLLOW_NO");
		String txtsource_type = request.getParameter("SOURCE_TYPE");
		String txtsource = request.getParameter("SOURCE");
		String txtsitesubject = request.getParameter("SITESUBJECT");
		String txtmafu_no = request.getParameter("MAFU_NO");
		String txtcase_dc_sn = request.getParameter("CASE_DC_SN");
		
		request.setAttribute("HRMFLNS_CASE_CODE", txthrmflns_case_code);
		request.setAttribute("PRDUCT_CODE", txtprduct_code);
		request.setAttribute("FOLLOW_NO", txtfollow_no);
		request.setAttribute("SOURCE_TYPE", txtsource_type);
		request.setAttribute("SOURCE", txtsource);
		request.setAttribute("SITESUBJECT", txtsitesubject);
		request.setAttribute("MAFU_NO", txtmafu_no);
		request.setAttribute("CASE_DC_SN", txtcase_dc_sn);
		
		
		
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "SDB033");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		
		return "/pantheon/sdb/c02/SDBC0208";
	}	
	
	@RequestMapping(value="/sdb/c02/popupSDBC0210.do")
	public String popupSdbc0210(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txttrget_code = request.getParameter("TRGET_CODE");
		String txttrgetnm = request.getParameter("TRGETNM");
		String txttrget_mode = request.getParameter("TRGET_MODE");
		
		
		request.setAttribute("TRGET_CODE", txttrget_code);
		request.setAttribute("TRGETNM", txttrgetnm);
		request.setAttribute("TRGET_MODE", txttrget_mode);
		
		return "/pantheon/sdb/c02/SDBC0210";
	}	
	
	
	@RequestMapping(value="/sdb/c02/popupSDBC0217.do")
	public String popupSdbc0217(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		List<Map<String, Object>> printType = new ArrayList<Map<String, Object>>();
		map.put("CMMN_CLCODE", "EDC001");
		map.put("task_code", "1");
		map.put("type", "type");
		try {
			printType = comd01Service.selectCmCmmnCodeListByPk(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("printType", printType);
		
		
		
		String txttrget_code = request.getParameter("TRGET_CODE");
		String txttrgetnm = request.getParameter("TRGETNM");
		String txttrget_mode = request.getParameter("TRGET_MODE");
		
		request.setAttribute("TRGET_CODE", txttrget_code);
		request.setAttribute("TRGETNM", txttrgetnm);
		request.setAttribute("TRGET_MODE", txttrget_mode);
		
		return "/pantheon/sdb/c02/SDBC0217";
	}	
	
	@RequestMapping(value="/sdb/c02/popupSDBC0218.do")
	public String popupSdbc0218(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String txtid_korean = request.getParameter("ID_KOREAN");
		String txtid_eng = request.getParameter("ID_ENG");
		String txtkorean = request.getParameter("KOREAN");
		String txteng = request.getParameter("ENG");
		
		request.setAttribute("ID_KOREAN", txtid_korean);
		request.setAttribute("ID_ENG", txtid_eng);
		request.setAttribute("KOREAN", txtkorean);
		request.setAttribute("ENG", txteng);		

		return "/pantheon/sdb/c02/SDBC0218";
	}
	
	@RequestMapping(value="/sdb/c02/popupSDBC0219.do")
	public String popupSdbc0219(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		return "/pantheon/sdb/c02/SDBC0219";
	}
	
	/**
	 * Reason 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertReason.do")
	public Map<String, Object> insertReason(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		map.put("SN", sdbChangereasonseq.getNextStringId());
		
		System.out.println("============== Study insert Controller");
		System.out.println(map);
		
		try{
			sdbc02Service.insertReason(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Reason 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertNarrativeInfo.do")
	public Map<String, Object> insertNarrativeInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("============== Study insert Controller");
		
		try{
			sdbc02Service.insertNarrativeInfo(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
	/**
	 * Narrative 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectNarrativeInfo.do")
	public  Map<String, Object> selectStudyInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectNarrativeInfo(param);
			//날짜형식변경
//			map.put("MFDS_CONFM_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("MFDS_CONFM_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
//			map.put("FRT_PATNT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(map.get("FRT_PATNT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
//			map.put("LAST_PATNT_OCCRRNCDE", EgovDateUtil.convertDate(String.valueOf(map.get("LAST_PATNT_OCCRRNCDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
//			map.put("RYMSLMDONG_CTRL_DATA_TRNSMISDE", EgovDateUtil.convertDate(String.valueOf(map.get("RYMSLMDONG_CTRL_DATA_TRNSMISDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
//			map.put("SAFEHELTH_DTA_LOCK_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("SAFEHELTH_DTA_LOCK_DTE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Source 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */

//	@RequestMapping(value="/sdb/c01/selectTrialList.do")
//	public @ResponseBody Map<String, Object> selectTrialList(HttpServletRequest request, HttpServletResponse response, 
//			@RequestParam Map<String, String> map) throws Exception {
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectSource.do")
	public  Map<String, Object> selectSource(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		//Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = sdbc02Service.slSource(param);
			
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Follow UP 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectSiteSubject.do")
	public  Map<String, Object> selectSiteSubject(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		//Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = sdbc02Service.selectSiteSubject(param);
			
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Follow UP 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectFollow.do")
	public  Map<String, Object> selectFollow(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		//Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try{
			list = sdbc02Service.selectFollow(param);
			
			result.put("success", true);
			result.put("result", list);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
		
	/**
	 * tDemographics 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertDemographics.do")
	public Map<String, Object> insertDemographics(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("============== Study insert Controller");
		
		try{
			sdbc02Service.insertDemographics(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * Demographics 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDemographics.do")
	public  Map<String, Object> selectDemographics(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectDemographics(param);
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * Demographics 유사사례상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDemographics_Case.do")
	public  Map<String, Object> selectDemographics_Case(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectDemographics_Case(param);
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	

	/**
	 * LAB LIST  조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/selectLabList.do")
	public @ResponseBody Map<String, Object> selectLabList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
			
		try {
			list = sdbc02Service.selectLabList(map);
			
			result.put("success", true);			
			result.put("result", list);
						
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		return result;
	}
	
	
	
	/**
	 * Lab 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertLabInfo.do")
	public Map<String, Object> insertLabInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("============== Study insert Controller");
		
		try{
			sdbc02Service.insertLabInfo(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	
	/**
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectLabListInfo.do")
	public Map<String, Object> selectLabListInfo (HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			map = sdbc02Service.selectLabListInfo(param);
			
			result.put("success", true);
			result.put("result", map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
			
		return result;
	}
	
	/**
	 * DemographicsLab 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDemographicsLab.do")
	public  Map<String, Object> selectDemographicsLab(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectDemographicsLab(param);			
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * DemographicsLab 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDemographicsMedi.do")
	public  Map<String, Object> selectDemographicsMedi(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectDemographicsMedi(param);			
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * Medical History LIST  조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/selectMedicalList.do")
	public @ResponseBody Map<String, Object> selectMedicalList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
			
		try {
			list = sdbc02Service.selectMedicalList(map);

			result.put("success", true);			
			result.put("result", list);
						
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		return result;
	}
	
	
	
	/**
	 * Medical History 상세조회
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectMedicalHistoryInfo.do")
	public Map<String, Object> selectMedicalHistoryInfo (HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			map = sdbc02Service.selectMedicalHistoryInfo(param);
			
			result.put("success", true);
			result.put("result", map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
			
		return result;
	}
	
	
	
	/**
	 * tDemographics 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertMedicalHistory.do")
	public Map<String, Object> insertMedicalHistory(HttpServletRequest req, HttpServletResponse resp, @RequestBody Map<String, String> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("============== Study insert Controller");
		
		try{
			sdbc02Service.insertMedicalHistory(map);			
			result.put("success", true);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * Drug History LIST  조회
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
		
	@RequestMapping(value="/sdb/c02/selectDrugHistoryList.do")
	public @ResponseBody Map<String, Object> selectDrugHistory(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
			
		try {
			list = sdbc02Service.selectDrugHistory(map);
			
			result.put("success", true);			
			result.put("result", list);
						
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping(value="/sdb/c02/selectCasualityList.do")
	public @ResponseBody Map<String, Object> selectCasualityList(HttpServletRequest	request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
		
		try {
			list = sdbc02Service.selectCasualityList(map);
			result.put("success", true);			
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
		
	}
	
	
	/**
	 * Medical History 상세조회
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDrugHistoryInfo.do")
	public Map<String, Object> selectDrugHistoryInfo (HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			map = sdbc02Service.selectDrugHistoryInfo(param);
			
			result.put("success", true);
			result.put("result", map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
			
		return result;
	}

	//insertDrugHistory
	
	/**
	 * Drug History 등록
	 * @param request
	 * @param response 
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/insertDrugHistory.do")
	public Map<String, Object> insertDrugHistory(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			sdbc02Service.insertDrugHistory(map);	
			result.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * 상위메뉴 입력
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/insertCasuality.do")
	public @ResponseBody Map<String, Object> insertCasuality(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			sdbc02Service.insertCasuality(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	/**
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/insertDrug.do")
	public @ResponseBody Map<String, Object> insertDrug(HttpServletRequest request, HttpServletResponse response,  @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			sdbc02Service.insertDrug(map);
			
			result.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;		
	}
	
	
	
	
	/**
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/selectDrugList.do")
	public @ResponseBody Map<String, Object> selectDrugList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = null;
			
		try {
			list = sdbc02Service.selectDrugList(map);
			
			result.put("success", true);			
			result.put("result", list);
						
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * @param request
	 * @param response
	 * @param param
	 * @return                                         
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/selectDrugInfo.do")
	public @ResponseBody Map<String, Object> selectDrugInfo (HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			map = sdbc02Service.selectDrugInfo(param);
			
			result.put("success", true);
			result.put("result", map);
			
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
			
		return result;
	} 
	
	
	@RequestMapping(value="/sdb/c02/selectAeList.do")
	public @ResponseBody Map<String, Object> selectAeList(HttpServletRequest request, HttpServletResponse response,@RequestParam Map<String, String> param) throws Exception{
		Map<String, Object> result =  new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			
			list = sdbc02Service.selectAeList(param);
			
			result.put("success", true);			
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		
		return result;		
	}
	
	/**
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/selectAeInfo.do")
	public @ResponseBody Map<String, Object> selectAeInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = sdbc02Service.selectAeInfo(param);
			
			result.put("success", true);
			result.put("result", map);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
		
	}
	
	/**
	 * DemographicsLab 상세조회
	 * @param request
	 * @param response
	 * @param map
	 * @return map 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/sdb/c02/selectDemoAeInfo.do")
	public  Map<String, Object> selectDemoAeInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			map = sdbc02Service.selectDemoAeInfo(param);
			
			if(map.get("FRT_RCEPT_DTE") != null){				
				map.put("FRT_RCEPT_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("FRT_RCEPT_DTE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("MFDS_REPORT_DTE") != null){
				map.put("MFDS_REPORT_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("MFDS_REPORT_DTE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("KIDS_REPORT_DTE") != null){
				map.put("KIDS_REPORT_DTE", EgovDateUtil.convertDate(String.valueOf(map.get("KIDS_REPORT_DTE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("IRB_REPORT_DATE") != null){
				map.put("IRB_REPORT_DATE", EgovDateUtil.convertDate(String.valueOf(map.get("IRB_REPORT_DATE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("DIFR_INSTT_REPORT_DATE") != null){
				map.put("DIFR_INSTT_REPORT_DATE", EgovDateUtil.convertDate(String.valueOf(map.get("DIFR_INSTT_REPORT_DATE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(map.get("MANUFACTURER_REPORT_DATE") != null){
				map.put("MANUFACTURER_REPORT_DATE", EgovDateUtil.convertDate(String.valueOf(map.get("MANUFACTURER_REPORT_DATE")),	"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			result.put("success", true);
			result.put("result", map);
		} catch(Exception e){
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping(value="/sdb/c02/insertAe.do")
	public @ResponseBody Map<String, Object> insertAe(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			sdbc02Service.insertAe(map);
			sdbc02Service.insertDemoAe(map);
			result.put("success", true);
			
		} catch (Exception e) {
			// TODO: handle exception
			
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@RequestMapping(value="/sdb/c02/insertDemoAe.do")
	public @ResponseBody Map<String, Object> insertDemoAe(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			sdbc02Service.insertDemoAe(map);
			
			result.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception\
			
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
			
		}
		
		
		return result;
		
	}
	
//	@RequestMapping(value="/sdb/c02/insertDrug.do")
//	public @ResponseBody Map<String, Object> insertDrug(HttpServletRequest request, HttpServletResponse response,  @RequestBody Map<String, String> map) throws Exception{
//		Map<String, Object> result = new HashMap<String, Object>();
//		
//		try {
//			sdbc02Service.insertDrug(map);
//			
//			result.put("success", true);
//		} catch (Exception e) {
//			// TODO: handle exception
//			result.put("success", false);
//			result.put("message", Util.getPantheonErrorMessage(e, this));
//		}
//		
//		return result;		
//	}
//	
	@RequestMapping(value="/sdb/c02/insertTransfer.do")
	public @ResponseBody Map<String, Object> insertTransfer(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result =  new HashMap<String, Object>();
		try {
			sdbc02Service.insertTransfer(map);
			
			result.put("success",true);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		
		return result;
	}
	
	
	/**
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/insertFollowUp.do")
	public @ResponseBody Map<String, Object> insertFollowUp(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object>  result = new HashMap<String, Object>();
		Map<String, String> map_follow = new HashMap<String, String>();
		try {
			map_follow = sdbc02Service.insertFollowUp(map);
			sdbc02Service.insertCasuality_T(map_follow);
			result.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	
	@RequestMapping(value="/sdb/c02/selectCaseListPop.do")
	public @ResponseBody Map<String, Object> selectCaseListPop(HttpServletRequest request, HttpServletResponse response,@RequestParam Map<String, String> param) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = sdbc02Service.selectCaseListPop(param);
			
			result.put("success", true);
			result.put("result", list);
		} catch (Exception e) {
			// TODO: handle exception
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}		
		
		return result;	
		
	}
	
	/**
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sdb/c02/insertCasuality_T.do")
	public @ResponseBody Map<String, Object> insertCasuality_T(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> map) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();		
		try {
			sdbc02Service.insertCasuality_T(map);
			
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());

		}
		
		return result;
	}
}





