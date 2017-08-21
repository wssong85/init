package pantheon.com.z02.service.impl;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonPdfWriterService;
import pantheon.com.z02.dao.COMZ02DAO;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z02.service.DrmManageService;

@Service("COMZ02Service")
public class COMZ02ServiceImpl implements COMZ02Service{

	@Resource(name = "COMZ02DAO")
	private COMZ02DAO comz02DAO;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	@Resource(name = "PantheonPdfWriterService")
	private PantheonPdfWriterService pantheonPdfWriterService;
	
	@Resource(name = "SDM_FILE_MASTR")
	private EgovIdGnrService dmFileMastrSeq;
	
	@Resource(name = "SDM_FILE_DETAIL")
	private EgovIdGnrService dmFileDetailSeq;
	
	@Override
	public String insertDmFileMstrForPdf(EgovPropertyService egovPeopertyService, String moduleKnd, String fileNm, Map<String, String> map) throws Exception {
		
		if(moduleKnd == null) {
			moduleKnd = "COM";
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
		
		String fileMastrSn = dmFileMastrSeq.getNextStringId();
		
		uploadMap.put("FILE_MASTR_SN", fileMastrSn);
		uploadMap.put("MODULE_KND", moduleKnd);
		uploadMap.put("UPLOAD_PHYSIC_COURS",uploadPath);
		uploadMap.put("DWLD_PHYSIC_COURS", uploadPath);
		uploadMap.put("DRM_RELIS_AT", "");
		uploadMap.put("USE_AT", "Y");
		uploadMap.put("UPDATE_ID", "admin");
		
		//파일마스터 입력
		comz02DAO.insertDmFileMstr(uploadMap);
		
		uploadMap = null;
		uploadMap = new HashMap<String, String>();
		
		String fileDetailSn = dmFileDetailSeq.getNextStringId();
		String uploadFileNm = moduleKnd + "_" + fileMastrSn + "_" + fileDetailSn;
		
		uploadMap.put("DETAIL_SN", fileDetailSn);
		uploadMap.put("FILE_MASTR_SN", fileMastrSn);

		uploadMap.put("ORGINL_FILE_NM", fileNm);
		uploadMap.put("ORGINL_EXTSN_NM", "pdf");

		uploadMap.put("UPLOAD_FILE_NM", uploadFileNm);
		
		//PDF 생성
		uploadMap.put("ORGINL_SIZE", EgovStringUtil.isNullToString(pantheonPdfWriterService.pdfWriter(egovPeopertyService, uploadPath, uploadFileNm, map)));
		uploadMap.put("USE_AT", "Y");
		uploadMap.put("UPDATE_ID", "admin");

		comz02DAO.insertDmFileDetail(uploadMap);
		
		return fileMastrSn;
	}	
	
	@Override
	public String insertDmFileMstr(HttpServletRequest request, String moduleKnd) throws Exception {
		
		if(moduleKnd == null) {
			moduleKnd = "COM";
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
		
		String fileMastrSn = dmFileMastrSeq.getNextStringId();
		
		uploadMap.put("FILE_MASTR_SN", fileMastrSn);
//			uploadMap.put("MODULE_KND", map.get("MODULE_KND"));
//			모듈이나 업로드 성격에 맞게 파라미터를 보내주도록 한다.
		uploadMap.put("MODULE_KND", moduleKnd);
		uploadMap.put("UPLOAD_PHYSIC_COURS",uploadPath);
		uploadMap.put("DWLD_PHYSIC_COURS", uploadPath);
		uploadMap.put("DRM_RELIS_AT", "");
		uploadMap.put("USE_AT", "Y");
		uploadMap.put("UPDATE_ID", "admin");
		
		//파일마스터 입력
		comz02DAO.insertDmFileMstr(uploadMap);
		
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
				comz02DAO.insertDmFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
				
				//drm이 걸려있다면, 마지막으로 풀어줌
//				drmManageService.doFileExtract(uploadPath + uploadFileNm);
			}
		}
		
		return fileMastrSn;
	}

