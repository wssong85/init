package pantheon.edc.d01;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.excel.EgovExcelService;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.edc.d01.service.EDCD01Service;

/*@RunWith(SpringJUnit4ClassRunner.class)
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
})*/
public class queryExcelTest {
	
	@Resource(name = "EDCD01Service")
	private EDCD01Service edcd01Service;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
	/*@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	*/
	// @Test
	public void excelCreate() throws Exception {
		
		List<Map<String, String>> queryList = null;
		Map<String, String> param = new HashMap<String, String>();
		param.put("EDV_VERSION", "2.2.1");
		param.put("TASK_SN", "1");
		
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
				"Sn"
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
				"SN"
		};
		
		row = sheet.createRow(0);
	//	queryList = edcd01Service.selectQueryTemplate(param);
		
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
		
		File saveFolder = new File(EgovProperties.getProperty("file.upload.tmp.path"));
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		String strTmpPath = EgovProperties.getProperty("file.upload.tmp.path") + Util.getStrRnd(); 
		
		FileOutputStream fos = new FileOutputStream(strTmpPath);
		wb.write(fos);
		fos.close();
		System.out.println("성공!");
		
	}
	
// 	@Test
	public void excelListView() throws Exception {
		// String strTmpPath = comz02Service.uploadFile(request);
		
		String strTmpPath = "C:\\test\\test.xls";
		
		HSSFWorkbook hssfWB = (HSSFWorkbook) excelRdnmadZipService.loadWorkbook(strTmpPath);

		if (hssfWB.getNumberOfSheets() != 1) {
			throw new Exception("Please check whether the Excel sheet with three!");
		}

		List<Map<String, String>> listTmpAtc = null;
		List<Map<String, String>> listAtc = new ArrayList<Map<String, String>>();
		Map<String, String> mapAtc = null;
		Map<String, Object> result = new HashMap<String, Object>();
		
		String[] arrStrAtc = {
				"Site",
				"Subject",
				"Visit",
				"CRF",
				"Variable",
				"Query",
				"SetVriablSn",
				"VisitGroupSn",
				"Sn"
		};
		
		listTmpAtc = Util.getListForExcelSheet(hssfWB.getSheetAt(0), arrStrAtc, 1);
		
		for(Map<String, String> iMap : listTmpAtc) {
				
			mapAtc = new HashMap<String, String>();
			mapAtc.put("SITE", iMap.get("Site"));
			mapAtc.put("SUBJECT", iMap.get("Subject"));
			mapAtc.put("VISIT", iMap.get("Visit"));
			mapAtc.put("CRF", iMap.get("CRF"));
			mapAtc.put("VARIABLE", iMap.get("Variable"));
			mapAtc.put("QUERY", iMap.get("Query"));
			mapAtc.put("SET_VRIABL_SN", iMap.get("SetVriablSn"));
			mapAtc.put("VISIT_GROUP_SN", iMap.get("VisitGroupSn"));
			mapAtc.put("SN", iMap.get("Sn"));
			
			listAtc.add(mapAtc);
		}
		
		// comz02Service.deleteFile(strTmpPath);
		
		result.put("list", listAtc);
		
		for(int k=0; k<listAtc.size(); k++){
          	 System.out.println("====================================" + k + "번째 결과값");
          	 System.out.println("SITE : " + listAtc.get(k).get("SITE") + " SUBJECT : " + listAtc.get(k).get("SUBJECT") 
		          			 + " VISIT : " + listAtc.get(k).get("VISIT") + " CRF : " + listAtc.get(k).get("CRF")
		          			 + " VARIABLE : " + listAtc.get(k).get("VARIABLE") + " QUERY : " + listAtc.get(k).get("QUERY")
		          			 + " SET_VRIABL_SN : " + listAtc.get(k).get("SET_VRIABL_SN") + " VISIT_GROUP_SN : " + listAtc.get(k).get("VISIT_GROUP_SN")
		          			 + " SN : " + listAtc.get(k).get("SN")
		          			 );
          	 System.out.println("====================================");
           }
		
	//	return result;
	}
	
}
