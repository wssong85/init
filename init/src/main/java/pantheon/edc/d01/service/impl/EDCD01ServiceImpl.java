package pantheon.edc.d01.service.impl;

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

import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.d01.dao.EDCD01DAO;
import pantheon.edc.d01.service.EDCD01Service;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.excel.EgovExcelService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * QUERY 관리를 처리하는 비지니스 구현 클래스
 * 
 * @author 오동근
 * @since 2016.05.31
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.31 오동근 최초 생성
 *      
 */
@Service("EDCD01Service")
public class EDCD01ServiceImpl implements EDCD01Service{

	@Resource(name = "EDCD01DAO")
	EDCD01DAO edcd01DAO;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
	@Resource(name = "ATRAIL_CM_QUERY")
	protected EgovPropertyService atrailCmQueryRole;
	
	@Resource(name = "ATRAIL_EDC_CF_QUERY")
	protected EgovPropertyService atrailEdcCfQuery;
	
	@Resource(name = "CM_QUERY_SEQ")
	private EgovIdGnrService cmQuerySeq;
	
	/**
	 * 파일 다운로드 시 엑셀을 만들어 기초데이터를 넣은 후 파일 생성 후에 업로드 한다.
	 */
	public Map<String, Object> selectQueryTemplate(Map<String, String> param) throws Exception {
		// 여기 정리부터.
		
		List<Map<String, String>> queryList = null;
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> edcParam = new HashMap<String, Object>();
		
		edcParam.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		
		Map<String, Object> rtnEdcVer = edcd01DAO.selectGetEdcVer(edcParam);
		String EDC_VERSION = "";
		
		EDC_VERSION = (String) rtnEdcVer.get("EDC_VER");
		param.put("EDV_VERSION", EDC_VERSION);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFSheet sheet = wb.createSheet("Query Template");		
		
		HSSFRow row = null;
		HSSFCell cell = null;
		
		String[] arrHeader = {
				"Site",
				"Subject",
				"Visit",
				"CRF",
				"Variable",
				"Query",
				"SetVriablSn",
				"VisitGroupSn",
				"Sn",
				"insttFormSn",
				"visitSn",
				"setRowSn",
				"vriablRowSn"
		};
		
		String[] arrValue = {
				"NAME1",
				"SUBJECT_NO",
				"VISIT_LBL",
				"GROUP_LBL",
				"VRIABL_NM",
				"",
				"SET_VRIABL_SN",
				"VISIT_GROUP_SN",
				"SN",
				"INSTT_FORM_SN",
				"VISIT_SN",
				"SET_ROW_SN",
				"VRIABL_ROW_SN"
				
		};
		
		row = sheet.createRow(0);
		queryList = edcd01DAO.selectQueryTemplate(param);
		
		for(int j=0; j< queryList.size(); j++){
			row = sheet.createRow(j);
			
			if(j == 0){
				for(int i=0; i < arrHeader.length; i++){
					cell = row.createCell(i);
					cell.setCellValue(arrHeader[i]);
				}
			}else{
				
				for(int k=0; k < arrValue.length; k++){
					cell = row.createCell(k);
					if(k == 5){
						cell.setCellValue("");
					}else{
						cell.setCellValue(String.valueOf(queryList.get(j).get(arrValue[k])));
					}
					
				}
			}
			
		}
		
		for(int i=0; i < arrHeader.length; i++){
			sheet.autoSizeColumn(i);
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
	
	public List<Map<String, Object>> selectQueryListByPre(Map<String, Object> param) throws Exception{
		Map<String, Object> rtnEdcVer = edcd01DAO.selectGetEdcVer(param);
		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return edcd01DAO.selectQueryListByPre(param);
	}
	
	public List<Map<String, Object>> selectQueryListByOpen(Map<String, Object> param) throws Exception{
		Map<String, Object> rtnEdcVer = edcd01DAO.selectGetEdcVer(param);
		param.put("EDC_VER", rtnEdcVer.get("EDC_VER"));
		return edcd01DAO.selectQueryListByOpen(param);
	}
	
	public void updateCmQueryByQuerySttus(List<Map<String, Object>> param) throws Exception{
		for(Map<String, Object> iMap : param) {
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmQueryRole, null, null);
			edcd01DAO.updateCmQueryByQuerySttus(iMap);
		}
	}
	
	public void updateCmQueryByUseAt(List<Map<String, Object>> param) throws Exception{
		for(Map<String, Object> iMap : param) {
			iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
			comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmQueryRole, null, null);
			edcd01DAO.updateCmQueryByUseAt(iMap);
		}
	}
	
	@Override
	public Map<String, Object> selectQueryListByExcel(HttpServletRequest request) throws Exception {
		String strTmpPath = comz02Service.uploadFile(request);
		
		Workbook wb = WorkbookFactory.create(new File(strTmpPath));
		Sheet sheet = wb.getSheetAt(0); //wb.getSheet("시트명"); 으로 대체가능
		List<Map<String, String>> listSocSheet = null;
		
		String[] arrSoc = {
			"Site",
			"Subject",
			"Visit",
			"CRF",
			"Variable",
			"Query",
			"SetVriablSn",
			"VisitGroupSn",
			"Sn",
			"insttFormSn",
			"visitSn",
			"setRowSn",
			"vriablRowSn"
		};
		
		sheet = wb.getSheetAt(0);
		
		listSocSheet = Util.setTrimByListString(Util.getListForExcelSheet(sheet, arrSoc, 1));
			
		comz02Service.deleteFile(strTmpPath);
		
		return QueryListForNullCheck(listSocSheet, arrSoc);
	}
	
	public static Map<String, Object> QueryListForNullCheck(List<Map<String, String>> list, String[] arr) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int count = 0;
		String USER_ID = Util.getUserMap().get("USER_ID");
		String ROLE_ID = Util.getUserMap().get("ROLE_ID");
		
		for (Map<String, String> iMap : list) {
			iMap.put("STATUS", "Success");
			iMap.put("Role", USER_ID);
			iMap.put("Issue", ROLE_ID);
			for (String iStr : arr) {
				if("".equals(iMap.get(iStr))){
					iMap.put("STATUS", "fail");
					iMap.put("REASON", "빈 값이 존재합니다.");
					count++;
				}
				
				if(iStr.equals("SetVriablSn")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("SetVriablSn")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "키는 양식에 있는 숫자만 가능합니다.");
						count++;
					}
				}else if(iStr.equals("VisitGroupSn")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("VisitGroupSn")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "키는 양식에 있는 숫자만 가능합니다.");
						count++;
					}
				}else if(iStr.equals("Sn")){
					if(!Util.isRegexStr(String.valueOf(iMap.get("Sn")), "number")){
						iMap.put("STATUS", "fail");
						iMap.put("REASON", "키는 양식에 있는 숫자만 가능합니다.");
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
	public void insertCfQuery(List<Map<String, Object>> param) throws Exception {
		
		for(Map<String, Object> iMap : param) {
			iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iMap.put("QUERY_SN", cmQuerySeq.getNextStringId());
			
			edcd01DAO.insertQueryMst(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmQueryRole, null, null);
			edcd01DAO.insertCfQuery(iMap);
			comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailEdcCfQuery, null, null);
		}
		
	}

}
