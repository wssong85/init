package pantheon.com.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import pantheon.com.j01.dao.COMJ01DAO;
import pantheon.com.j01.service.COMJ01Service;
import pantheon.com.z06.dao.COMZ06DAO;

//@RunWith(SpringJUnit4ClassRunner.class)
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
})
public class PatheonAuditForClob {
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;
	
	@Resource(name = "COMJ01Service")
	private COMJ01Service comj01Service;
	
//	@Test
	public void selectAudit() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("MODULE_CODE", "COM");
		map.put("SDATE", "20160602");
		map.put("EDATE", "20160602");
		map.put("page", "1");
		map.put("count", "20");
		List<Map<String, Object>> list = comj01Service.selectCmDtaAtrailListByPk(map);
		
//		System.out.println(list.size());
//		int count = 0;
		for(Map<String, Object> iMap : list) {
			for(String mapkey : iMap.keySet()) {
				System.out.print(mapkey + " : [" + iMap.get(mapkey) + "] ");
			}
			System.out.println();
		}
	}
	
//    , #UPDTBFE_VALUE:CLOB#
//    , #AFTUPD_VALUE:CLOB#
//    , #STRE_ETC_RESN#
//    , #STRE_RESN_CODE#
//    , #USER_ID#
//    , #TABLE_NM#
//    , #COLUMN_NM#
//    , #TABLE_PK#
//    , #PK_NM#
//    , #MODULE#
//    , #LABEL_NM#
//    , #TASK_NO#
//    , (SELECT A.CONECT_IP 
//         FROM CM_PROGRM_CONECT A, 
//              CM_PROGRM B 
//        WHERE A.PROGRM_ID = B.PROGRM_ID 
//          AND A.CONECT_DT = (SELECT MAX(X.CONECT_DT) FROM CM_PROGRM_CONECT X WHERE X.USER_ID = #USER_ID#)
//          AND ROWNUM = 1)
//    , (SELECT B.PROGRM_NM 
//         FROM CM_PROGRM_CONECT A, 
//              CM_PROGRM B 
//        WHERE A.PROGRM_ID = B.PROGRM_ID 
//          AND A.CONECT_DT = (SELECT MAX(X.CONECT_DT) FROM CM_PROGRM_CONECT X WHERE X.USER_ID = #USER_ID#)
//          AND ROWNUM = 1)

	
//	@Test
	public void insertAudit() throws Exception {
//		comj01DAO.in
		Map<String, String> map = new HashMap<String, String>();
		map.put("UPDTBFE_VALUE", "이전값 CLOB 테스트");
		map.put("AFTUPD_VALUE", "이후값 CLOB 테스트");
		map.put("STRE_ETC_RESN", "리즌");
		map.put("STRE_RESN_CODE", "02");
		map.put("USER_ID", "admin");
		map.put("TABLE_NM", "ASD");
		map.put("COLUMN_NM", "asd");
		map.put("TABLE_PK", "asd");
		map.put("PK_NM", "asd");
		map.put("MODULE", "COM");
		map.put("LABEL_NM", "asd");
		map.put("TASK_NO", "asd");
		comz06DAO.insertCmDtaAtrailForClob(map);
	}

}
