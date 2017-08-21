package pantheon.sdb.f04.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z02.service.DrmManageService;
import pantheon.sdb.f04.dao.SDBF04DAO;
import pantheon.sdb.f04.service.SDBF04Service;

/**
 * SOP 등록 관리 구현 클래스
 * @author 이원민
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일                  수정자                                         수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17   이원민                    최초 생성
 *  
 */
@Service("SDBF04Service")
public class SDBF04ServiceImpl implements SDBF04Service {
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "SDBF04DAO")
	private SDBF04DAO sdbf04Dao;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drm;
	
	@Override
	public void insertSopInfo(Map<String, String> param) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", param.get("SJ"));
		map.put("SN", param.get("SN"));
		map.put("CN", param.get("CN"));
		map.put("EFECT_OCCRRNC_AT", param.get("EFECT_OCCRRNC_AT"));
		map.put("EFECT_OCCRRNCDE", param.get("EFECT_OCCRRNCDE"));
		map.put("SE_CODE", param.get("SE_CODE"));
		map.put("FILE_MASTR_SN", param.get("FILE_MASTR_SN"));
		map.put("USE_AT", param.get("USE_AT"));
		map.put("USER_ID", param.get("USER_ID"));
		
		sdbf04Dao.insertSopInfo(map);
	}
	
	@Override
	public String insertSopFile(HttpServletRequest req) throws Exception{
		String fileSn = comz02Service.insertDmFileMstr(req, "SDB");
		return fileSn;
	}
	
	@Override
	public void updateSopInfo(Map<String, String> param) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("SJ", param.get("SJ"));
		map.put("SN", param.get("SN"));
		map.put("CN", param.get("CN"));
		map.put("EFECT_OCCRRNC_AT", param.get("EFECT_OCCRRNC_AT"));
		map.put("EFECT_OCCRRNCDE", param.get("EFECT_OCCRRNCDE"));
		map.put("SE_CODE", param.get("SE_CODE"));
		map.put("FILE_MASTR_SN", param.get("FILE_MASTR_SN"));
		map.put("USE_AT", param.get("USE_AT"));
		map.put("USER_ID", param.get("USER_ID"));
		
		sdbf04Dao.updateSopInfo(map);
		
		String[] strDeleteFile = param.get("DELFILE").split(",");
		
		for(String strFileSn : strDeleteFile){
			Map<String, String> deleteFileMap = new HashMap<String, String>();
			deleteFileMap.put("FILE_MASTR_SN", param.get("FILE_MASTR_SN"));
			deleteFileMap.put("DETAIL_SN", strFileSn);
			
			sdbf04Dao.deleteFileInfo(deleteFileMap);
		}
	}
	
	@Override
	public void updateSopFile(HttpServletRequest req, String fileSn) throws Exception{
		comz02Service.insertDmFileDetailNonDelete(req, "SDB", fileSn);
	}
	
	@Override
	public List<Map<String, String>> selectSopInfo(Map<String, String> param) throws Exception{
		return sdbf04Dao.selectSopInfo(param);
	}
	
	@Override
	public void deleteFileInfo(Map<String, String> param) throws Exception{
		sdbf04Dao.deleteFileInfo(param);
	}
	
	@Override
	public void deleteSopInfo(Map<String, String> param)throws Exception{
		sdbf04Dao.deleteSopInfo(param);
	}
}
