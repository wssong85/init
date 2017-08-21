package pantheon.com.e01.service;

import java.util.List;
import java.util.Map;

/**
 * 인터페이스 처리하는 비지니스 인터페이스 클래스
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
public interface COME01Service {
	
	/**
	 * SAP정보 배치
	 * @throws Exception
	 */
	public void batchSapBcncTmpr() throws Exception;
	
	/**
	 * 부서정보 배치
	 * @throws Exception
	 */
	public void batchInfraDeptTmpr() throws Exception;
	
	/**
	 * 유저정보 배치
	 * @throws Exception
	 */
	public void batchInfraUserTmpr() throws Exception;
	
	/**
	 * SAP정보 없을 시 실행
	 * @throws Exception
	 */
	public void initialSapBcncTmpr() throws Exception;
	
	/**
	 * 부서정보 없을 시 실행
	 * @throws Exception
	 */
	public void initialInfraDeptTmpr() throws Exception;
	
	/**
	 * 유저정보 없을 시 실행
	 * @throws Exception
	 */
	public void initialInfraUserTmpr() throws Exception;
	
	/**
	 * 인터페이스 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmIntrfcListByCondition(Map<String, String> map) throws Exception;
	
	/**
	 * 인터페이스 목록 카운트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCmIntrfcListCountByCondition(Map<String, String> map) throws Exception;
	
	/**
	 * 운영/테스트 구분하는 환경테이블 조회
	 * @return true: 운영, false: 테스트
	 * @throws Exception
	 */
	public void selectCmSysEnvrnByEnvrnSe() throws Exception;
}
