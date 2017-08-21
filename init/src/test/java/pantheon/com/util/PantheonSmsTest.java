package pantheon.com.util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.service.PantheonSmsService;

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
		,"classpath:com/context-send-properties.xml"
})
public class PantheonSmsTest {
	
	@Resource(name = "PantheonSmsService")
	private PantheonSmsService pantheonSmsService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesSmsService")
	protected EgovPropertyService propertiesSmsService;
	
//	@Test
//	@Override
	public void insertSmsService() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		//보내는사람, TXT_NM
		map.put("HTML_NM", propertiesSmsService.getString("TEST_SMS_TEMPLATE"));
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		map.put("URL", "52.2.72.199:8080");

		pantheonSmsService.insertSmsService(map, "01071164074", "문자발송테스트");
	}
}
