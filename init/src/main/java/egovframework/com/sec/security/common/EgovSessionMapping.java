package egovframework.com.sec.security.common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

//import egovframework.com.cmm.LoginVO;
import pantheon.com.i01.web.LoginVO;
import egovframework.rte.fdl.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.security.userdetails.jdbc.EgovUsersByUsernameMapping;

import javax.sql.DataSource;

/**
 * mapRow 결과를 사용자 EgovUserDetails Object 에 정의한다.
 * 
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  ByungHun Woo    최초 생성
 *   2009.03.20  이문준          UPDATE
 *
 * </pre>
 */

public class EgovSessionMapping extends EgovUsersByUsernameMapping {
	
//	@Request(name = "")
	
	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
    }
	
	/**
	 * mapRow Override
	 * @param rs ResultSet 결과
	 * @param rownum row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
    protected EgovUserDetails mapRow(ResultSet rs, int rownum) throws SQLException {
    	logger.debug("## EgovUsersByUsernameMapping mapRow ##");
    	
    	
//    	A.USER_ID
//		,A.USER_NAME
//		,A.PASSWORD
//		,B.BIRTH_DT
//		,B.AGE
//		,B.PHONE
//		,B.ADDR
//		,B.EMAIL
    	
    	String strUserId = rs.getString("USER_ID");
    	String strUserName = rs.getString("USER_NAME");
    	String strBirthDt = rs.getString("BIRTH_DT");
    	String strAge = rs.getString("AGE");
    	String strPhone = rs.getString("PHONE");
    	String strAddr = rs.getString("ADDR");
    	String strEmail = rs.getString("EMAIL");
    	String strPassword = rs.getString("PASSWORD");
    	boolean strEnabled = rs.getBoolean("ENABLED");
    	
    	Map<String, Object> mapLogin = new HashMap<String, Object>();
    	
    	mapLogin.put("USER_ID", strUserId);
    	mapLogin.put("USER_NAME", strUserName);
    	mapLogin.put("BIRTH_DT", strBirthDt);
    	mapLogin.put("AGE", strAge);
    	mapLogin.put("PHONE", strPhone);
    	mapLogin.put("ADDR", strAddr);
    	mapLogin.put("EMAIL", strEmail);
    	mapLogin.put("PASSWORD", strPassword);
    	
//        String strUserId    = rs.getString("USER_ID");
//        String strPassWord  = rs.getString("PASSWORD");
//        boolean strEnabled  = rs.getBoolean("ENABLED");
//        String strUserNm  = rs.getString("USER_NM");
//        String strUserSeCode  = rs.getString("USER_SE_CODE");
//        String strUserEngnm = rs.getString("USER_ENGNM");
//        String strEmail = rs.getString("EMAIL");
//        String strTelno = rs.getString("TELNO");
//        String strLoginFailrCo = rs.getString("LOGIN_FAILR_CO");
//        String strPasswordChangeDe = rs.getString("PASSWORD_CHANGE_DE");
//        String strSbscrbDe = rs.getString("SBSCRB_DE");
//        String strAcntLockAt = rs.getString("ACNT_LOCK_AT");
//        String strUseYn = rs.getString("USE_YN");
//        String strFrstCrede = rs.getString("FRST_CREDE");
//        String strRegistId = rs.getString("REGIST_ID");
//        String strLastUpdde = rs.getString("LAST_UPDDE");
//        String strUpdateId = rs.getString("UPDATE_ID");
//        String strStdTimeStdr = rs.getString("STD_TIME_STDR");
        
//        LoginVO loginVO = new LoginVO();
//        loginVO.setUserId(strUserId);
//        loginVO.setPassword(strPassWord);
//        loginVO.setUserNm(strUserNm);
//        loginVO.setUserSeCode(strUserSeCode);
//        loginVO.setUserEngNm(strUserEngnm);
//        loginVO.setEmail(strEmail);
//        loginVO.setTelno(strTelno);
//        loginVO.setLoginFailrCo(strLoginFailrCo);
//        loginVO.setPasswordChangeDe(strPasswordChangeDe);
//        loginVO.setSbscrbDe(strSbscrbDe);
//        loginVO.setAcntLockAt(strAcntLockAt);
//        loginVO.setUseYn(strUseYn);
//        loginVO.setFrstCrede(strFrstCrede);
//        loginVO.setRegistId(strRegistId);
//        loginVO.setLastUpdde(strLastUpdde);
//        loginVO.setUpdateId(strUpdateId);
//        loginVO.setStdTimeStdr(strStdTimeStdr);
        
        return new EgovUserDetails(strUserId, strPassword, strEnabled, mapLogin);
    }
}
