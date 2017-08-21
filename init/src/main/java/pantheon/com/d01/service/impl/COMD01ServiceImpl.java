package pantheon.com.d01.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.d01.dao.COMD01DAO;
import pantheon.com.d01.service.COMD01Service;
import pantheon.com.utl.Util;
import pantheon.com.z06.service.COMZ06Service;

/**
 * 공통코드 처리하는 비지니스 구현 클래스
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
@Service("COMD01Service")
public class COMD01ServiceImpl implements COMD01Service{
	
	@Resource(name = "COMD01DAO")
	private COMD01DAO comd01DAO;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

	@Resource(name = "ATRAIL_CM_CLCODE")
	protected EgovPropertyService atrailCmClcode;
	
	@Resource(name = "ATRAIL_CM_CMMNCODE")
	protected EgovPropertyService atrailCmCmmncode;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public List<Map<String, Object>> selectCmClCodeListByPk(Map<String, String> map) throws Exception {
		return comd01DAO.selectCmClCodeListByPk(map);
	}

	@Override
	public int updateCmClCodeByPk(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException();
	}
	
	@Override
	public void insertCmClCode(List<Map<String, Object>> list) throws Exception {
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(comd01DAO.selectCmClCodeForDupCheck(iMap) > 0) {
//					throw new Exception("분류코드가 중복되었습니다.");
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comd0101.msg.1"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comd01DAO.insertCmClCode(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmClcode, null, null);
				
			} else if(iMap.get("CURD").equals("U")) {
				
				if(comd01DAO.selectCmCmmnCodeForDelete(iMap) > 0 && "N".equals(iMap.get("USE_AT"))) {
//					throw new Exception("분류코드에 포함된 공통코드를 모두 사용안함으로 수정해 주십시오.");
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comd0101.msg.2"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmClcode, null, null);
				comd01DAO.updateCmClCodeByPk(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				if(comd01DAO.selectCmCmmnCodeForDelete(iMap) > 0) {
//					throw new Exception("분류코드에 포함된 공통코드를 모두 사용안함으로 수정해 주십시오.");
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comd0101.msg.3"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmClcode, null, null);
				comd01DAO.updateCmClCodeForDelete(iMap);
				
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectCmCmmnCodeListByPk(Map<String, String> map) throws Exception {
		return comd01DAO.selectCmCmmnCodeListByPk(map);
	}

	@Override
	public int updateCmCmmnCodeByPk(Map<String, String> map) throws Exception {
		throw new UnsupportedOperationException();
	}

	@Override
	public void insertCmCmmnCode(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			if(iMap.get("CURD").equals("C")) {
				
				if(comd01DAO.selectCmCmmnCodeForDupCheck(iMap) > 0) {
//					throw new Exception("공통코드가 중복되었습니다.");
					throw new Exception(egovMessageSource.getPantheonExceptionMessage("comd0101.msg.4"));
				}
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comd01DAO.insertCmCmmnCode(iMap);
				comz06Service.createCmDtaAtrailForInsertByObject(iMap, atrailCmCmmncode, null, null);
				
			} else if(iMap.get("CURD").equals("U")){
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmCmmncode, null, null);
				comd01DAO.updateCmCmmnCodeByPk(iMap);
				
			} else if(iMap.get("CURD").equals("D")){
				
				iMap.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
				comz06Service.createCmDtaAtrailForUpdateByObject(iMap, atrailCmCmmncode, null, null);
				comd01DAO.updateCmCmmnCodeForDelete(iMap);
				
			}
		}
	}
}
