package pantheon.sdb.e03.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import pantheon.com.i02.dao.COMI02DAO;
import pantheon.com.utl.Util;
import pantheon.com.utl.service.PantheonMailService;
import pantheon.com.z02.service.DrmManageService;
import pantheon.sdb.e03.dao.SDBE03DAO;
import pantheon.sdb.e03.service.SDBE03Service;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;

import org.codehaus.jettison.json.JSONArray;

import egovframework.rte.fdl.excel.EgovExcelService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBE03Service")
public class SDBE03ServiceImpl implements SDBE03Service{
	@Resource(name = "SDBE03DAO")
	private SDBE03DAO sdbe03Dao;
	
	@Resource(name = "COMI02DAO")
	private COMI02DAO comi02DAO;
	
	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelService;
	
	/** EmailService */
	@Resource(name = "PantheonMailService")
	private PantheonMailService pantheonMailService;
	

	/** EgovPropertyService */
	@Resource(name = "propertiesMailService")
	protected EgovPropertyService propertiesMailService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Override
	public List<Map<String, String>> selectQueryList(Map<String, String> param) throws Exception{
		return sdbe03Dao.selectQueryList(param); 
	}
	
	@Override
	public int selectQueryCnt(Map<String, String> param) throws Exception{
		return sdbe03Dao.selectQueryCnt(param);
	}
	
	@Override
	public void updateEndQueryInfo(Map<String, String> param) throws Exception{
		String[] strQuerySn = param.get("QUERY_NO").split(",");
		for(String str: strQuerySn){
			Map<String, String> map = new HashMap<String, String>();
			map.put("QUERY_SN", str);
			List<Map<String, String>> list = sdbe03Dao.selectQueryInfo(map);
			String seq = sdbe03Dao.selectQuerySeq();
			map.put("QUERY_SN", seq);
			map.put("MODULE_CODE", "SDB");
			map.put("QUERY_TY_CODE", list.get(0).get("QUERY_TY_CODE"));
			map.put("QUERY_STTUS_CODE", param.get("QUERY_STTUS_CODE"));
			map.put("QUERY_CN", String.valueOf(list.get(0).get("QUERY_CN")));
			map.put("END_AT", "Y");
			map.put("RESN", param.get("RESN"));
			map.put("USE_AT", "Y");
			map.put("QUERY_GROUP", String.valueOf(list.get(0).get("QUERY_GROUP")));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("PRDUCT_CODE", list.get(0).get("PRDUCT_CODE"));
			map.put("PROGRM_ID", list.get(0).get("PROGRM_ID"));
			map.put("SE_NO", String.valueOf(list.get(0).get("SE_NO")));
			map.put("COLUMNNM", list.get(0).get("COLUMNNM"));
			map.put("HRMFLNSCASESOURC_CODE", list.get(0).get("HRMFLNSCASESOURC_CODE"));
			map.put("HRMFLNSCASESOURC_NO", list.get(0).get("HRMFLNSCASESOURC_NO"));
			map.put("FOLLOW_NO", list.get(0).get("FOLLOW_NO"));
			
			sdbe03Dao.insertQueryInfo(map);
			sdbe03Dao.insertPhaseInfo(map);
		}
	}
	
	@Override
	public List<Map<String, String>> selectVerificationInfo(Map<String, String> param) throws Exception{
		return sdbe03Dao.selectVerificationInfo(param);
	}
	
	@Override
	public String insertExcelInfo(HttpServletRequest req) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multiRequest = null;
		Map<String, MultipartFile> files = null;

		try {
			multiRequest = (MultipartHttpServletRequest) req;
			files = multiRequest.getFileMap();
		} catch (Exception e) {
			throw new Exception("파일 업로드 중 에러가 발생하였습니다. 관리자에게 문의하세요.");
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file = null;
		
		File saveFolder = new File(EgovProperties.getProperty("file.upload.tmp.path"));
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		String strRnd = Util.getStrRnd();
		String strTmpPath = "";
		String extNm = "";
		String fileName = "";
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			fileName = file.getOriginalFilename();
			extNm = fileName.substring(file.getOriginalFilename().indexOf(".") + 1, fileName.length());
			strTmpPath = EgovProperties.getProperty("file.upload.tmp.path") + strRnd + "." + extNm; 
			file.transferTo(new File(strTmpPath));
		}
		
		drmManageService.doFileExtract(strTmpPath);
		
		Workbook wb = null;
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String[] arrStr = {"REPORT_DE", "REGIST_DE", "BATCH", "MAFU_NO", "KIDS_NO", "FILE_NM", "STATUS", "NM", "MDCIN_NM", "MD_NM"};
		
