package pantheon.edc.c01.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.c01.dao.EDCC01DAO;
import pantheon.edc.c01.service.EDCC01Service;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * Subject 관리를 처리하는 비지니스 구현 클래스
 * 
 * @author 오동근
 * @since 2016.05.03
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.03 오동근 최초 생성
 * 
 */
@Service("EDCC01Service")
public class EDCC01ServiceImpl implements EDCC01Service {

	@Resource(name = "EDCC01DAO")
	EDCC01DAO edccDao;

	@Resource(name = "EDC_CR_INSTT_FORM_SEQ")
	private EgovIdGnrService insttFormSeq;

	@Resource(name = "EDC_CF_SUBJECT_SEQ")
	private EgovIdGnrService subjectSeq;

	@Resource(name = "EDC_CF_VISIT_SEQ")
	private EgovIdGnrService visitSeq;

	@Resource(name = "CM_QUERY_SEQ")
	private EgovIdGnrService querySeq;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_CR_INSTT_FORM")
	protected EgovPropertyService atrailEdcCrInsttForm;
	
	@Resource(name = "ATRAIL_EDC_CF_SUBJECT")
	protected EgovPropertyService atrailEdcCfSubject;
	
	@Resource(name = "ATRAIL_EDC_CF_VISIT")
	protected EgovPropertyService atrailEdccfVisit;

