package pantheon.edc.k03.service.impl;

import java.io.File;
import java.io.FileOutputStream;
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

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.excel.EgovExcelService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.DrmManageService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.h01.dao.EDCH01DAO;
import pantheon.edc.k03.dao.EDCK03DAO;
import pantheon.edc.k03.service.EDCK03Service;

/**
 * Lab 정상범위 관리를 처리하는 비지니스 구현 클래스
 * @author 오동근
 * @since 2016.02.29
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.29  오동근          최초 생성
 *  
 */
@Service("EDCK03Service")
public class EDCK03ServiceImpl implements EDCK03Service{
	
	@Resource(name = "EDCK03DAO")
    EDCK03DAO edck03DAO;
	
	@Resource(name = "EDCH01DAO")
	EDCH01DAO EDCH01DAO;
	
	@Resource(name = "EDC_CF_LAB_SEQ")
	private EgovIdGnrService edcCfLabSeq;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_CF_LAB_DETAIL")
	protected EgovPropertyService atrailEdcCfLabDetail;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	/**
	 * Lab 정상범위 목록
	 */
	@Override
	public List<Map<String, Object>> selectLabList(Map<String, Object> param)throws Exception {
		// TODO Auto-generated method stub
		return edck03DAO.selectLabList(param);
	}
	
	/**
	 * Lab 정상범위 목록 Count
	 */
	@Override
	public String selectLabListCount(Map<String, Object> param)	throws Exception {
		// TODO Auto-generated method stub
		return edck03DAO.selectLabListCount(param);
	}

	/**
	 * Lab 정상범위 상세
	 */
	@Override
	public Map<String, Object> selectLab(Map<String, Object> param)	throws Exception {
		// TODO Auto-generated method stub
		return edck03DAO.selectLab(param);
	}

