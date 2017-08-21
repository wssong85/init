package pantheon.com.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.excel.EgovExcelService;

//@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:com/context-common.xml"
		,"classpath:com/context-aspect.xml"
		,"classpath:com/context-idgn-pantheon.xml"
		,"classpath:com/context-datasource.xml"
		,"classpath:com/context-sqlMap.xml"
		,"classpath:com/context-transaction.xml"
		,"classpath:com/context-properties.xml"
		,"classpath:com/context-com-atrail-properties.xml"
		,"classpath:com/context-ctms-atrail-properties.xml"
		,"classpath:com/context-edc-atrail-properties.xml"
		,"classpath:com/context-iwrs-atrail-properties.xml"
		,"classpath:com/context-scheduling-panteon.xml"
		,"classpath:com/context-sdb-atrail-properties.xml"
		,"classpath:com/context-excel.xml"
})
public class ExceCdisclTest {
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
//	@Test
	public void excelParsing() throws Exception {
		
		HSSFWorkbook hssfWB = (HSSFWorkbook) excelRdnmadZipService.loadWorkbook("C:/test/excel/test.xls");
		HSSFSheet iSheet = null;
		if (hssfWB.getNumberOfSheets() != 3) {
			System.out.println("throw error!");
		}
		
		//CDISC_DOMN
		//domain,Dataset,Description,Class,Structure,Purpose,Keys,Location
		String[] arrDomain = {"DOMN_NM", "DOMN_DC", "DOMN_CLASS", "DOMN_STRCT", "DOMN_PURPS", "DOMN_KEYS", "DOMN_LOCATION"};
		
		//CDISC_DOMN_VRIABL
		//Domain Name,OrderNum,Variable Name,Variable Label,Type,Controlled Terms,CRF LABEL1,CRF LABEL2,Role,CDISC Notes,Core
		// 기준 업데이트		
		//CDISC_UPPER_CODE = CDISC_CL_CODE.CDISC_UPPER_CODE (update)
		//Controlled Terms
		String[] arrVariable = {"CDISC_DOMN.DOMN_NM", "LBL_ORDR", "VRIABL_NM","VRIABL_LBL", "VRIABL_TY_CODE", "CTRL_FOM", "CRF_LBL_ONE", 
				"CRF_LBL_TWO", "VRIABL_ROLE", "VRIABL_DC", "CORE_CODE"};
		
		//CDISC_CL_CODE
		//Code,Codelist Code,Codelist Extensible (Yes/No),Codelist Name,CDISC Submission Value,CDISC Synonym(s),CDISC Definition,NCI Preferred Term
		String[] arrTerminology = {"CDISC_CL_CODE", "CDISC_UPPER_CODE", "CDISC_CODE", "ESTN_POSBL_AT", "CODE_NM", "CDISC_SUBMIT_VALUE",
				"CDISC_SYNONM", "CDISC_DFN", "NCI_NM"};
		
		List<Map<String, String>> listDomain = null;
		List<Map<String, String>> listVariable = null;
		List<Map<String, String>> listTerminology = null;
					
		for(int i = 0; i < hssfWB.getNumberOfSheets(); i++) {
			
			iSheet = hssfWB.getSheetAt(i);
			
			if(i == 0) {
				listDomain = getListForExcelSheet(iSheet, arrDomain);
			} else if(i == 1) {
				listVariable = getListForExcelSheet(iSheet, arrVariable);
			} else if(i == 2) {
				listTerminology = getListForExcelSheet(iSheet, arrTerminology);
			}
			
		}
		//마스터 입력
		//insert
		
		for(Map<String, String> iMap : listDomain) {
			//insert
			
			for(Map<String, String> jMap : listVariable) {
				if(iMap.get("DOMN_NM").equals("CDISC_DOMN.DOMN_NM")) {
					//listDomain 순번입력
				}
			}
			
		}
		
		for(Map<String, String> iMap : listTerminology) {
			//insert
		}
		
		//update
		 
	}
	
	public List<Map<String, String>> getListForExcelSheet(HSSFSheet sheet, String[] arrStr) {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		HSSFRow row = null;
		Map<String, String> map = null;
		HSSFCell cell = null;
		int cnt = sheet.getPhysicalNumberOfRows();
		
		for(int i = 1; i < cnt; i ++) {
			map = new HashMap<String, String>();
			row = sheet.getRow(i);
			
			for(int j = 0; j < arrStr.length; j++) {
				cell = row.getCell(j);
				if(cell != null) {
					try {
						map.put(arrStr[j], cell.getStringCellValue());
					} catch (Exception e) {
						map.put(arrStr[j], String.valueOf(cell.getCellNum()));
					}
				} else {
					map.put(arrStr[j], "");
				}
			}
			
			list.add(map);
		}
		
		return list;
	}
}
