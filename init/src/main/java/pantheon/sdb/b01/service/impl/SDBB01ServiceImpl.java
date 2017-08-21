  package pantheon.sdb.b01.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import pantheon.com.z02.service.DrmManageService;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.b01.dao.SDBB01DAO;
import pantheon.sdb.b01.service.SDBB01Service;
import pantheon.sdb.c02.service.MultiLangManageService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBB01Service")
public class SDBB01ServiceImpl implements SDBB01Service{
	
	@Resource(name = "SDBB01DAO")
	private SDBB01DAO sdbb01DAO;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	@Resource(name = "SDM_FILE_MASTR")
	private EgovIdGnrService dmFileMastrSeq;
	
	@Resource(name = "SDM_FILE_DETAIL")
	private EgovIdGnrService dmFileDetailSeq;
	
	@Resource(name = "SDB_LABEL_SEQ")
	private EgovIdGnrService sdbLabelSeq;
	
	@Resource(name = "SDB_PRODUCT_SEQ")
	private EgovIdGnrService sdbProductSeq;
	
	
	@Resource(name = "MultiLangManageService")
	private MultiLangManageService multiLangManageService;
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "ATRAIL_SDB_IM_PRDUCT_INFO_MANAGE")
	protected EgovPropertyService atrailprductinfomanaget;
	
	
	
	
	/**
	 * 의약품 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectProductList(Map<String, String> map) throws Exception {
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb01DAO.selectProductList(map);
	}
	

	/**
	 * 의약품 리스트 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public String insertProductList(Map<String, String> iMap) throws Exception{
		
		String txtconfm_bfe_ip_nm_mullang_code1 	= iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE1");
		String txtconfm_bfe_ip_nm_mullang_code1_kor = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE1_KOR");
		String txtconfm_bfe_ip_nm_mullang_code1_eng = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE1_ENG");
		String txtconfm_bfe_ip_nm_mullang_code2 	= iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE2");
		String txtconfm_bfe_ip_nm_mullang_code2_kor = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE2_KOR");
		String txtconfm_bfe_ip_nm_mullang_code2_eng = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE2_ENG");
		String txtconfm_bfe_ip_nm_mullang_code3 	= iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE3");
		String txtconfm_bfe_ip_nm_mullang_code3_kor = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE3_KOR");
		String txtconfm_bfe_ip_nm_mullang_code3_eng = iMap.get("CONFM_BFE_IP_NM_MULLANG_CODE3_ENG");
		String txtprductnm_code 					= iMap.get("PRDUCTNM_CODE");
		String txtprductnm_code_kor 				= iMap.get("PRDUCTNM_CODE_KOR");
		String txtprductnm_code_eng 				= iMap.get("PRDUCTNM_CODE_ENG");
		String txtgnrl_nm_code1 		 			= iMap.get("GNRL_NM_CODE1");
		String txtgnrl_nm_code1_kor 		 		= iMap.get("GNRL_NM_CODE1_KOR");
		String txtgnrl_nm_code1_eng 		 		= iMap.get("GNRL_NM_CODE1_ENG");
		String txtgnrl_nm_code2 		 			= iMap.get("GNRL_NM_CODE2");
		String txtgnrl_nm_code2_kor 		 		= iMap.get("GNRL_NM_CODE2_KOR");
		String txtgnrl_nm_code2_eng 		 		= iMap.get("GNRL_NM_CODE2_ENG");
		String txtgnrl_nm_code3 		 			= iMap.get("GNRL_NM_CODE3");
		String txtgnrl_nm_code3_kor 		 		= iMap.get("GNRL_NM_CODE3_KOR");
		String txtgnrl_nm_code3_eng 		 		= iMap.get("GNRL_NM_CODE3_ENG");
		
					
		String txtTg_code ="";
		
		if(iMap.get("CURD").equals("C"))
		{
			int Prduct_code = Integer.parseInt(sdbProductSeq.getNextStringId());
			String txt_code = String.format("%04d", Prduct_code);
		    Calendar c = Calendar.getInstance();
		    String txtYear = new String();
		    txtYear = String.valueOf(c.get(Calendar.YEAR));
			String Category ="PD"; //Label
			
			txtTg_code = Category+""+txtYear+""+txt_code;
			
			multiLangManageService.mullangInsert(txtconfm_bfe_ip_nm_mullang_code1_kor, txtconfm_bfe_ip_nm_mullang_code1_eng, "CONFM_BFE_IP_NM_MULLANG_CODE1", iMap);
			multiLangManageService.mullangInsert(txtconfm_bfe_ip_nm_mullang_code2_kor, txtconfm_bfe_ip_nm_mullang_code2_eng, "CONFM_BFE_IP_NM_MULLANG_CODE2", iMap);
			multiLangManageService.mullangInsert(txtconfm_bfe_ip_nm_mullang_code3_kor, txtconfm_bfe_ip_nm_mullang_code3_eng, "CONFM_BFE_IP_NM_MULLANG_CODE3", iMap);
			multiLangManageService.mullangInsert(txtprductnm_code_kor, txtprductnm_code_eng, "PRDUCTNM_CODE", iMap);
			multiLangManageService.mullangInsert(txtgnrl_nm_code1_kor, txtgnrl_nm_code1_eng, "GNRL_NM_CODE1", iMap); 
			multiLangManageService.mullangInsert(txtgnrl_nm_code2_kor, txtgnrl_nm_code2_eng, "GNRL_NM_CODE2", iMap); 
			multiLangManageService.mullangInsert(txtgnrl_nm_code3_kor, txtgnrl_nm_code3_eng, "GNRL_NM_CODE3", iMap);
			iMap.put("PRDUCT_CODE", txtTg_code);
			
			sdbb01DAO.insertProductList(iMap);
			//comz06Service.createCmDtaAtrailForInsertByString(iMap, atrailprductinfomanaget, null, null);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtconfm_bfe_ip_nm_mullang_code1, txtconfm_bfe_ip_nm_mullang_code1_kor, txtconfm_bfe_ip_nm_mullang_code1_eng, "CONFM_BFE_IP_NM_MULLANG_CODE1", iMap);
			multiLangManageService.mullangUpdate(txtconfm_bfe_ip_nm_mullang_code2, txtconfm_bfe_ip_nm_mullang_code2_kor, txtconfm_bfe_ip_nm_mullang_code2_eng, "CONFM_BFE_IP_NM_MULLANG_CODE2", iMap);
			multiLangManageService.mullangUpdate(txtconfm_bfe_ip_nm_mullang_code3, txtconfm_bfe_ip_nm_mullang_code3_kor, txtconfm_bfe_ip_nm_mullang_code3_eng, "CONFM_BFE_IP_NM_MULLANG_CODE3", iMap);
			multiLangManageService.mullangUpdate(txtprductnm_code, txtprductnm_code_kor, txtprductnm_code_eng, "PRDUCTNM_CODE", iMap);
			multiLangManageService.mullangUpdate(txtgnrl_nm_code1, txtgnrl_nm_code1_kor, txtgnrl_nm_code1_eng, "GNRL_NM_CODE1", iMap);
			multiLangManageService.mullangUpdate(txtgnrl_nm_code2, txtgnrl_nm_code2_kor, txtgnrl_nm_code2_eng, "GNRL_NM_CODE2", iMap);
			multiLangManageService.mullangUpdate(txtgnrl_nm_code3, txtgnrl_nm_code3_kor, txtgnrl_nm_code3_eng, "GNRL_NM_CODE3", iMap);
//comz06Service.createCmDtaAtrailForUpdateByString(iMap, atrailprductinfomanaget, null, null);
			sdbb01DAO.updateProductList(iMap);
			
			txtTg_code = iMap.get("PRDUCT_CODE");
		}else if(iMap.get("CURD").equals("D")){
			sdbb01DAO.deleteProductList(iMap); 
		}	
		return txtTg_code;
	}
	
	/**
	 * 의약품 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectProductListInfo(Map<String, Object> param){
		Map<String, Object> result = sdbb01DAO.selectProductListInfo(param);		
		System.err.println(result);
		return result;
	}
	
	/**
	 * 의약품 보고설정 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectProductReportInfo(Map<String, Object> param){
		System.err.println("==========ServiceImpl start1===");
		System.err.println("==========ServiceImpl===");
		return sdbb01DAO.selectProductReportInfo(param);
//		System.err.println("==========ServiceImpl===");
//		System.err.println(result);
//		return result;
	}
	

	/**
	 * 의약품 보고설정 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public void insertProductReport(Map<String, String> iMap) throws Exception{

		if(iMap.get("CURD").equals("C"))
		{
			sdbb01DAO.insertProductReport(iMap);
		}else if(iMap.get("CURD").equals("U")){
			sdbb01DAO.updateProductReport(iMap);
			
		}else if(iMap.get("CURD").equals("D")){
			sdbb01DAO.deleteProductReport(iMap);
		
		}else if(iMap.get("CURD").equals("D_D")){
			sdbb01DAO.deleteProductReportByPk(iMap);
		
		}	
	}
	
	/**
	 * Label 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectLabelList(Map<String, String> map) throws Exception {
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb01DAO.selectLabelList(map);
	}
	
	
	
	@Override
	public String insertDmFileMstr(HttpServletRequest request, String moduleKnd) throws Exception {
		
		if(moduleKnd == null) {
			moduleKnd = "SDB";
		}
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String strDate = sdf.format(d);
		
		String uploadPath = EgovProperties.getProperty("file.upload.path") 
				+ "/" + strDate.substring(0, 4) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/";
		
		File saveFolder = new File(uploadPath);
		System.out.println(uploadPath);
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
		sdbb01DAO.insertDmFileMstr(uploadMap);
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		
		System.out.println(itr);
		System.out.println("=====fileupload impl0000");
		MultipartFile file;
//		String filePath = null;
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			System.out.println("=====fileupload impl1111");
			if (!"".equals(file.getOriginalFilename())) {
				System.out.println("=====fileupload imp22222");
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
				System.out.println("=====fileupload imp3333");
				sdbb01DAO.insertDmFileDetail(uploadMap);
				System.out.println("=====fileupload imp5555");
				file.transferTo(new File(uploadPath+uploadFileNm));
				
				//drm 테스트
//				drmManageService.doPackage(uploadPath, uploadFileNm);
//				drmManageService.doFileExtract(uploadPath, uploadFileNm);
			}
		}
		
		return fileMastrSn;
	}
	
	@Override
	public void uploadFile(HttpServletRequest request, String path, String name) throws Exception {
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		File saveFolder = new File(path);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			
			if (!"".equals(file.getOriginalFilename())) {
				file.transferTo(new File(path+name));
			}
		}
	}

	@Override
	public void deleteFile(HttpServletRequest request, String path, String name) throws Exception {
		File file = new File(path + name);
		file.delete();
	}
	
	/**
	 * Label 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public void insertLabelList(Map<String, String> iMap) throws Exception{
		System.err.println("++++==============IMPL");		
		String txtetc_appn 				  	= iMap.get("ETC_APPN");
		String txtetc_appn_kor			  	= iMap.get("ETC_APPN_KOR");
		String txtetc_appn_eng			  	= iMap.get("ETC_APPN_ENG");
		String txtmain_change_isestatn 	  	= iMap.get("MAIN_CHANGE_ISESTATN");
		String txtmain_change_isestatn_kor	= iMap.get("MAIN_CHANGE_ISESTATN_KOR");
		String txtmain_change_isestatn_eng	= iMap.get("MAIN_CHANGE_ISESTATN_ENG");
		String txtsend_person 			  	= iMap.get("SEND_PERSON");
		String txtsend_person_kor		  	= iMap.get("SEND_PERSON_KOR");
		String txtsend_person_eng		  	= iMap.get("SEND_PERSON_ENG");
		String txtsend_person_etc_info 	  	= iMap.get("SEND_PERSON_ETC_INFO");
		String txtsend_person_etc_info_kor	= iMap.get("SEND_PERSON_ETC_INFO_KOR");
		String txtsend_person_etc_info_eng	= iMap.get("SEND_PERSON_ETC_INFO_ENG");
		
		if(iMap.get("CURD").equals("C"))
		{
			int lbl_code = Integer.parseInt(sdbLabelSeq.getNextStringId());			
			
			String txt_code = String.format("%05d", lbl_code);
		    Calendar c = Calendar.getInstance();
		    String txtYear = new String();
		    txtYear = String.valueOf(c.get(Calendar.YEAR));
			String Category ="L"; //Label
			
			System.out.println("=-------=============");
			System.out.println(Category+""+txtYear+""+txt_code);
			
			String txtlbl_code = Category+""+txtYear+""+txt_code;
			iMap.put("LBL_CODE", txtlbl_code);
			
			multiLangManageService.mullangInsert(txtetc_appn_kor, txtetc_appn_eng, "ETC_APPN", iMap);
			multiLangManageService.mullangInsert(txtmain_change_isestatn_kor, txtmain_change_isestatn_eng, "MAIN_CHANGE_ISESTATN", iMap);			
			multiLangManageService.mullangInsert(txtsend_person_kor, txtsend_person_eng, "SEND_PERSON", iMap);
			multiLangManageService.mullangInsert(txtsend_person_etc_info_kor, txtsend_person_etc_info_eng, "SEND_PERSON_ETC_INFO", iMap);
			
			sdbb01DAO.insertLabelList(iMap);
		}else if(iMap.get("CURD").equals("U")){
			multiLangManageService.mullangUpdate(txtetc_appn, txtetc_appn_kor, txtetc_appn_eng, "ETC_APPN", iMap);
			multiLangManageService.mullangUpdate(txtmain_change_isestatn, txtmain_change_isestatn_kor, txtmain_change_isestatn_eng, "MAIN_CHANGE_ISESTATN", iMap);			
			multiLangManageService.mullangUpdate(txtsend_person, txtsend_person_kor, txtsend_person_eng, "SEND_PERSON", iMap);
			multiLangManageService.mullangUpdate(txtsend_person_etc_info, txtsend_person_etc_info_kor, txtsend_person_etc_info_eng, "SEND_PERSON_ETC_INFO", iMap);
			
			sdbb01DAO.updateLabelList(iMap);
			
		}else if(iMap.get("CURD").equals("D")){
			sdbb01DAO.deleteLabelListByPk(iMap);
		
		}			
		
	}
	
	/**
	 * Label 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectLabelListInfo(Map<String, Object> param){
		Map<String, Object> result = sdbb01DAO.selectLabelListInfo(param);		
		System.err.println(result);
		return result;
	}
	
	@Override
	public Map<String, String> selectDmFileDetailByPk(Map<String, String> map) throws Exception {
		return sdbb01DAO.selectDmFileDetailByPk(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDmFileDetailListByPk(Map<String, String> map) throws Exception {
		return sdbb01DAO.selectDmFileDetailListByPk(map);
	}
	
	/**
	 * PSUR 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectPSURList(Map<String, String> map) throws Exception {
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb01DAO.selectPSURList(map);
	}
	
	/**
	 * Label 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public void  insertPSURList(Map<String, String> param) throws Exception{
		System.err.println("++++==============IMPL");
		System.err.println(param);	
		if(param.get("CURD").equals("C"))
		{
			sdbb01DAO.insertPSURList(param);
		}else if(param.get("CURD").equals("U")){
			sdbb01DAO.updatePSURList(param);
			
		}else if(param.get("CURD").equals("D")){
			sdbb01DAO.deletePSURListByPk(param);
		
		}		
			
	}
	
	/**
	 * PSUR 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectPSURListInfo(Map<String, Object> param) throws Exception{
		Map<String, Object> result = sdbb01DAO.selectPSURListInfo(param);		
		System.err.println(result);
		return result;
	}
	
	/**
	 * PSUR 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectNonCList(Map<String, String> map) throws Exception {
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb01DAO.selectNonCList(map);
	}
	
	/**
	 * Label 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public void insertNonCList(Map<String, String> iMap) throws Exception{
		System.err.println("++++==============IMPL");
		
		if(iMap.get("CURD").equals("C"))
		{
			sdbb01DAO.updateNonCList(iMap);
		}else if(iMap.get("CURD").equals("U")){
			sdbb01DAO.updateNonCList(iMap);
			
		}else if(iMap.get("CURD").equals("D")){
			sdbb01DAO.updateNonCList(iMap);
		
		}				
		
	}
	
	/**
	 * PSUR 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectNonCListInfo(Map<String, Object> param) throws Exception{
		Map<String, Object> result = sdbb01DAO.selectNonCListInfo(param);		
		System.err.println(result);
		return result;
	}
	
	@Override
	public List<Map<String, Object>> selectOrganCodeListByPk(Map<String, String> map_ori) throws Exception{
		return sdbb01DAO.selectOrganCodeListByPk(map_ori);
	}
}