		if("xls".equals(extNm)){
			try {
				wb = excelService.loadWorkbook(strTmpPath);
			} catch (Exception e) {
				try{
					File f = new File(strTmpPath);
					f.delete();
				}catch(Exception ex){
					
				}
				throw new Exception("엑셀 타입이 아닙니다. 확인 하십시오.");
			}
		}else if("xlsx".equals(extNm)){
			try {
				wb = excelService.loadWorkbook(strTmpPath, new XSSFWorkbook());
			} catch (Exception e) {
				try{
					File f = new File(strTmpPath);
					f.delete();
				}catch(Exception ex){
					
				}
				throw new Exception("엑셀 타입이 아닙니다. 확인 하십시오.");
			}
		}else{
			try{
				File f = new File(strTmpPath);
				f.delete();
			}catch(Exception e){
				
			}
			throw new Exception("엑셀 타입이 아닙니다. 확인 하십시오.");
		}
		Sheet sheet = wb.getSheetAt(0);
		list = Util.getListForExcelSheet(sheet, arrStr, 3);
		
		try{
			File f = new File(strTmpPath);
			f.delete();
		}catch(Exception e){
			
		}
		
		for(Map<String, String> map : list){
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			map.put("USE_AT", "Y");
			map.put("FILENM", strRnd + "." + extNm);
			sdbe03Dao.insertExcelInfo(map);
		}
		
		return strRnd + "." + extNm;
	}
	
	@Override
	public List<Map<String, String>> selectVerificationForExcel(Map<String, String> param) throws Exception{
		return sdbe03Dao.selectVerificationForExcel(param);
	}
	
	@Override
	public void updateVerificationInfo(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("param"));
		Map<String, String> map = new HashMap<String, String>();
		map.put("FILENM", array.getJSONObject(0).getString("FILENM"));
		sdbe03Dao.deleteVerificationForTemp(map);
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DATA").length(); i++){
			if("Y".equals(array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("NORMAL_CODE"))){
				map.put("FILENM", array.getJSONObject(0).getString("FILENM"));
				map.put("KIDS_NO", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("KIDS_NO"));
				map.put("KIDS_REPORT_DTE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("KIDS_REPORT_DTE"));
				map.put("HRMFLNS_CASE_CODE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("HRMFLNS_CASE_CODE"));
				map.put("FOLLOW_NO", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("FOLLOW_NO"));
				map.put("USER_ID", param.get("USER_ID"));
				sdbe03Dao.updateVerificationInfoForCase(map);
				sdbe03Dao.updateVerificationInfoForAe(map);
			}
		}
	}
	
	@Override
	public void deleteTempVerificationInfo(Map<String, String> param) throws Exception{
		sdbe03Dao.deleteVerificationForTemp(param);
	}
	
	@Override
	public List<Map<String, Object>> selectChargeListPop(Map<String, String> map) throws Exception{
		
		return sdbe03Dao.selectChargeListPop(map); 
	}
	
	@Override
	public void insertSendMail(Map<String, String> map)throws Exception{
		map.put("PASSWORD_CODE", Util.getStrRnd());
//		comz06Service.createCmDtaAtrailForUpdateByString(map, atrailCmUser, null, null);
//		comi02DAO.updateCmUserForSendTmpMail(map);
		sdbe03Dao.insertEmailHistory(map);
		Map<String, String> sendMap = new HashMap<String, String>();
		//context-properties 에서 등록 후 메일 템플릿 사용(실제 html파일은 webapp/html/pantheon/email 안에 넣어햐 함)
		sendMap.put("HTML_NM", propertiesMailService.getString("SDB_CHARGE_MAIL_TEMPLATE"));
		//html에는 el식 기준으로 작성하면 변환됨
		sendMap.put("USER_NM", map.get("DNAME"));
		
		
//		HttpServletRequest req = Util.getHttpServletRequest();
//		sendMap.put("URL", req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()  + "/com/anonymous/COMI0204.do?PASSWORD_CODE=" + map.get("PASSWORD_CODE"));
		//sendMap.put("URL", req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()  + "/com/anonymous/COMI0204.do");
//		pantheonMailService.sendMail(sendMap, map.get("EMAIL"), map.get("USER_NM"), "[판테온시스템]비밀번호변경 안내드립니다.");
		pantheonMailService.sendMail(sendMap, map.get("EMAIL"), map.get("DNAME"),"거래선 담당자 이메일입니다.");
		
	}
}
