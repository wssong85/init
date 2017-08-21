package pantheon.com.z99.web;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.LocaleResolver;

import pantheon.com.utl.service.DamoService;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z06.service.COMZ06Service;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class COMZ99Controller {
	/** LocaleResolver */
	@Resource
	private LocaleResolver localeResolver;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;
	
	/** DamoService */
	@Resource(name = "DamoService")
	private DamoService damoService;
	
	/** EmailService */
	@Resource(name = "PantheonMailService")
	private PantheonMailService PantheonMailService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	/**
	 * 다국어 샘플 페이지 호출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/com/z99/COMZ9901.do")
	public String comz9901(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "/pantheon/com/z99/COMZ9901";
	}
	
	/**
	 * 국제화기능을 적용하여 Locale을 변경한다.
	 * @param request
	 * @param response
	 * @return "egovMainView"
	 * @throws Exception
	 */
	@RequestMapping(value="/com/anonymous/changeLocale.do", method=RequestMethod.GET)
	protected String changeLocale(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//다모테스트
		/*
		System.out.println("enc 숫자:" +damoService.scpEncStr("1234"));
		System.out.println("enc 한글:" +damoService.scpEncStr("한글 안녕하세요 반갑습니다. 주소는 서울시 서대문구 홍은동입니다. 숫자: 222"));
		System.out.println("enc 중국어:" +damoService.scpEncStr("中国語"));
		System.out.println("enc 일본어:" +damoService.scpEncStr("こんにちは"));
		String str1 = damoService.scpEncStr("1234");
		String str2 = damoService.scpEncStr("한글 안녕하세요 반갑습니다. 주소는 서울시 서대문구 홍은동입니다. 숫자: 222");
		String str3 = damoService.scpEncStr("中国語");
		String str4 = damoService.scpEncStr("こんにちは");
		System.out.println("dec 숫자:" +damoService.scpDecStr(str1));
		System.out.println("dec 한글:" +damoService.scpDecStr(str2));
		System.out.println("dec 중국어:" +damoService.scpDecStr(str3));
		System.out.println("dec 일본어:" +damoService.scpDecStr(str4));
		*/
		
		//이메일테스트
		
		/*
		Map<String, String> map = new HashMap<String, String>();
		//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
		map.put("HTML_NM", propertiesMailService.getString("TEST_MAIL_TEMPLATE"));
		//html에는 el식 기준으로 작성하면 변환됨
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		map.put("URL", "52.2.72.199:8080");
		PantheonMailService.sendMail(map, "kimbokmin@cj.net", "김복민", "메일발송테스트");
		*/
		
		Locale locale = new Locale("kr"); //default = kr
		if(request.getParameter("locale") == null){
			locale = localeResolver.resolveLocale(request);
		} else{
			locale = new Locale(request.getParameter("locale"));
		}
		
		// localeResolver에 locale 셋팅
		localeResolver.setLocale(request, response, locale);
		
		//요청한 화면으로 다시 이동
		if(request.getParameter("URL") == null) {
			return "forward:/com/i01/pantheonLoginUsr.do";
		} else {					
			return "redirect:" + request.getParameter("URL");
		}
	}
}