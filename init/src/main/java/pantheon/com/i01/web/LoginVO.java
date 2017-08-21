package pantheon.com.i01.web;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 로그인 VO
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  송원석          최초 생성
 *  
 */
public class LoginVO implements Serializable{
	
	private static final long serialVersionUID = -8274004534207618049L;
	
	private String userId;
	private String password;
	private String userNm;
	private String userSeCode;
	private String userEngNm;
	private String email;
	private String telno;
	private String loginFailrCo;
	private String passwordChangeDe;
	private String sbscrbDe;
	private String acntLockAt;
	private String useYn;
	private String frstCrede;
	private String registId;
	private String lastUpdde;
	private String updateId;
	private String stdTimeStdr;
	
	/**
	 * @return the stdTimeStdr
	 */
	public String getStdTimeStdr() {
		return stdTimeStdr;
	}
	/**
	 * @param stdTimeStdr the stdTimeStdr to set
	 */
	public void setStdTimeStdr(String stdTimeStdr) {
		this.stdTimeStdr = stdTimeStdr;
	}
	
	private List<Map<String, String>> userUrl;

	/**
	 * @return the userUrl
	 */
	public List<Map<String, String>> getUserUrl() {
		return userUrl;
	}
	/**
	 * @param userUrl the userUrl to set
	 */
	public void setUserUrl(List<Map<String, String>> userUrl) {
		this.userUrl = userUrl;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the userSeCode
	 */
	public String getUserSeCode() {
		return userSeCode;
	}
	/**
	 * @param userSeCode the userSeCode to set
	 */
	public void setUserSeCode(String userSeCode) {
		this.userSeCode = userSeCode;
	}
	/**
	 * @return the userEngNm
	 */
	public String getUserEngNm() {
		return userEngNm;
	}
	/**
	 * @param userEngNm the userEngNm to set
	 */
	public void setUserEngNm(String userEngNm) {
		this.userEngNm = userEngNm;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the telno
	 */
	public String getTelno() {
		return telno;
	}
	/**
	 * @param telno the telno to set
	 */
	public void setTelno(String telno) {
		this.telno = telno;
	}
	/**
	 * @return the loginFailrCo
	 */
	public String getLoginFailrCo() {
		return loginFailrCo;
	}
	/**
	 * @param loginFailrCo the loginFailrCo to set
	 */
	public void setLoginFailrCo(String loginFailrCo) {
		this.loginFailrCo = loginFailrCo;
	}
	/**
	 * @return the passwordChangeDe
	 */
	public String getPasswordChangeDe() {
		return passwordChangeDe;
	}
	/**
	 * @param passwordChangeDe the passwordChangeDe to set
	 */
	public void setPasswordChangeDe(String passwordChangeDe) {
		this.passwordChangeDe = passwordChangeDe;
	}
	/**
	 * @return the sbscrbDe
	 */
	public String getSbscrbDe() {
		return sbscrbDe;
	}
	/**
	 * @param sbscrbDe the sbscrbDe to set
	 */
	public void setSbscrbDe(String sbscrbDe) {
		this.sbscrbDe = sbscrbDe;
	}
	/**
	 * @return the acntLockAt
	 */
	public String getAcntLockAt() {
		return acntLockAt;
	}
	/**
	 * @param acntLockAt the acntLockAt to set
	 */
	public void setAcntLockAt(String acntLockAt) {
		this.acntLockAt = acntLockAt;
	}
	/**
	 * @return the userYn
	 */
	public String getUseYn() {
		return useYn;
	}
	/**
	 * @param userYn the userYn to set
	 */
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	/**
	 * @return the frstCrede
	 */
	public String getFrstCrede() {
		return frstCrede;
	}
	/**
	 * @param frstCrede the frstCrede to set
	 */
	public void setFrstCrede(String frstCrede) {
		this.frstCrede = frstCrede;
	}
	/**
	 * @return the registId
	 */
	public String getRegistId() {
		return registId;
	}
	/**
	 * @param registId the registId to set
	 */
	public void setRegistId(String registId) {
		this.registId = registId;
	}
	/**
	 * @return the lastUpdde
	 */
	public String getLastUpdde() {
		return lastUpdde;
	}
	/**
	 * @param lastUpdde the lastUpdde to set
	 */
	public void setLastUpdde(String lastUpdde) {
		this.lastUpdde = lastUpdde;
	}
	/**
	 * @return the updateId
	 */
	public String getUpdateId() {
		return updateId;
	}
	/**
	 * @param updateId the updateId to set
	 */
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
