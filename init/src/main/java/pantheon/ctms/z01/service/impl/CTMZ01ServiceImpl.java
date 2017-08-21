package pantheon.ctms.z01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.ctms.r01.dao.CTMR01DAO;
import pantheon.ctms.r01.service.CTMR01Service;
import pantheon.ctms.z01.dao.CTMZ01DAO;
import pantheon.ctms.z01.service.CTMZ01Service;

@Service("CTMZ01Service")
public class CTMZ01ServiceImpl implements CTMZ01Service{

	@Resource(name = "CTMZ01DAO")
	private CTMZ01DAO ctmz01DAO;

	/**
	 * 기관정보 그리드 조회
	 */
	@Override
	public List<Map<String, Object>> selectInsttInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return ctmz01DAO.selectInsttInfo(map);
	}

	/**
	 * 방문그리드 조회
	 */
	@Override
	public List<Map<String, Object>> selectVisitReportInfo(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz01DAO.selectVisitReportInfo(map);
	}
	
	/**
	 * 방문그리드 조회
	 */
	@Override
	public List<Map<String, Object>> selectComPatibilityReportInfo(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return ctmz01DAO.selectComPatibilityReportInfo(map);
	}
	
	

}

	



















