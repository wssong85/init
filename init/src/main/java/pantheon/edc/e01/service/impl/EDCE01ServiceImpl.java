package pantheon.edc.e01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.c01.dao.EDCC01DAO;
import pantheon.edc.e01.dao.EDCE01DAO;
import pantheon.edc.e01.service.EDCE01Service;


/**
 * eSign 관리를 처리하는 비지니스 구현 클래스
 * 
 * @author 오동근
 * @since 2016.05.23
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.05.23 오동근 최초 생성
 *      
 */
@Service("EDCE01Service")
public class EDCE01ServiceImpl implements EDCE01Service {
	
	@Resource(name = "EDCE01DAO")
	EDCE01DAO edcedao;
	
	@Resource(name = "EDCC01DAO")
	EDCC01DAO edccDao;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_EDC_CF_VISIT")
	protected EgovPropertyService atrailEdcCfVisit;
	
	@Resource(name = "ATRAIL_EDC_CF_SUBJECT")
	protected EgovPropertyService atrailEdcCfSubject;

	@Override
	public List<Map<String, Object>> selectESignVisitList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);
				
		return edcedao.selectESignVisitList(param);
	}

	@Override
	public List<Map<String, Object>> selectESignSubjectList(Map<String, Object> param) throws Exception {
		// EDC Version
		String EDC_VERSION = "";
		param.put("TASK_SN", Util.getUserMap().get("TASK_SN"));
		EDC_VERSION = edccDao.selectEdcVer(param);
		param.put("EDC_VERSION", EDC_VERSION);
		
		return edcedao.selectESignSubjectList(param);
	}

	@Override
	public void updateESignVisit(Map<String, String> param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		param.put("ELTSGN_STTUS_CODE", "03");
		map.put("UPDATE_SN", param.get("UPDATE_SN"));
		map.put("ELTSGN_STTUS_CODE", "03");
		comz06Service.createCmDtaAtrailForUpdateByObject(map, atrailEdcCfVisit, null, null);
		edcedao.updateESignVisit(param);
		
	}

	@Override
	public void updateESignSubject(Map<String, String> param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		param.put("ELTSGN_STTUS_CODE", "03");
		map.put("UPDATE_SN", param.get("UPDATE_SN"));
		map.put("ELTSGN_STTUS_CODE", "03");
		comz06Service.createCmDtaAtrailForUpdateByObject(map, atrailEdcCfSubject, null, null);
		edcedao.updateESignSubject(param);
	}

}
