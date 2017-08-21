package pantheon.com.g01.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import pantheon.com.g01.service.COMG01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;

/**
 * 공지사항 처리하는 컨트롤러 클래스
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
@Controller
public class COMG01Controller {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(COMG01Controller.class);
	
	@Resource(name="COMG01Service")
	private COMG01Service comg01Service;
	
	@Resource(name="COMZ02Service")
	private COMZ02Service comz02Service;
	
	
	/**
	 * 공지사항 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/g01/COMG0101.do")
	public String comg0101(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/g01/COMG0101";
	}
	
	/**
	 * 공지사항 작성 화면 출력
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/com/g01/COMG0102.do")
	public String comg0102(HttpServletRequest request, HttpServletResponse response, ModelMap model, @RequestParam Map<String, String> map) throws Exception {
		
		
		try {
			if(map != null && map.get("NOTICE_SN") != null) {
				Map<String, Object> resultMap = comg01Service.selectCmNoticeByPk(map);
				
				String strBngde = EgovDateUtil.convertDate(String.valueOf(resultMap.get("NOTICE_BGNDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", "");
				String strEndde = EgovDateUtil.convertDate(String.valueOf(resultMap.get("NOTICE_ENDDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", "");
				
				resultMap.put("NOTICE_BGNDE", strBngde);
				resultMap.put("NOTICE_ENDDE", strEndde);
				model.addAttribute("CM_NOTICE", resultMap);
			}
		} catch (Exception e) {
			Util.recordThrow(this, e);
		}
		
		return "/pantheon/com/g01/COMG0102";
	}
	
	/**
	 * 공지사항 리스트 팝업
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/anonymous/COMZ0401.do")
	public String popupComz0401(HttpServletRequest request, HttpServletResponse response) {
		return "/pantheon/com/z04/COMZ0401";
	}
	
	/**
	 * 공지사항 상세 팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/com/anonymous/COMZ0402.do")
	public String popupComz0402(HttpServletRequest request, HttpServletResponse response, ModelMap model, @RequestParam Map<String, String> map) throws Exception {
		
		try {
			if(map != null && map.get("NOTICE_SN") != null) {
				Map<String, Object> resultMap = comg01Service.selectCmNoticeByPk(map);
				
				String strBngde = EgovDateUtil.convertDate(String.valueOf(resultMap.get("NOTICE_BGNDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", "");
				String strEndde = EgovDateUtil.convertDate(String.valueOf(resultMap.get("NOTICE_ENDDE")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", "");
				
				resultMap.put("NOTICE_BGNDE", strBngde);
				resultMap.put("NOTICE_ENDDE", strEndde);
				model.addAttribute("CM_NOTICE", resultMap);
				
				@SuppressWarnings("unchecked")
				List<Map<String, Object>> resultList = comz02Service.selectDmFileDetailListByPk((Map<String, String>)(Object)resultMap);
				model.addAttribute("LIST_FILE_DETAIL", resultList);
			}
		} catch (Exception e) {
			Util.recordThrow(this, e);
		}
		
		return "/pantheon/com/z04/COMZ0402";
	}
	
	/**
	 * 공지사항 리스트 조회
	 * @param request
	 * @param response
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/selectCmNoticeListByPk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String , Object> selectCmNoticeListByPk(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		int count = 0;
		try {
			count = comg01Service.selectCmNoticeListCountByPk(map);
			list = comg01Service.selectCmNoticeListByPk(map);
			
			result.put("success", true);
			result.put("result", list);
			result.put("count", count);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 공지사항 저장
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/g01/insertCmNotice.do", method=RequestMethod.POST)
	public String insertCmClCode(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		try {
			comg01Service.insertCmNotice(map, request);
		} catch (Exception e) {
			Util.recordThrow(this, e);
		}
		
		return "forward:/com/g01/COMG0101.do";
	}
	
	/**
	 * 공지사항 수정
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/g01/updateCmNotice.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCmNotice(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			comg01Service.updateCmNotice(map, request);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}
	
	/**
	 * 공지사항 삭제
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/com/g01/updateCmNoticeForDelete.do", method=RequestMethod.POST)
	public String updateCmNoticeForDelete(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		
		try {
			comg01Service.updateCmNoticeForDelete(map);
		} catch (Exception e) {
			Util.recordThrow(this, e);
		}
		
		return "forward:/com/g01/COMG0101.do";
	}
	
	/**
	 * 공지사항 에디터 이미지 업로드
	 * @param request
	 * @param response
	 * @param editor
	 * @return
	 */
	@RequestMapping("/com/anonymous/file_uploader.do")
	public String file_uploader(HttpServletRequest request,HttpServletResponse response, Editor editor) throws Exception{
		String return1 = request.getParameter("callback");
		String return2 = "?callback_func=" + request.getParameter("callback_func");
		String return3 = "";
		String name = "";
		try {
			if (editor.getFiledata() != null
					&& editor.getFiledata().getOriginalFilename() != null
					&& !editor.getFiledata().getOriginalFilename().equals("")) {
				// 기존 상단 코드를 막고 하단코드를 이용
				name = editor.getFiledata().getOriginalFilename().substring(editor.getFiledata().getOriginalFilename().lastIndexOf(File.separator) + 1);
				String filename_ext = name.substring(name.lastIndexOf(".") + 1);
				filename_ext = filename_ext.toLowerCase();
				String[] allow_file = { "jpg", "png", "bmp", "gif" };
				int cnt = 0;
				for (int i = 0; i < allow_file.length; i++) {
					if (filename_ext.equals(allow_file[i])) {
						cnt++;
					}
				}
				if (cnt == 0) {
					return3 = "&errstr=" + name;
				} else {
					// 파일 기본경로
					String dftFilePath = request.getSession()
							.getServletContext().getRealPath("/");
					// 파일 기본경로 _ 상세경로
					String filePath = dftFilePath + "resource" + File.separator + "editor" + File.separator + "upload" + File.separator;
					File file = new File(filePath);
					if (!file.exists()) {
						file.mkdirs();
					}
					String realFileNm = "";
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
					String today = formatter.format(new java.util.Date());
					realFileNm = today + UUID.randomUUID().toString()+ name.substring(name.lastIndexOf("."));
					String rlFileNm = filePath + realFileNm;
					// /////////////// 서버에 파일쓰기 /////////////////
					editor.getFiledata().transferTo(new File(rlFileNm));
					// /////////////// 서버에 파일쓰기 /////////////////
					return3 += "&bNewLine=true";
					return3 += "&sFileName=" + name;
					return3 += "&sFileURL=/resource/editor/upload/"
							+ realFileNm;
				}
			} else {
				return3 += "&errstr=error";
			}
		} catch (Exception e) {
			LOGGER.error(e.getLocalizedMessage());
			throw e;
		}
		
		return "redirect:" + return1 + return2 + return3;
	}

}