	@Override
	public List<Map<String, Object>> selectEdcSubjectList(Map<String, Object> param) throws Exception {
		param.put("USER_ID", Util.getUserMap().get("USER_ID"));
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));

		return edccDao.selectEdcSubjectList(param);
	}

	@Override
	public String selectEdcSubjectListCount(Map<String, Object> param) throws Exception {
		param.put("USER_ID", Util.getUserMap().get("USER_ID"));
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));

		return edccDao.selectEdcSubjectListCount(param);
	}

	@Override
	public Map<String, Object> insertSubject(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> insttCodeList = new ArrayList();
		// 기관 양식 순번
		String INSTT_FORM_SN = "";
		// 기관 코드
		String INSTT_CODE = "";
		// EDC Version
		String EDC_VERSION = "";
		// 피험자 번호
		String SUBJECT_NO = "";
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));

		// 1. 기관 양식 테이블 값 유무 판단. 있으면 기관양식 순번을 가져온다.(INSTT_FORM_SN)
		// 파라미터 : USER_ID 
		// RETURN : INSTT_FORM_SN String. 
		INSTT_FORM_SN = edccDao.selectLoginInsttFormSn(param);
		// 파라미터 : USER_ID		 
		INSTT_CODE = edccDao.selectInsttCode(param);

		EDC_VERSION = edccDao.selectEdcVer(param);

		param.put("INSTT_FORM_SN", INSTT_FORM_SN);
		param.put("INSTT_CODE", INSTT_CODE);
		param.put("EDC_VERSION", EDC_VERSION);

		if (INSTT_FORM_SN == null || INSTT_FORM_SN.equals("")) {
			// 2. INSTT_FORM_SN이 없으면 기관양식 등록 후 테이블 INSERT한다.
			// 기관양식 순번 생성
			INSTT_FORM_SN = insttFormSeq.getNextStringId();
			param.put("INSTT_FORM_SN", INSTT_FORM_SN);
			// 기관양식 등록 (파라미터 : 과제순번, 기관양식 순번) 			
			edccDao.insertInsttForm(param);
			comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCrInsttForm, null, null);

		}

		// 등록한 기관양식번호와 생성 규칙에 맞는 피험자번호를 파라미터로 피험자 등록.
		// 피험자 번호 생성
		String tempStr = subjectSeq.getNextStringId();
		if (tempStr.length() == 1) {
			tempStr = "00" + tempStr;
		} else if (tempStr.length() == 2) {
			tempStr = "0" + tempStr;
		}

		SUBJECT_NO = "S" + tempStr;

		param.put("SUBJECT_NO", SUBJECT_NO);
		edccDao.insertSubject(param);
		comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfSubject, null, null);

		// 방문순번을 list로 가져온다.
		insttCodeList = edccDao.selectInsttCodeList(param);

		for (Map<String, Object> map : insttCodeList) {
			param.put("VISIT_SN", map.get("VISIT_SN"));
			param.put("VMODE_SN", visitSeq.getNextStringId());

			// 방문 순번 생성
			param.put("SN", "1");
			edccDao.insertCfVisit(param);
			comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdccfVisit, null, null);
		}

		return null;
	}

	@Override
	public List<Map<String, Object>> selectSubjectMenuList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";

		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);

		return edccDao.selectSubjectMenuList(param);
	}

	@Override
	public List<Map<String, Object>> selectVisitList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";

		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);

		return edccDao.selectVisitList(param);
	}

	@Override
	public String selectVisitListCount(Map<String, Object> param) throws Exception {
		String EDC_VERSION = "";

		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);

		return edccDao.selectVisitListCount(param);
	}

	public List<Map<String, Object>> selectVisitViewList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";

		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);

		return edccDao.selectVisitViewList(param);
	}

	@Override
	public List<Map<String, Object>> selectCRFVisitList(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> visit_list = edccDao.selectCRFVisitList(param);
		List<Map<String, Object>> group_list = edccDao.selectCRFGroupList(param);
		for (Map<String, Object> v : visit_list) {
			String visit_sn = String.valueOf(v.get("VISIT_SN"));
			List<Map<String, Object>> temp_list = new ArrayList<Map<String, Object>>();
			int size = group_list.size();
			for (int i = 0; i < size; i++) {
				Map<String, Object> g = group_list.get(i);
				String visit_sn2 = String.valueOf(g.get("VISIT_SN"));
				if (visit_sn.equals(visit_sn2)) {
					temp_list.add(g);
					group_list.remove(i);
					i--;
					size--;
				}
			}
			v.put("GROUP_LIST", temp_list);
		}

		return visit_list;
	}

	@Override
	public List<Map<String, Object>> selectCRFLayoutList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edccDao.selectCRFLayoutList(param);
	}

	@Override
	public List<Map<String, Object>> selectVisitViewSnList(Map<String, Object> param) throws Exception {
		return edccDao.selectVisitViewSnList(param);
	}

	@Override
	public List<Map<String, Object>> selectVisitViewHeaderList(Map<String, Object> param) throws Exception {
		String EDC_VERSION = "";

		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);

		return edccDao.selectVisitViewHeaderList(param);
	}

	@Override
	public List<Map<String, Object>> selectCRFCommentList(Map<String, Object> param) throws Exception {
		return edccDao.selectCRFCommentList(param);
	}

	@Override
	public void insertCRFValue(Map<String, Object> map) throws Exception {
		Object update_id = Util.getUserMap().get("USER_ID");
		if (map.get("BASE") != null && !"".equals(map.get("BASE"))) {
			Map<String, Object> iMap = Util.makeMap(new JSONObject(String.valueOf(map.get("BASE"))));
			if (edccDao.selectGroupInfo(iMap) == null) {
				edccDao.insertCRFGroup(iMap);
			} else {
				edccDao.updateCRFGroup(iMap);
			}
		}
		if (map.get("VALUE_LIST") != null && !"".equals(map.get("VALUE_LIST"))) {
			ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			JSONArray jsonArray = new JSONArray(String.valueOf(map.get("VALUE_LIST")));
			for (int i = 0; i < jsonArray.length(); i++) {
				list.add(Util.makeMap(jsonArray.getJSONObject(i)));
			}
			Object sn = null;
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> iMap = list.get(i);
				Object i_vriabl_row_sn = iMap.get("VRIABL_ROW_SN");

				String cnt = edccDao.selectCRFRow(iMap);
				if (cnt == null || "0".equals(cnt)) {
					sn = edccDao.selectVriablRowSn(iMap);
					iMap.put("VRIABL_ROW_SN", sn);
					iMap.put("CRUD", "C");
					list.set(i, iMap);
					edccDao.insertCRFRow(iMap);
					for (int j = i + 1; j < list.size(); j++) {
						Map<String, Object> jMap = list.get(j);
						if (i_vriabl_row_sn.equals(jMap.get("VRIABL_ROW_SN"))) {
							jMap.put("VRIABL_ROW_SN", sn);
							jMap.put("CRUD", "C");
						}
						list.set(j, jMap);
					}
				}
			}

			for (Map<String, Object> iMap : list) {
				iMap.put("UPDATE_ID", update_id);
				if (iMap.get("CRUD").equals("C")) {
					edccDao.insertCRFValue(iMap);
				} else {
					if (iMap.get("CRUD").equals("U")) {
						iMap.put("USE_AT", "Y");
					} else {
						iMap.put("USE_AT", "N");
						iMap.put("SDV_AT", "N");
						edccDao.updateCRFRow(iMap);
					}
					edccDao.insertCRFValue(iMap);
					//edccDao.updateCRFValue(iMap);
				}
			}
		}
		if (map.get("COMMENT_LIST") != null && !"".equals(map.get("COMMENT_LIST"))) {
			ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			JSONArray jsonArray = new JSONArray(String.valueOf(map.get("COMMENT_LIST")));
			for (int i = 0; i < jsonArray.length(); i++) {
				list.add(Util.makeMap(jsonArray.getJSONObject(i)));
			}
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> iMap = list.get(i);
				iMap.put("UPDATE_ID", update_id);
				edccDao.updateCRFComment(iMap);
				iMap.put("ATRAIL_SN", edccDao.selectAtrailSn(iMap));
				edccDao.insertCRFComment(iMap);
			}
		}

	}

	@Override
	public void insertCRFQuery(Map<String, Object> param) throws Exception {
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		Object query_sn = querySeq.getNextStringId();
		param.put("QUERY_SN", query_sn);
		String separator = String.valueOf(param.get("SEPARATOR"));

		if (separator.equals("REOPEN")) {
			edccDao.insertCRFQuery(param);
			edccDao.insertMasterQuery(param);
			edccDao.updateMasterQuery(param);

			query_sn = querySeq.getNextStringId();
			param.put("QUERY_SN", query_sn);
			param.put("QUERY_GROUP", query_sn);
			param.put("QUERY_STTUS_CODE", "01");
			param.put("QUERY_CN", param.get("NEW_QUERY_CN"));
			param.put("RESN", "Manual issued");
			edccDao.insertCRFQuery(param);
			edccDao.insertMasterQuery(param);

			param.put("USE_AT", "Y");
			param.put("SDV_AT", "N");
			edccDao.updateCRFRow(param);

			param.put("SDV_STTUS_CODE", "01");
			param.put("SDV_COMPT_STTUS_CODE", "01");
			edccDao.updateCRFGroup(param);
		} else {
			if (separator.equals("OPEN")) {
				edccDao.insertCRFQuery(param);
				param.put("QUERY_GROUP", query_sn);
				param.put("RESN", "Manual issued");
				edccDao.insertMasterQuery(param);

				if ("01".equals(param.get("QUERY_STTUS_CODE"))) {
					param.put("USE_AT", "Y");
					param.put("SDV_AT", "N");
					edccDao.updateCRFRow(param);

					param.put("SDV_STTUS_CODE", "01");
					param.put("SDV_COMPT_STTUS_CODE", "01");
					edccDao.updateCRFGroup(param);
				}
			} else if (separator.equals("END")) {
				edccDao.insertCRFQuery(param);
				edccDao.insertMasterQuery(param);
				edccDao.updateMasterQuery(param);
			} else if (separator.equals("ANSWER")) {
				edccDao.insertCRFQuery(param);
				edccDao.insertMasterQuery(param);
			}
		}
	}

	@Override
	public Map<String, Object> selectGroupInfo(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edccDao.selectGroupInfo(param);
	}

	@Override
	public List<Map<String, Object>> selectCRFQueryList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edccDao.selectCRFQueryList(param);
	}

	@Override
	public List<Map<String, Object>> selectCRFSDVList(Map<String, Object> param) throws Exception {
		return edccDao.selectCRFSDVList(param);
	}

	@Override
	public void insertSDVList(List<Map<String, Object>> list) throws Exception {
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("USE_AT", "Y");
			edccDao.updateCRFRow(iMap);

		}
		Map<String, Object> m = list.get(0);
		m.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		m.put("SDV_AT", "N");
		String cnt = edccDao.selectCRFSDV(m);
		if (cnt != null) {
			if (Integer.parseInt(cnt) == 0) {
				m.put("SDV_STTUS_CODE", "03");
			} else {
				m.put("SDV_STTUS_CODE", "01");
				m.put("SDV_COMPT_STTUS_CODE", "01");
			}
			edccDao.updateCRFGroup(m);
		}
	}

	@Override
	public void insertSDVcompletion(Map<String, Object> param) throws Exception {
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		edccDao.updateCRFGroup(param);
	}

	@Override
	public void updateCRFSign(Map<String, String> param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>(param);
		param.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		if (edccDao.selectGroupInfo(map) == null) {
			edccDao.insertCRFGroup(map);
		}
		if ("CRF_VISIT".equals(param.get("TYPE"))) {
			edccDao.updateVisitSign(param);
		} else if ("CRF_SUBJECT".equals(param.get("TYPE"))) {
			edccDao.updateSubjectSign(param);
		}
	}

	@Override
	public List<Map<String, Object>> selectPatientList(Map<String, Object> param) throws Exception {
		return edccDao.selectPatientList(param);
	}

	@Override
	public void updatePatientList(List<Map<String, Object>> list) throws Exception {
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			if (iMap.get("CRUD").equals("U")) {
				iMap.put("USE_AT", "Y");
			} else {
				iMap.put("USE_AT", "N");
			}
			edccDao.updatePatient(iMap);

			//edccDao.updatePatientVariable(iMap);
		}
	}

}