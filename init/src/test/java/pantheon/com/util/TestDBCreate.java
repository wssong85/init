package pantheon.com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TestDBCreate {
	
	private static Connection connection;
	
	private static final String testUrl = "jdbc:mariadb://127.0.0.1:5306/realtime";
//	private static final String testUrl = "jdbc:oracle:thin:@52.2.42.141:1521:cjpandev";
	private static final String testUser = "realtime";
	private static final String testName = "1234";
	
	//실제 운영
	private static final String operationUrl = "jdbc:oracle:thin:@52.2.42.141:1521:cjpandev";
	private static final String operationUser = "o_cjpan";
	private static final String operationName = "o_cjpan1!";
	
	private static final String strSqlTableSelect =
			"SELECT TNAME FROM TAB WHERE TNAME NOT LIKE 'BIN%'";
	
	private static final String[] strSynonym = 
		{	
		"SAP_BCNC_INFO",
		"SAP_BCNC_TMPR",
		"INFRA_DEPT_TMPR",
		"INFRA_USER_TMPR",
		"CM_ROLE",
		"CM_ROLE_AUTHOR",
		"CM_BUTTON_AUTHOR",
		"CM_MENU",
		"CM_PROGRM",
		"CM_BUTTON",
		"CDISC_RULE",
		"CDISC_DOMN",
		"CDISC_DOMN_VRIABL",
		"CDISC_CL_CODE",
		"EDC_CR_MDIC",
		"EDC_CR_MEDDRA",
		"EDC_CR_ATC",
		"EDC_CR_WHOART",
		"EDC_CR_KIMS",
		"EDC_CR_KCD"
		};
	
	public static void main(String[] args) throws Exception {
//		List<String> list = TestDBCreate.execueQuery(strSqlTableSelect, operationUrl, operationUser, operationName);
		
//		for(String iStr : strSynonym) {
//			for(int i = 0; i < list.size(); i ++) {
//				if(iStr.equals(list.get(i))) {
//					list.remove(i);
//				}
//			}
//		}
		
//		for(String iStr : list) {
//			String str =
//					"CREATE TABLE " + testUser + "." + iStr + " AS" +
//			        " (SELECT * FROM " + iStr + ")";
//			TestDBCreate.excuteUpdate(str, operationUrl, operationUser, operationName);
//		}
		
		System.out.println(getConnection(testUrl, testUser, testName));
		System.out.println(1);
		
	}
	
	public static Connection getConnection(String url, String user, String name) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		if(connection == null) {
			connection = DriverManager.getConnection(url, user, name);
		}
		
		return connection;
	}
	
	public static List<String> execueQuery(String sql, String url, String user, String name) throws Exception {
		List<String> list = new ArrayList<String>();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;
		
		try {
			con = TestDBCreate.getConnection(url, user, name);
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				list.add(rs.getString("TNAME").toUpperCase());
				
			}
			
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
			
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
			
		}
		
		
		return list;
	}
	
	public static void excuteUpdate(String sql, String url, String user, String name) throws Exception {
		Statement pstmt = null;
		Connection con = null;
		
		try {
			
			con = TestDBCreate.getConnection(url, user, name);
			pstmt = con.createStatement();
			pstmt.executeUpdate(sql);
			
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
		} finally {
			
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
			
		}

	}

}



