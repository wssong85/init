package pantheon.com.i01.service;

import java.util.List;
import java.util.Map;

import pantheon.com.i01.web.LoginVO;

/**
 * 로그인 처리하는 비지니스 인터페이스 클래스
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
public interface COMI01Service {
	
	/**
	 * 로그인
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public LoginVO actionLogin(LoginVO vo) throws Exception;
	
	/**
	 * 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmMenuForModuleCode(Map<String, String> map) throws Exception;
	
	/**
	 * 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmMenuByModuleCode(Map<String, Object> map) throws Exception;
	
	/**
	 * 레프트메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmMenuForLeftMenu(Map<String, String> map) throws Exception;
	
	/**
	 * 레프트메뉴 조회(distinct)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmMenuDistinctForLeftMenu(Map<String, String> map) throws Exception;
	
	/**
	 * 과제레프트메뉴 조회(distinct)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectDistinctTaskByLeftMenu(Map<String, String> map) throws Exception;
	
	/**
	 * 과제레프트 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectTaskByLeftMenu(Map<String, String> map) throws Exception;
	
	/**
	 * 과제메뉴 카운팅
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskByMenuCnt(Map<String, String> map) throws Exception;
	
	/**
	 * 변경비밀번호 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public boolean selectCmUserForPasswordChangeDe(Map<String, String> map) throws Exception;
	
	/**
	 * 상단 헤더 프로그램조회(전체)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmProgrmForHeaderAllModule(Map<String, String> map) throws Exception;
	
	/**
	 * 상단 헤더 프로그램 조회(과제)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> selectCmProgrmForHeaderTaskModule(Map<String, String> map) throws Exception;
}
