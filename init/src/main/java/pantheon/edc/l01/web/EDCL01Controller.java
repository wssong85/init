package pantheon.edc.l01.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.edc.l01.service.EDCL01Service;
import egovframework.com.cmm.annotation.IncludedInfo;


/**
 * Data Import 처리하는 컨트롤러 클래스
 * @author 오동근
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17  오동근          최초 생성
 *  
 */
@Controller
@RequestMapping("edc/l01")
public class EDCL01Controller {
	
	@Resource(name = "EDCL01Service")
	EDCL01Service edcl01Service;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@IncludedInfo(name="pantheon Data Import 목록", order = 6580, gid = 110)
	@RequestMapping("/EDCL0101.do")
	public String EDCL0101(ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/l01/EDCL0101";
	}
	
	@IncludedInfo(name="pantheon Data Import 목록", order = 6590, gid = 110)
	@RequestMapping("/EDCL0102.do")
	public String EDCL0102(@RequestParam Map<String, Object> map, HttpServletRequest request, ModelMap model) throws Exception {
		// model.addAttribute("result", edcl01Service.selectCdisc(map));
		model.addAttribute("param",  map.get("imprtNmParam"));
		model.addAttribute("param",  map.get("cdiscSecode"));
		model.addAttribute("param",  map.get("cdiscSn"));
		return "/pantheon/edc/l01/EDCL0102";
	}
	
