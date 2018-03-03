package realtime.com.file.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import realtime.com.file.mapper.FileManageMapper;
import realtime.com.file.service.FileManageService;
import realtime.com.util.Util;

@Service("FileManageService")
public class FileManageServiceImpl implements FileManageService{

	@Resource(name = "FileManageMapper")
	private FileManageMapper fileManageMapper;
	
	@Resource(name = "SEQ_FILE_ID")
	private EgovIdGnrService seqFileId;
	
	@Resource(name = "SEQ_FILE_DETAIL_ID")
	private EgovIdGnrService seqFileDetailId;

	
	@Override
	public String insertTbFileMaster(HttpServletRequest request) throws Exception {
		
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
		
		String strSeqFileId = seqFileId.getNextStringId();
		@SuppressWarnings("unchecked")
		Map<String, Object> loginMap = (Map<String, Object>) Util.getHttpSession().getAttribute("loginMap");
		
		uploadMap.put("FILE_ID", strSeqFileId);
		uploadMap.put("USER_ID", loginMap.get("USER_ID").toString());
		
		//파일마스터 입력
		fileManageMapper.insertTbFileMaster(uploadMap);
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			
			if (!"".equals(file.getOriginalFilename())) {
				uploadMap = null;
				uploadMap = new HashMap<String, String>();
				String strSeqFileDetailId = seqFileDetailId.getNextStringId();
				
				String uploadFileNm = strSeqFileId + "_" + strSeqFileDetailId;
				String fStr = file.getOriginalFilename();
				int ixFstr = file.getOriginalFilename().indexOf(".");
				
				uploadMap.put("FILE_DETAIL_ID", strSeqFileDetailId);
				uploadMap.put("FILE_SEQ", "1");
				uploadMap.put("FILE_PATH", uploadPath+uploadFileNm);
				uploadMap.put("FILE_NAME", fStr.substring(0, ixFstr));
				uploadMap.put("FILE_EXT", fStr.substring(ixFstr + 1, fStr.length()));
				
				//파일 상세 입력
				fileManageMapper.insertTbFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
				
			}
		}
		
		return strSeqFileId;
	}

	
}
