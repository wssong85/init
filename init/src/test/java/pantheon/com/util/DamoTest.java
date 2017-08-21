package pantheon.com.util;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import pantheon.com.common.service.PantheonCommonService;
import pantheon.com.utl.service.DamoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:com/context-common.xml"
		,"classpath:com/context-aspect.xml"
		,"classpath:com/context-idgn-pantheon.xml"
		,"classpath:com/context-datasource.xml"
		,"classpath:com/context-sqlMap.xml"
		,"classpath:com/context-transaction.xml"
		,"classpath:com/context-properties.xml"
		,"classpath:com/context-com-atrail-properties.xml"
		,"classpath:com/context-ctms-atrail-properties.xml"
		,"classpath:com/context-edc-atrail-properties.xml"
		,"classpath:com/context-iwrs-atrail-properties.xml"
		,"classpath:com/context-scheduling-panteon.xml"
		,"classpath:com/context-sdb-atrail-properties.xml"
		,"classpath:com/context-excel.xml"
})
public class DamoTest {
	
	@Resource(name = "DamoService")
	private DamoService damoService;
	
	@Resource(name = "PantheonCommonService")
	private PantheonCommonService pantheonCommonService;
	
	@Test
	public void selectDamo() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("QUERY", "selectDamoTest");
		try {
			Map<String, Object> mapDamo = pantheonCommonService.selectQueryData(map);
			
//			System.out.println(mapDamo.get("AFTUPD_VALUE"));
			String test = damoService.scpDecStr(EgovStringUtil.isNullToString(mapDamo.get("AFTUPD_VALUE")));
			System.out.println("1");
			System.out.println(test);
			System.out.println("2");
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
	}
}
