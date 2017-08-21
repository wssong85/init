package pantheon.com.c01.service.impl;

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
import pantheon.com.c01.dao.COMC01DAO;
import pantheon.com.c01.service.COMC01Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;

@Service("COMC01Service")
public class COMC01ServiceImpl implements COMC01Service{

	@Resource(name = "COMC01DAO")
	private COMC01DAO comc01DAO;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
	@Resource(name = "CDISC_DOMN_SEQ")
	private EgovIdGnrService cdiscDomnSeq;
	
	@Resource(name = "CDISC_DOMN_VRIABL_SEQ")
	private EgovIdGnrService cdiscDomnVriablSeq;
	
	@Resource(name = "CDISC_CL_CODE_SEQ")
	private EgovIdGnrService cdiscClCodeSeq;
	
	@Resource(name = "CDISC_RULE_SEQ")
	private EgovIdGnrService cdiscRuleSeq;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public Map<String, Object> selectExcellForCdisc(HttpServletRequest request) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		String strTmpPath = comz02Service.uploadFile(request);
		
		Workbook hssfWB = null;
		
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.2"));
		}
		
		Sheet iSheet = null;
		
		if (hssfWB.getNumberOfSheets() != 3) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}
		
		//CDISC_DOMN
		//domain,Dataset,Description,Class,Structure,Purpose,Keys,Location
		String[] arrDomain = {
				"DOMN_NM", 
				"DOMN_DC", 
				"DOMN_CLASS", 
				"DOMN_STRCT", 
				"DOMN_PURPS", 
				"DOMN_KEYS", 
				"DOMN_LOCATION"
		};
		
		//CDISC_DOMN_VRIABL
		//Domain Name,OrderNum,Variable Name,Variable Label,Type,Controlled Terms,CRF LABEL1,CRF LABEL2,Role,CDISC Notes,Core
		// 기준 업데이트		
		//CDISC_UPPER_CODE = CDISC_CL_CODE.CDISC_UPPER_CODE (update)
		//Controlled Terms
		String[] arrVariable = {
				"CDISC_DOMN.DOMN_NM", 
				"LBL_ORDR", 
				"VRIABL_NM",
				"VRIABL_LBL", 
				"VRIABL_TY_CODE", 
				"CTRL_FOM", 
				"CRF_LBL_ONE", 
				"CRF_LBL_TWO", 
				"VRIABL_ROLE", 
				"VRIABL_DC", 
				"CORE_CODE"
		};
		
		//CDISC_CL_CODE
		//Code,Codelist Code,Codelist Extensible (Yes/No),Codelist Name,CDISC Submission Value,CDISC Synonym(s),CDISC Definition,NCI Preferred Term
		String[] arrTerminology = {
				"CDISC_CODE", 
				"CDISC_UPPER_CODE", 
				"ESTN_POSBL_AT", 
				"CODE_NM", 
				"CDISC_SUBMIT_VALUE",
				"CDISC_SYNONM", 
				"CDISC_DFN", 
				"NCI_NM"
		};
		
		List<Map<String, String>> listAllData = new ArrayList<Map<String, String>>();
		
		List<Map<String, String>> listDomain = null;
		List<Map<String, String>> listVariable = null;
		List<Map<String, String>> listTerminology = null;
		
		int failCountDomain = 0;
		int failCountVariable = 0;
		int failCountTerminology = 0;
					
		for(int i = 0; i < hssfWB.getNumberOfSheets(); i++) {
			
			iSheet = hssfWB.getSheetAt(i);
			
			if(i == 0) {
				listDomain = Util.getListForExcelSheet(iSheet, arrDomain, 1);
			} else if(i == 1) {
				listVariable = Util.getListForExcelSheet(iSheet, arrVariable, 1);
			} else if(i == 2) {
				listTerminology = Util.getListForExcelSheet(iSheet, arrTerminology, 1);
			}
			
		}
		
		for(Map<String, String> iMap : listVariable) {
			
			for(Map<String, String> jMap : listTerminology) {
				
				if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_UPPER_CODE")))) {
					continue;
				}
				
				if(!"".equals(EgovStringUtil.isNullToString(jMap.get("CDISC_UPPER_CODE")))) {
					continue;
				}
				
				if("".equals(EgovStringUtil.isNullToString(iMap.get("CTRL_FOM")))) {
					continue;
				}
				
				if("".equals(EgovStringUtil.isNullToString(jMap.get("CDISC_SUBMIT_VALUE")))) {
					continue;
				}
				
				if(iMap.get("CTRL_FOM") != null && iMap.get("CTRL_FOM").contains("(" + jMap.get("CDISC_SUBMIT_VALUE") + ")")) {
					iMap.put("CDISC_UPPER_CODE", jMap.get("CDISC_CODE"));
				}
			}
		}
		
		for(Map<String, String> iMap : listDomain) {
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_NM"))) && iMap.get("DOMN_NM").getBytes("UTF-8").length > 200) {
				iMap.put("DOMN_NM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_DC"))) && iMap.get("DOMN_DC").getBytes("UTF-8").length > 4000) {
				iMap.put("DOMN_DC", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_CLASS"))) && iMap.get("DOMN_CLASS").getBytes("UTF-8").length > 300) {
				iMap.put("DOMN_CLASS", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_STRCT"))) && iMap.get("DOMN_STRCT").getBytes("UTF-8").length > 300) {
				iMap.put("DOMN_STRCT", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_PURPS"))) && iMap.get("DOMN_PURPS").getBytes("UTF-8").length > 300) {
				iMap.put("DOMN_PURPS", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_KEYS"))) && iMap.get("DOMN_KEYS").getBytes("UTF-8").length > 300) {
				iMap.put("DOMN_KEYS", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("DOMN_LOCATION"))) && iMap.get("DOMN_LOCATION").getBytes("UTF-8").length > 300) {
				iMap.put("DOMN_LOCATION", "fail");
				iMap.put("VALIDATION", "fail");
				failCountDomain ++;
			}
			
			iMap.put("GUBUN", "listDomain");
			listAllData.add(iMap);
		}
		
		for(Map<String, String> iMap : listVariable) {
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("VRIABL_NM"))) && iMap.get("VRIABL_NM").getBytes("UTF-8").length > 200) {
				iMap.put("VRIABL_NM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("VRIABL_LBL"))) && iMap.get("VRIABL_LBL").getBytes("UTF-8").length > 200) {
				iMap.put("VRIABL_LBL", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("VRIABL_ROLE"))) && iMap.get("VRIABL_ROLE").getBytes("UTF-8").length > 100) {
				iMap.put("VRIABL_ROLE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("VRIABL_DC"))) && iMap.get("VRIABL_DC").getBytes("UTF-8").length > 4000) {
				iMap.put("VRIABL_DC", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CRF_LBL_ONE"))) && iMap.get("CRF_LBL_ONE").getBytes("UTF-8").length > 200) {
				iMap.put("CRF_LBL_ONE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CRF_LBL_TWO"))) && iMap.get("CRF_LBL_TWO").getBytes("UTF-8").length > 200) {
				iMap.put("CRF_LBL_TWO", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CTRL_FOM"))) && iMap.get("CTRL_FOM").getBytes("UTF-8").length > 300) {
				iMap.put("CTRL_FOM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CORE_CODE"))) && iMap.get("CORE_CODE").getBytes("UTF-8").length > 10) {
				iMap.put("CORE_CODE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_UPPER_CODE"))) && iMap.get("CDISC_UPPER_CODE").getBytes("UTF-8").length > 200) {
				iMap.put("CDISC_UPPER_CODE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_DOMN.DOMN_NM"))) && iMap.get("CDISC_DOMN.DOMN_NM").getBytes("UTF-8").length > 200) {
				iMap.put("CDISC_DOMN.DOMN_NM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountVariable++;
			}
			
			iMap.put("GUBUN", "listVariable");
			listAllData.add(iMap);
		}
		
		for(Map<String, String> iMap : listTerminology) {
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_UPPER_CODE"))) && iMap.get("CDISC_UPPER_CODE").getBytes("UTF-8").length > 7) {
				iMap.put("CDISC_UPPER_CODE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_CODE"))) && iMap.get("CDISC_CODE").getBytes("UTF-8").length > 7) {
				iMap.put("CDISC_CODE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CODE_NM"))) && iMap.get("CODE_NM").getBytes("UTF-8").length > 200) {
				iMap.put("CODE_NM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("ESTN_POSBL_AT"))) && "YES".equals(iMap.get("ESTN_POSBL_AT").trim().toUpperCase())) {
				iMap.put("ESTN_POSBL_AT", "Y");
			} else if(!"".equals(EgovStringUtil.isNullToString(iMap.get("ESTN_POSBL_AT"))) && "NO".equals(iMap.get("ESTN_POSBL_AT").trim().toUpperCase())) {
				iMap.put("ESTN_POSBL_AT", "N");
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("ESTN_POSBL_AT"))) && iMap.get("ESTN_POSBL_AT").getBytes("UTF-8").length > 1) {
				iMap.put("ESTN_POSBL_AT", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_SUBMIT_VALUE"))) && iMap.get("CDISC_SUBMIT_VALUE").getBytes("UTF-8").length > 300) {
				iMap.put("CDISC_SUBMIT_VALUE", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_SYNONM"))) && iMap.get("CDISC_SYNONM").getBytes("UTF-8").length > 1000) {
				iMap.put("CDISC_SYNONM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("CDISC_DFN"))) && iMap.get("CDISC_DFN").getBytes("UTF-8").length > 4000) {
				iMap.put("CDISC_DFN", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}
			
			if(!"".equals(EgovStringUtil.isNullToString(iMap.get("NCI_NM"))) && iMap.get("NCI_NM").getBytes("UTF-8").length > 200) {
				iMap.put("NCI_NM", "fail");
				iMap.put("VALIDATION", "fail");
				failCountTerminology++;
			}

			iMap.put("GUBUN", "listTerminology");
			listAllData.add(iMap);
		}
		
		result.put("listAllData", listAllData);
		
		result.put("listDomain", listDomain);
		result.put("listVariable", listVariable);
		result.put("listTerminology", listTerminology);
		
		result.put("failCountDomain", failCountDomain);
		result.put("failCountVariable", failCountVariable);
		result.put("failCountTerminology", failCountTerminology);
		
		comz02Service.deleteFile(strTmpPath);
		
		return result;
	}

	@Override
	public void insertCdiscByExcelList(List<Map<String, Object>> list) throws Exception {
		
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strRuleSeq = cdiscRuleSeq.getNextStringId(); 
		
		//CDISC_RULE 입력
		for(Map<String, Object> iMap : list) {
			
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("CDISC_RULE_SN", strRuleSeq);
			
			if("rule".equals(iMap.get("GUBUN"))) {
				comc01DAO.insertCdiscRuleByExcelSheet(iMap);
			}
			
		}
		
		//CDISC_DOMN 입력
		for(Map<String, Object> iMap : list) {
			
			if("listDomain".equals(iMap.get("GUBUN"))) {
				
				iMap.put("CDISC_DOMN_SN", cdiscDomnSeq.getNextStringId());
				
				comc01DAO.insertCdiscDomnByExcelSheet(iMap);
			} 
			
		}
		
		//CDISC_CL_CODE 입력
		for(Map<String, Object> iMap : list) {
			
			if("listTerminology".equals(iMap.get("GUBUN"))) {
				
				iMap.put("CL_CODE_SN", cdiscClCodeSeq.getNextStringId());
				
				comc01DAO.insertCdiscClCodeByExcelSheet(iMap);
				
			}
			
		}
		
		List<Map<String, Object>> listVariableShallowCopy = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listDomainShallowCopy = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapShallowCopy = null;
		
		for(Map<String, Object> iMap : list) {
			if("listVariable".equals(iMap.get("GUBUN"))) {
				
				mapShallowCopy = new HashMap<String, Object>();
				
				for(String mapkey : iMap.keySet()) {
					mapShallowCopy.put(mapkey, iMap.get(mapkey));
				}
				
				listVariableShallowCopy.add(mapShallowCopy);
				
			}
		}
		
		for(Map<String, Object> iMap : list) {
			if("listDomain".equals(iMap.get("GUBUN"))) {
				
				mapShallowCopy = new HashMap<String, Object>();
				
				for(String mapkey : iMap.keySet()) {
					mapShallowCopy.put(mapkey, iMap.get(mapkey));
				}
				
				listDomainShallowCopy.add(mapShallowCopy);
			}
		}
		
		for(Map<String, Object> iMap : listDomainShallowCopy) {
			
			for(Map<String, Object> jMap : listVariableShallowCopy) {
				
				if(iMap.get("DOMN_NM").toString().trim().toUpperCase().equals(jMap.get("CDISC_DOMN.DOMN_NM").toString().trim().toUpperCase())) {
					
					jMap.put("DOMN_VRIABL_SN", cdiscDomnVriablSeq.getNextStringId());
					jMap.put("CDISC_DOMN_SN", iMap.get("CDISC_DOMN_SN"));
					
					comc01DAO.insertCdiscDomnVariablByExcelSheet(jMap);
				
				}
				
			}
			
		}
		
	}

	@Override
	public List<Map<String, Object>> selectCdiscRuleList() throws Exception {
		return comc01DAO.selectCdiscRuleList();
	}

	@Override
	public List<Map<String, Object>> selectCdiscDomnListByCdiscRuleSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscDomnListByCdiscRuleSn(map);
	}

	@Override
	public List<Map<String, Object>> selectCdiscDomnVriablListByCdiscDomnSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscDomnVriablListByCdiscDomnSn(map);
	}

	@Override
	public List<Map<String, Object>> selectCdiscClCodeByCdiscRuleSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscClCodeByCdiscRuleSn(map);
	}

	@Override
	public int selectCdiscDomnListCountByCdiscRuleSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscDomnListCountByCdiscRuleSn(map);
	}

	@Override
	public int selectCdiscDomnVriablListCountByCdiscDomnSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscDomnVriablListCountByCdiscDomnSn(map);
	}

	@Override
	public int selectCdiscClCodeCountByCdiscRuleSn(Map<String, String> map) throws Exception {
		return comc01DAO.selectCdiscClCodeCountByCdiscRuleSn(map);
	}

}
