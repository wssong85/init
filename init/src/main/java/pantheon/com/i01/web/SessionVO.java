package pantheon.com.i01.web;

import java.io.Serializable;

/**
 * 세션 VO
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
@SuppressWarnings("serial")
public class SessionVO implements Serializable {
	
	/** 아이디 */
	private String sUserId;
	/** 이름 */
	private String sUserNm;
	/** 이메일 */
	private String sEmail;
	/** 사용자구분 */
	private String sUserSe;
	/** 조직(부서)ID */
	private String orgnztId;
	/** 고유아이디 */
	private String uniqId;
	/**
	 * sUserId attribute 를 리턴한다.
	 * @return String
	 */
	public String getSUserId() {
		return sUserId;
	}
	/**
	 * sUserId attribute 값을 설정한다.
	 * @param sUserId String
	 */
	public void setSUserId(String userId) {
		sUserId = userId;
	}
	/**
	 * sUserNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getSUserNm() {
		return sUserNm;
	}
	/**
	 * sUserNm attribute 값을 설정한다.
	 * @param sUserNm String
	 */
	public void setSUserNm(String userNm) {
		sUserNm = userNm;
	}
	/**
	 * sEmail attribute 를 리턴한다.
	 * @return String
	 */
	public String getSEmail() {
		return sEmail;
	}
	/**
	 * sEmail attribute 값을 설정한다.
	 * @param sEmail String
	 */
	public void setSEmail(String email) {
		sEmail = email;
	}
	/**
	 * sUserSe attribute 를 리턴한다.
	 * @return String
	 */
	public String getSUserSe() {
		return sUserSe;
	}
	/**
	 * sUserSe attribute 값을 설정한다.
	 * @param sUserSe String
	 */
	public void setSUserSe(String userSe) {
		sUserSe = userSe;
	}
	/**
	 * orgnztId attribute 를 리턴한다.
	 * @return String
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * orgnztId attribute 값을 설정한다.
	 * @param orgnztId String
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * uniqId attribute 를 리턴한다.
	 * @return String
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId String
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
}
