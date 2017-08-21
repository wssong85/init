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
public class ExcelTest {
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
//	@Test
	public void excelParsing() throws Exception {
		
		HSSFWorkbook hssfWB = (HSSFWorkbook) excelRdnmadZipService.loadWorkbook("D:/springUtil/test2.xls");
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		
		if (hssfWB.getNumberOfSheets() == 1) {
			HSSFSheet kcdSheet = hssfWB.getSheetAt(0);
			
			HSSFRow kcdRow = null;
			Map<String, String> map = null;
			HSSFCell cell = null;
			int kcdCnt = kcdSheet.getPhysicalNumberOfRows();
			
			if(kcdCnt != 3) {
				throw new Exception();
			}
			
			for(int i = 1; i < kcdCnt; i ++) {
				
				kcdRow = kcdSheet.getRow(i);
				map = new HashMap<String, String>();
				cell = kcdRow.getCell(0);
				if (cell != null) {
					map.put("DISS_CODE", (String) cell.getStringCellValue());
				} else {
					map.put("DISS_CODE", "");
				}
				
				cell = kcdRow.getCell(1);
				if (cell != null) {
					map.put("KOREA_NM", (String) cell.getStringCellValue());
				} else {
					map.put("KOREA_NM", "");
				}
				
				cell = kcdRow.getCell(2);
				if (cell != null) {
					map.put("ENG_NM", (String) cell.getStringCellValue());
				} else{
					map.put("ENG_NM", "");
				}
				
				list.add(map);
			}
			
		}
		
//		for(Map<String, String> iMap : list) {
//			System.out.print(iMap.get("DISS_CODE") + "  ");
//			System.out.print(iMap.get("KOREA_NM") + "  ");
//			System.out.println(iMap.get("ENG_NM"));
//		}
		
	}
}
