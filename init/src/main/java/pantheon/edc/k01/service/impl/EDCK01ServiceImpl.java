package pantheon.edc.k01.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonPdfWriterService;
import pantheon.com.z02.dao.COMZ02DAO;
import pantheon.com.z02.service.DrmManageService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.edc.k01.dao.EDCK01DAO;
import pantheon.edc.k01.service.EDCK01Service;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("EDCK01Service")
public class EDCK01ServiceImpl implements EDCK01Service {
	@Resource(name = "EDCK01DAO")
	private EDCK01DAO edck01DAO;

	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;

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

	@Resource(name = "comPdfService")
	protected EgovPropertyService comPdfService;

	/** EgovPropertyService */
	@Resource(name = "ATRAIL_EDC_CR_TASK")
	protected EgovPropertyService atrailEdcCrTask;

	@Override
	public List<Map<String, Object>> selectStudyList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck01DAO.selectStudyList(param);
	}

	@Override
	public String selectStudyListCount(Map<String, Object> param) throws Exception {
		return edck01DAO.selectStudyListCount(param);
	}

	@Override
	public Map<String, Object> selectBaseInfo(Map<String, Object> param) throws Exception {
		if ("C".equals(param.get("CRUD"))) {
			return param;
		} else {
			return edck01DAO.selectBaseInfo(param);
		}
	}

	public Map<String, Object> selectCheckTaskNo(Map<String, Object> param) throws Exception {
		return edck01DAO.selectCheckTaskNo(param);
	}

	@Override
	public Map<String, Object> insertBaseInfo(HttpServletRequest request, Map<String, Object> param) throws Exception {
		File saveFolder = null;
		try {
			MultipartHttpServletRequest multiRequest = null;
			Map<String, MultipartFile> files = null;

			try {
				multiRequest = (MultipartHttpServletRequest) request;
				files = multiRequest.getFileMap();
			} catch (Exception e) {
				throw e;
			}
			UUID uuid = UUID.randomUUID();
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String strDate = sdf.format(d);
			String uploadPath = EgovProperties.getProperty("file.upload.path");
			uploadPath += strDate.substring(0, 4) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/";
			uploadPath += uuid + "/";

			String update_id = Util.getUserMap().get("USER_ID");
			param.put("UPDATE_ID", update_id);

			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					if (param.get("CRUD").equals("U") || param.get("CRUD").equals("D")) {
						param.put("USE_AT", "N");
						param.put("DETAIL_SN", param.get("CTRTC_FILE_SN"));
						edck01DAO.updateFileMasterUse(param);
						edck01DAO.updateFileDetailUse(param);
						param.put("DETAIL_SN", param.get("CTRTC_PDF_FILE_SN"));
						edck01DAO.updateFileDetailUse(param);
					}

					String fileMastrSn = dmFileMastrSeq.getNextStringId();
					String moduleKnd = "DMC";
					Map<String, String> uploadMap = new HashMap<String, String>();
					uploadMap.put("FILE_MASTR_SN", fileMastrSn);
					uploadMap.put("MODULE_KND", moduleKnd);
					uploadMap.put("UPLOAD_PHYSIC_COURS", uploadPath);
					uploadMap.put("DWLD_PHYSIC_COURS", uploadPath);
					uploadMap.put("DRM_RELIS_AT", "N");
					uploadMap.put("USE_AT", "Y");
					uploadMap.put("REGIST_ID", update_id);
					uploadMap.put("UPDATE_ID", update_id);

					comz02DAO.insertDmFileMstr(uploadMap);

					String fileDetailSn = dmFileDetailSeq.getNextStringId();
					param.put("CTRTC_FILE_SN", fileDetailSn);
					uploadMap.put("DETAIL_SN", fileDetailSn);
					String uploadFileNm = moduleKnd + "_" + fileMastrSn + "_" + fileDetailSn;
					uploadMap.put("UPLOAD_FILE_NM", uploadFileNm);

					String fStr = file.getOriginalFilename();
					int ixFstr = file.getOriginalFilename().indexOf(".");
					if (ixFstr > -1) {
						uploadMap.put("ORGINL_FILE_NM", fStr.substring(0, ixFstr));
						uploadMap.put("ORGINL_EXTSN_NM", fStr.substring(ixFstr + 1, fStr.length()));
					} else {
						uploadMap.put("ORGINL_FILE_NM", file.getOriginalFilename());
						uploadMap.put("ORGINL_EXTSN_NM", "");
					}
					uploadMap.put("ORGINL_SIZE", String.valueOf(file.getSize()));

					comz02DAO.insertDmFileDetail(uploadMap);

					saveFolder = new File(uploadPath);
					if (!saveFolder.exists() || saveFolder.isFile()) {
						saveFolder.mkdirs();
					}
					file.transferTo(new File(uploadPath + uploadFileNm));

					drmManageService.doFileExtract(uploadPath + uploadFileNm);

					Util.wordConverter(uploadPath, uploadFileNm, getConvertTextList());

					fileDetailSn = dmFileDetailSeq.getNextStringId();
					param.put("CTRTC_PDF_FILE_SN", fileDetailSn);
					uploadMap.put("DETAIL_SN", fileDetailSn);
					uploadMap.put("ORGINL_EXTSN_NM", "pdf");
					uploadMap.put("UPLOAD_FILE_NM", uploadFileNm + "_pdf");

					comz02DAO.insertDmFileDetail(uploadMap);
					//"soffice.exe" -headless -accept=socket,port=8100;urp;
				}
			}
			Object task_sn = null;
			if (param.get("CRUD").equals("C")) {
				task_sn = edck01DAO.selectTaskSn(param);
				param.put("TASK_SN", task_sn);
				param.put("CDISC_RULE_SN", edck01DAO.selectCDISCSn());
				edck01DAO.insertBaseInfo(param);
				comz06Service.createCmDtaAtrailForInsertByObject(param, atrailEdcCrTask, null, null);
			} else {
				if (param.get("CRUD").equals("U")) {
					param.put("USE_AT", "Y");
				} else {
					param.put("USE_AT", "N");
				}
				comz06Service.createCmDtaAtrailForUpdateByObject(param, atrailEdcCrTask, null, null);
				edck01DAO.updateBaseInfo(param);
			}

			if (param.get("PRODUCT_LIST") != null && !"".equals(param.get("PRODUCT_LIST"))) {
				ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				JSONArray jsonArray = new JSONArray(String.valueOf(param.get("PRODUCT_LIST")));
				for (int i = 0; i < jsonArray.length(); i++) {
					list.add(Util.makeMap(jsonArray.getJSONObject(i)));
				}
				for (Map<String, Object> iMap : list) {
					if (iMap.get("CRUD").equals("C")) {
						if (task_sn != null) {
							iMap.put("TASK_SN", task_sn);
						}
						iMap.put("PRDUCT_SN", edck01DAO.selectProductSn(iMap));
						edck01DAO.insertProduct(iMap);
					} else {
						if (iMap.get("CRUD").equals("U")) {
							iMap.put("USE_AT", "Y");
						} else {
							iMap.put("USE_AT", "N");
						}
						edck01DAO.updateProduct(iMap);
					}
				}
			}
		} catch (Exception e) {
			if (saveFolder != null) {
				File[] files = saveFolder.listFiles();
				for (File f : files) {
					f.delete();
				}
				saveFolder.delete();
			}
			e.printStackTrace();
			throw e;
		}
		return param;
	}

	public List<Map<String, String>> getConvertTextList() {
		List<Map<String, String>> testList = new ArrayList<Map<String, String>>();
		Map<String, String> textMap = new HashMap<String, String>();
		textMap.put("CODE", "INSTT_NM");
		textMap.put("VALUE", "테스트연구기관");
		testList.add(textMap);
		textMap = new HashMap<String, String>();
		textMap.put("CODE", "TASK_NO");
		textMap.put("VALUE", "cj_000");
		testList.add(textMap);
		textMap = new HashMap<String, String>();
		textMap.put("CODE", "USER_NM");
		textMap.put("VALUE", "홍길동");
		testList.add(textMap);
		textMap = new HashMap<String, String>();
		textMap.put("CODE", "ADDR");
		textMap.put("VALUE", "서울 특별시 서대문구 미근동 통일로");
		testList.add(textMap);
		textMap = new HashMap<String, String>();
		textMap.put("CODE", "GOAL_NO");
		textMap.put("VALUE", "00");
		testList.add(textMap);
		return testList;
	}

	@Override
	public List<Map<String, Object>> selectProductList(Map<String, Object> param) throws Exception {
		param.put("LOCALE", Util.getStrLocale());
		return edck01DAO.selectProductList(param);
	}
}