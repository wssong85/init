package pantheon.edc.c01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.h01.service.COMH01Service;
import pantheon.com.utl.Util;
import pantheon.edc.c01.service.EDCC01Service;
import pantheon.iwrs.b01.service.IWRB01Service;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 * Subject 관리를 처리하는 컨트롤러 클래스
 * 
 * @author 오동근
 * @since 2016.05.03
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.03 오동근 최초 생성
 */
@Controller
@RequestMapping("/edc/c01")
public class EDCC01Controller {

	@Resource(name = "EDCC01Service")
	EDCC01Service edcc01Service;

	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;

	@Resource(name = "IWRB01Service")
	private IWRB01Service iwrb01Service;

	@Resource(name = "COMH01Service")
	private COMH01Service comh01Service;

	@IncludedInfo(name = "pantheon Subject 목록", order = 6600, gid = 110)
	@RequestMapping("/EDCC0101.do")
	public String EDCC0101(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/c01/EDCC0101";
	}

	@IncludedInfo(name = "pantheon Patient Visit 목록[View]", order = 6610, gid = 110)
	@RequestMapping("/EDCC0102.do")
	public String EDCC0102(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		model.addAttribute("SubjectMenuList", edcc01Service.selectSubjectMenuList(map));
		model.addAttribute("INSTT_NM", map.get("INSTT_NM"));
		model.addAttribute("SUBJECT_NO", map.get("SUBJECT_NO"));
		model.addAttribute("subjectNo", map.get("subjectNo"));
		return "/pantheon/edc/c01/EDCC0102";
	}

