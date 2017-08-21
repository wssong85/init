package pantheon.sdb.c02.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.z06.dao.COMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.c02.dao.SDBC02DAO;
import pantheon.sdb.c02.service.MultiLangManageService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("MultiLangManageService")
public class MultiLangManageServiceImpl implements  MultiLangManageService{
	@Resource(name = "SDBC02DAO")
	private SDBC02DAO sdbc02DAO;
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "MultiLangManageService")
	private MultiLangManageService multiLangManageService;
	
	@Resource(name = "SDB_MULLANG_SEQ")
	private EgovIdGnrService sdbMullangSeq;
	

	/**
	 * 다국어 입력
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
	@Override
	public void insertMul(String code, String kor, String eng) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		Map<String, String> iMap_M = new HashMap<String, String>();
		Map<String, String> iMap_M2 = new HashMap<String, String>();
		iMap.put("MULLANG_CODE",code);
		iMap.put("KOREAN",kor);
		iMap.put("ENG",eng);
		
		sdbc02DAO.insertMul(iMap);
		
		iMap_M.put("LABEL_NM","한글");
		iMap_M.put("MODULE","SDB");
		iMap_M.put("PK_NM","다국어 코드");
		iMap_M.put("TABLE_PK","MULLANG_CODE");
		iMap_M.put("COLUMN_NM","KOREAN");
		iMap_M.put("TABLE_NM","SDB_IM_MULLANG_INFO");
		iMap_M.put("STRE_RESN_CODE","01");
		iMap_M.put("STRE_ETC_RESN","");
		iMap_M.put("UPDTBFE_VALUE","");
		iMap_M.put("AFTUPD_VALUE",kor);
		
		iMap_M2.put("LABEL_NM","영문");
		iMap_M2.put("MODULE","SDB");
		iMap_M2.put("PK_NM","다국어 코드");
		iMap_M2.put("TABLE_PK","MULLANG_CODE");
		iMap_M2.put("COLUMN_NM","ENG");
		iMap_M2.put("TABLE_NM","SDB_IM_MULLANG_INFO");
		iMap_M2.put("STRE_RESN_CODE","01");
		iMap_M2.put("STRE_ETC_RESN","");
		iMap_M2.put("UPDTBFE_VALUE","");
		iMap_M2.put("AFTUPD_VALUE",eng);
		
		comz06DAO.insertCmDtaAtrailForClob(iMap_M);
		comz06DAO.insertCmDtaAtrailForClob(iMap_M2);
//		comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailmullanginfo, null, null);
	}
	
	/**
	 * 다국어 수정
	 * @param code
	 * @param kor
	 * @param eng
	 * @throws Exception
	 */
	@Override
	public void updateMul(String code, String kor, String eng) throws Exception{
		Map<String, String> iMap = new HashMap<String, String>();
		Map<String, String> iMap_M = new HashMap<String, String>();
		Map<String, String> iMap_M2 = new HashMap<String, String>();
		Map<String, String> iMap_select = new HashMap<String, String>();
		
		iMap.put("MULLANG_CODE",code);
		iMap.put("KOREAN",kor);
		iMap.put("ENG",eng);
		
		iMap_select = sdbc02DAO.selectMulKorEng(iMap);
		
		String pre_kor = iMap_select.get("KOREAN");
		String pre_eng = iMap_select.get("ENG");
		
		//comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailmullanginfo, null, "이상사례");		
		iMap_M.put("LABEL_NM","한글");
		iMap_M.put("MODULE","SDB");
		iMap_M.put("PK_NM","다국어 코드");
		iMap_M.put("TABLE_PK","MULLANG_CODE");
		iMap_M.put("COLUMN_NM","KOREAN");
		iMap_M.put("TABLE_NM","SDB_IM_MULLANG_INFO");
		iMap_M.put("STRE_RESN_CODE","04");
		iMap_M.put("STRE_ETC_RESN","");
		iMap_M.put("UPDTBFE_VALUE",pre_kor);
		iMap_M.put("AFTUPD_VALUE",kor);
		
		iMap_M2.put("LABEL_NM","영문");
		iMap_M2.put("MODULE","SDB");
		iMap_M2.put("PK_NM","다국어 코드");
		iMap_M2.put("TABLE_PK","MULLANG_CODE");
		iMap_M2.put("COLUMN_NM","ENG");
		iMap_M2.put("TABLE_NM","SDB_IM_MULLANG_INFO");
		iMap_M2.put("STRE_RESN_CODE","04");
		iMap_M2.put("STRE_ETC_RESN","");
		iMap_M2.put("UPDTBFE_VALUE",pre_eng);
		iMap_M2.put("AFTUPD_VALUE",eng);
		
		comz06DAO.insertCmDtaAtrailForClob(iMap_M);
		comz06DAO.insertCmDtaAtrailForClob(iMap_M2);
		
		sdbc02DAO.updateMul(iMap);
		
	}
	
	
	@Override
	public void mullangInsert (String kor, String eng, String colName,  Map<String, String> iMap) throws Exception{
		if((kor != null && !"".equals(kor)) || (eng != null && !"".equals(eng))){
			String MullangSeq = sdbMullangSeq.getNextStringId();
			multiLangManageService.insertMul(MullangSeq, kor, eng);
			iMap.put(colName, MullangSeq);
		}
	}
	@Override
	public void mullangUpdate (String code, String kor, String eng, String colName,  Map<String, String> iMap) throws Exception{
		if(code == null || "".equals(code)){
			String MullangSeq = sdbMullangSeq.getNextStringId();
			multiLangManageService.insertMul(MullangSeq, kor, eng);
			iMap.put(colName, MullangSeq);
		}
		else if((kor != null && !"".equals(kor)) || (eng != null && !"".equals(eng))|| (code != null && !"".equals(code))){
			multiLangManageService.updateMul(code, kor, eng);
		}
	}
}
