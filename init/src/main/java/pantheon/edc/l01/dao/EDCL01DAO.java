package pantheon.edc.l01.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * Data import 목록을 위한 데이터 접근 클래스
 * @author 오동근
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17  오동근          최초 생성
 *  
 */
@Repository("EDCL01DAO")
public class EDCL01DAO extends EgovComAbstractDAO{
	
	/**
	 * Data import 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCL01DAO.selectCdiscList", param);
	}
	
	/**
	 * Data import 목록 Count
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String selectCdiscListCount(Map<String, Object>param)throws Exception{
		return (String) select("EDCL01DAO.selectCdiscListCount", param); 
	}
	
	/**
	 * Define.xml 파싱 후 EDC_CF_CDISC에 INSERT
	 * @param param
	 * @throws Exception
	 */
	public void insertCdisc(Map<String, Object> param) throws Exception{
		insert("EDCL01DAO.insertCdisc", param);
	}
	
	/**
	 * Define.xml 파싱 후 EDC_CF_CDISCDOMN에 INSERT
	 * @param param
	 * @throws Exception
	 */
	public void insertCdiscDomn(Map<String, Object> param) throws Exception{
		insert("EDCL01DAO.insertCdiscDomn", param);
	}
	
	/**
	 * Define.xml 파싱 후 EDC_CF_CDISCVRIABL에 INSERT
	 * @param param
	 * @throws Exception
	 */
	public void insertCdiscVriabl(Map<String, Object> param) throws Exception{
		insert("EDCL01DAO.insertCdiscVriabl", param);
	}
	
	/**
	 * Define.xml 파싱 후 EDC_CF_CDISCCODE에 INSERT
	 * @param param
	 * @throws Exception
	 */
	public void insertCdiscCode(Map<String, Object> param) throws Exception{
		insert("EDCL01DAO.insertCdiscCode", param);
	}
	
	/**
	 * 도메인 명 콤보박스 List
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscDomainList(String cfcdiscSn) throws Exception{
		return (List<Map<String, Object>>) list("EDCL01DAO.selectCdiscDomainList", cfcdiscSn);
	}
	
	/**
	 * 하위 xml 및 Excel 파싱 할때 기준이 되는 변수명과 순서 및 Data Import view 그리드 동적 생성 List 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscVriablList(String cfcdiscDomnSn) throws Exception{
		return (List<Map<String, Object>>) list("EDCL01DAO.selectCdiscVriablList", cfcdiscDomnSn);
	}
	
	/**
	 * 파싱 후 EDC_CF_VALUE에 INSERT
	 * @param param
	 * @throws Exception
	 */
	public void insertCdiscValue(Map<String, Object> param) throws Exception{
		insert("EDCL01DAO.insertCdiscValue", param);
	}
	
	/**
	 * Data Import view 그리드 동적 생성 Value값  List 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCdiscVariablValueList(Map<String, Object> param) throws Exception{
		return (List<Map<String, Object>>) list("EDCL01DAO.selectCdiscVariablValueList", param);
	}
	
}
