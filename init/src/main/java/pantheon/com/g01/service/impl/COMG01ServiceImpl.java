package pantheon.com.g01.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.g01.dao.COMG01DAO;
import pantheon.com.g01.service.COMG01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.dao.COMZ02DAO;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z06.dao.COMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;

@Service("COMG01Service")
public class COMG01ServiceImpl implements COMG01Service{
	
	@Resource(name = "COMG01DAO")
	private COMG01DAO comg01DAO;
	
	@Resource(name = "COMZ02DAO")
	private COMZ02DAO comz02DAO;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "NOTICE_SN_SEQ")
	private EgovIdGnrService noticeSnSeq;

	@Resource(name = "ATRAIL_CM_NOTICE")
	protected EgovPropertyService atrailCmNotice;
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;
	
	@Override
	public List<Map<String, Object>> selectCmNoticeListByPk(Map<String, String> map) throws Exception {
		return comg01DAO.selectCmNoticeListByPk(map);
	}

	@Override
	public int selectCmNoticeListCountByPk(Map<String, String> map) throws Exception {
		return comg01DAO.selectCmNoticeListCountByPk(map);
	}

	@SuppressWarnings({ "unchecked" })
	@Override
	public void insertCmNotice(Map<String, String> map, HttpServletRequest request) throws Exception {
		
		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		
		if(!"".equals(EgovStringUtil.isNullToString(map.get("FILE_MASTR_SN")))) {
			
			if(!"".equals(EgovStringUtil.isNullToString(map.get("DELETE_DETAIL_SN")))) {
				comz02Service.deleteDmFileDetailEachDelete(map.get("FILE_MASTR_SN"), map.get("DELETE_DETAIL_SN"));
			}
			
			comz02Service.insertDmFileDetailNonDelete(request, "COM", map.get("FILE_MASTR_SN"));
			
		} else {
			
			map.put("FILE_MASTR_SN", comz02Service.insertDmFileMstr(request, "COM"));
			
		}
		
		map.put("FIXING_AT", map.get("FIXING_AT") != null && "Y".equals(map.get("FIXING_AT")) ? "Y" : "N");
		map.put("USE_AT", "Y");
		
		if(!"".equals(EgovStringUtil.isNullToString(map.get("NOTICE_SN")))){
			
			comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmNotice, null, null);
			
			Map<String, Object> mapNoticeForAuditTrailBy = comg01DAO.selectCmNoticeByPk((Map<String, String>)(Object)map);
			
			//공지사항 내용이 바뀌었다면 audit trail 입력
			if(map.get("NOTICE_CN") != null && mapNoticeForAuditTrailBy.get("NOTICE_CN") != null && 
					!EgovStringUtil.isNullToString(mapNoticeForAuditTrailBy.get("NOTICE_CN")).equals(map.get("NOTICE_CN"))) {
				
				Map<String, String> mapForAuditClob = new HashMap<String, String>();
				mapForAuditClob.put("LABEL_NM", "공지 내용");
				mapForAuditClob.put("MODULE", "COM");
				mapForAuditClob.put("TABLE_PK", "NOTICE_SN");
				mapForAuditClob.put("COLUMN_NM", "NOTICE_CN");
				mapForAuditClob.put("TABLE_NM", "CM_NOTICE");
				mapForAuditClob.put("STRE_RESN_CODE", "04");
				mapForAuditClob.put("STRE_ETC_RESN", "");
				mapForAuditClob.put("UPDTBFE_VALUE", EgovStringUtil.isNullToString(mapNoticeForAuditTrailBy.get("NOTICE_CN")));
				mapForAuditClob.put("AFTUPD_VALUE", map.get("NOTICE_CN"));
				
				comz06DAO.insertCmDtaAtrailForClob(mapForAuditClob);
			}
			
			comg01DAO.updateCmNotice(map);
			
		} else {
			
			map.put("NOTICE_SN", noticeSnSeq.getNextStringId());
			comg01DAO.insertCmNotice(map);
			comz06Service.createCmDtaAtrailForInsertByString(map, atrailCmNotice, null, null);
			
			//공지내용 clob audit trail 입력
			Map<String, String> mapForAuditClob = new HashMap<String, String>();
			mapForAuditClob.put("LABEL_NM", "공지 내용");
			mapForAuditClob.put("MODULE", "COM");
			mapForAuditClob.put("TABLE_PK", "NOTICE_SN");
			mapForAuditClob.put("COLUMN_NM", "NOTICE_CN");
			mapForAuditClob.put("TABLE_NM", "CM_NOTICE");
			mapForAuditClob.put("STRE_RESN_CODE", "01");
			mapForAuditClob.put("STRE_ETC_RESN", "");
			mapForAuditClob.put("UPDTBFE_VALUE", "");
			mapForAuditClob.put("AFTUPD_VALUE", map.get("NOTICE_CN"));
			
			comz06DAO.insertCmDtaAtrailForClob(mapForAuditClob);
			
		}
	}

	@Override
	public int updateCmNotice(Map<String, String> map, HttpServletRequest request) throws Exception {
		
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmNotice, null, null);
		int ret = comg01DAO.updateCmNotice(map);
		
		return ret;
		
	}

	@Override
	public int updateCmNoticeForDelete(Map<String, String> map) throws Exception {
		
		map.put("UPDATE_ID", Util.getUserMap().get("USER_ID"));
		
		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmNotice, null, null);
		int ret = comg01DAO.updateCmNoticeForDelete(map);
		
		return ret;
		
	}

	@Override
	public int updateCmNoticeForInqireNum(Map<String, String> map) throws Exception {
		if(true) {
			throw new UnsupportedOperationException();
		}
//		return comg01DAO.updateCmNoticeForInqireNum(map);
		return 0;
	}

	@Override
	public Map<String, Object> selectCmNoticeByPk(Map<String, String> map) throws Exception {
		
		Map<String, Object> ret = new HashMap<String, Object>();
		
		ret = comg01DAO.selectCmNoticeByPk(map);
		
		int inquireNum = Integer.parseInt(EgovStringUtil.isNullToString(ret.get("INQIRE_NUM"))) + 1;
		
		ret.put("INQIRE_NUM", EgovStringUtil.isNullToString(inquireNum));
		
		comz06Service.createCmDtaAtrailForUpdateByObject(ret, atrailCmNotice, null, null);
		
		comg01DAO.updateCmNoticeForInqireNum(map);	
		
		return ret;
		
	}

}
