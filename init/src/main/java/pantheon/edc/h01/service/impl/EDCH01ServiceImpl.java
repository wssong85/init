package pantheon.edc.h01.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.com.z02.service.DrmManageService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.c01.dao.EDCC01DAO;
import pantheon.edc.h01.dao.EDCH01DAO;
import pantheon.edc.h01.service.EDCH01Service;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service("EDCH01Service")
public class EDCH01ServiceImpl implements EDCH01Service{

	@Resource(name = "EDCH01DAO")
	EDCH01DAO EDCH01DAO;
	
	@Resource(name = "EDCC01DAO")
	EDCC01DAO edcc01DAO;
	
	@Resource(name = "EDC_LAB_DTA_SEQ")
	private EgovIdGnrService edcLabDtaSeq;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_LAB_DTA_FILE")
	protected EgovPropertyService atrailEdcLabDtaFile;
	
	@Resource(name = "ATRAIL_EDC_LAB_DTA")
	protected EgovPropertyService atrailEdcLabDta;
	
	@Resource(name = "ATRAIL_EDC_CF_GROUP")
	protected EgovPropertyService atrailEdcCfGroup;
	
	@Resource(name = "ATRAIL_EDC_CF_ROW")
	protected EgovPropertyService atrailEdcCfRow;
	
