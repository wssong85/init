package pantheon.com.enc;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import pantheon.com.z03.dao.COMZ03DAO;

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
})
public class EncTest {
	//단방향 암호화
	
	//양방향 암호화
	@Resource(name = "COMZ03DAO")
	private COMZ03DAO comz03DAO;
	
//	@Test
	public void selectComPasswordTest() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "12345678");
		Assert.assertEquals(1, comz03DAO.selectComPasswordTest(map));
	}

//	@Test
	public void selectComEncTest() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "12345678");
		Map<String, String> map2 = comz03DAO.selectComEncTest(map);
		System.out.println("EMAIL :" + map2.get("EMAIL"));
		System.out.println("PASSWORD : " + map2.get("PASSWORD"));
	}

//	@Test
//	@Transactional("txManager")
	public void updateComPasswordTest() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("USER_ID", "admin");
		map.put("PASSWORD", "1234");
		Assert.assertEquals(1, comz03DAO.updateComPasswordTest(map));
	}
	
//	@Test
//	@Transactional("txManager")
	public void updateComEmailTest() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("USER_ID", "admin");
		map.put("EMAIL", "wssong2@cj.net");
		Assert.assertEquals(1, comz03DAO.updateComEmailTest(map));
	}

}
