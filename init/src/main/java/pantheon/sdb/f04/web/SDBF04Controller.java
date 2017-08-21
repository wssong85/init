package pantheon.sdb.f04.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.sdb.f04.service.SDBF04Service;

/**
 * SOP 등록 관리 컨트롤러 클래스
 * @author 이원민
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17   이원민                    최초 생성
 *  
 */
@Controller
public class SDBF04Controller {
	@Resource(name="SDBF04Service")
	private SDBF04Service sdbf04Service;
	
	@Resource(name="COMZ02Service")
	private COMZ02Service comz02Service;
	
	/**
	 * SOP 등록 페이지 오픈
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("/sdb/f04/SDBF0401.do")
	public String SDBF0401(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/f04/SDBF0401";	 
	}
	
	/**
	 * SOP 등록
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f04/insertSopInfo.do")
	public Map<String, String> insertSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		
		try {
			if("false".equals(req.getParameter("FILE_FLAG"))){
				Map<String, String> map = new HashMap<String, String>();
				map.put("SJ", req.getParameter("SJ"));
				map.put("CN", req.getParameter("CN"));
				map.put("EFECT_OCCRRNC_AT", req.getParameter("EFECT_OCCRRNC_AT"));
				map.put("EFECT_OCCRRNCDE", req.getParameter("EFECT_OCCRRNCDE"));
				map.put("SE_CODE", req.getParameter("SE_CODE"));
				map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
				map.put("SN", req.getParameter("SN"));
				map.put("DELFILE", req.getParameter("DELFILE"));
				map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				map.put("USE_AT", "Y");
				sdbf04Service.insertSopInfo(map);
			}else{
				Map<String, String> map = new HashMap<String, String>();
				map.put("SJ", req.getParameter("SJ")); 
				map.put("CN", req.getParameter("CN"));
				map.put("EFECT_OCCRRNC_AT", req.getParameter("EFECT_OCCRRNC_AT"));
				map.put("EFECT_OCCRRNCDE", req.getParameter("EFECT_OCCRRNCDE"));
				map.put("SE_CODE", req.getParameter("SE_CODE"));
				map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
				map.put("SN", req.getParameter("SN"));
				map.put("DELFILE", req.getParameter("DELFILE"));
				map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				map.put("USE_AT", "Y");
				sdbf04Service.updateSopInfo(map);
			}
			result.put("result", "true");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/sdb/f04/insertSopFile.do")
	public String insertSopFile(HttpServletRequest req, HttpServletResponse resp){
		String result = "";
		String fileSn = "";
		try {
			MultipartHttpServletRequest multiRequest = null;
			
			try {
				multiRequest = (MultipartHttpServletRequest) req;
				if("".equals(multiRequest.getParameter("hFileFn"))){
					fileSn = sdbf04Service.insertSopFile(req);
				}else{
					sdbf04Service.updateSopFile(req, multiRequest.getParameter("hFileFn"));
				}
			} catch (Exception e) {
				return null;
			}
			
			result = "{\"result\": true, \"filesn\" : \"" + fileSn + "\"}";
		} catch (Exception e) {
			result = "{\"result\": false, \"message\" : \"파일 저장중 에러가 발생하였습니다.\"}";
		}
		
		return result;
	}
	
	/**
	 * 등록된 SOP 검색
	 * @param request
	 * @param response
	 * @return Map<String, Object> 
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f04/selectSopInfo.do")
	public Map<String, Object> selectSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("SE_CODE", "01");
		map.put("SN", req.getParameter("SN"));
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		
		try {
			List<Map<String, String>> list = sdbf04Service.selectSopInfo(map);
			for(Map<String, String> deli : list){
				deli.put("EFECT_OCCRRNCDE", EgovDateUtil.convertDate(deli.get("EFECT_OCCRRNCDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
				deli.put("FRST_CREDE", EgovDateUtil.convertDate(deli.get("FRST_CREDE"), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", null));
			}
			
			if(req.getParameter("SN") != null && !"".equals(req.getParameter("SN"))){
				List<Map<String, Object>> fileList = comz02Service.selectDmFileDetailListByPk(map);
				result.put("fileList", fileList);
			}
			result.put("result", "true");
			result.put("list", list);
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 첨부된 파일 개별 삭제
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f04/deleteFileInfo.do")
	public Map<String, String> deleteFileInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		map.put("DETAIL_SN", req.getParameter("DETAIL_SN"));
		try {
			sdbf04Service.deleteFileInfo(map);
			result.put("result", "true");
			result.put("message", "삭제하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 등롥된 SOP 삭제
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f04/deleteSopInfo.do")
	public Map<String, String> deleteSopInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("SN", req.getParameter("SN"));
		try {
			sdbf04Service.deleteSopInfo(map);
			result.put("result", "true");
			result.put("message", "삭제하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
