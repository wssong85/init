package pantheon.ctms.o01.service;

import java.util.List;
import java.util.Map;

public interface CTMO01Service {
	
	/**
	 * 연구자 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 연구자 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void updateRsrchUserInfo(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 조사연구기관 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchInstt(Map<String, String> map) throws Exception;
	
	/**
	 * 조사연구기관 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchInstt(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 계약관리 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCntrctManage(Map<String, String> map) throws Exception;
	
	/**
	 * 계약관리 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void updateCntrctManage(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 연구비 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResearchFunds(Map<String, String> map) throws Exception;
	
	/**
	 * 연구비 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertResearchFunds(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * IRB심의 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchDlbrt(Map<String, String> map) throws Exception;
	
	/**
	 * IRB심의 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchDlbrt(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 동의서 정보 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchWrtcns(Map<String, String> map) throws Exception;
	
	/**
	 * 동의서 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchWrtcns(List<Map<String, Object>> list) throws Exception;
	
	/**
	 * 버전관리 조회
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRsrchVer(Map<String, String> map) throws Exception;
	
	/**
	 * 버전 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertRsrchVer(List<Map<String, Object>> list) throws Exception;
	
}
