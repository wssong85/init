package pantheon.ctms.j11.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.z02.service.DrmManageService;
import pantheon.ctms.j11.dao.DMCJ11DAO;
import pantheon.ctms.j11.service.DMCJ11Service;

@Service("DMCJ11Service")
public class DMCJ11ServiceImpl implements DMCJ11Service{

	@Resource(name = "DMCJ11DAO")
	private DMCJ11DAO dmcj11DAO;
	
	@Resource(name = "DMC_RTN_RESN_SEQ")
	private EgovIdGnrService dmcRtnresnSeq;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	@Resource(name = "SDM_FILE_MASTR")
	private EgovIdGnrService dmFileMastrSeq;
	
	@Resource(name = "SDM_FILE_DETAIL")
	private EgovIdGnrService dmFileDetailSeq;
	
	/**
	 * 기관정보 조회
	 */
	@Override
	public List<Map<String, Object>> selectInsttList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectInsttList(map);		
	}
	
	/**
	 * TodoList 기관정보 조회
	 */
	@Override
	public List<Map<String, Object>> selectTodoListInsttInfo(Map<String, String> map) throws Exception {
		
		return dmcj11DAO.selectTodoListInsttInfo(map); //TodoList 에서 호출했을때..		
	}

	@Override
	public List<Map<String, Object>> selectTaskUserList(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectTaskUserList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectReturnReasonInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectReturnReasonInfo(map);
	}
	
	@Override
	public void insertReturnReasonInfo(Map<String, String> iMap) throws Exception {

		if(iMap.get("CURD").equals("C")) {
			String rtnresnSeq = dmcRtnresnSeq.getNextStringId();
			iMap.put("SN", rtnresnSeq);
			dmcj11DAO.insertReturnReasonInfo(iMap);
		}
		else if(iMap.get("CURD").equals("U")) {
			dmcj11DAO.updateReturnReasonInfo(iMap);
		}
		else if(iMap.get("CURD").equals("D")) {
			dmcj11DAO.deleteReturnReasonInfo(iMap);
		}
	}
	/*------------------------------------------------------------------------------------------------------------*/
	
	@Override
	public void deleteFile(HttpServletRequest request, String path, String name) throws Exception {
		File file = new File(path + name);
		file.delete();
	}
	
	@Override
	public String insertDmFileMstr(HttpServletRequest request, Map<String, String> map) throws Exception {
		
		String moduleKnd = map.get("moduleKnd");
		String fileMastrSn = map.get("FILE_SN");
		if(StringUtils.isEmpty(moduleKnd)) {
			moduleKnd = "CTMS";
		}
		
		MultipartHttpServletRequest multiRequest = null;
		Map<String, MultipartFile> files = null;
		
		try {
			multiRequest = (MultipartHttpServletRequest) request;
			files = multiRequest.getFileMap();
		} catch (Exception e) {
			return null;
		}
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String strDate = sdf.format(d);
		
		String uploadPath = EgovProperties.getProperty("file.upload.path") 
				+ "/" + strDate.substring(0, 4) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/";
		
		File saveFolder = new File(uploadPath);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		Map<String, String> uploadMap = new HashMap<String, String>();
		
//			uploadMap.put("MODULE_KND", map.get("MODULE_KND"));
//			모듈이나 업로드 성격에 맞게 파라미터를 보내주도록 한다.
		uploadMap.put("MODULE_KND", moduleKnd);
		uploadMap.put("UPLOAD_PHYSIC_COURS",uploadPath);
		uploadMap.put("DWLD_PHYSIC_COURS", uploadPath);
		uploadMap.put("DRM_RELIS_AT", "");
		uploadMap.put("USE_AT", "Y");
		uploadMap.put("UPDATE_ID", "admin");
		
		if(StringUtils.isEmpty(fileMastrSn)){
			fileMastrSn = dmFileMastrSeq.getNextStringId();
			uploadMap.put("FILE_MASTR_SN", fileMastrSn);
			dmcj11DAO.insertDmFileMstr(uploadMap);
		}
		else{
			//Is Not null !!!!!
		}
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
//		String filePath = null;
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			
			if (!"".equals(file.getOriginalFilename())) {
				uploadMap = null;
				uploadMap = new HashMap<String, String>();
				String fileDetailSn = dmFileDetailSeq.getNextStringId();
				
				String uploadFileNm = moduleKnd + "_" + fileMastrSn + "_" + fileDetailSn;
				String fStr = file.getOriginalFilename();
				int ixFstr = file.getOriginalFilename().indexOf(".");
				
				uploadMap.put("DETAIL_SN", fileDetailSn);
				uploadMap.put("FILE_MASTR_SN", fileMastrSn);
				
				if(ixFstr > -1) {
					uploadMap.put("ORGINL_FILE_NM", fStr.substring(0, ixFstr));
					uploadMap.put("ORGINL_EXTSN_NM", fStr.substring(ixFstr + 1, fStr.length()));
				} else {
					uploadMap.put("ORGINL_FILE_NM", file.getOriginalFilename());
					uploadMap.put("ORGINL_EXTSN_NM", "");
				}
				
				uploadMap.put("UPLOAD_FILE_NM", uploadFileNm);
				
				uploadMap.put("ORGINL_SIZE", String.valueOf(file.getSize()));
				uploadMap.put("USE_AT", "Y");
				uploadMap.put("UPDATE_ID", "admin");
				
				//파일 상세 입력
				dmcj11DAO.insertDmFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
				
				//drm 테스트
//				drmManageService.doPackage(uploadPath, uploadFileNm);
//				drmManageService.doFileExtract(uploadPath, uploadFileNm);
			}
		}
		
		return fileMastrSn;
	}

	@Override
	public String insertDmFileDetail(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception {
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
//		String filePath = null;
		
		//파일 디테일 삭제
		dmcj11DAO.deleteDmFIleDetailByDmFileMstrSn(fileMastrSn);
		List<Map<String, String>> deleteFileList = dmcj11DAO.selectDmFileDetailForDmDetailDelete(fileMastrSn);
		for(Map<String, String> iMap : deleteFileList) {
			deleteFile(null, iMap.get("DWLD_PHYSIC_COURS"), iMap.get("UPLOAD_FILE_NM"));
		}
		
//		Date d = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//		String strDate = sdf.format(d);
		
//		String uploadPath = EgovProperties.getProperty("file.upload.path") 
//				+ "/" + strDate.substring(0, 4) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/";
		
		String uploadPath = deleteFileList.get(0).get("DWLD_PHYSIC_COURS");
		
		File saveFolder = new File(uploadPath);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		
		Map<String, String> uploadMap = new HashMap<String, String>();
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			
			file = entry.getValue();
			
			if (!"".equals(file.getOriginalFilename())) {
				uploadMap = null;
				uploadMap = new HashMap<String, String>();
				String fileDetailSn = dmFileDetailSeq.getNextStringId();
				
				String uploadFileNm = moduleKnd + "_" + fileMastrSn + "_" + fileDetailSn;
				String fStr = file.getOriginalFilename();
				int ixFstr = file.getOriginalFilename().indexOf(".");
				
				uploadMap.put("DETAIL_SN", dmFileDetailSeq.getNextStringId());
				uploadMap.put("FILE_MASTR_SN", fileMastrSn);
				
				if(ixFstr > -1) {
					uploadMap.put("ORGINL_FILE_NM", fStr.substring(0, ixFstr));
					uploadMap.put("ORGINL_EXTSN_NM", fStr.substring(ixFstr + 1, fStr.length()));
				} else {
					uploadMap.put("ORGINL_FILE_NM", file.getOriginalFilename());
					uploadMap.put("ORGINL_EXTSN_NM", "");
				}
				
				uploadMap.put("UPLOAD_FILE_NM", uploadFileNm);
				
				uploadMap.put("ORGINL_SIZE", String.valueOf(file.getSize()));
				uploadMap.put("USE_AT", "Y");
				uploadMap.put("UPDATE_ID", "admin");
				
				//파일 상세 입력
				dmcj11DAO.insertDmFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
			}
		}
		
		return fileMastrSn;
	}

	
	@Override
	public List<Map<String, Object>> selectDmFileMasterForSN(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectDmFileMasterForSN(map);
	}
	
	@Override
	public Map<String, Object> selectDmFileDetailInfo(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectDmFileDetailInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectTaskList(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectTaskList(map);
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeList(
			Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectCommonCodeList(map);
	}

	@Override
	public List<Map<String, Object>> selectUserRoleInfoList(
			Map<String, String> map) throws Exception {		
		return dmcj11DAO.selectUserRoleInfoList(map);
	}

	@Override
	public List<Map<String, Object>> selectRsrchUserInfo(Map<String, String> map)
			throws Exception {
		// TODO Auto-generated method stub
		return dmcj11DAO.selectRsrchUserInfo(map);
	}



	
}
