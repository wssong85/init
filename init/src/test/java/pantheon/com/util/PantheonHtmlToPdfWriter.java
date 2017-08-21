package pantheon.com.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import pantheon.com.utl.service.PantheonMailService;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;
//import com.itextpdf.text.pdf.fonts.otf.TableHeader;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.HTML;
import com.itextpdf.tool.xml.html.TagProcessorFactory;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import egovframework.rte.fdl.property.EgovPropertyService;

//@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:com/context-common.xml"
		,"classpath:com/context-aspect.xml"
		,"classpath:com/context-idgn-pantheon.xml"
		,"classpath:com/context-datasource.xml"
		,"classpath:com/context-sqlMap.xml"
		,"classpath:com/context-transaction.xml"
		,"classpath:com/context-com-atrail-properties.xml"
		,"classpath:com/context-ctms-atrail-properties.xml"
		,"classpath:com/context-edc-atrail-properties.xml"
		,"classpath:com/context-iwrs-atrail-properties.xml"
		,"classpath:com/context-scheduling-panteon.xml"
		,"classpath:com/context-sdb-atrail-properties.xml"
		,"classpath:com/context-properties.xml"
})
public class PantheonHtmlToPdfWriter {
	@Resource(name = "comPdfService")
	protected EgovPropertyService comPdfService;
	
    public static void manipulatePdf(String src, String dest) throws IOException, DocumentException {
    	String test = "test";
        PdfReader reader = new PdfReader(src);
        int n = reader.getNumberOfPages();
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(dest));
        PdfContentByte pagecontent;
        for (int i = 0; i < n; ) {
            pagecontent = stamper.getOverContent(++i);
            ColumnText.showTextAligned(pagecontent, Element.ALIGN_RIGHT, new Phrase(String.format("Confidential                                           %s / %s                                      Contract NO.:" + test, i, n)), 500, 15, 0);
        }
        stamper.close();
        reader.close();
    }
	
//	@Test
	public static void pdfWrite() throws DocumentException, IOException {
		Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정
		     
		// PdfWriter 생성
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("c:/test/test.pdf")); // 바로 다운로드.
		writer.setInitialLeading(12.5f);
		
        //상단
        HeaderTable event2 = new HeaderTable();
        writer.setPageEvent(event2);
        
        //하단
		PdfPCell cell = new PdfPCell(new Phrase("This is a copyright notic11e"));
		cell.setBorder(0);
        PdfPTable table = new PdfPTable(1);
        table.setTotalWidth(523);
        FooterTable event = new FooterTable(table);
		table.addCell(cell);
		writer.setPageEvent(event);
        
		// Document 오픈
		document.open();
		XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
		     
		// CSS
		CSSResolver cssResolver = new StyleAttrCSSResolver();
		CssFile cssFile = helper.getCSS(new FileInputStream("C:/eGov_/eGovFrameDev-3.5.1-64bit/workspace/pantheon2016/src/main/webapp/css/pdf.css"));
		cssResolver.addCss(cssFile);
		     
		// HTML, 폰트 설정
		XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
		fontProvider.register("C:/eGov_/eGovFrameDev-3.5.1-64bit/workspace/pantheon2016/src/main/webapp/font/GulimChe.ttf"); // MalgunGothic은 alias,
		
//		FontFactory.register("C:/eGov_/eGovFrameDev-3.5.1-64bit/workspace/pantheon2016/src/main/webapp/font/GulimChe.ttf");
//		fontProvider.register("c:/window/fonts/GulimChe.ttf", "MalgunGothic"); // MalgunGothic은 alias,
		CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
		 
		HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
		htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

		// Pipelines
		PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
		HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
		CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
		 
		XMLWorker worker = new XMLWorker(css, true);
		XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
		 
		// 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
		String htmlStr = "<html><head><body style='font-family: MalgunGothic;'>"
		            + "<p>PDF 안에 들어갈 내용입니다.</p>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<h3>한글, English, 漢字.漢字漢字漢字漢字tttt</h3>"
		            + "<img src='http://static.naver.net/www/u/2010/0611/nmms_215646753.gif'/>"
		            + "</body></head></html>";
		StringReader strReader = new StringReader(htmlStr);
		xmlParser.parse(strReader);
		
		document.close();
		writer.close();
		
		manipulatePdf("c:/test/test.pdf", "c:/test/test2.pdf");
	}
	
	public static void main(String[] args) throws DocumentException, IOException {
		pdfWrite();
		
//		String fontname = "C:/eGov_/eGovFrameDev-3.5.1-64bit/workspace/pantheon2016/src/main/webapp/font/GulimChe.ttf";
//		String filename = "C:/test/test3.pdf";
		
//		FontFactory.register(fontname);
//		StringBuffer sBuff = new StringBuffer("<html>");
//		sBuff.append("<head></head>");
//		sBuff.append("<body>");
//		sBuff.append("<table border=1>");
//		sBuff.append("<tr><td>Test worker <b>한글</b> 테스트</td><td>11<b>1</b>11</td></tr>");
//		sBuff.append("</table>");
//		sBuff.append("</body>");
//		sBuff.append("</html>");
//		StringReader stringReader = new StringReader(sBuff.toString());
//		Document document = new Document();
//		StyleSheet st = new StyleSheet();
//		st.loadTagStyle("body", "face", "굴림체"); 
//		st.loadTagStyle("body", "encoding", "Identity-H"); 
//		st.loadTagStyle("body", "leading", "12,0"); 
//		HTMLWorker worker = new HTMLWorker(document);
//		PdfWriter.getInstance(document, new FileOutputStream(filename));
//		document.open();
//		java.util.List<Element> p = HTMLWorker.parseToList(stringReader, st);
//		for (int k = 0; k < p.size(); ++k) document.add((Element)p.get(k));
//		document.close();

	}
}
