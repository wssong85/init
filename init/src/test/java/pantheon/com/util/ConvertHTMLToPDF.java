package pantheon.com.util;

import java.io.FileOutputStream;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
//import com.incross.pdf.DefaultFontProvider;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.pdf.PdfWriter;

public class ConvertHTMLToPDF {
	public static void main(String[] args) {
		String file = "c:/test/test.pdf";

		PdfWriter pdfWriter = null;

		try {

			// create a new document
			Document document = new Document();

			// get Instance of the PDFWriter
			pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(
					file));

			document.setPageSize(PageSize.A4);

			document.open();
			
			HTMLWorker htmlWorker = new HTMLWorker(document);

			HashMap<String, Object> interfaceProps = new HashMap<String, Object>();

			StyleSheet styles = new StyleSheet();

			DefaultFontProvider dfp = new DefaultFontProvider(
					"C:/eGov_/eGovFrameDev-3.5.1-64bit/workspace/pantheon2016/src/main/webapp/font/MALGUN.TTF");
			// 폰트 파일 설정 (한글 나오게 하기 위해 설정 필요함
			interfaceProps.put(HTMLWorker.FONT_PROVIDER, dfp);

			StringBuffer sb = new StringBuffer();
			sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");

			sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");

			sb.append("<html>");

			sb.append("<head>");

			sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
			
			sb.append("</head>");

			sb.append("<body>");

			sb.append("<table border='1'>");

			sb.append("  <tr>");

			sb.append("    <td> 테스트  </td>");

			sb.append("  <tr>");

			sb.append("</table>");

			sb.append("<img src='http://static.naver.net/www/u/2010/0611/nmms_215646753.gif'/>");
			sb.append("</body>");

			sb.append("</html>");

			System.out.println("html:" + sb.toString());

			StringReader strReader = new StringReader(sb.toString());
			List<Element> objects = htmlWorker.parseToList(strReader, styles, interfaceProps);

			for (int k = 0; k < objects.size(); ++k) {

				document.add((Element) objects.get(k));
			}
			document.close();
			// close the writer
			pdfWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}