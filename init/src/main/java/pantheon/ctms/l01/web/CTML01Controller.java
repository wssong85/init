package pantheon.ctms.l01.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pantheon.com.utl.Util;
import pantheon.ctms.l01.service.CTML01Service;



@Controller
public class CTML01Controller {

	@Resource(name="CTML01Service")
	private CTML01Service CTML01Service;

	/**
	 * Milestone 계획 리스트 화면 출력
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/CTML0101.do")
	public String CTML0101(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "/pantheon/ctms/l01/CTML0101";
	}

	/**
	 * Milestone
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/CTML0102.do")
	public String CTML0102(HttpServletRequest request, HttpServletResponse response) {
		return "/pantheon/ctms/l01/CTML0102";
	}

	/**
	 * Milestone 초기 공통 및 기본 정보 조회.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/selectInitInfoList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectInitInfoList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> loginMap = Util.getUserMap();
		Map<String, Object> taskInfo = new HashMap<String, Object>();
		
		List<Map<String, Object>> planlist  = null; //계획 코드 리스트
		List<Map<String, Object>> cralist   = null; //CRA 리스트
		List<Map<String, Object>> insttlist = null; //과제별 기관 리스트

		try {
			map.put("TASK_SN", loginMap.get("TASK_SN"));
			taskInfo = CTML01Service.selectTaskInfo(map);
			System.out.println("taskInfo : TASK_TY_CODE ::: "+taskInfo.get("TASK_TY_CODE"));
			System.out.println(taskInfo);
			if("01".equals(taskInfo.get("TASK_TY_CODE").toString())){
				map.put("CMMN_CLCODE", "CTM004");
			}
			else{
				map.put("CMMN_CLCODE", "CTM003");
			}

			planlist  = CTML01Service.selectCommonCodeList(map);		
			cralist   = CTML01Service.selectCRAList(map);		
			insttlist = CTML01Service.selectInsttList(map);		
			result.put("success", true);
			result.put("planlist" , planlist );
			result.put("cralist"  , cralist  );
			result.put("insttlist", insttlist);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * Milestone 계획 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/selectMileStonePlanList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectMileStonePlanList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		System.out.println("PLAN========================================================"+map);

		try {
			list = CTML01Service.selectMileStonePlanList(map);			
			result.put("success", true);
			result.put("result", list);			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}

	/**
	 * Milestone 계획 정보 데이터 저장
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/insertMileStonePlanInfo.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String, Object> insertMileStonePlanInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("==============map==================="+list);
		try {
			CTML01Service.insertMileStonePlanInfo(list);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));
		}
		
		return result;
	}

	/**
	 * Milestone 계획 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ctms/l01/selectMileStonePlanBarList.do", method=(RequestMethod.POST))
	public @ResponseBody Map<String , Object> selectMileStonePlanBarList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> colwidth  = null;
		List<Map<String, Object>> yearList = null;
		List<Map<String, Object>> barList  = null;
		System.out.println("PLAN========================================================"+map);

		try {
			colwidth = CTML01Service.selectMilestoneColWidthInfo(map);
			yearList = CTML01Service.selectMilestoneYearInfo(map);
			barList  = CTML01Service.selectMilestonerPlanBarList(map);
			result.put("success" , true);
			result.put("colwidth", colwidth);
			result.put("yearcnt" , yearList.size());
			result.put("yearList", yearList);
			result.put("barcnt"  , barList.size());
			result.put("barList" , barList);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", Util.getPantheonErrorMessage(e, this));		
		}
		
		return result;
	}
/*-------------------------------------------------------------------------------------------------------------------------------*/

}



