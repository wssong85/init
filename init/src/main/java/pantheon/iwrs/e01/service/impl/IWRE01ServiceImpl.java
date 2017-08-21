package pantheon.iwrs.e01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.iwrs.c01.dao.IWRC01DAO;
import pantheon.iwrs.e01.dao.IWRE01DAO;
import pantheon.iwrs.e01.service.IWRE01Service;
import pantheon.iwrs.f01.service.IWRF01Service;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("IWRE01Service")
public class IWRE01ServiceImpl implements IWRE01Service {
	@Resource(name = "IWRE01DAO")
	private IWRE01DAO iwre01Dao;
	
	@Resource(name = "IWRF01Service")
	private IWRF01Service iwrf01Service;
	
	@Resource(name = "IWRC01DAO")
	private IWRC01DAO iwrc01Dao;
	
	@Resource(name = "IWRS_SJ_RTUNMANAGE_INFO")
	private EgovPropertyService iwrsSjRtunmanageInfo;
	
	@Resource(name = "IWRS_IP_IP_CODE_INFO")
	private EgovPropertyService iwrsIpIpCodeInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

	@Override
	public List<Map<String, String>> selectVisitLabel(Map<String, String> param) throws Exception {
		return iwre01Dao.selectVisitLabel(param);
	}

	@Override
	public List<Map<String, String>> selectDispenseList(Map<String, String> param) throws Exception {
		String mainCol = "";
		String joinTable = "";
		int ch = 65;
		int i = 0;
		List<Map<String, String>> visitList = iwre01Dao.selectVisitLabel(param);
		String locale = Util.getStrLocale();
		for(Map<String, String> visit : visitList){
			if(i != 0){
				ch = ch + 1;
				joinTable += "LEFT JOIN ";
			}
			joinTable += "(SELECT A.DLVYMANAGE_CODE ";
			joinTable += ",A.SN ";
			joinTable += ",A.INVNTRYMANAGE_CODE ";
			joinTable += ",A.INSTT_CODE ";
			joinTable += ",A.SUBJECT_CODE ";
			joinTable += ",A.IP_CODE ";
			joinTable += ",A.VISIT_CODE ";
			joinTable += ",TO_CHAR(A.RTUN_DT, 'YYYYMMDDHH24MISS') RTUN_DT ";
			joinTable += ",TO_CHAR(A.RTURN_DT, 'YYYYMMDDHH24MISS') RTURN_DT ";
			joinTable += ",FN_GET_COMMONCODE('IWRS009', A.IP_STTUS_CODE, '" + locale + "') IP_STTUS_CODE ";
			joinTable += ",DECODE(A.RTUN_RTURN_CNFIRM_AT, 'Y', '확인', '미확인') RTUN_RTURN_CNFIRM_AT ";
			joinTable += ",B.TASK_CODE ";
			joinTable += "FROM IWRS_SJ_RTUNMANAGE A ";
			joinTable += "INNER JOIN IWRS_DS_INVNTRYMANAGE_DETAIL B ";
			joinTable += "ON A.DLVYMANAGE_CODE = B.DLVYMANAGE_CODE ";
			joinTable += "AND A.SN = B.SN ";
			joinTable += "AND A.INVNTRYMANAGE_CODE = B.INVNTRYMANAGE_CODE ";
			joinTable += "AND B.TASK_CODE = '" + param.get("TASK_CODE") + "' ";
			joinTable += "WHERE A.VISIT_CODE = '" + String.valueOf(visit.get("VISIT_SN")) + "') " + (char)ch + " ";
			if(i != 0){
				joinTable += "ON A.DLVYMANAGE_CODE = " + (char)ch + ".DLVYMANAGE_CODE ";
				joinTable += "AND A.INVNTRYMANAGE_CODE = " + (char)ch + ".INVNTRYMANAGE_CODE ";
				joinTable += "AND " + (char)ch + ".VISIT_CODE = '" + String.valueOf(visit.get("VISIT_SN")) + "' ";
			}
			mainCol += "," + (char)ch + ".IP_CODE IP_CODE_" + visit.get("VISIT_LBL") + " ";
			mainCol += "," + (char)ch + ".VISIT_CODE VISIT_CODE_" + visit.get("VISIT_LBL") + " ";
			mainCol += "," + (char)ch + ".RTUN_DT RTUN_DT_" + visit.get("VISIT_LBL") + " ";
			mainCol += "," + (char)ch + ".RTURN_DT RTURN_DT_" + visit.get("VISIT_LBL") + " ";
			mainCol += "," + (char)ch + ".IP_STTUS_CODE IP_STTUS_CODE_" + visit.get("VISIT_LBL") + " ";
			mainCol += "," + (char)ch + ".RTUN_RTURN_CNFIRM_AT RTUN_RTURN_CNFIRM_AT_" + visit.get("VISIT_LBL") + " ";
			i++;
		}
		param.put("maincol", mainCol);
		param.put("jointable", joinTable);
		
		return iwre01Dao.selectDispenseList(param);
	}

