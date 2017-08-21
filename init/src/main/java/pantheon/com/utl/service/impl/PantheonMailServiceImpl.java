package pantheon.com.utl.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z03.dao.COMZ03DAO;

@Service("PantheonMailService")
public class PantheonMailServiceImpl implements PantheonMailService {

	private static final Logger log = LoggerFactory.getLogger(PantheonMailServiceImpl.class);
	
	@Resource(name = "COMZ03DAO")
	private COMZ03DAO comz03DAO;
	
	@Resource(name = "COMTHEMAILDSPTCHMANAGE_SEQ")
	private EgovIdGnrService comTheMailDsptchManageSeq;
	
	@Override
	public boolean sendMail(Map<String, String> map, String emailTo, String emailUserName, String emailSubject) throws Exception {
		
//		if(!Util.isRegexStr(emailTo, "email")) {
//			log.error("ERROR: This email format is incorrent!!");
//			throw new Exception("ERROR: This email format is incorrent!!");
//		}
		
		if(!map.containsKey("HTML_NM")) {
			log.error("parameter HTML_NM null");
			throw new Exception("parameter HTML_NM null");
		}
		
		Map<String, String> parseMap = new HashMap<String, String>();
		
		HtmlEmail email = new HtmlEmail();
		email.setHostName(EgovProperties.getProperty("mx.server"));
		email.addTo(emailTo, "xxxx");
		email.setFrom(EgovProperties.getProperty("email.from"), EgovProperties.getProperty("email.fromname"));
		email.setSubject(emailSubject);
		
		//파일 읽기
		String template = Util.getStrFile(null, Util.getFullUrl() + "/" + EgovProperties.getProperty("email.url")+map.get("HTML_NM"));
		
		//메일 템플릿에 쓰일 동적 데이터만들기
		for(String mapkey : map.keySet()){
			parseMap.put("${"+mapkey+"}", map.get(mapkey));
		}
		
		//메일템플릿 데이터 변환
		for(String mapkey : parseMap.keySet()){
			template = EgovStringUtil.replace(template, mapkey, parseMap.get(mapkey));
		}
		
		email.setHtmlMsg(template);
		email.setTextMsg("Your email client does not support HTML messages");
		email.send();
		
		log.debug("mail ("+ EgovProperties.getProperty("mx.server")+") send success!!");
		
		Map<String, String> manageMap = new HashMap<String, String>();
		manageMap.put("MSG_SN", comTheMailDsptchManageSeq.getNextStringId());
		manageMap.put("MSG_SE", "01");
		manageMap.put("SJ", emailSubject);
		manageMap.put("MSG_CN", template);
		manageMap.put("SNDR", EgovProperties.getProperty("email.from"));
		manageMap.put("RCVER", emailTo);
		
		comz03DAO.insertComTheMailDsptchManage(manageMap);
		
		return true;
	}
}