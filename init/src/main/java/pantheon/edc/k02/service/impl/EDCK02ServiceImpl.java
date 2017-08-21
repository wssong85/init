package pantheon.edc.k02.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.k02.dao.EDCK02DAO;
import pantheon.edc.k02.service.EDCK02Service;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("EDCK02Service")
public class EDCK02ServiceImpl implements EDCK02Service {
	@Resource(name = "EDCK02DAO")
	private EDCK02DAO edck02DAO;
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

	/** EgovPropertyService */
	@Resource(name = "ATRAIL_EDC_CR_FORM")
	protected EgovPropertyService atrailEdcCrForm;
	@Resource(name = "ATRAIL_EDC_CR_GROUP")
	protected EgovPropertyService atrailEdcCrGroup;
	@Resource(name = "ATRAIL_EDC_CR_VRIABL")
	protected EgovPropertyService atrailEdcCrVriabl;
	@Resource(name = "ATRAIL_EDC_CR_VISIT_GROUP")
	protected EgovPropertyService atrailEdcCrVisitGroup;
	@Resource(name = "ATRAIL_EDC_CR_VISIT_SCHDUL")
	protected EgovPropertyService atrailEdcCrVisitSchdul;
	@Resource(name = "ATRAIL_EDC_CR_TE")
	protected EgovPropertyService atrailEdcCrTe;
	@Resource(name = "ATRAIL_EDC_CR_TA")
	protected EgovPropertyService atrailEdcCrTa;
	@Resource(name = "ATRAIL_EDC_CR_TADETAIL")
	protected EgovPropertyService atrailEdcCrTadetail;
	@Resource(name = "ATRAIL_EDC_CR_TI")
	protected EgovPropertyService atrailEdcCrTi;
	@Resource(name = "ATRAIL_EDC_CR_TS")
	protected EgovPropertyService atrailEdcCrTs;
	@Resource(name = "ATRAIL_EDC_USER_VRIABL")
	protected EgovPropertyService atrailEdcUserVriabl;
	@Resource(name = "ATRAIL_EDC_USER_VRIABLOPTN")
	protected EgovPropertyService atrailEdcUserVriabloptn;
	@Resource(name = "ATRAIL_EDC_CR_EDITCECK")
	protected EgovPropertyService atrailEdcCrEditceck;
	@Resource(name = "ATRAIL_EDC_CR_INPUTLMTT")
	protected EgovPropertyService atrailEdcCrInputlmtt;
	@Resource(name = "ATRAIL_EDC_CR_CODING")
	protected EgovPropertyService atrailEdcCrCoding;