	@Override
	public int selectDispenseCnt(Map<String, String> param) throws Exception {
		String joinTable = "";
		int ch = 65;
		int i = 0;
		List<Map<String, String>> visitList = iwre01Dao.selectVisitLabel(param);
		System.err.println(visitList);
		for(Map<String, String> visit : visitList){
			if(i != 0){
				ch = ch + 1;
				joinTable += "LEFT JOIN ";
			}
			joinTable += "(SELECT A.DLVYMANAGE_CODE ";
			joinTable += ",A.SN ";
			joinTable += ",A.INVNTRYMANAGE_CODE ";
			joinTable += ",A.INSTT_CODE ";
			joinTable += ",A.SUBJECT_CODE ";
			joinTable += ",A.IP_CODE ";
			joinTable += ",A.VISIT_CODE ";
			joinTable += ",A.RTUN_DT ";
			joinTable += ",A.RTURN_DT ";
			joinTable += ",A.IP_STTUS_CODE ";
			joinTable += ",A.RTUN_RTURN_CNFIRM_AT ";
			joinTable += "FROM IWRS_SJ_RTUNMANAGE A ";
			joinTable += "INNER JOIN IWRS_DS_INVNTRYMANAGE_DETAIL B ";
			joinTable += "ON A.DLVYMANAGE_CODE = B.DLVYMANAGE_CODE ";
			joinTable += "AND A.SN = B.SN ";
			joinTable += "AND A.INVNTRYMANAGE_CODE = B.INVNTRYMANAGE_CODE ";
			joinTable += "AND B.TASK_CODE = '" + param.get("TASK_CODE") + "' ";
			joinTable += "WHERE A.VISIT_CODE = '" + String.valueOf(visit.get("VISIT_SN")) + "') " + (char)ch + " ";
			if(i != 0){
				joinTable += "ON A.DLVYMANAGE_CODE = " + (char)ch + ".DLVYMANAGE_CODE ";
				joinTable += "AND A.SN = " + (char)ch + ".SN ";
				joinTable += "AND A.INVNTRYMANAGE_CODE = " + (char)ch + ".INVNTRYMANAGE_CODE ";
				joinTable += "AND " + (char)ch + ".VISIT_CODE = '" + String.valueOf(visit.get("VISIT_SN")) + "' ";
			}
			i++;
		}
		param.put("jointable", joinTable);
		
		return iwre01Dao.selectDispenseCnt(param);
	}
	
	@Override
	public List<Map<String, String>> selectSubjectList(Map<String, String> param) throws Exception{
		return iwre01Dao.selectSubjectList(param);
	}
	
	@Override
	public List<Map<String, String>> selectDispenseListForSubject(Map<String, String> param) throws Exception{
		return iwre01Dao.selectDispenseListForSubject(param);
	}
	
	@Override
	public List<Map<String, String>> selectDispenseForView(Map<String, String> param) throws Exception{
		return iwre01Dao.selectDispenseForView(param);
	}

	@Override
	public List<Map<String, String>> selectDispenseReturnInfo(Map<String, String> param) throws Exception {
		return iwre01Dao.selectDispenseReturnInfo(param);
	}

	@Override
	public void insertDispenseInfo(Map<String, String> param) throws Exception {
		iwre01Dao.insertDispenseInfo(param);
		comz06Service.createCmDtaAtrailForInsertByString(param, iwrsSjRtunmanageInfo, null, "불출 정보 등록");
	}

