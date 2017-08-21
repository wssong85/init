package pantheon.com.utl.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonSmsService;
import pantheon.com.z03.dao.COMZ03DAO;

@Service("PantheonSmsService")
public class PantheonSmsServiceImpl implements PantheonSmsService{

	private static final Logger log = LoggerFactory.getLogger(PantheonMailServiceImpl.class);
	
	@Resource(name = "COMZ03DAO")
	private COMZ03DAO comz03DAO;
	
	@Resource(name = "MMS_MSG_SEQ")
	private EgovIdGnrService mmsMsgSeq;
	
	@Resource(name = "COMTHEMAILDSPTCHMANAGE_SEQ")
	private EgovIdGnrService comTheMailDsptchManageSeq;
	
	@Override
	public boolean insertSmsService(Map<String, String> map, String smsTo, String smsSubject) throws Exception {
		
		if(!Util.isRegexStr(smsTo, "number")) {
			log.debug("ERROR: Please input the correct phone number!!");
			throw new Exception("ERROR: Please input the correct phone number!!");
		}
		
		map.put("MSGKEY", mmsMsgSeq.getNextStringId());
		map.put("CALLBACK", EgovProperties.getProperty("sms.send.telno"));
		map.put("PHONE", smsTo);
		String msg = Util.getStrFile(null, Util.getFullUrl() + "/" + EgovProperties.getProperty("sms.url")+map.get("HTML_NM"));
		
		Map<String, String> parseMap = new HashMap<String, String>();
		
		//SMS 템플릿에 쓰일 동적 데이터만들기
		for(String mapkey : map.keySet()){
			parseMap.put("${"+mapkey+"}", map.get(mapkey));
		}
		
		//SMS템플릿 데이터 변환
		for(String mapkey : parseMap.keySet()){
			msg = EgovStringUtil.replace(msg, mapkey, parseMap.get(mapkey));
		}
		
		map.put("SUBJECT", smsSubject);
		
		//엔터값 변환
		msg = EgovStringUtil.replace(msg, "(NEWLINE)", "\n");
		
		map.put("MSG", msg);
		
		comz03DAO.insertMmsMsgForLms(map);
		
		log.debug("sms send success!!");
		
		Map<String, String> manageMap = new HashMap<String, String>();
		manageMap.put("MSG_SN", comTheMailDsptchManageSeq.getNextStringId());
		manageMap.put("MSG_SE", "02");
		manageMap.put("SJ", map.get("SUBJECT"));
		manageMap.put("MSG_CN", map.get("MSG"));
		manageMap.put("SNDR", map.get("CALLBACK"));
		manageMap.put("RCVER", map.get("PHONE"));
		
		comz03DAO.insertComTheMailDsptchManage(manageMap);
		
		return true;
	}

}