	/**
	 * Lab 정상범위 저장
	 */
	@Override
	public void insertLab(Map<String, Object> param) throws Exception {
		param.put("LAB_SN", edcCfLabSeq.getNextStringId());
		edck03DAO.insertLab(param);
		comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCfLabDetail, null, null);
	}

	/**
	 * Lab 정상범위 수정
	 */
	@Override
	public void updateLab(Map<String, Object> param) throws Exception {
		comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCfLabDetail, null, null);
		edck03DAO.updateLab(param);
	}
	
	public List<Map<String, String>> selectAnalysisList(Map<String, String> param)throws Exception {
		return EDCH01DAO.selectLabTemplate(param);
	}

	@Override
	public Map<String, Object> selectLabTemplate(Map<String, String> param)	throws Exception {
		List<Map<String, String>> queryList = null;
		Map<String, Object> result = new HashMap<String, Object>();
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFSheet sheet = wb.createSheet("Lab Template");		
		HSSFSheet sheet1 = wb.createSheet("Lab Code");
		
		HSSFRow row = null;
		HSSFCell cell = null;
		
		String[] arrHeader = {
				"LaboratoryName",
				"AnalysisParameter(Code)",
				"Unit",
				"ReferenceRangeLowerLimit",
				"ReferenceRangeUpperLimit",
				"Age",
				"Sex",
				"적용시작일",
				"적용종료일"
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
		
			row = sheet.createRow(1);
			
			for(int k=0; k < arrHeader.length; k++){
				cell = row.createCell(k);
				if(k == 0){
					cell.setCellValue("SCL1");
				}else if(k == 1){
					cell.setCellValue("133218");
				}else if(k == 2){
					cell.setCellValue("pg/mL");
				}else if(k == 3){
					cell.setCellValue("23");
				}else if(k == 4){
					cell.setCellValue("34");
				}else if(k == 5){
					cell.setCellValue("27");
				}else if(k == 6){
					cell.setCellValue("F");
				}else if(k == 7){
					cell.setCellValue("20160601");
				}else if(k == 8){
					cell.setCellValue("20160630");
				}
			}
			
			row = sheet.createRow(2);
			
			for(int k=0; k < arrHeader.length; k++){
				cell = row.createCell(k);
				if(k == 0){
					cell.setCellValue("SCL1");
				}else if(k == 1){
					cell.setCellValue("133211");
				}else if(k == 2){
					cell.setCellValue("pg/mL");
				}else if(k == 3){
					cell.setCellValue("17");
				}else if(k == 4){
					cell.setCellValue("22");
				}else if(k == 5){
					cell.setCellValue("42");
				}else if(k == 6){
					cell.setCellValue("M");
				}else if(k == 7){
					cell.setCellValue("20160512");
				}else if(k == 8){
					cell.setCellValue("20160728");
				}
			}
			
		
		param.put("MODULE", "DMC");
		
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
	public Map<String, Object> selectLabListByExcel(HttpServletRequest request,	Map<String, String> param) throws Exception {
		// drm 해제. 로컬에서는 주석처리 해야 한다.
		drmManageService.doExtract(param.get("filePath"), param.get("filePath"));
		Workbook wb = WorkbookFactory.create(new File(param.get("filePath")));
		Sheet sheet = wb.getSheetAt(0); //wb.getSheet("시트명"); 으로 대체가능
		List<Map<String, String>> listSocSheet = null;
		String[] arrSoc = {
				"LaboratoryName",
				"AnalysisParameter(Code)",
				"Unit",
				"ReferenceRangeLowerLimit",
				"ReferenceRangeUpperLimit",
				"Age",
				"Sex",
				"적용시작일",
				"적용종료일"
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
			iMap.put("INSTT_CODE", param.get("INSTT_CODE"));
			for (String iStr : arr) {
				if("".equals(iMap.get(iStr))){
					iMap.put("STATUS", "fail");
					iMap.put("REASON", "빈 값이 존재합니다.");
					count++;
				}
				
				if(iStr.equals("ReferenceRangeLowerLimit")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("ReferenceRangeLowerLimit")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "ReferenceRangeLowerLimit는 숫자만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("ReferenceRangeUpperLimit")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("ReferenceRangeUpperLimit")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "ReferenceRangeUpperLimit는 숫자만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("Age")){
					iMap.put("AGE", iMap.get("Age"));
					if(!Util.isRegexStr(String.valueOf(iMap.get("Age")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "ReferenceRangeUpperLimit는 숫자만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("Sex")){
					iMap.put("SEXDSTN", iMap.get("Sex"));
					if(iMap.get("Sex").length() != 1){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "성별은 F나 M만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("적용시작일")){
					iMap.put("APPLC_BGNDE", iMap.get("적용시작일"));
					if(!Util.isRegexStr(String.valueOf(iMap.get("적용시작일")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "적용시작일은 숫자만 입력 가능합니다.");
						count++;
					}
					
					if(iMap.get("적용시작일").length() != 8){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "적용시작일은 8자리만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("적용종료일")){
					iMap.put("APPLC_ENDDE", iMap.get("적용종료일"));
					if(!Util.isRegexStr(String.valueOf(iMap.get("적용종료일")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "적용종료일은 숫자만 입력 가능합니다.");
						count++;
					}
					
					if(iMap.get("적용종료일").length() != 8){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "적용종료일은 8자리만 입력 가능합니다.");
						count++;
					}
					
				}else if(iStr.equals("AnalysisParameter(Code)")){
					param.put("AnalysisParameter", iMap.get("AnalysisParameter(Code)"));
					param.put("LabName", iMap.get("LaboratoryName"));
					iMap.put("AnalysisParameter", iMap.get("AnalysisParameter(Code)"));
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

	@Override
	public void insertLabData(List<Map<String, Object>> param) throws Exception {
		for(Map<String, Object> iMap : param) {
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			if(edck03DAO.selectLabCount(iMap) == 0){
				edck03DAO.insertCfLab(iMap);
			}
			
			iMap.put("UPLOAD_STATUS", "Y");
			iMap.put("LAB_SN", edcCfLabSeq.getNextStringId());
			iMap.put("LAB_NM", iMap.get("LaboratoryName"));
			iMap.put("ANALS_PARAMTR", iMap.get("AnalysisParameter"));
			iMap.put("UNIT", iMap.get("Unit"));
			iMap.put("SCOPE_LWLT_VALUE", iMap.get("ReferenceRangeLowerLimit"));
			iMap.put("SCOPE_UPLMT_VALUE", iMap.get("ReferenceRangeUpperLimit"));
			
			edck03DAO.insertLab(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCfLabDetail, null, null);
		}
	}

}
