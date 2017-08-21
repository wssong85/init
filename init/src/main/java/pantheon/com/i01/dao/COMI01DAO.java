package pantheon.com.i01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pantheon.com.i01.web.LoginVO;
import pantheon.com.utl.Util;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 로그인 관리를 위한 데이터 접근 클래스
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
@Repository("COMI01DAO")
public class COMI01DAO extends EgovComAbstractDAO{
	
	/**
	 * 로그인
	 * @param vo
	 * @return
	 */
	public LoginVO actionLogin(LoginVO vo) {
		return (LoginVO) select("COMI01DAO.actionLogin", vo);
	}
	
	/**
	 * 유저 조회
	 * @param vo
	 * @return
	 */
	public int selectCmUserForCmSysConect(LoginVO vo) {
		return (Integer) select("COMI01DAO.selectCmUserForCmSysConect", vo);
	}
	
	/**
	 * intro화면에서 유저에 맞는 모듈을 가져온다.
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCmMenuForModuleCode(Map<String, String> map) {
		return (List<Map<String, Object>>) list("COMI01DAO.selectCmMenuForModuleCode", map); 
	}
	
	/**
	 * MODULE_SE를 기준으로 리스트 조회
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmMenuByModuleCode(Map<String, Object> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("COMI01DAO.selectCmMenuByModuleCode", map);
	}
	
	/**
	 * 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmMenuForLeftMenu(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("COMI01DAO.selectCmMenuForLeftMenu", map);
	}
	
	/**
	 * 메뉴조회(dinstainct)
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmMenuDistinctForLeftMenu(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("COMI01DAO.selectCmMenuDistinctForLeftMenu", map);
	}
	

	/**
	 * 과제메뉴조회(distinct)
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectDistinctTaskByLeftMenu(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("COMI01DAO.selectDistinctTaskByLeftMenu", map);
	}
	
	/**
	 * 과제메뉴조회
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectTaskByLeftMenu(Map<String, String> map) throws Exception {
		map.put("LOCALE", Util.getStrLocale());
		return (List<Map<String, String>>) list("COMI01DAO.selectTaskByLeftMenu", map);
	}
	
	/**
	 * 과제메뉴 카운팅
	 * @param map
	 * @return
	 */
	public int selectTaskByMenuCnt(Map<String, String> map) {
		return (Integer) select("COMI01DAO.selectTaskByMenuCnt", map);
	}
	
	/**
	 * 변경비밀번호 조회
	 * @param map
	 * @return
	 */
	public int selectCmUserForPasswordChangeDe(Map<String, String> map) {
		return (Integer) select("COMI01DAO.selectCmUserForPasswordChangeDe", map);
	}
	
	/**
	 * 상단 헤더 프로그램 조회(전체)
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmProgrmForHeaderAllModule(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMI01DAO.selectCmProgrmForHeaderAllModule", map);
	}
	
	/**
	 * 상단 헤더 프로그램 조회(과제)
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> selectCmProgrmForHeaderTaskModule(Map<String, String> map) {
		return (List<Map<String, String>>) list("COMI01DAO.selectCmProgrmForHeaderTaskModule", map);
	}

}