	@Override
	public List<Map<String, Object>> selectCRFList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectCRFList(param);
	}

	@Override
	public Map<String, Object> selectCRFVersion(Map<String, Object> param) throws Exception {
		return edck02DAO.selectCRFVersion(param);
	}

	@Override
	public List<Map<String, Object>> selectGroupList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectGroupList(param);
	}

	@Override
	public void insertGroupList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("GROUP_SN", edck02DAO.selectGroupSn(iMap));
				edck02DAO.insertGroup(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrGroup, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrGroup, null, null);
				edck02DAO.updateGroup(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "03");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectVariableList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectVariableList(param);
	}

	@Override
	public List<Map<String, Object>> selectGroupInsideList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectGroupInsideList(param);
	}

	@Override
	public void insertGroupInsideList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("VRIABL_SN", edck02DAO.selectVriablSn(iMap));
				iMap.put("USE_AT", "Y");
				edck02DAO.insertGroupInside(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrVriabl, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrVriabl, null, null);
				edck02DAO.updateGroupInside(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "03");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectGroupListForVisit(Map<String, Object> param) throws Exception {
		return edck02DAO.selectGroupListForVisit(param);
	}

	@Override
	public List<Map<String, Object>> selectDictionary(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectDictionary(param);
	}

	@Override
	public void insertDictionary(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			iMap.put("USE_AT", "Y");
			String group_sn = String.valueOf(iMap.get("GROUP_SN"));
			group_sn = group_sn.substring(group_sn.indexOf("_") + 1, group_sn.length());
			iMap.put("GROUP_SN", group_sn);
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrVriabl, null, null);
			edck02DAO.updateGroupInside(iMap);
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "05");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public void insertEDCVersion(Map<String, Object> param) throws Exception {
		Object update_id = param.get("UPDATE_ID");
		if (!param.get("CRF_VER").equals("N")) {
			param.put("EDC_VER", param.get("CRF_VER") + ".0");
			edck02DAO.insertCRF(param);
			comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCrForm, null, null);
			copyEDCVersion(param);
		} else {
			Map<String, Object> r = edck02DAO.selectCRFVersion(param);
			if (r.get("EDC_VER") == null) {
				r.put("EDC_VER", r.get("CRF_VER") + ".0");
			} else {
				r.put("EDC_VER", r.get("CRF_VER") + "." + r.get("NEW_EDC_VER"));
			}
			r.put("UPDATE_ID", update_id);
			edck02DAO.insertCRF(r);
			comz06Service.createCmDtaAtrailForInsertByObject(r, atrailEdcCrForm, null, null);

			if ("1.0.0".equals(r.get("EDC_VER"))) {
				insertFirstEDCVersion(r);
			} else {
				copyEDCVersion(r);
			}
		}
	}

	public void insertFirstEDCVersion(Map<String, Object> param) throws Exception {
		param.put("VISIT_SN", "1");
		param.put("VISIT_LBL", "등록");
		param.put("VISIT_TY", "08");
		param.put("REFRN_BEGIN_AT", "N");
		param.put("REFRN_END_AT", "N");
		param.put("VISIT_ORDR", "1");
		edck02DAO.insertVisitInfo(param);

		param.put("GROUP_SN", 1);
		param.put("GROUP_SE_CODE", "06");
		param.put("GROUP_LBL", "등록");
		param.put("GROUP_ORDR", 1);
		edck02DAO.insertGroup(param);

		ArrayList<Object> list = new ArrayList<Object>();
		list.add("SUBJID");
		int cnt = 1;
		for (Object vriabl_nm : list) {
			Object domn_vriabl_sn = null;
			Object vriabl_se_code = null;

			param.put("VRIABL_NM", vriabl_nm);
			domn_vriabl_sn = edck02DAO.selectCDISCSn(param);
			vriabl_se_code = "12";
			param.put("USER_DFN_AT", "N");

			param.put("DOMN_VRIABL_SN", domn_vriabl_sn);
			param.put("VRIABL_SN", cnt);
			param.put("VRIABL_ORDR", cnt);
			param.put("USE_AT", "Y");
			edck02DAO.insertGroupInside(param);

			param.put("VISIT_GROUP_SN", cnt);
			edck02DAO.insertVisitInside(param);

			param.put("SET_SN", cnt);
			param.put("SET_TY_CODE", "01");
			param.put("SET_ORDR", cnt);
			edck02DAO.insertSet(param);

			param.put("SET_ROW_SN", cnt);
			param.put("SET_ROW_ORDR", cnt);
			edck02DAO.insertSetRow(param);

			param.put("SET_VRIABL_SN", cnt);
			param.put("VRIABL_SE_CODE", vriabl_se_code);
			param.put("SET_VRIABL_ORDR", cnt);
			edck02DAO.insertSetVariable(param);

			cnt++;
		}

		if (param.get("BLIND_CODE") != null && !"03".equals(param.get("BLIND_CODE"))) {
			param.put("VISIT_SN", "2");
			param.put("VISIT_LBL", "무작위배정");
			param.put("VISIT_TY", "04");
			param.put("REFRN_BEGIN_AT", "N");
			param.put("REFRN_END_AT", "N");
			param.put("VISIT_ORDR", "2");
			edck02DAO.insertVisitInfo(param);

			param.put("GROUP_SN", 2);
			param.put("GROUP_SE_CODE", "07");
			param.put("GROUP_LBL", "무작위배정");
			param.put("GROUP_ORDR", 2);
			edck02DAO.insertGroup(param);

			param.put("VISIT_GROUP_SN", cnt);
			edck02DAO.insertVisitInside(param);
		}
	}

	@Override
	public void copyEDCVersion(Map<String, Object> param) throws Exception {
		Object update_id = param.get("UPDATE_ID");
		Object edc_ver = param.get("EDC_VER");
		Object old_edc_ver = edck02DAO.selectOldEDCVer(param);
		if (old_edc_ver != null) {
			param.put("EDC_VER", old_edc_ver);
			List<Map<String, Object>> group_list = edck02DAO.selectGroupList(param);
			for (Map<String, Object> group : group_list) {
				group.put("EDC_VER", edc_ver);
				group.put("UPDATE_ID", update_id);
				edck02DAO.insertGroup(group);
			}

			List<Map<String, Object>> group_in_list = edck02DAO.selectGroupInsideList(param);
			for (Map<String, Object> group_in : group_in_list) {
				group_in.put("EDC_VER", edc_ver);
				group_in.put("UPDATE_ID", update_id);
				edck02DAO.insertGroupInside(group_in);
			}

			List<Map<String, Object>> visit_list = edck02DAO.selectVisitInfoList(param);
			for (Map<String, Object> visit : visit_list) {
				visit.put("EDC_VER", edc_ver);
				visit.put("UPDATE_ID", update_id);
				edck02DAO.insertVisitInfo(visit);
			}

			List<Map<String, Object>> visit_in_list = edck02DAO.selectVisitInsideList(param);
			for (Map<String, Object> visit_in : visit_in_list) {
				visit_in.put("EDC_VER", edc_ver);
				visit_in.put("UPDATE_ID", update_id);
				edck02DAO.insertVisitInside(visit_in);
			}

			List<Map<String, Object>> set_list = edck02DAO.selectSetList(param);
			for (Map<String, Object> set : set_list) {
				set.put("EDC_VER", edc_ver);
				edck02DAO.insertSet(set);
			}

			List<Map<String, Object>> set_row_list = edck02DAO.selectSetRowList(param);
			for (Map<String, Object> set_row : set_row_list) {
				set_row.put("EDC_VER", edc_ver);
				set_row.put("UPDATE_ID", update_id);
				edck02DAO.insertSetRow(set_row);
			}

			List<Map<String, Object>> set_var_list = edck02DAO.selectSetVariableList(param);
			for (Map<String, Object> set_var : set_var_list) {
				Map<String, Object> desc = edck02DAO.selectDescription(set_var);
				set_var.put("EDC_VER", edc_ver);
				set_var.put("UPDATE_ID", update_id);
				edck02DAO.insertSetVariable(set_var);
				if (desc != null) {
					desc.put("EDC_VER", edc_ver);
					desc.put("UPDATE_ID", update_id);
					edck02DAO.insertDescription(desc);
				}
			}

			List<Map<String, Object>> edit_list = edck02DAO.selectEditCheckList(param);
			for (Map<String, Object> edit : edit_list) {
				edit.put("EDC_VER", edc_ver);
				edit.put("UPDATE_ID", update_id);
				edck02DAO.insertEditCheck(edit);
			}

			List<Map<String, Object>> edit_disable_list = edck02DAO.selectDisableList(param);
			for (Map<String, Object> edit_disable : edit_disable_list) {
				edit_disable.put("EDC_VER", edc_ver);
				edit_disable.put("UPDATE_ID", update_id);
				edck02DAO.insertDisable(edit_disable);
			}

			List<Map<String, Object>> coding_list = edck02DAO.selectCodingList(param);
			for (Map<String, Object> coding : coding_list) {
				coding.put("EDC_VER", edc_ver);
				coding.put("UPDATE_ID", update_id);
				edck02DAO.insertCoding(coding);
			}

			List<Map<String, Object>> t_list = edck02DAO.selectElementList(param);
			for (Map<String, Object> t : t_list) {
				t.put("EDC_VER", edc_ver);
				t.put("UPDATE_ID", update_id);
				edck02DAO.insertElement(t);
			}

			t_list = edck02DAO.selectArmCodeList(param);
			for (Map<String, Object> t : t_list) {
				t.put("EDC_VER", edc_ver);
				t.put("UPDATE_ID", update_id);
				edck02DAO.insertArmCode(t);
			}

			t_list = edck02DAO.selectArmList(param);
			for (Map<String, Object> t : t_list) {
				t.put("EDC_VER", edc_ver);
				t.put("UPDATE_ID", update_id);
				edck02DAO.insertArm(t);
			}

			t_list = edck02DAO.selectInclusionList(param);
			for (Map<String, Object> t : t_list) {
				t.put("EDC_VER", edc_ver);
				t.put("UPDATE_ID", update_id);
				edck02DAO.insertInclusion(t);
			}

			t_list = edck02DAO.selectTrialSummaryList(param);
			for (Map<String, Object> t : t_list) {
				t.put("EDC_VER", edc_ver);
				t.put("UPDATE_ID", update_id);
				edck02DAO.insertTrialSummary(t);
			}

		}
	}

	@Override
	public List<Map<String, Object>> selectVisitInsideList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectVisitInsideList(param);
	}

	@Override
	public void insertVisitInsideList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("VISIT_GROUP_SN", edck02DAO.selectVisitGroupSn(iMap));
				edck02DAO.insertVisitInside(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrVisitGroup, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrVisitGroup, null, null);
				edck02DAO.updateVisitInside(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "04");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectUserVariableList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectUserVariableList(param);
	}

	@Override
	public List<Map<String, Object>> selectUserVariableOptionList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectUserVariableOptionList(param);
	}

	@Override
	public Map<String, Object> selectUserVariableDetail(Map<String, Object> param) throws Exception {
		return edck02DAO.selectUserVariableDetail(param);
	}

	@Override
	public void insertUserVariable(Map<String, Object> map) throws Exception {
		Object domn_vriabl_sn = null;
		if (map.get("BASE") != null && !"".equals(map.get("BASE"))) {
			Map<String, Object> iMap = Util.makeMap(new JSONObject(String.valueOf(map.get("BASE"))));
			if (iMap.get("CDISC_DOMN_SN") == null || iMap.get("CDISC_DOMN_SN").equals("")) {
				Map<String, Object> m = edck02DAO.selectUserDomain(iMap);
				if (m != null) {
					if (Integer.parseInt(String.valueOf(m.get("COUNT"))) == 0) {
						iMap.put("CDISC_DOMN_SN", m.get("CDISC_DOMN_SN"));
						edck02DAO.insertUserDomain(iMap);
					}
				}
			}
			if (iMap.get("CRUD").equals("C")) {
				domn_vriabl_sn = edck02DAO.selectUserDomnVriablSn(iMap);
				iMap.put("DOMN_VRIABL_SN", domn_vriabl_sn);
				edck02DAO.insertUserVariable(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcUserVriabl, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcUserVriabl, null, null);
				edck02DAO.updateUserVariable(iMap);
			}
		}

		if (map.get("OPTION_LIST") != null && !"".equals(map.get("OPTION_LIST"))) {
			ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			JSONArray jsonArray = new JSONArray(String.valueOf(map.get("OPTION_LIST")));
			for (int i = 0; i < jsonArray.length(); i++) {
				list.add(Util.makeMap(jsonArray.getJSONObject(i)));
			}
			for (Map<String, Object> iMap : list) {
				if (iMap.get("CRUD").equals("C")) {
					if (domn_vriabl_sn != null) {
						iMap.put("DOMN_VRIABL_SN", domn_vriabl_sn);
					}
					iMap.put("VRIABL_OPTN_SN", edck02DAO.selectOptnSn(iMap));
					edck02DAO.insertUserVariableOption(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcUserVriabloptn, null, null);
				} else {
					if (iMap.get("CRUD").equals("U")) {
						iMap.put("USE_AT", "Y");
					} else {
						iMap.put("USE_AT", "N");
					}
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcUserVriabloptn, null, null);
					edck02DAO.updateUserVariableOption(iMap);
				}
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectVisitInfoList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectVisitInfoList(param);
	}

	@Override
	public void insertVisitInfoList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("VISIT_SN", edck02DAO.selectVisitSn(iMap));
				edck02DAO.insertVisitInfo(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrVisitSchdul, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrVisitSchdul, null, null);
				edck02DAO.updateVisitInfo(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "04");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectElementList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectElementList(param);
	}

	@Override
	public void insertElementList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("TE_SN", edck02DAO.selectTeSn(iMap));
				edck02DAO.insertElement(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTe, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrTe, null, null);
				edck02DAO.updateElement(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "01");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectArmList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectArmList(param);
	}

	@Override
	public void insertArmList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("TA_DETAIL_SN", edck02DAO.selectTaDetailSn(iMap));
				edck02DAO.insertArm(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTadetail, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrTadetail, null, null);
				edck02DAO.updateArm(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "01");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectInclusionList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectInclusionList(param);
	}

	@Override
	public Map<String, Object> selectInclusionDetail(Map<String, Object> param) throws Exception {
		return edck02DAO.selectInclusionDetail(param);
	}

	@Override
	public void insertInclusionList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("TI_SN", edck02DAO.selectTiSn(iMap));
				edck02DAO.insertInclusion(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTi, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrTi, null, null);
				edck02DAO.updateInclusion(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "01");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectTrialSummaryList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectTrialSummaryList(param);
	}

	@Override
	public void insertTrialSummary(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("TS_SN", edck02DAO.selectTsSn(iMap));
				edck02DAO.insertTrialSummary(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTs, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrTs, null, null);
				edck02DAO.updateTrialSummary(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "01");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public void insertInclusionVersion(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> list = edck02DAO.selectNewInclusionVersion(param);
		if (list != null) {
			for (Map<String, Object> iMap : list) {
				edck02DAO.insertInclusionVersion(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTi, null, null);
			}
			param.put("CRF_PROGRS_CODE", "01");
			edck02DAO.updateCRFStatus(param);
		}
	}

	@Override
	public Map<String, Object> selectChangeReason(Map<String, Object> param) throws Exception {
		return edck02DAO.selectChangeReason(param);
	}

	@Override
	public void updateChangeReason(Map<String, Object> param) throws Exception {
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCrForm, null, null);
		edck02DAO.updateChangeReason(param);
	}

	@Override
	public List<Map<String, Object>> selectArmCodeList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectArmCodeList(param);
	}

	@Override
	public void insertArmCodeList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);

			if (iMap.get("CRUD").equals("C")) {
				iMap.put("TA_SN", edck02DAO.selectTaSn(iMap));
				edck02DAO.insertArmCode(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrTa, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrTa, null, null);
				edck02DAO.updateArmCode(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "01");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectGroupListForLayout(Map<String, Object> param) throws Exception {
		return edck02DAO.selectGroupListForLayout(param);
	}

	@Override
	public List<Map<String, Object>> selectLayoutList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectLayoutList(param);
	}

	@Override
	public List<Map<String, Object>> selectCDISCCodeList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectCDISCCodeList(param);
	}

	@Override
	public void insertLayoutList(List<Map<String, Object>> list) throws Exception {
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		}

		List<Map<String, Object>> c_list = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> iMap = list.get(i);
			if (iMap.get("CRUD").equals("C")) {
				c_list.add(iMap);
				list.remove(i);
				i--;
			}
		}

		Object sn = null;
		for (int i = 0; i < c_list.size(); i++) {
			Map<String, Object> iMap = c_list.get(i);
			System.out.println(iMap);
			Object i_set_sn = iMap.get("SET_SN");
			if (Util.isRegexStr(String.valueOf(i_set_sn), "number")) {
			} else {
				sn = edck02DAO.selectSetSn(iMap);
				iMap.put("SET_SN", sn);
				c_list.set(i, iMap);
				edck02DAO.insertSet(iMap);
				for (int j = i + 1; j < c_list.size(); j++) {
					Map<String, Object> jMap = c_list.get(j);
					if (i_set_sn.equals(jMap.get("SET_SN"))) {
						jMap.put("SET_SN", sn);
					}
					c_list.set(j, jMap);
				}
			}
		}
		for (int i = 0; i < c_list.size(); i++) {
			Map<String, Object> iMap = c_list.get(i);
			System.out.println(iMap);
			Object i_set_row_sn = iMap.get("SET_ROW_SN");
			if (Util.isRegexStr(String.valueOf(i_set_row_sn), "number")) {
			} else {
				sn = edck02DAO.selectSetRowSn(iMap);
				iMap.put("SET_ROW_SN", sn);
				c_list.set(i, iMap);
				edck02DAO.insertSetRow(iMap);
				for (int j = i + 1; j < c_list.size(); j++) {
					Map<String, Object> jMap = c_list.get(j);
					if (i_set_row_sn.equals(jMap.get("SET_ROW_SN"))) {
						jMap.put("SET_ROW_SN", sn);
					}
					c_list.set(j, jMap);
				}
			}
		}

		for (Map<String, Object> iMap : c_list) {
			Object i_set_vriabl_sn = iMap.get("SET_VRIABL_SN");
			if (Util.isRegexStr(String.valueOf(i_set_vriabl_sn), "number")) {
			} else {
				iMap.put("SET_VRIABL_SN", edck02DAO.selectSetVriablSn(iMap));
				edck02DAO.insertSetVariable(iMap);
			}
			if (iMap.get("SET_TY_CODE").equals("03")) {
				edck02DAO.insertDescription(iMap);
			}
		}

		for (Map<String, Object> iMap : list) {
			if (iMap.get("CRUD").equals("U")) {
				iMap.put("USE_AT", "Y");
			} else {
				iMap.put("USE_AT", "N");
			}
			edck02DAO.updateSetVariable(iMap);
			iMap.put("USE_AT", "Y");
			edck02DAO.updateSetRow(iMap);
			edck02DAO.updateSet(iMap);

			if (iMap.get("SET_TY_CODE").equals("03")) {
				edck02DAO.updateDescription(iMap);
			}
		}

	}

	@Override
	public Map<String, Object> selectDescription(Map<String, Object> param) throws Exception {
		if (param.get("CRUD").equals("U")) {
			return edck02DAO.selectDescription(param);
		} else {
			return param;
		}
	}

	@Override
	public List<Map<String, Object>> selectSameVariable(Map<String, Object> param) throws Exception {
		return edck02DAO.selectSameVariable(param);
	}

	@Override
	public List<Map<String, Object>> selectAllEditCheckList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck02DAO.selectAllEditCheckList(param);
	}

	@Override
	public Map<String, Object> selectEditCheckDetail(Map<String, Object> param) throws Exception {
		return edck02DAO.selectEditCheckDetail(param);
	}

	@Override
	public List<Map<String, Object>> selectDisableList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectDisableList(param);
	}

	@Override
	public Map<String, Object> selectTaskBlindPk(Map<String, Object> param) throws Exception {
		return edck02DAO.selectTaskBlindPk(param);
	}

	public void updateTaskBlindPk(Map<String, Object> param) throws Exception {
		edck02DAO.updateTaskBlindPk(param);
	}

	@Override
	public List<Map<String, Object>> selectEditSeqList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectEditSeqList(param);
	}

	@Override
	public List<Map<String, Object>> selectEditVariableList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectEditVariableList(param);
	}

	@Override
	public Object insertEditCheck(Map<String, Object> map) throws Exception {
		Object editceck_sn = null;
		Object update_id = Util.getUserMap().get("USER_ID");
		if (map.get("BASE") != null && !"".equals(map.get("BASE"))) {
			Map<String, Object> iMap = Util.makeMap(new JSONObject(String.valueOf(map.get("BASE"))));
			iMap.put("UPDATE_ID", update_id);
			System.out.println(iMap);
			if (iMap.get("CRUD").equals("C")) {
				editceck_sn = edck02DAO.selectEditCheckSn(iMap);
				iMap.put("EDITCECK_SN", editceck_sn);
				edck02DAO.insertEditCheck(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrEditceck, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrEditceck, null, null);
				edck02DAO.updateEditCheck(iMap);
			}
		}
		if (map.get("DISABLE_LIST") != null && !"".equals(map.get("DISABLE_LIST"))) {
			ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			JSONArray jsonArray = new JSONArray(String.valueOf(map.get("DISABLE_LIST")));
			for (int i = 0; i < jsonArray.length(); i++) {
				list.add(Util.makeMap(jsonArray.getJSONObject(i)));
			}
			for (Map<String, Object> iMap : list) {
				iMap.put("UPDATE_ID", update_id);
				if (iMap.get("CRUD").equals("C")) {
					if (editceck_sn != null) {
						iMap.put("EDITCECK_SN", editceck_sn);
					}
					iMap.put("INPUT_LMTT_SN", edck02DAO.selectInputLmttSn(iMap));
					edck02DAO.insertDisable(iMap);
					comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrInputlmtt, null, null);
				} else {
					if (iMap.get("CRUD").equals("U")) {
						iMap.put("USE_AT", "Y");
					} else {
						iMap.put("USE_AT", "N");
					}
					System.out.println(iMap);
					comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrInputlmtt, null, null);
					edck02DAO.updateDisable(iMap);
				}
			}
		}
		return editceck_sn;
	}

	@Override
	public List<Map<String, Object>> selectCodingList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectCodingList(param);
	}

	@Override
	public void insertCodingList(List<Map<String, Object>> list) throws Exception {
		Boolean b = true;
		Object update_id = Util.getUserMap().get("USER_ID");
		for (Map<String, Object> iMap : list) {
			iMap.put("UPDATE_ID", update_id);
			if (iMap.get("CRUD").equals("C")) {
				iMap.put("CODING_SN", edck02DAO.selectCodingSn(iMap));
				edck02DAO.insertCoding(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCrCoding, null, null);
			} else {
				if (iMap.get("CRUD").equals("U")) {
					iMap.put("USE_AT", "Y");
				} else {
					iMap.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailEdcCrCoding, null, null);
				edck02DAO.updateCoding(iMap);
			}
			if (b) {
				iMap.put("CRF_PROGRS_CODE", "11");
				edck02DAO.updateCRFStatus(iMap);
				b = false;
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectCodingVariableList(Map<String, Object> param) throws Exception {
		Object domn_se_code = param.get("DOMN_SE_CODE");
		if ("01".equals(domn_se_code)) {
			param.put("DOMN_NM", "AE");
		} else if ("02".equals(domn_se_code)) {
			param.put("DOMN_NM", "CM");
		} else {
			param.put("DOMN_NM", "MH");
		}

		return edck02DAO.selectCodingVariableList(param);
	}

	@Override
	public List<Map<String, Object>> selectDictionaryVersionList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectDictionaryVersionList(param);
	}

	@Override
	public Map<String, Object> selectTaskType(Map<String, Object> param) throws Exception {
		return edck02DAO.selectTaskType(param);
	}

	@Override
	public List<Map<String, Object>> selectAllVariableList(Map<String, Object> param) throws Exception {
		return edck02DAO.selectAllVariableList(param);
	}

	@Override
	public List<Map<String, Object>> selectVariableSECodeList(Map<String, Object> param) throws Exception {
		Map<String, Object> m = edck02DAO.selectTaskType(param);
		param.put("TASK_TY_CODE", m.get("TASK_TY_CODE"));
		param.put("BLIND_CODE", m.get("BLIND_CODE"));
		return edck02DAO.selectVariableSECodeList(param);
	}

}
