package pantheon.sdb.f05.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import pantheon.com.z02.service.COMZ02Service;
import pantheon.sdb.f05.dao.SDBF05DAO;
import pantheon.sdb.f05.service.SDBF05Service;

/**
 * 교육이수리스트 등록 관리 구현 클래스
 * @author 이원민
 * @since 2016.03.22
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.22   이원민                    최초 생성
 *  
 */
@Service("SDBF05Service")
public class SDBF05ServiceImpl implements SDBF05Service {
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "SDBF05DAO")
	private SDBF05DAO sdbf05Dao;
	
	@Override
	public void insertEducationInfo(HttpServletRequest req) throws Exception{
		String fileSn = comz02Service.insertDmFileMstr(req, "SDB");
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", req.getParameter("SJ"));
		map.put("SN", req.getParameter("SN"));
		map.put("CN", req.getParameter("CN"));
		map.put("SE_CODE", req.getParameter("SE_CODE"));
		map.put("FILE_MASTR_SN", fileSn);
		map.put("USE_AT", "Y");
		map.put("USER_ID", "one6438");
		
		sdbf05Dao.insertEducationInfo(map);
	}
	
	@Override
	public void updateEducationInfo(HttpServletRequest req) throws Exception{
		comz02Service.insertDmFileDetailNonDelete(req, "SDB", req.getParameter("FILE_MASTR_SN"));
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", req.getParameter("SJ"));
		map.put("SN", req.getParameter("SN"));
		map.put("CN", req.getParameter("CN"));
		map.put("SE_CODE", req.getParameter("SE_CODE"));
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		map.put("USE_AT", "Y");
		map.put("USER_ID", "one6438");
		
		sdbf05Dao.updateEducationInfo(map);
		
		String[] strDeleteFile = req.getParameter("DELFILE").split(",");
		
		for(String strFileSn : strDeleteFile){
			Map<String, String> deleteFileMap = new HashMap<String, String>();
			deleteFileMap.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
			deleteFileMap.put("DETAIL_SN", strFileSn);
			
			sdbf05Dao.deleteFileInfo(deleteFileMap);
		}
	}
	
	@Override
	public List<Map<String, String>> selectEducationInfo(Map<String, String> param) throws Exception{
		return sdbf05Dao.selectEducationInfo(param);
	}
	
	@Override
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		sdbf05Dao.deleteFileInfo(param);
	}
	
	@Override
	public void deleteEducationInfo(Map<String, String> param)throws Exception{
		sdbf05Dao.deleteEducationInfo(param);
	}
}
