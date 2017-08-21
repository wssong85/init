package pantheon.sdb.f05.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.sdb.f05.service.SDBF05Service;

/**
 * 교육이수리스트 등록 관리 컨트롤러 클래스
 * @author 이원민
 * @since 2016.03.22
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.22  이원민          최초 생성
 *  
 */
@Controller
public class SDBF05Controller {
	@Resource(name="SDBF05Service")
	private SDBF05Service sdbf05Service;
	
	@Resource(name="COMZ02Service")
	private COMZ02Service comz02Service;
	
	/**
	 * 교육이수리스트 등록 페이지 오픈
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/sdb/f05/SDBF0501.do")
	public String SDBF0501(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		return "/pantheon/sdb/f05/SDBF0501";	 
	}
	
	/**
	 * 교육이수리스트 등록
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f05/insertEducationInfo.do")
	public Map<String, String> insertEducationInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		
		try {
			if("".equals(req.getParameter("FILE_MASTR_SN"))){
				sdbf05Service.insertEducationInfo(req);
			}else{
				sdbf05Service.updateEducationInfo(req);
			}
			result.put("result", "true");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 등록된 교육이수리스트 조회 
	 * @param request
	 * @param response
	 * @return Map<String, Object>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f05/selectEducationInfo.do")
	public Map<String, Object> selectEducationInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("SE_CODE", "02");
		map.put("SN", req.getParameter("SN"));
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		
		try {
			List<Map<String, String>> list = sdbf05Service.selectEducationInfo(map);
			for(Map<String, String> deli : list){
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
	 * 등록된 첨부파일 개별 삭제
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f05/deleteFileInfo.do")
	public Map<String, String> deleteFileInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		map.put("DETAIL_SN", req.getParameter("DETAIL_SN"));
		try {
			sdbf05Service.deleteFileInfo(map);
			result.put("result", "true");
			result.put("message", "삭제하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
	
	/**
	 * 등록된 교육이수 정보 삭제
	 * @param request
	 * @param response
	 * @return Map<String, String>
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/sdb/f05/deleteEducationInfo.do")
	public Map<String, String> deleteEducationInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("SN", req.getParameter("SN"));
		try {
			sdbf05Service.deleteEducationInfo(map);
			result.put("result", "true");
			result.put("message", "삭제하였습니다.");
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}
}
