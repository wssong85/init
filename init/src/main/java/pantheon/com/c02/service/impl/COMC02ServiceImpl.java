package pantheon.com.c02.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.excel.EgovExcelService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.c02.dao.COMC02DAO;
import pantheon.com.c02.service.COMC02Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;

@Service("COMC02Service")
public class COMC02ServiceImpl implements COMC02Service{

	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
	@Resource(name = "COMC02DAO")
	private COMC02DAO comc02DAO;
	
	@Resource(name = "EDC_CR_ATC_SEQ")
	private EgovIdGnrService edcCrAtcSeq;
	
	@Resource(name = "EDC_CR_WHOART_SEQ")
	private EgovIdGnrService edcCrWhoartSeq;
	
	@Resource(name = "EDC_CR_MEDDRA_SEQ")
	private EgovIdGnrService edcCrMeddraSeq;
	
	@Resource(name = "EDC_CR_KIMS_SEQ")
	private EgovIdGnrService edcCrKimsSeq;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public Map<String, Object> selectAtcListByExcel(HttpServletRequest request) throws Exception {
		
		String strTmpPath = comz02Service.uploadFile(request);
		
		Workbook hssfWB = null; 
				
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.1"));
		}

		if (hssfWB.getNumberOfSheets() != 1) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}

		List<Map<String, String>> listTmpAtc = null;
		List<Map<String, String>> listAtc = new ArrayList<Map<String, String>>();
		Map<String, String> mapAtc = null;
		
		String[] arrStrAtc = {
				"ATCCode",
				"Name",
				"Commnet"
		};
		
		listTmpAtc = Util.getListForExcelSheet(hssfWB.getSheetAt(0), arrStrAtc, 1);
		
		for(Map<String, String> iMap : listTmpAtc) {
			if(iMap.get("ATCCode").length() == 7) {
				
				mapAtc = new HashMap<String, String>();
				mapAtc.put("ATC_CODE", iMap.get("ATCCode"));
				mapAtc.put("FIVE_T_LVL", iMap.get("Name"));
				mapAtc.put("CURD", "C");
				
				for(Map<String, String> jMap : listTmpAtc) {
					if(iMap.get("ATCCode").substring(0, 5).equals(jMap.get("ATCCode"))) {
						mapAtc.put("FOUR_T_LVL", jMap.get("Name"));
					}
				}
				
				for(Map<String, String> jMap : listTmpAtc) {
					if(iMap.get("ATCCode").substring(0, 4).equals(jMap.get("ATCCode"))) {
						mapAtc.put("THREE_T_LVL", jMap.get("Name"));
					}
				}
				
				for(Map<String, String> jMap : listTmpAtc) {
					if(iMap.get("ATCCode").substring(0, 3).equals(jMap.get("ATCCode"))) {
						mapAtc.put("TWO_T_LVL", jMap.get("Name"));
					}
				}
				
				for(Map<String, String> jMap : listTmpAtc) {
					if(iMap.get("ATCCode").substring(0, 1).equals(jMap.get("ATCCode"))) {
						mapAtc.put("ONE_T_LVL", jMap.get("Name"));
					}
				}
				listAtc.add(mapAtc);
			}
		}
		
		comz02Service.deleteFile(strTmpPath);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("FIVE_T_LVL", 200);
		map.put("FOUR_T_LVL", 200);
		map.put("THREE_T_LVL", 200);
		map.put("TWO_T_LVL", 200);
		map.put("ONE_T_LVL", 200);
		map.put("ATC_CODE", 10);
		
		return Util.getListForByteCheck(listAtc, map);
	}

	@Override
	public void insertEdcCrAtcByExcelList(List<Map<String, Object>> list) throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strDicaryVer = "";
		
		for(Map<String, Object> iMap : list) {
			
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			
			if("M".equals(iMap.get("CURD"))) {
				
				iMap.put("DICARY_SE_CODE", "02");
				strDicaryVer = EgovStringUtil.isNullToString(iMap.get("DICARY_VER"));
				
				comc02DAO.insertEdcCrMdicForExcelList(iMap);
				
			}
		}
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CURD"))) {
				
				iMap.put("ATC_SN", edcCrAtcSeq.getNextStringId());
				iMap.put("DICARY_VER", strDicaryVer);
				
				comc02DAO.insertEdcCrAtcByExcelList(iMap);
			} 
			
		}
		
	}
	
	@Override
	public List<Map<String, Object>> selectEdcCrAtcByDicaryVer(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrAtcByDicaryVer(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> selectWhoartListByExcel(HttpServletRequest request) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int count = 0;
		String strTmpPath = comz02Service.uploadFile(request);
		List<Map<String, String>> listWhoart = null;
		Workbook hssfWB = null;
		
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.1"));
		}


		if (hssfWB.getNumberOfSheets() != 1) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}
		
		String[] arrStrWhoart = {
				"KOREAN_NM"
				,"ENG_NM"
				,"ARRN_CODE"
		};
		
		listWhoart = Util.getListForExcelSheet(hssfWB.getSheetAt(0), arrStrWhoart, 1);
		
		comz02Service.deleteFile(strTmpPath);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("KOREAN_NM", 200);
		map.put("ENG_NM", 200);
		map.put("ARRN_CODE", 200);
		
		Map<String, Object> mapByteCheck = Util.getListForByteCheck(listWhoart, map);
		Map<String, Object> mapNullCheck = Util.getListForNullCheck((List<Map<String, String>>) mapByteCheck.get("list"), arrStrWhoart);
		
		count += (Integer) mapByteCheck.get("count");
		count += (Integer) mapNullCheck.get("count");
		
		List<Map<String, String>> resultList = (List<Map<String, String>>) mapNullCheck.get("list");
		
		for(Map<String, String> iMap : resultList) {
			iMap.put("CURD", "C");
		}
		
		result.put("list", resultList);
		result.put("count", count);
		
		comz02Service.deleteFile(strTmpPath);
		
		return result;
	}
	
	@Override
	public void insertEdcCrWhoartByExcelList(List<Map<String, Object>> list)throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strDicaryVer = "";
		
		for(Map<String, Object> iMap : list) {
			
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			
			if("M".equals(iMap.get("CURD"))) {
				
				iMap.put("DICARY_SE_CODE", "03");
				strDicaryVer = EgovStringUtil.isNullToString(iMap.get("DICARY_VER"));
				
				comc02DAO.insertEdcCrMdicForExcelList(iMap);
				
			}
		}
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CURD"))) {
				
				iMap.put("WHOART_SN", edcCrWhoartSeq.getNextStringId());
				iMap.put("DICARY_VER", strDicaryVer);
				
				comc02DAO.insertEdcCrWhoartByExcelList(iMap);
			} 
			
		}

	}

	@Override
	public List<Map<String, Object>> selectEdcCrWhoartByDicaryVer(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrWhoartByDicaryVer(map);
	}

	@Override
	public Map<String, Object> selectMeddraListByExcel(HttpServletRequest request) throws Exception {
		
		String strTmpPath = comz02Service.uploadFile(request);
		
		Workbook hssfWB = null;
		Sheet iSheet = null;
		
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.1"));
		}
		
		if (hssfWB.getNumberOfSheets() != 4) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}
		
		List<Map<String, String>> listSocSheet = null;
		List<Map<String, String>> listHlgtSheet = null;
		List<Map<String, String>> listHltSheet = null;
		List<Map<String, String>> listPtSheet = null;
		
		String[] arrSoc = {
			"SOC",
			"SOC_Code",
			"HLGT_CODE",
			"HLGT"
		};
		
		String[] arrHlgt = {
			"HLGT",
			"HLGT_CODE",
			"HLT_CODE",
			"HLT"		
		};
		
		String[] arrHlt = {
			"HLT"
			,"HLT_CODE"
			,"PT_CODE"
			,"PT"		
		};
		
		String[] arrPt = {
			"PT"
			,"PT_CODE"
			,"LLT_CODE"
			,"LLT"		
		};
		
		for(int i = 0; i < hssfWB.getNumberOfSheets(); i++) {
			
			iSheet = hssfWB.getSheetAt(i);
			
			if(i == 0) {
				listSocSheet = Util.setTrimByListString(Util.getListForExcelSheet(iSheet, arrSoc, 1));
			} else if(i == 1) {
				listHlgtSheet = Util.setTrimByListString(Util.getListForExcelSheet(iSheet, arrHlgt, 1));
			} else if(i == 2) {
				listHltSheet = Util.setTrimByListString(Util.getListForExcelSheet(iSheet, arrHlt, 1));
			} else if(i == 3) {
				listPtSheet = Util.setTrimByListString(Util.getListForExcelSheet(iSheet, arrPt, 1));
			}
			
		}
		
		int ptSize = listPtSheet.size();
		int hltSize = listHltSheet.size();
		int hlgtSize = listHlgtSheet.size();
		int socSize = listSocSheet.size();
		
		for(int i = 0; i < ptSize; i++) {
			
			for(int j = 0; j < hltSize; j++) {
				
				if(listPtSheet.get(i).get("PT_CODE").equals(listHltSheet.get(j).get("PT_CODE"))) {
					listPtSheet.get(i).put("HLT_CODE", listHltSheet.get(j).get("HLT_CODE"));
					listPtSheet.get(i).put("HLT", listHltSheet.get(j).get("HLT"));
				}
				
			}
			
		}
		
		for(int i = 0; i < ptSize; i++) {
			
			for(int j = 0; j < hlgtSize; j++) {
				
				if(listPtSheet.get(i).get("HLT_CODE").equals(listHlgtSheet.get(j).get("HLT_CODE"))) {
					listPtSheet.get(i).put("HLGT_CODE", listHlgtSheet.get(j).get("HLGT_CODE"));
					listPtSheet.get(i).put("HLGT", listHlgtSheet.get(j).get("HLGT"));
				}
				
			}
			
		}
		
		for(int i = 0; i < ptSize; i++) {
			
			for(int j = 0; j < socSize; j++) {
				
				if(listPtSheet.get(i).get("HLGT_CODE").equals(listSocSheet.get(j).get("HLGT_CODE"))) {
					listPtSheet.get(i).put("SOC", listSocSheet.get(j).get("SOC"));
				}
				
			}
			
		}
		
		for(Map<String, String> iMap : listPtSheet) {
			iMap.put("CURD", "C");
		}
		
		comz02Service.deleteFile(strTmpPath);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("LLT", 200);
		map.put("PT", 200);
		map.put("SOC", 200);
		map.put("HLT", 200);
		map.put("HLGT", 200);
		map.put("LLT_CODE", 12);
		
		return Util.getListForByteCheck(listPtSheet, map);
	}

	@Override
	public void insertEdcCrMeddraByExcelList(List<Map<String, Object>> list) throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strDicaryVer = "";
		
		for(Map<String, Object> iMap : list) {
			
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			
			if("M".equals(iMap.get("CURD"))) {
				
				iMap.put("DICARY_SE_CODE", "01");
				strDicaryVer = EgovStringUtil.isNullToString(iMap.get("DICARY_VER"));
				
				comc02DAO.insertEdcCrMdicForExcelList(iMap);
				
			}
			
		}
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CURD"))) {
				
				iMap.put("MEDDRA_SN", edcCrMeddraSeq.getNextStringId());
				iMap.put("DICARY_VER", strDicaryVer);
				
				comc02DAO.insertEdcCrMeddraByExcellList(iMap);
			} 
			
		}
		
	}

	@Override
	public List<Map<String, Object>> selectEdcCrMeddraByPk(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrMeddraByPk(map);
	}

	@Override
	public List<Map<String, Object>> selectEdcCrKimsByPk(Map<String, String> map)throws Exception {
		return comc02DAO.selectEdcCrKimsByPk(map);
	}

	@Override
	public void insertEdcCrKimsByExcelList(List<Map<String, Object>> list)throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strDicaryVer = "";
		
		for(Map<String, Object> iMap : list) {
			
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			
			if("M".equals(iMap.get("CURD"))) {
				
				iMap.put("DICARY_SE_CODE", "04");
				strDicaryVer = EgovStringUtil.isNullToString(iMap.get("DICARY_VER"));
				
				comc02DAO.insertEdcCrMdicForExcelList(iMap);
				
			}
			
		}
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CURD"))) {
				
				iMap.put("KIMS_SN", edcCrKimsSeq.getNextStringId());
				iMap.put("DICARY_VER", strDicaryVer);
				
				comc02DAO.insertEdcCrKimsByExcelList(iMap);
			} 
			
		}

	}

	@Override
	public Map<String, Object> selectKimsListByExcel(HttpServletRequest request) throws Exception {
		String strTmpPath = comz02Service.uploadFile(request);
		
		List<Map<String, String>> listKims = null;
		
		Workbook hssfWB = null;
		
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.1"));
		}
		
		if (hssfWB.getNumberOfSheets() != 1) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}
		
		String[] arrKims = {
				"GOODS_NM"
				,"GOODS_ENG"
				,"SLE_CMPNY"
				,"SLE_CMPNY_ENG"
				,"ATC_CODE"
				,"ATC_NM"
		};

		listKims = Util.getListForExcelSheet(hssfWB.getSheetAt(0), arrKims, 1);
		
		for(Map<String, String> iMap : listKims) {
			iMap.put("CURD", "C");
		}
		
		comz02Service.deleteFile(strTmpPath);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("GOODS_NM", 200);
		map.put("GOODS_ENG", 200);
		map.put("SLE_CMPNY", 200);
		map.put("SLE_CMPNY_ENG", 200);
		map.put("ATC_CODE", 10);
		map.put("ATC_NM", 200);
		
		return Util.getListForByteCheck(listKims, map);
	}

	@Override
	public int selectEdcCrKimsCountByPk(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrKimsCountByPk(map);
	}

	@Override
	public int selectEdcCrMeddraCountByPk(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrMeddraCountByPk(map);
	}

	@Override
	public int selectEdcCrWhoartCountByDicaryVer(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrWhoartCountByDicaryVer(map);
	}

	@Override
	public int selectEdcCrAtcCountByDicaryVer(Map<String, String> map) throws Exception {
		return comc02DAO.selectEdcCrAtcCountByDicaryVer(map);
	}

}