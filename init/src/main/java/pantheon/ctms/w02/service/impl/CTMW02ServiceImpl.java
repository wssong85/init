package pantheon.ctms.w02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.r01.dao.CTMR01DAO;
import pantheon.ctms.r01.service.CTMR01Service;
import pantheon.ctms.w02.dao.CTMW02DAO;
import pantheon.ctms.w02.service.CTMW02Service;

@Service("CTMW02Service")
public class CTMW02ServiceImpl implements CTMW02Service{

	@Resource(name = "CTMW02DAO")
	private CTMW02DAO ctmw02DAO;

	/**
	 * CRF Status Report 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectCTMW0201(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.selectCTMW0201(map);
	}	
	
	
	
	
	/**
	 * CRF Status Report : VISIT 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectCTMW0202(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.selectCTMW0202(map);
	}
	
	/**
	 * Subject CRF Version Report 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectCTMW0203(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.selectCTMW0203(map);
	}
	
	/**
	 * User Report 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectCTMW0205(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.selectCTMW0205(map);//ctmw02DAO.selectCRFStatusReportVisit(map);
		
	}
	
	/**
	 * User History Report 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectCTMW0206(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.selectCTMW0206(map);//ctmw02DAO.selectCRFStatusReportVisit(map);
		
	}

	/**
	 * Time Zone 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> standardTimeList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmw02DAO.standardTimeList(map);
	}

	

	

	

	
	



	
	
	

}

	



















