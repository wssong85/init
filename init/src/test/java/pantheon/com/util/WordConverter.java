package pantheon.com.util;
 
 import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.List;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.CharacterRun;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Section;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.BodyElementType;
import org.apache.poi.xwpf.usermodel.IBodyElement;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.xmlbeans.SchemaType;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHdrFtr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.impl.CTHdrFtrImpl;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.impl.CTHdrFtrRefImpl;
import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.fasoo.adk.packager.WorkPackager;

import egovframework.com.cmm.service.EgovProperties;
 
 public class WordConverter {
	 public static void test() {
		 
	 }
	 
 	public static void main(String[] args) throws Exception {
 		WorkPackager wp = new WorkPackager();
 		wp.DoExtract("C:/dev/fasoo/fsdinit", "0000000000010105", "C:/test/test_word.doc", "C:/test/test_word.doc");
 		
 		POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream("C:/test/test_word.doc"));
 		HWPFDocument doc = new HWPFDocument(fs);
        
        Range r = doc.getRange();
        for (int i = 0; i < r.numSections(); ++i) {
        	Section s = r.getSection(i);
        	for (int j = 0; j < s.numParagraphs(); j++) {
        		Paragraph p = s.getParagraph(j);
        		for (int k = 0; k < p.numCharacterRuns(); k++) {
        			CharacterRun run = p.getCharacterRun(k);
        			String text = run.text();
        			if (text.contains("${INSTT_NM}")) {
        				run.replaceText("${INSTT_NM}", "테스트연구기관");
        			}
        			if (text.contains("${TASK_NO}")) {
        				run.replaceText("${TASK_NO}", "CA010_A");
        			}
        			if (text.contains("${USER_NM}")) {
        				run.replaceText("${USER_NM}", "홍길동");
        			}
        			if (text.contains("${ADDR}")) {
        				run.replaceText("${ADDR}", "서울 특별시 서대문구 미근동 통일로");
        			}
        			if (text.contains("${GOAL_IN}")) {
        				run.replaceText("${GOAL_IN}", "90");
        			}
        			if (text.contains("${Y}")) {
        				run.replaceText("${Y}", "2016");
        			}
        			if (text.contains("${M}")) {
        				run.replaceText("${M}", "05");
        			}
        			if (text.contains("${D}")) {
        				run.replaceText("${D}", "16");
        			}
        		}
        	}
        }
        
 		FileOutputStream out = new FileOutputStream(new File("C:/test/test_word2.doc"));
 		doc.write(out);
 		out.close();
 		
 		SocketOpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
 		connection.connect();
 		
 		File inputFile = new File("C:/test/test_word2.doc");
 		File outputFile = new File("C:/test/test_word2.pdf");
 		
 		DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
 		converter.convert(inputFile, outputFile);
 		connection.disconnect();
 	}
 	
 	public static XWPFDocument replacePOI2(XWPFDocument doc, String placeHolder, String replaceText){
 		for (XWPFFooter footer : doc.getFooterList()) 
 			replaceAllBodyElements(footer.getBodyElements(), placeHolder, replaceText);
 		replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
 		return doc;
 	}
 	
 	 public static XWPFDocument replacePOI(XWPFDocument doc, String placeHolder, String replaceText){
 		    for (XWPFHeader header : doc.getHeaderList()) 
 		        replaceAllBodyElements(header.getBodyElements(), placeHolder, replaceText);
 		    	replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
 		    return doc;
 	 }
 
 	private static void replaceAllBodyElements(List<IBodyElement> bodyElements, String placeHolder, String replaceText){
 	    for (IBodyElement bodyElement : bodyElements) {
 	        if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0)
 	            replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
 	        if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0)
 	            replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
 	    }
 	}
 
 	private static void replaceTable(XWPFTable table, String placeHolder, String replaceText) {
 	    for (XWPFTableRow row : table.getRows())
 	        for (XWPFTableCell cell : row.getTableCells())
 	            for (IBodyElement bodyElement : cell.getBodyElements()) {
 	                if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0)
 	                    replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
 	                if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0)
 	                    replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
 	            }
 	}
 
 	private static void replaceParagraph(XWPFParagraph paragraph, String placeHolder, String replaceText) {
 	    for (XWPFRun r : paragraph.getRuns()) {
 	        String text = r.getText(r.getTextPosition());
 	        if (text != null && text.contains(placeHolder)) {
 	            text = text.replace(placeHolder, replaceText);
 	            r.setText(text, 0);
 	        }
 	    }
 	}
 }