package pantheon.edc;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class Test {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		DefineXmlValidationChk();
	}
	
	public static String DefineXmlValidationChk() throws Exception {
		try {
			Map<String,Object> excelMap = new HashMap<String, Object>();
			List<Map<String,Object>> excelList = new ArrayList<Map<String,Object>>();
			
			Workbook wb = WorkbookFactory.create(new File("C:/Sample//TA.xls"));
			Sheet sheet = wb.getSheetAt(0); //wb.getSheet("시트명"); 으로 대체가능
			
			int rows = sheet.getPhysicalNumberOfRows(); // 행 갯수 가져오기
			System.out.println("@@@행 갯수 : " + rows);
			String value = null;
			DataFormatter formatter = new DataFormatter();
		//	int j = 1;
		//	int c = 0;
			
			/*for(Row row : sheet){
				j++;
				for(Cell cell : row){
					value = formatter.formatCellValue(cell);  //cell.getStringCellValue();
					System.out.println(j +  "번째 행의 " + c + "번째 cell의 값 : " + value);
					excelMap.put(c + "val", value);
					System.out.println("map 값 : " + excelMap.get(c + "val"));
					//엑셀 양식이 정해지면 마지막 열에서 excelList에 excelMap을 담고 초기화 시켜준다
					c++;
				}
				c = 0;
				excelList.add(excelMap);
				excelMap = new HashMap<String, Object>();
			}*/
			int cells = sheet.getRow(0).getPhysicalNumberOfCells();
			String itemOid = "";
			for(int j = 1; j < rows; j++){
				Row row = sheet.getRow(j);
				if(row != null){
					for(int c = 0; c < cells; c++){
						Cell cell = row.getCell(c); //cell 가져오기
						value = formatter.formatCellValue(cell);  //cell.getStringCellValue();
						System.out.println(j +  "번째 행의 " + c + "번째 cell의 값 : " + value);
						excelMap.put(c + "val", value);
						excelMap.put("vriablValue", value);
						excelMap.put("itemOid", itemOid);
						excelMap.put("rowOrdr", j); // 행순서
						excelMap.put("lblOrdr", c+1); // 라벨순서
						
						excelList.add(excelMap);
						excelMap = new HashMap<String, Object>();
					}
				}
			}
			
			for(int k=0; k<excelList.size(); k++){
           	 System.out.println("====================================" + k + "번째 결과값");
           	 System.out.println("행순서 : " + excelList.get(k).get("rowOrdr") + " 라벨순서 : " + excelList.get(k).get("lblOrdr") + " 변수 값 : " + excelList.get(k).get("vriablValue"));
           	 System.out.println("====================================");
            }
			
			
		} catch (Exception e) {
			System.out.println("@@@@Service Error : " + e.getLocalizedMessage());
		}
		
		return null;
	}

}
