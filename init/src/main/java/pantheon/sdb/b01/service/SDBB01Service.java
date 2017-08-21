package pantheon.sdb.b01.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SDBB01Service {

	/**
	 * 의약품 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectProductList(Map<String, String> map) throws Exception;	

	/**
	 * 의약품 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	public String insertProductList(Map<String, String> param) throws Exception;

	/**
	 * 의약품 상세조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> selectProductListInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 취급의약품 등록
	 * @param map
	 * @param String
	 * @return
	 * @throws Exception
	 */
	public void insertProductReport(Map<String, String> param) throws Exception;
	
	/**
	 * 의약품 상세조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProductReportInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * Label 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectLabelList(Map<String, String> map) throws Exception;

	/**
	 * 파일등록
	 * @param request
	 * @param String
	 * @return 
	 * @throws Exception
	 */
	
	public String insertDmFileMstr(HttpServletRequest request, String string) throws Exception;
	
	/**
	 * Label 등록/수정/삭제
	 * @param map
	 * @param string
	 * @return
	 * @throws Exception
	 */
	public void insertLabelList(Map<String, String> param) throws Exception;

	/**
	 * 파일업로드
	 * @param request
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void uploadFile(HttpServletRequest request, String path, String name) throws Exception;
	
	/**
	 * 파일삭제
	 * @param request
	 * @param path
	 * @param name
	 * @throws Exception
	 */
	public void deleteFile(HttpServletRequest request, String path, String name) throws Exception;

	/**
	 * Label 리스트 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectLabelListInfo(Map<String, Object> param) throws Exception;
	
	/**
	 * 파일상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) throws Exception;

	/**
	 * 파일상세 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) throws Exception;

	/**
	 * PSUR 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPSURList(Map<String, String> map) throws Exception;
	
	/**
	 * PSUR 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertPSURList(Map<String, String> param) throws Exception;
	
	/**
	 * PSUR 상세  조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPSURListInfo(Map<String, Object> param) throws Exception;
	
	
	/**
	 * PSUR 목록 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNonCList(Map<String, String> map) throws Exception;
	
	/**
	 * PSUR 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void  insertNonCList(Map<String, String> param) throws Exception;
	
	/**
	 * PSUR 상세  조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectNonCListInfo(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectOrganCodeListByPk(Map<String, String> map_ori) throws Exception;

	
}
