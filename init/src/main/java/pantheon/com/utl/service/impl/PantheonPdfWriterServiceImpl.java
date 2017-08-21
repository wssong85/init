package pantheon.com.utl.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonPdfWriterService;

@Service("PantheonPdfWriterService")
public class PantheonPdfWriterServiceImpl implements PantheonPdfWriterService{
	
	
	@Override
	public long pdfWriter(EgovPropertyService egovPeopertyService, String uploadPath, String uploadFileNm, Map<String, String> map) throws Exception {
		if(true) {
			throw new UnsupportedOperationException();
		}
		
		// Document 생성
		Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정
		     
		// PdfWriter 생성
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(uploadPath + uploadFileNm)); // 바로 다운로드.
		
		writer.setInitialLeading(12.5f);
		 
		// Document 오픈
		document.open();
		XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
		     
		// CSS
		CSSResolver cssResolver = new StyleAttrCSSResolver();
		CssFile cssFile = helper.getCSS(new FileInputStream(EgovProperties.getProperty("pdf.path") + egovPeopertyService.getString("CSS_TEMPLATE")));
		cssResolver.addCss(cssFile);
		     
		// HTML, 폰트 설정
		XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
		fontProvider.register(EgovProperties.getProperty("pdf.font"), EgovProperties.getProperty("pdf.font.name")); // MalgunGothic은 alias,
		CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
		 
		HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
		htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
		 
		// Pipelines
		PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
		HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
		CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
		 
		XMLWorker worker = new XMLWorker(css, true);
		XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
		 
		String htmlStr = Util.getStrFile(EgovProperties.getProperty("pdf.path") + egovPeopertyService.getString("HTML_TEMPLATE"), null);
		
		Map<String, String> parseMap = new HashMap<String, String>();
		
		//pdf 템플릿에 쓰일 동적 데이터만들기	
		for(String mapkey : map.keySet()){
			parseMap.put("${"+mapkey+"}", map.get(mapkey));
		}
		
		//pdf 템플릿 데이터 변환
		for(String mapkey : parseMap.keySet()){
			htmlStr = EgovStringUtil.replace(htmlStr, mapkey, parseMap.get(mapkey));
		}

		StringReader strReader = new StringReader(htmlStr);
		xmlParser.parse(strReader);
		 
		document.close();
		writer.close();
		File f = new File(uploadPath);
		
		return f.length();
	}

}
