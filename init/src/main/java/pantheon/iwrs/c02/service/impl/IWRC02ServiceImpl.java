package pantheon.iwrs.c02.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.iwrs.c02.dao.IWRC02DAO;
import pantheon.iwrs.c02.service.IWRC02Service;

/**
 * 배송요청 알림 처리하는 구현 인터페이스 클래스
 * @author 이원민
 * @since 2016.02.24
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.02.24  이원민          최초 생성
 *  
 */
@Service("IWRC02Service")
public class IWRC02ServiceImpl implements IWRC02Service {
	@Resource(name = "IWRC02DAO")
	private IWRC02DAO iwrc02Dao;
	
	@Resource(name = "IWRS_DL_DLVYREQUSTMANAGE_INFO")
	private EgovPropertyService iwrsDlDlvyrequstmanageInfo;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

	@Override
	public List<Map<String, String>> selectRequestInfo(Map<String, String> param) throws Exception {
		return iwrc02Dao.selectRequestInfo(param);
	}

	@Override
	public void updateRequestInfo(Map<String, String> param) throws Exception {
		comz06Service.createCmDtaAtrailForUpdateByString(param, iwrsDlDlvyrequstmanageInfo, null, "관리약사 배송 요청 확인");
		iwrc02Dao.updateRequestInfo(param);
	}
	
}
