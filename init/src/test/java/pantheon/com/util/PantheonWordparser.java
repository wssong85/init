package pantheon.com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.ConnectException;
import java.nio.charset.Charset;

import org.apache.poi.hslf.extractor.PowerPointExtractor;
import org.apache.poi.hssf.extractor.ExcelExtractor;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class PantheonWordparser {
	public String DocFileContentParser(String fileName) {
		POIFSFileSystem fs = null;
		try {

			fs = new POIFSFileSystem(new FileInputStream(fileName));

			if (fileName.endsWith(".doc")) {
				HWPFDocument doc = new HWPFDocument(fs);
				WordExtractor we = new WordExtractor(doc);
				return we.getText();
			} else if (fileName.endsWith(".xls")) {
				// HSSFWorkbook wb = new HSSFWorkbook(new
				// FileInputStream(fileName));
				ExcelExtractor ex = new ExcelExtractor(fs);
				ex.setFormulasNotResults(true);
				ex.setIncludeSheetNames(true);
				return ex.getText();
			} else if (fileName.endsWith(".ppt")) {
				PowerPointExtractor extractor = new PowerPointExtractor(fs);
				return extractor.getText();
			}

		} catch (Exception e) {
			System.out.println("document file cant be indexed");
		}
		return "";
	}

//	public static void main(String[] args) throws ConnectException {
//		String filepath = "C:/test/test.doc";
//		System.out.println(new PantheonWordparser().DocFileContentParser(filepath));
//		SocketOpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
//		connection.connect();
//		DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
//		File inputFile = new File("C:/test/test.doc");
//		File outputFile = new File("C:/test/test.pdf");
//		converter.convert(inputFile, outputFile);
//		connection.disconnect();
//	}
	
	
	public static void main(String[] args) {

        POIFSFileSystem fs = null;  
        Document document = new Document();

         try {  
             System.out.println("Starting the test");  
             fs = new POIFSFileSystem(new FileInputStream("C:/test/test.doc"));  

             HWPFDocument doc = new HWPFDocument(fs);  
             WordExtractor we = new WordExtractor(doc);  

             OutputStream file = new FileOutputStream(new File("C:/test/test.pdf")); 
             
             PdfWriter writer = PdfWriter.getInstance(document, file);  

             Range range = doc.getRange();
             document.open();  
             writer.setPageEmpty(true);  
             document.newPage();  
             writer.setPageEmpty(true);  

             String[] paragraphs = we.getParagraphText();  
             for (int i = 0; i < paragraphs.length; i++) {  

                 org.apache.poi.hwpf.usermodel.Paragraph pr = range.getParagraph(i);
                // CharacterRun run = pr.getCharacterRun(i);
                // run.setBold(true);
                // run.setCapitalized(true);
                // run.setItalic(true);
                 paragraphs[i] = paragraphs[i].replaceAll("\\cM?\r?\n", "");  
                 System.out.println("Length:" + paragraphs[i].length());  
                 System.out.println("Paragraph" + i + ": " + paragraphs[i].toString());  

                 // add the paragraph to the document  
                 document.add(new Paragraph(paragraphs[i]));  
             }  

             System.out.println("Document testing completed");  
         } catch (Exception e) {  
             System.out.println("Exception during test");  
             e.printStackTrace();  
         } finally {  
                         // close the document  
            document.close();  
         }  
	}  

}