	@Override
	public void updateDispenseInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("param"));
		
		for(int i = 0; i < array.length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("RTUN_QTT", array.getJSONObject(i).getString("RTUN_QTT"));
			map.put("RTUN_DT", array.getJSONObject(i).getString("RTUN_DT").replace("-", ""));
			map.put("IP_STTUS_CODE", "03");
			map.put("RTUNMAN_ID", array.getJSONObject(0).getString("RTUNMAN_ID"));
			map.put("RTUN_COMMENT", array.getJSONObject(i).getString("RTUN_COMMENT"));
			map.put("USER_ID", array.getJSONObject(i).getString("USER_ID"));
			map.put("RTUN_NO", array.getJSONObject(i).getString("RTUN_NO"));
			map.put("IP_CODE", array.getJSONObject(i).getString("IP_CODE"));
			map.put("DLVYMANAGE_CODE", array.getJSONObject(i).getString("DLVYMANAGE_CODE"));
			map.put("SN", array.getJSONObject(i).getString("SN"));
			map.put("INVNTRYMANAGE_CODE", array.getJSONObject(i).getString("INVNTRYMANAGE_CODE"));
			map.put("SUBJECT_CODE", array.getJSONObject(i).getString("SUBJECT_CODE"));
			map.put("VISIT_CODE", array.getJSONObject(i).getString("VISIT_CODE"));
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsSjRtunmanageInfo, null, "불출 정보 수정");
			iwre01Dao.updateDispenseInfo(map);
		}
	}
	
	@Override
	public void updateReturnInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("param"));
		
		for(int i = 0; i < array.length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("RTURN_QTT", array.getJSONObject(i).getString("RTURN_QTT"));
			map.put("TAKNG_QTT", array.getJSONObject(i).getString("TAKNG_QTT"));
			map.put("RTURN_DT", array.getJSONObject(i).getString("RTURN_DT").replace("-", ""));
			map.put("IP_STTUS_CODE", "05");
			map.put("RTNPSN_ID", array.getJSONObject(0).getString("RTNPSN_ID"));
			map.put("RTURN_COMMENT", array.getJSONObject(i).getString("RTURN_COMMENT"));
			map.put("USER_ID", array.getJSONObject(i).getString("USER_ID"));
			map.put("RTUN_NO", array.getJSONObject(i).getString("RTUN_NO"));
			map.put("IP_CODE", array.getJSONObject(i).getString("IP_CODE"));
			map.put("DLVYMANAGE_CODE", array.getJSONObject(i).getString("DLVYMANAGE_CODE"));
			map.put("SN", array.getJSONObject(i).getString("SN"));
			map.put("INVNTRYMANAGE_CODE", array.getJSONObject(i).getString("INVNTRYMANAGE_CODE"));
			map.put("SUBJECT_CODE", array.getJSONObject(i).getString("SUBJECT_CODE"));
			map.put("VISIT_CODE", array.getJSONObject(i).getString("VISIT_CODE"));
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsSjRtunmanageInfo, null, "반납 정보 등록/수정");
			iwre01Dao.updateReturnInfo(map);
		}
	}
	
	@Override
	public void updateConfirmInfo(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("param"));
		
		for(int i = 0; i < array.length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("RTUN_RTURN_CNFRMR_ID", array.getJSONObject(i).getString("RTUN_RTURN_CNFRMR_ID"));
			map.put("RTUN_RTURN_CNFIRM_AT", "Y");
			map.put("USER_ID", array.getJSONObject(i).getString("USER_ID"));
			map.put("RTUN_NO", array.getJSONObject(i).getString("RTUN_NO"));
			map.put("IP_CODE", array.getJSONObject(i).getString("IP_CODE"));
			map.put("DLVYMANAGE_CODE", array.getJSONObject(i).getString("DLVYMANAGE_CODE"));
			map.put("SN", array.getJSONObject(i).getString("SN"));
			map.put("INVNTRYMANAGE_CODE", array.getJSONObject(i).getString("INVNTRYMANAGE_CODE"));
			map.put("SUBJECT_CODE", array.getJSONObject(i).getString("SUBJECT_CODE"));
			map.put("VISIT_CODE", array.getJSONObject(i).getString("VISIT_CODE"));
			comz06Service.createCmDtaAtrailForUpdateByString(map, iwrsSjRtunmanageInfo, null, "불출/반납 정보 확인");
			iwre01Dao.updateConfirmInfo(map);
		}
	}
	
	@Override
	public void updateErrorInfo(Map<String, String> param) throws Exception{
		iwre01Dao.updateErrorInfo(param);
		List<Map<String, String>> list = iwre01Dao.selectIpInfo(param);
		param.put("CREAT_CODE", list.get(0).get("CREAT_CODE"));
		param.put("IP_TYPE", list.get(0).get("IP_TYPE"));
		comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsIpIpCodeInfo, null, "IP 에러 등록");
		iwrc01Dao.updateIpErrorInfo(param);
	}
	
	@Override
	public void insertQuery(Map<String, String> param) throws Exception{
		String seq = iwre01Dao.selectQuerySeq(param);
		param.put("QUERY_SN", seq);
		param.put("QUERY_GROUP", seq);
//		iwre01Dao.insertQueryMaster(param);
//		iwre01Dao.insertQueryDetail(param);
		iwre01Dao.insertQueryInfo(param);
		iwre01Dao.insertRtunQuery(param);
	}
	
	@Override
	public void updateQuery(Map<String, String> param) throws Exception{
		String detailSeq = iwre01Dao.selectQueryDetailCode(param);
		param.put("QUERY_DETAIL_CODE", detailSeq);
		iwre01Dao.updateQueryMaster(param);
		iwre01Dao.insertQueryDetail(param);
	}
	
	@Override
	public List<Map<String, String>> selectQueryInfo(Map<String, String> param) throws Exception{
		return iwre01Dao.selectQueryInfo(param);
	}
	
	@Override
	public void updateEndQuery(Map<String, String> param) throws Exception{
		String[] strQuerySn = param.get("QUERY_NO").split(",");
		for(String str : strQuerySn){
			Map<String, String> map = new HashMap<String, String>();
			map.put("QUERY_SN", str);
			List<Map<String, String>> list = iwrf01Service.selectQueryInfo(map);
//			System.err.println(map);
			String seq = iwre01Dao.selectQuerySeq(param);
			map.put("QUERY_SN", seq);			
			map.put("END_AT", "Y");
			map.put("RESN", param.get("RESN"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("QUERY_GROUP", String.valueOf(list.get(0).get("QUERY_GROUP")));
			map.put("QUERY_CN", list.get(0).get("QUERY_CN"));
			map.put("RTUN_NO", String.valueOf(list.get(0).get("RTUN_NO")));
			map.put("DLVY_SE_CODE", list.get(0).get("DLVY_SE_CODE"));
			map.put("QUERY_SE_CODE", list.get(0).get("QUERY_SE_CODE"));
			map.put("MODULE_CODE", "IWR");
			map.put("QUERY_TY_CODE", list.get(0).get("QUERY_TY_CODE"));
			map.put("QUERY_STTUS_CODE", param.get("QUERY_STTUS_CODE"));
			map.put("USE_AT", "Y");

			iwre01Dao.insertQueryInfo(map);
			iwre01Dao.insertRtunQuery(map);
			iwre01Dao.updateEndQueryInfo(map);
		}
	}
	
	@Override
	public void insertEndQueryInfo(Map<String, String> param) throws Exception{
		String seq = iwre01Dao.selectQuerySeq(param);
		param.put("QUERY_SN", seq);
		iwre01Dao.insertQueryInfo(param);
		iwre01Dao.insertRtunQuery(param);
		iwre01Dao.updateEndQueryInfo(param);
		if("02".equals(param.get("QUERY_END_TYPE"))){
			seq = iwre01Dao.selectQuerySeq(param);
			param.put("QUERY_SN", seq);
			param.put("QUERY_GROUP", seq);
			param.put("QUERY_CN", param.get("RESN"));
			param.put("RESN", "Manual Query Issue");
			param.put("QUERY_STTUS_CODE", "01");
			param.put("END_AT", "N");
			iwre01Dao.insertQueryInfo(param);
			iwre01Dao.insertRtunQuery(param);
		}
	}
	
	@Override
	public void insertAnswerQueryInfo(Map<String, String> param) throws Exception{
		String seq = iwre01Dao.selectQuerySeq(param);
		param.put("QUERY_SN", seq);
		iwre01Dao.insertQueryInfo(param);
		iwre01Dao.insertRtunQuery(param);
	}
}
