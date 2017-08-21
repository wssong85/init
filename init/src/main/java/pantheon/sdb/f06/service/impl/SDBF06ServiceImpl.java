package pantheon.sdb.f06.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import pantheon.com.z02.service.COMZ02Service;
import pantheon.sdb.f06.dao.SDBF06DAO;
import pantheon.sdb.f06.service.SDBF06Service;

/**
 * 전자이력서 등록 관리 구현 클래스
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
@Service("SDBF06Service")
public class SDBF06ServiceImpl implements SDBF06Service {
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "SDBF06DAO")
	private SDBF06DAO sdbf06Dao;
	
	@Override
	public void insertResumeInfo(HttpServletRequest req) throws Exception{
		String fileSn = comz02Service.insertDmFileMstr(req, "SDB");
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", req.getParameter("SJ"));
		map.put("SN", req.getParameter("SN"));
		map.put("CN", req.getParameter("CN"));
		map.put("SE_CODE", req.getParameter("SE_CODE"));
		map.put("FILE_MASTR_SN", fileSn);
		map.put("USE_AT", "Y");
		map.put("USER_ID", "one6438");
		
		sdbf06Dao.insertResumeInfo(map);
	}
	
	@Override
	public void updateResumeInfo(HttpServletRequest req) throws Exception{
		comz02Service.insertDmFileDetailNonDelete(req, "SDB", req.getParameter("FILE_MASTR_SN"));
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", req.getParameter("SJ"));
		map.put("SN", req.getParameter("SN"));
		map.put("CN", req.getParameter("CN"));
		map.put("SE_CODE", req.getParameter("SE_CODE"));
		map.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
		map.put("USE_AT", "Y");
		map.put("USER_ID", "one6438");
		
		sdbf06Dao.updateResumeInfo(map);
		
		String[] strDeleteFile = req.getParameter("DELFILE").split(",");
		
		for(String strFileSn : strDeleteFile){
			Map<String, String> deleteFileMap = new HashMap<String, String>();
			deleteFileMap.put("FILE_MASTR_SN", req.getParameter("FILE_MASTR_SN"));
			deleteFileMap.put("DETAIL_SN", strFileSn);
			
			sdbf06Dao.deleteFileInfo(deleteFileMap);
		}
	}
	
	@Override
	public List<Map<String, String>> selectResumeInfo(Map<String, String> param) throws Exception{
		return sdbf06Dao.selectResumeInfo(param);
	}
	
	@Override
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		sdbf06Dao.deleteFileInfo(param);
	}
	
	@Override
	public void deleteResumeInfo(Map<String, String> param)throws Exception{
		sdbf06Dao.deleteResumeInfo(param);
	}
}