	@Resource(name = "ATRAIL_EDC_CF_VRIABL")
	protected EgovPropertyService atrailEdcCfVriabl;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	
	public List<Map<String, Object>> selectDmFileDetailList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)EDCH01DAO.selectDmFileDetailList(param);
	}
	
	public List<Map<String, Object>> selectEdcLabDtaList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>)EDCH01DAO.selectEdcLabDtaList(param);
	}
	
	public Map<String, Object> selectLabTemplate(Map<String, String> param) throws Exception {
		List<Map<String, String>> queryList = null;
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> edcParam = new HashMap<String, Object>();
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFSheet sheet = wb.createSheet("Lab Template");		
		HSSFSheet sheet1 = wb.createSheet("Lab Code");
		
		HSSFRow row = null;
		HSSFCell cell = null;
		
		String[] arrHeader = {
				"StudyNo",
				"LabName",
				"SubjectNo",
				"SamplingDate",
				"Visit",
				"Group",
				"AnalysisParameter(Code)",
				"Result"
		};
		
		String[] arrHeaderCodezip = {
				"AnalysisParameterCode",
				"AnalysisParameter",
				"AnalysisParameterSynoName"
		};
		
		String[] arrValue = {
				"CL_CODE_SN",
				"CDISC_SUBMIT_VALUE",
				"CDISC_SYNONM"
		};
		
		row = sheet.createRow(0);
		for(int i=0; i < arrHeader.length; i++){
			cell = row.createCell(i);
			cell.setCellValue(arrHeader[i]);
			sheet.autoSizeColumn(i);
		}
		
		edcParam.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		
		queryList = EDCH01DAO.selectLabTemplate(param);
		
		for(int j=0; j< queryList.size(); j++){
			row = sheet1.createRow(j);
			
			if(j == 0){
				for(int i=0; i < arrHeaderCodezip.length; i++){
					cell = row.createCell(i);
					cell.setCellValue(arrHeaderCodezip[i]);
				}
			}else{
				for(int k=0; k < arrValue.length; k++){
					cell = row.createCell(k);
					cell.setCellValue(String.valueOf(queryList.get(j).get(arrValue[k])));
				}
				
			}
		}
		
		for(int i=0; i < arrHeaderCodezip.length; i++){
			sheet1.autoSizeColumn(i);
		}
		
		File saveFolder = new File(EgovProperties.getProperty("file.upload.tmp.path"));
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		String strTmpPath = EgovProperties.getProperty("file.upload.tmp.path") + Util.getStrRnd(); 
		
		FileOutputStream fos = new FileOutputStream(strTmpPath);
		wb.write(fos);
		fos.close();
		
		result.put("path", EgovProperties.getProperty("file.upload.tmp.path"));
		result.put("fileName", Util.getStrRnd());
		result.put("filePath", strTmpPath);
		
		return result;
	}

	@Override
	public Map<String, Object> selectLabListByExcel(HttpServletRequest request, Map<String, String> param)	throws Exception {
		// drm 해제. 로컬에서는 주석처리 해야 한다.
		drmManageService.doExtract(param.get("filePath"), param.get("filePath"));
		Workbook wb = WorkbookFactory.create(new File(param.get("filePath")));
		Sheet sheet = wb.getSheetAt(0); //wb.getSheet("시트명"); 으로 대체가능
		List<Map<String, String>> listSocSheet = null;
		String[] arrSoc = {
				"StudyNo",
				"LabName",
				"SubjectNo",
				"SamplingDate",
				"Visit",
				"Group",
				"AnalysisParameter",
				"Result"
		};
		
		sheet = wb.getSheetAt(0);
		
		listSocSheet = Util.setTrimByListString(Util.getListForExcelSheet(sheet, arrSoc, 1));
		
		return QueryListForNullCheck(listSocSheet, arrSoc, param);
	}
	
	private Map<String, Object> QueryListForNullCheck(List<Map<String, String>> list, String[] arr, Map<String, String> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int count = 0;
		
		for (Map<String, String> iMap : list) {
			iMap.put("STATUS", "Success");
			iMap.put("MstrSn", param.get("FILE_MASTR_SN"));
			iMap.put("INSTT_CODE", param.get("INSTT_CODE"));
			for (String iStr : arr) {
				if("".equals(iMap.get(iStr))){
					iMap.put("STATUS", "fail");
					iMap.put("REASON", "빈 값이 존재합니다.");
					count++;
				}
				
				if(iStr.equals("SubjectNo")){
					if(EDCH01DAO.selectSubjectNoCount(iMap.get("SubjectNo")) == 0){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "시스템에 등록된 정확한 Subject No를 입력해 주세요.");
						count++;
					}
					
				}else if(iStr.equals("SamplingDate")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("SamplingDate")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "SamplingDate는 숫자만 입력 가능합니다.");
						count++;
					}
					
					if(iMap.get("SamplingDate").length() != 8){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "SamplingDate는 8자리만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("StudyNo")){
					if(EDCH01DAO.selectStydyNoCount(iMap.get("StudyNo")) == 0){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "시스템에 등록된 정확한 Study No를 입력해 주세요.");
						count++;
					}
				}else if(iStr.equals("VisitNo")){
					param.put("VisitNo", iMap.get("VisitNo"));
					if(EDCH01DAO.selectVisitCount(param) == 0){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "시스템에 등록된 정확한 Visit Name을 입력해 주세요.");
						count++;
					}
				}else if(iStr.equals("AnalysisParameter")){
					param.put("AnalysisParameter", iMap.get("AnalysisParameter"));
					param.put("LabName", iMap.get("LabName"));
					if(EDCH01DAO.selectAnalParamCount(param) > 0){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "하나의 기관의 실험실에는 하나의 AnalysisParameter만 입력 가능합니다.");
						count++;
					}
				}
			}
		}
		
		result.put("list", list);
		result.put("count", count);
		return result;
	}
	
	public void insertLabData(List<Map<String, Object>> param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, String> tempMap = new HashMap<String, String>();
		
		String USER_ID = Util.getUserMap().get("USER_ID");
		tempMap.put("USER_ID", USER_ID);
		map.put("USER_ID", USER_ID);
		
		
		map.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		map.put("FILE_MASTR_SN", param.get(0).get("MstrSn"));
		
		EDCH01DAO.insertLabDataFile(map);
		comz06Service.createCmDtaAtrailForInsertByObject(map, atrailEdcLabDtaFile, null, null);
		
		for(Map<String, Object> iMap : param) {
			iMap.put("USER_ID", USER_ID);
			iMap.put("LAB_DTA_SN", edcLabDtaSeq.getNextStringId());
			
			EDCH01DAO.insertLabData(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(map, atrailEdcLabDta, null, null);
		}
		
	}

	@Override
	public void insertLabCfValue(Map<String, Object> param)	throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> labMap = new HashMap<String, Object>();
		List<Map<String, Object>> list =  new ArrayList<Map<String,Object>>();
		
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		param.put("USER_ID", Util.getUserMap().get("USER_ID"));
		list = EDCH01DAO.selectEdcLabDtaList(param);
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcLabDtaFile, null, null);
		EDCH01DAO.updateLabDtaFile(param); 
		
		// result 값을 넣어준다.
		for(Map<String, Object> iMap : list){
			iMap.put("PARAM_TYPE", "1");
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
			iMap.put("EDC_VER", edcc01DAO.selectEdcVer(iMap));
			iMap.put("CRF_VER", edcc01DAO.selectCrfVer(iMap));
			map = EDCH01DAO.selectVriablKey(iMap);
			
			iMap.put("INSTT_FORM_SN", EDCH01DAO.selectInsttFormSn(iMap));
			iMap.put("VISIT_SN", map.get("VISIT_SN"));
			iMap.put("VISIT_GROUP_SN", map.get("VISIT_GROUP_SN"));
			iMap.put("SET_ROW_SN", map.get("SET_ROW_SN"));
			iMap.put("SET_VRIABL_SN", map.get("SET_VRIABL_SN"));
			iMap.put("SET_SN", map.get("SET_SN"));
			
			if(EDCH01DAO.selectCfGroupCount(iMap) == 0){
				EDCH01DAO.insertCfGroup(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfGroup, null, null);
			}
			
			if(EDCH01DAO.selectCfRowCount(iMap) == 0){
				EDCH01DAO.insertCfRow(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfRow, null, null);
			}
			
			if(EDCH01DAO.selectCfVriablCount(iMap) == 0){
				EDCH01DAO.insertCfVraiabl(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfVriabl, null, null);
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfVriabl, null, null);
				EDCH01DAO.updateCfVriabl(iMap);
			}
			
		}
		
		map = new HashMap<String, Object>();
		
		// 이상반응 비교 후 정상여부 넣어준다.
		for(Map<String, Object> iMap : list){
			iMap.put("PARAM_TYPE", "2");
			iMap.put("LBNOR", "Y");
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
			iMap.put("EDC_VER", edcc01DAO.selectEdcVer(iMap));
			iMap.put("CRF_VER", edcc01DAO.selectCrfVer(iMap));
			map = EDCH01DAO.selectNorValue(iMap);
			labMap = EDCH01DAO.selectLabDetailData(iMap);
			
			iMap.put("INSTT_FORM_SN", EDCH01DAO.selectInsttFormSn(iMap));
			iMap.put("VISIT_SN", map.get("VISIT_SN"));
			iMap.put("VISIT_GROUP_SN", map.get("VISIT_GROUP_SN"));
			iMap.put("SET_ROW_SN", map.get("SET_ROW_SN"));
			iMap.put("SET_VRIABL_SN", map.get("SET_VRIABL_SN"));
			iMap.put("SET_SN", map.get("SET_SN"));
			
			iMap.put("AGE", EDCH01DAO.selectAgeVriablValue(iMap));
			iMap.put("SEX", EDCH01DAO.selectSexVriablValue(iMap));
			
			if(EDCH01DAO.selectCfGroupCount(iMap) == 0){
				EDCH01DAO.insertCfGroup(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfGroup, null, null);
			}
			if(EDCH01DAO.selectCfRowCount(iMap) == 0){
				EDCH01DAO.insertCfRow(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfRow, null, null);
			}
			
			if(Integer.parseInt((String) iMap.get("ANALS_RESULT")) < Integer.parseInt((String) labMap.get("SCOPE_LWLT_VALUE")) || 
				Integer.parseInt((String) iMap.get("ANALS_RESULT")) > Integer.parseInt((String) labMap.get("SCOPE_UPLMT_VALUE"))){
				iMap.put("LBNOR", "N");
			}
			
			String bgnDt = (String) labMap.get("APPLC_BGNDE");
			String endDt = (String) labMap.get("APPLC_ENDDE");
			int a = Integer.parseInt(bgnDt);
			int b = Integer.parseInt(endDt);
			
			String sDt = (String) iMap.get("SMPLERING_DE2");
			int c = Integer.parseInt(sDt);
			
			if(c < a || c > b){
				iMap.put("LBNOR", "N");
			}
			
			if(iMap.get("SEX") != null && !iMap.get("SEX").equals(labMap.get("SEXDSTN"))){
				iMap.put("LBNOR", "N");
			}
			
			if(iMap.get("AGE") != null && !iMap.get("AGE").equals(labMap.get("AGE"))){
				iMap.put("LBNOR", "N");
			}
			
			if(EDCH01DAO.selectCfVriablCount(iMap) == 0){
				EDCH01DAO.insertCfVraiabl(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfVriabl, null, null);
			}else{
				comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfVriabl, null, null);
				EDCH01DAO.updateCfVriabl(iMap);
			}
			
		}
	}
	
}
