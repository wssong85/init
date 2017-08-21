package pantheon.com.e01;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import pantheon.com.e01.service.COME01Service;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		 "classpath:com/context-common2.xml"
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
})
public class COME01Test implements COME01Service{
	
	@Resource(name="COME01Service")
	private COME01Service come01Service;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(COME01Test.class);
	
//	@Test
	@Override
//	@Transactional("txManager")
	public void batchSapBcncTmpr() throws Exception {
		come01Service.batchSapBcncTmpr();
	}
	
//	@Test
	@Override
//	@Transactional("txManager")
	public void batchInfraDeptTmpr() throws Exception {
		come01Service.batchInfraDeptTmpr();
	}
	
	@Test
	@Override
//	@Transactional("txManager")
	public void batchInfraUserTmpr() throws Exception {
		try {
			come01Service.batchInfraUserTmpr();
		} catch (Exception e) {
			LOGGER.error("", e);
			throw e;
		}
	}

	@Override
	public void initialSapBcncTmpr() throws Exception {
		
	}

	@Override
	public void initialInfraDeptTmpr() throws Exception {
		
	}

	@Override
	public void initialInfraUserTmpr() throws Exception {
		
	}

	@Override
	public List<Map<String, Object>> selectCmIntrfcListByCondition(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectCmIntrfcListCountByCondition(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void selectCmSysEnvrnByEnvrnSe() throws Exception {
		// TODO Auto-generated method stub
		
	}

}