package pantheon.com.utl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.f05.dao.COMF05DAO;
import pantheon.com.i01.web.LoginVO;
import pantheon.com.utl.Util;

/**
 * 프로그램 입력(AOP) 클래스
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
@Service("PantheonProgrmLogAspect")
public class PantheonProgrmLogAspect extends HandlerInterceptorAdapter{
	
	//static 프로그램 리스트
	private static List<Map<String, Object>> progrmInitialUrl;
	
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;
	
	@Resource(name = "COMF05DAO")
	private COMF05DAO comf05DAO;
	
	@Resource(name = "CM_PROGRM_CONECT_SEQ")
	private EgovIdGnrService cmProgrmConectSeq;
	
	/**
	 * 프로그램리스트 가져오기
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getInstanceForProgrmInitialUrl() throws Exception{
		if(progrmInitialUrl == null) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("QUERY", "selectCmProgrmForPostConstruct");
			progrmInitialUrl = pantheonCommonService.selectQueryDataList(map);
		}
		return progrmInitialUrl;	
	}
	
	/**
	 * 프로그램리스트 세팅
	 * @return
	 * @throws Exception
	 */
	public void setInstanceForProgrmInitialUrl() throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("QUERY", "selectCmProgrmForPostConstruct");
		if(progrmInitialUrl == null) {
			progrmInitialUrl = pantheonCommonService.selectQueryDataList(map);
		}
		progrmInitialUrl = pantheonCommonService.selectQueryDataList(map);
	}
	
	/**
	 * 프로그램이력 로그 입력
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void insertProgrmLog() throws Exception{
		
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		HttpServletRequest hsr = Util.getHttpServletRequest();
		String test = hsr.getServletPath();
		
		Map<String, Object> mapForCurdSession = new HashMap<String, Object>();
		
		if(test.indexOf("anonymous") > 0) {
			return;
		}
		
		if(loginVO == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/com/i01/pantheonLogout.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		if(Util.getUserMap() == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/com/i01/pantheonLogout.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		map.put("CONECT_IP", hsr.getRemoteAddr());
		
		List<Map<String, Object>> progrmList = getInstanceForProgrmInitialUrl();
		
		for(Map<String, Object> iMap : progrmList) {
			if(test.equals(iMap.get("PROGRM_URL")) && 
					"Y".equals(iMap.get("TASK_AT")) &&
					"".equals(EgovStringUtil.isNullToString(Util.getUserMap().get("TASK_SN")))) {
				
				//과제 정보가 없을 때 과제 화면을 요청하면 초기화면으로 리턴시킴
				ModelAndView modelAndView = new ModelAndView("redirect:/edc/system/EDCA0101.do");
				throw new ModelAndViewDefiningException(modelAndView);
			}
			
			if(test.equals(iMap.get("PROGRM_URL")) && "N".equals(iMap.get("TASK_AT"))) {
				
				//과제 화면이 아닐 경우 과제 정보 삭제
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_SN", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_NO", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("ROLE_ID", null));
				EgovStringUtil.isNullToString(Util.getUserMap().put("TASK_TY_CODE", null));
			}
			
			if(test.equals(iMap.get("PROGRM_URL"))) {
				
				Util.getProgrmMap().put("PROGRM_NM", EgovStringUtil.isNullToString(iMap.get("PROGRM_NM")));
				
				//프로그램 정보 세팅
				iMap.put("QUERY", "selectCmMenuForMenuNm");
				Map<String, Object> mapMenuInfo = pantheonCommonService.selectQueryData((Map<String, String>)(Object)iMap);
				Util.getProgrmMap().put("UPPER_MENU_NM", EgovStringUtil.isNullToString(mapMenuInfo.get("UPPER_MENU_NM")));
				Util.getProgrmMap().put("MENU_NM", EgovStringUtil.isNullToString(mapMenuInfo.get("MENU_NM")));
				
				//프로그램 아이디 세팅
				map.put("PROGRM_ID", EgovStringUtil.isNullToString(iMap.get("PROGRM_ID")));
			}
		}
		
		if(!map.containsKey("PROGRM_ID")) {
			return;
		}
		
		map.put("CONECT_SN", cmProgrmConectSeq.getNextStringId());
		
		comf05DAO.insertCmProgrmConect(map);
		
		//과제
		if(Util.getUserMap().get("ROLE_ID") != null) {
			String[] strRoleId = {Util.getUserMap().get("ROLE_ID")};
			
//			mapForCurdSession.put("USER_ID", map.get("USER_ID"));
			mapForCurdSession.put("ROLE_ID", strRoleId);
			mapForCurdSession.put("PROGRM_ID", map.get("PROGRM_ID"));
			
			//프로그램 CRUD 조회 해서 세션에 넣어준다.
			Map<String, String> mapCRUD = comf05DAO.selectCmRoleAuthorForAspect(mapForCurdSession);
			
			Util.getUserMap().put("WRITE_AT", mapCRUD.get("WRITE_AT"));
			Util.getUserMap().put("REDNG_AT", mapCRUD.get("REDNG_AT"));
		}
		//전체
		else {
			List<Map<String, String>> listRoleId = comf05DAO.selectCmUserRoleListForAspect(map);
			String[] strRoleId = new String[listRoleId.size()];
			
			for(int i = 0; i < listRoleId.size(); i++) {
				strRoleId[i] = listRoleId.get(i).get("ROLE_ID"); 
			}
			
//			mapForCurdSession.put("USER_ID", map.get("USER_ID"));
			mapForCurdSession.put("ROLE_ID", strRoleId);
			mapForCurdSession.put("PROGRM_ID", map.get("PROGRM_ID"));
			
			//프로그램 CRUD 조회 해서 세션에 넣어준다.
			Map<String, String> mapCRUD = comf05DAO.selectCmRoleAuthorForAspect(mapForCurdSession);
			
			Util.getUserMap().put("WRITE_AT", mapCRUD.get("WRITE_AT"));
			Util.getUserMap().put("REDNG_AT", mapCRUD.get("REDNG_AT"));
		}
	}
}