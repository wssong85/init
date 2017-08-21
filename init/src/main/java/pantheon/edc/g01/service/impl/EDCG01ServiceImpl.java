package pantheon.edc.g01.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.g01.dao.EDCG01DAO;
import pantheon.edc.g01.service.EDCG01Service;


@Service("EDCG01Service")
public class EDCG01ServiceImpl implements EDCG01Service{

	@Resource(name = "EDCG01DAO")
	EDCG01DAO EDCG01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_CF_VRIABL")
	protected EgovPropertyService atrailEdcCfVriablRole;
	
	@Resource(name = "ATRAIL_EDC_CF_QUERY")
	protected EgovPropertyService atrailEdcCfQueryRole;
	
	@Resource(name = "ATRAIL_CM_QUERY")
	protected EgovPropertyService atrailCmQueryRole;
	
	@Resource(name = "CM_QUERY_SEQ")
	private EgovIdGnrService cmQuerySeq;
	
	public List<Map<String, Object>> selectCsList(Map<String, Object> param) throws Exception{
		String edcVer = EDCG01DAO.selectEdcVer(param);
		param.put("EDC_VER", edcVer);
		return (List<Map<String, Object>>)EDCG01DAO.selectCsList(param);
	}
	
	public void updateEdcCfVriablByPvCraCnfirmCode(Map<String, Object> param) throws Exception{
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfVriablRole, null, null);
		EDCG01DAO.updateEdcCfVriablByPvCraCnfirmCode(param);
	}
	
	public List<Map<String, Object>> selectDicaryInfo(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsltList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> rsltTableInfo = EDCG01DAO.selectTableInfo(param);
		String tableName = "";
		String colNmList = "";
		String colNm = "";
		
		for(Map<String, Object> iMap : rsltTableInfo) {
			tableName = (String)iMap.get("TABLE_NAME");
			colNmList += iMap.get("COLUMN_NAME")+",";
			colNm += iMap.get("COLUMN_NAME")+"' AS "+iMap.get("COLUMN_NAME")+", '";
		}
		
		param.put("TABLE_NAME", tableName);
		param.put("TABLE_PK", tableName.substring(7)+"_SN");
		param.put("COLUMN_NAME1", "'"+colNm.substring(0, colNm.length()-3));
		param.put("COLUMN_NAME2", colNmList.substring(0, colNmList.length()-1));
		param.put("GBN_NM", "연구자");
		return (List<Map<String, Object>>) EDCG01DAO.selectDicaryInfo(param);
	}
	
	public void insertCmQueryByCra(Map<String, Object> param) throws Exception{
		//comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfVriablRole, null, null);
		param.put("QUERY_SN", cmQuerySeq.getNextStringId());
		EDCG01DAO.insertEdcCfQueryByCra(param);
		comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfQueryRole, null, null);
		EDCG01DAO.insertCmQueryByCra(param);
		comz06Service.createCmDtaAtrailForInsertByObject(param, atrailCmQueryRole, null, null);
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfVriablRole, null, null);
		EDCG01DAO.updateEdcCfVriablByPvCraCnfirmCode(param);
	}
	
	public List<Map<String, Object>> selectDistinctAbnRctList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)EDCG01DAO.selectDistinctAbnRctList(param);
	}
	
	public List<Map<String, Object>> selectDistinctDAbnRct(Map<String, Object> param) throws Exception{
		String edcVer = EDCG01DAO.selectEdcVer(param);
		param.put("EDC_VER", edcVer);
		return (List<Map<String, Object>>) EDCG01DAO.selectDistinctDAbnRct(param);
	}
}