	@IncludedInfo(name = "pantheon Patient Visit 목록[List]", order = 6620, gid = 110)
	@RequestMapping("/EDCC0103.do")
	public String EDCC0103(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {

		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		model.addAttribute("SubjectMenuList", edcc01Service.selectSubjectMenuList(map));
		model.addAttribute("INSTT_NM", map.get("INSTT_NM"));
		model.addAttribute("SUBJECT_NO", map.get("SUBJECT_NO"));
		model.addAttribute("subjectNo", map.get("subjectNo"));
		return "/pantheon/edc/c01/EDCC0103";
	}

	@IncludedInfo(name = "pantheon Patient 등록", order = 6630, gid = 110)
	@RequestMapping("/EDCC0104.do")
	public String EDCC0104(@RequestParam Map<String, String> map, ModelMap model, HttpServletRequest request) throws Exception {
		return "/pantheon/edc/c01/EDCC0104";
	}

	/**
	 * Subject 목록
	 * 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectEdcSubjectList.do")
	public @ResponseBody Map<String, Object> selectEdcSubjectList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;

		try {
			list = edcc01Service.selectEdcSubjectList(map);
			result.put("success", true);
			result.put("result", list);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;
	}

	@RequestMapping(value = "/insertSubject.do")
	public @ResponseBody Map<String, Object> updateChangeReason(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			param.put("USER_ID", Util.getUserMap().get("USER_ID"));

			edcc01Service.insertSubject(param);
			result.put("success", true);
			result.put("message", "성공");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit[List] 목록
	 * 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectVisitList.do")
	public @ResponseBody Map<String, Object> selectVisitList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;

		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));

			list = edcc01Service.selectVisitList(map);
			result.put("count", edcc01Service.selectVisitListCount(map));
			result.put("success", true);
			result.put("result", list);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;
	}

	/**
	 * Visit[View] 목록
	 * 
	 * @param request
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectVisitViewList.do")
	public @ResponseBody Map<String, Object> selectVisitViewList(HttpServletRequest request, @RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> snList = null;
		List<Map<String, Object>> headerList = null;
		Map<String, Object> tempMap = new HashMap<String, Object>();
		String sqlList = "";
		String resultStr = "";

		try {
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			// 순번 겸 select 후 가져올 필드 명이 될 sql -- SELECT SN FROM EDC_CF_VISIT WHERE SUBJECT_NO = 'S062';
			snList = edcc01Service.selectVisitViewSnList(map);

			int i = 0;
			for (Map<String, Object> sqlMap : snList) {
				if (i == 0) {
					sqlList = "'" + sqlMap.get("VMODE_SN") + "' AS \"" + sqlMap.get("VMODE_SN") + "\"";
				} else {
					sqlList += ",'" + sqlMap.get("VMODE_SN") + "' AS \"" + sqlMap.get("VMODE_SN") + "\"";
				}
				i++;
			}

			map.put("sqlList", sqlList);

			// -- 헤더(첫번째 행)이 될 sql
			headerList = edcc01Service.selectVisitViewHeaderList(map);
			list = edcc01Service.selectVisitViewList(map);

			for (Map<String, Object> sqlMap : list) {
				tempMap.put("GROUP_LBL", sqlMap.get("GROUP_LBL"));
				resultStr += "<tr>";
				resultStr += "<td>" + sqlMap.get("GROUP_LBL") + "</td>";
				for (Map<String, Object> subMap : snList) {
					if (sqlMap.get(String.valueOf(subMap.get("VISIT_SN"))) == null) {
						resultStr += "<td><a href=\"#\"><span class=\"big_icon_01\"></span></a></td>";
					} else {
						resultStr += "<td><a href=\"#\"><span class=\"big_icon_" + sqlMap.get(String.valueOf(subMap.get("SN"))) + "\"></span></a></td>";
					}
				}
				resultStr += "</tr>";
			}

			result.put("success", true);
			result.put("headerList", headerList);
			result.put("resultList", resultStr);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;
	}

	@RequestMapping("/EDCC0106.do")
	public String EDCC0106(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("EDCC0106");
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		model.addAllAttributes(map);
		model.addAttribute("SubjectMenuList", edcc01Service.selectSubjectMenuList(map));
		return "/pantheon/edc/c01/EDCC0106";
	}

	@RequestMapping("/popupEDCC0106Sub01.do")
	public String popupEDCC0106Sub01(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0106Sub01");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC056");
		model.addAttribute("EDC056", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/c01/EDCC0106Sub01";
	}

	@RequestMapping("/EDCC0107.do")
	public String EDCC0107(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("EDCC0107");
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		model.addAllAttributes(map);
		//map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		model.addAttribute("SubjectMenuList", edcc01Service.selectSubjectMenuList(map));
		return "/pantheon/edc/c01/EDCC0107";
	}

	@RequestMapping("/popupEDCC0107Sub01.do")
	public String popupEDCC0107Sub01(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0107Sub01");
		model.addAllAttributes(map);
		map.put("QUERY", "selectEDCCodeList");
		map.put("FLAG", "COMMON");
		map.put("CODE", "EDC053");
		model.addAttribute("EDC053", pantheonCommonService.selectQueryDataList2(map));
		map.put("CODE", "EDC054");
		model.addAttribute("EDC054", pantheonCommonService.selectQueryDataList2(map));
		return "/pantheon/edc/c01/EDCC0107Sub01";
	}

	@RequestMapping("/EDCC0108.do")
	public String EDCC0108(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("EDCC0108");
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		model.addAllAttributes(map);
		//map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		model.addAttribute("SubjectMenuList", edcc01Service.selectSubjectMenuList(map));
		return "/pantheon/edc/c01/EDCC0108";
	}

	@RequestMapping("/popupEDCC0109.do")
	public String popupEDCC0109(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0109");
		model.addAllAttributes(map);
		return "/pantheon/edc/c01/EDCC0109";
	}

	@RequestMapping("/popupEDCC0110.do")
	public String popupEDCC0110(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0110");
		model.addAllAttributes(map);
		return "/pantheon/edc/c01/EDCC0110";
	}

	@RequestMapping("/popupEDCC0111.do")
	public String popupEDCC0111(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0111");
		model.addAllAttributes(map);
		return "/pantheon/edc/c01/EDCC0111";
	}

	@RequestMapping("/popupEDCC0112.do")
	public String popupEDCC0112(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("popupEDCC0112");
		model.addAllAttributes(map);
		return "/pantheon/edc/c01/EDCC0112";
	}

	@RequestMapping("/EDCC0114.do")
	public String EDCC0114(@RequestParam Map<String, Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("EDCC0114");
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		model.addAllAttributes(map);
		return "/pantheon/edc/c01/EDCC0114";
	}

	/**
	 * CRF Group 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCRFVisitList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFGroupList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edcc01Service.selectCRFVisitList(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * CRF Layout 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCRFLayoutList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFLayout(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		try {
			list = edcc01Service.selectCRFLayoutList(map);
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * CRF comment 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCRFCommentList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFCommentList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edcc01Service.selectCRFCommentList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * crf 값 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCRFValue.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertCRFValue(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edcc01Service.insertCRFValue(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * query 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCRFQuery.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertCRFQuery(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edcc01Service.insertCRFQuery(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * group 상태 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectGroupInfo.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectGroupInfo(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edcc01Service.selectGroupInfo(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * CRF Query List 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCRFQueryList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFQueryList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edcc01Service.selectCRFQueryList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * CRF SDV List 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCRFSDVList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectCRFSDVList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edcc01Service.selectCRFSDVList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * SDV 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSDVList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertLayoutList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edcc01Service.insertSDVList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * SDV completion 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSDVcompletion.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertSDVcompletion(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edcc01Service.insertSDVcompletion(map);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * Visit ESign
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateCRFSign.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> updateCRFSign(@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			// 사용자 계정 패스워드 확인 및 실패시 계정 잠김 처리
			comh01Service.selectCmUserForContractReq(map);

			if (!Util.getUserMap().get("USER_ID").equals(map.get("USER_ID"))) {
				result.put("result", "false");
				result.put("message", "자신의 아이디를 입력하십시오.");
			} else {
				int cnt = iwrb01Service.selectUserInfo(map);

				if (cnt > 0) {
					edcc01Service.updateCRFSign(map);
					result.put("result", "true");
				} else {
					result.put("result", "false");
					result.put("message", "입력한 사용자 정보가 잘못 되었습니다.");
				}
			}
		} catch (Exception e) {
			result.put("result", "false");
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}

		return result;

	}

	/**
	 * 환자표 List 조회
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectPatientList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> selectPatientList(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result", edcc01Service.selectPatientList(map));
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

	/**
	 * SDV 목록 저장
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePatientList.do", method = (RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertPatientList(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			edcc01Service.updatePatientList(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		return result;
	}

}