	@Override
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) throws Exception {
		return comz02DAO.selectDmFileDetailByPk(map);
	}

	@Override
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) throws Exception {
		return comz02DAO.selectDmFileDetailListByPk(map);
	}

	@Override
	public String uploadFile(HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multiRequest = null;
		Map<String, MultipartFile> files = null;

		multiRequest = (MultipartHttpServletRequest) request;
		files = multiRequest.getFileMap();

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file = null;
		
		File saveFolder = new File(EgovProperties.getProperty("file.upload.tmp.path"));
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		String strTmpPath = EgovProperties.getProperty("file.upload.tmp.path") + Util.getStrRnd(); 
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			file.transferTo(new File(strTmpPath));
		}
		
		//drm 서비스 ( drm을 발급 받지 않은 로컬환경은 주석처리 )
//		drmManageService.doExtract(strTmpPath, strTmpPath);
		
		return strTmpPath;
	}

	@Override
	public void deleteFile(String deletePath) throws Exception {
		File file = new File(deletePath);
		file.delete();
	}

	@Override
	public String insertDmFileDetail(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception {
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
//		String filePath = null;
		
		//파일 디테일 삭제
		comz02DAO.deleteDmFileDetailByDmFileMstrSn(fileMastrSn);
		List<Map<String, String>> deleteFileList = comz02DAO.selectDmFileDetailForDmDetailDelete(fileMastrSn);
		for(Map<String, String> iMap : deleteFileList) {
			deleteFile(iMap.get("DWLD_PHYSIC_COURS") + iMap.get("UPLOAD_FILE_NM"));
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
				comz02DAO.insertDmFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
			}
		}
		
		return fileMastrSn;
	}
	
	public String insertDmFileDetailNonDelete(HttpServletRequest request, String moduleKnd, String fileMastrSn) throws Exception{
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
//		String filePath = null;
		
//		Date d = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//		String strDate = sdf.format(d);
		
//		String uploadPath = EgovProperties.getProperty("file.upload.path") 
//				+ "/" + strDate.substring(0, 4) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/";
		
		List<Map<String, String>> deleteFileList = comz02DAO.selectDmFileDetailForDmDetailDelete(fileMastrSn);
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
				comz02DAO.insertDmFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
			}
		}
		
		return fileMastrSn;
	}

	@Override
	public void deleteDmFileDetailEachDelete(String fileMastrSn, String splitDeleteDetailSn) throws Exception {

		List<Map<String, String>> list = comz02DAO.selectDmFileDetailForDmDetailDelete(fileMastrSn);
		String[] deleteDetailSn = splitDeleteDetailSn.split(",");
		
		for(String iStr : deleteDetailSn) {
			for(Map<String, String> iMap : list) {
				if(iStr.equals(EgovStringUtil.isNullToString(iMap.get("DETAIL_SN")))) {
					comz02DAO.deleteDmFileDetailByDetailSn(iStr);
					deleteFile(iMap.get("DWLD_PHYSIC_COURS") + iMap.get("UPLOAD_FILE_NM"));
				}
			}
		}
	}

	@Override
	public String selectEdcCrTaskForWord(Map<String, String> map) throws Exception {
		
		if(!map.containsKey("TASK_NO") || !map.containsKey("USER_ID")) {
			throw new Exception("TASK_NO is null");
		}
		
		Map<String, String> mapUserTask = comz02DAO.selectCmRsrchuserForWord(map);
		
		if(mapUserTask == null) {
			throw new Exception("user info is null");
		}

		if(!"".equals(EgovStringUtil.isNullToString(map.get("GOAL_NO")))) {
			mapUserTask.put("GOAL_NO", map.get("GOAL_NO"));
		}
		
		Map<String, String> mapFile = comz02DAO.selectEdcCrTaskForWord(map);
		
		if(mapFile == null) {
			throw new Exception("WORD_FILE is null");
		}
		
		List<Map<String, String>> listWordParsing = Util.getListByWordParsing(mapUserTask);
		
		File saveFolder = new File(EgovProperties.getProperty("file.upload.tmp.path"));
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		return Util.wordConverter2(mapFile.get("FULL_PATH"), EgovProperties.getProperty("file.upload.tmp.path") + map.get("USER_ID"), listWordParsing);
	}
}