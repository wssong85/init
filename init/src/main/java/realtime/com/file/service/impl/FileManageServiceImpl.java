package realtime.com.file.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
	public List<Map<String, String>> insertTbFileMaster(HttpServletRequest request, Map<String, Object> map) throws Exception {
		
		MultipartHttpServletRequest multiRequest = null;
		Map<String, MultipartFile> files = null;
		
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		
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
		
		String strSeqFileId = null;
		
		//파일아이디 가져오기
		if("C".equals(EgovStringUtil.isNullToString(map.get("PROCESS_SE")))) {
			strSeqFileId = seqFileId.getNextStringId();
		} else {
			strSeqFileId = EgovStringUtil.isNullToString(map.get("FILE_ID"));
		}
		
		@SuppressWarnings("unchecked")
		Map<String, Object> loginMap = (Map<String, Object>) Util.getHttpSession().getAttribute("loginMap");
		
		uploadMap.put("FILE_ID", strSeqFileId);
		uploadMap.put("USER_ID", loginMap.get("USER_ID").toString());
		
		//파일마스터 입력
		if("C".equals(EgovStringUtil.isNullToString(map.get("PROCESS_SE")))) {
			fileManageMapper.insertTbFileMaster(uploadMap);	
		}
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		File defaultFile;
		String strSeqFileDetailId = "";
		String uploadFileNm = "";
		String fStr = "";
		int ixFstr = 0;
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			
			if (!"".equals(file.getOriginalFilename())) {
				
				uploadMap = new HashMap<String, String>();
				if("U".equals(EgovStringUtil.isNullToString(map.get("PROCESS_SE")))) {
					strSeqFileDetailId = map.get("FILE_DETAIL_ID").toString();
				} else {
					strSeqFileDetailId = seqFileDetailId.getNextStringId();
				}
				
				uploadFileNm = strSeqFileId + "_" + strSeqFileDetailId;
				fStr = file.getOriginalFilename();
				ixFstr = file.getOriginalFilename().indexOf(".");
				
				uploadMap.put("FILE_ID", strSeqFileId);
				uploadMap.put("USER_ID", loginMap.get("USER_ID").toString());
				
				uploadMap.put("FILE_DETAIL_ID", strSeqFileDetailId);
				uploadMap.put("FILE_SEQ", fStr.substring(0, ixFstr).substring(fStr.substring(0, ixFstr).length()-1, fStr.substring(0, ixFstr).length()));
				uploadMap.put("FILE_PATH", uploadPath+uploadFileNm);
				uploadMap.put("FILE_NAME", fStr.substring(0, ixFstr).substring(0, fStr.substring(0, ixFstr).length()-2));
				uploadMap.put("FILE_EXT", fStr.substring(ixFstr + 1, fStr.length()));
				
				list.add(uploadMap);
				
				defaultFile = new File(uploadPath+uploadFileNm);
				try {
					fileManageMapper.deleteTbFileDetail(uploadMap);
					defaultFile.delete();	
				} catch (Exception e) {
					
				}
				
				//파일 상세 입력
				fileManageMapper.insertTbFileDetail(uploadMap);
				file.transferTo(new File(uploadPath+uploadFileNm));
				
			}
		}
		
		
		return list;
	}
	
	@Override
	public void deleteTbFileMaster(List<Map<String, String>> list) throws Exception {
		
		for(Map<String, String> iMap : list) {
			fileManageMapper.deleteTbFileDetail(iMap);
		}
		
		if(fileManageMapper.selectTbFileMasterCount(list.get(0)) == 0) {
			fileManageMapper.deleteTbFileMaster(list.get(0));	
		}
		
	}
	
	public static void main(String[] args) {
//		String strFileIdTest = "test_1";
//		System.out.println(strFileIdTest.substring(strFileIdTest.length()-1, strFileIdTest.length()));
//		System.out.println(strFileIdTest.substring(0, strFileIdTest.length()-2));
	}

}