	/**
	 * Data Import 목록
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscList.do")
	public @ResponseBody Map<String , Object> SelectCdiscList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			 list = edcl01Service.selectCdiscList(param);
			result.put("count", edcl01Service.selectCdiscListCount(param));
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	/**
	 * Data Upload와 동시에 MST 파일을 읽어 유효성을 체크를 한 후 결과값을 리턴한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscFileMstChk.do")
	public @ResponseBody Map<String, Object> selectCdiscFileMstChk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)		throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		
		String moduleKnd = "";
		String cdiscSeCode = "";
		String imprtNm = "";
		moduleKnd = map.get("moduleKnd");
		cdiscSeCode = map.get("cdiscSeCode");
		imprtNm = map.get("imprtNm");
		if(moduleKnd == "")	moduleKnd = "COM";
		try {
			String mstrSn = comz02Service.insertDmFileMstr(request, moduleKnd);
			param.put("FILE_MASTR_SN", mstrSn);
			
			// 디테일 순번도 select 한다.
			List<Map<String, Object>> detailInfo = comz02Service.selectDmFileDetailListByPk(param);
			
			// 파일갯수 만큼 처리한다.
			for(Map<String, Object> data : detailInfo){
				param.put("DETAIL_SN", data.get("DETAIL_SN").toString());
				
			
				// 마스터와 디테일 순번으로 파일 정보를 가져온다.
				Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(param);
				String filePath = fileInfo.get("DWLD_PHYSIC_COURS") + fileInfo.get("UPLOAD_FILE_NM");
				File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
				int fSize = (int) uFile.length();
				
				String chk = "success";
				
				if (fSize > 0) {
					if(fileInfo.get("ORGINL_EXTSN_NM").equals("xml")){
						// xml 파싱 및 유효성 체크하는 서비스.
						edcl01Service.defineXmlValidationChk(filePath, (String)param.get("DETAIL_SN"), cdiscSeCode, imprtNm);
					}
					
					result.put("chk", chk);
					if(chk.equals("success")){
						result.put("failMessage", "success");
					}else{
						result.put("failMessage", "50Line Error");
					}
				}else{
					result.put("chk", "Fail");
					result.put("failMessage", "Upload Error");
				}
			
			}
			
		} catch (Exception e) {
			result.put("chk", "Fail");
			result.put("failMessage", "Upload Error");
		}
		
		return result;
	}
	
	/**
	 * Data Import View 목록 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/SelectCdiscViewList.do")
	public @ResponseBody Map<String , Object> SelectCdiscViewList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		
		try {
			list = edcl01Service.selectCdiscList(param);
			result.put("count", edcl01Service.selectCdiscListCount(param));
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
	
	/**
	 * Data Upload와 동시에 파일을 읽어 유효성을 체크를 한 후 결과값을 리턴한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscFileChk.do")
	public @ResponseBody Map<String, Object> selectCdiscFileChk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map)		throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<String, String>();
		
		String moduleKnd = "";
		String cfcdiscDomnSn = "";
		moduleKnd = map.get("moduleKnd");
		cfcdiscDomnSn = map.get("cfcdiscDomnSn");
		if(moduleKnd == "")	moduleKnd = "COM";
		try {
			String mstrSn = comz02Service.insertDmFileMstr(request, moduleKnd);
			param.put("FILE_MASTR_SN", mstrSn);
			
			// 디테일 순번도 select 한다.
			List<Map<String, Object>> detailInfo = comz02Service.selectDmFileDetailListByPk(param);
			
			// 파일갯수 만큼 처리한다.
			for(Map<String, Object> data : detailInfo){
				param.put("DETAIL_SN", data.get("DETAIL_SN").toString());
			
				// 마스터와 디테일 순번으로 파일 정보를 가져온다.
				Map<String, String> fileInfo = comz02Service.selectDmFileDetailByPk(param);
				String filePath = fileInfo.get("DWLD_PHYSIC_COURS") + fileInfo.get("UPLOAD_FILE_NM");
				File uFile = new File(fileInfo.get("DWLD_PHYSIC_COURS"), fileInfo.get("UPLOAD_FILE_NM"));
				int fSize = (int) uFile.length();
				
				String chk = "success";
				
				if (fSize > 0) {
					if(fileInfo.get("ORGINL_EXTSN_NM").equals("xml")){
						// xml 파싱 및 유효성 체크하는 서비스.
						edcl01Service.xmlValidationChk(filePath, cfcdiscDomnSn);
					}else{
						// 엑셀 파싱 및 유효성 체크하는 서비스.
						edcl01Service.excelValidationChk(filePath, cfcdiscDomnSn);
					}
					
					result.put("chk", chk);
					if(chk.equals("success")){
						result.put("failMessage", "success");
					}else{
						result.put("failMessage", "50Line Error");
					}
				}else{
					result.put("chk", "Fail");
					result.put("failMessage", "Upload Error");
				}
			
			}
			
		} catch (Exception e) {
			result.put("chk", "Fail");
			result.put("failMessage", "Upload Error");
		}
		
		return result;
	}
	
	/**
	 * data Import View 도메인 명 콤보박스 List
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscDomainList.do")
	public @ResponseBody Map<String , Object> selectCdiscDomainList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		String cfcdiscSn = "";
		try {
			cfcdiscSn = (String) param.get("cfcdiscSn");
			list = edcl01Service.selectCdiscDomainList(cfcdiscSn);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    return result;
	}
	
	/**
	 * data Import View화면에서 동적으로 헤더를 생성한다.
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscVariablList.do")
	public @ResponseBody List<Map<String , Object>> selectCdiscVariablList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		List<Map<String, Object>> list = null;
		String cfcdiscDomnSn = "";
		try {
			cfcdiscDomnSn = (String) param.get("cfcdiscDomnSn");
			list = edcl01Service.selectCdiscVriablList(cfcdiscDomnSn);
		} catch (Exception e) {
		}
	    
	    return list;
	}
	
	/**
	 * data Import View화면에서 동적으로 Value 값 List
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectCdiscVariablValueList.do")
	public @ResponseBody Map<String , Object> selectCdiscVariablValueList(HttpServletRequest request, @RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> defaultList = null;
		List<Map<String, Object>> list = null;
		ArrayList<String> sqlList = new ArrayList<String>();
		
		String cfcdiscDomnSn = "";
		int j=1;
		
		try {
			cfcdiscDomnSn = (String) param.get("cfcdiscDomnSn");
			defaultList = edcl01Service.selectCdiscVriablList(cfcdiscDomnSn);
			
			for(int i=0;i<defaultList.size();i++ ){
				
				if(i == 0){
					sqlList.add("NVL(MAX( DECODE( LBL_ORDR, '" + j + "', VRIABL_VALUE )),' ') \"" + j + "\"");
				}else{
					sqlList.add(",NVL(MAX( DECODE( LBL_ORDR, '" + j + "', VRIABL_VALUE )),' ') \"" + j + "\"");
				}
				j++;
			}
			if(defaultList.size() == 0){
				result.put("result", list);
				result.put("success", true);
			}else{
				param.put("sqlList", sqlList);
				list = edcl01Service.selectCdiscVariablValueList(param);
				result.put("result", list);
				result.put("success", true);
			}
			
			
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
	    
	    return result;
	}
	
}
