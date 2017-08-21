package pantheon.com.c03.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.excel.EgovExcelService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import pantheon.com.c03.dao.COMC03DAO;
import pantheon.com.c03.service.COMC03Service;
import pantheon.com.e01.service.COME01Service;
import pantheon.com.utl.Util;
import pantheon.com.z02.service.COMZ02Service;
import pantheon.com.z02.service.DrmManageService;

@Service("COMC03Service")
public class COMC03ServiceImpl implements COMC03Service {

	@Resource(name = "COME01Service")
	private COME01Service come01Service;
	
	@Resource(name = "COMZ02Service")
	private COMZ02Service comz02Service;
	
	@Resource(name = "excelRdnmadZipService")
	private EgovExcelService excelRdnmadZipService;
	
	@Resource(name = "COMC03DAO")
	private COMC03DAO comc03DAO;

	@Resource(name = "EDC_CR_KCD_SEQ")
	private EgovIdGnrService edcCrKcdSeq;

	@Resource(name = "DrmManageService")
	private DrmManageService drmManageService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
    @SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> selectExcellForKcd(HttpServletRequest request) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		int count = 0;
		
		String strTmpPath = comz02Service.uploadFile(request);
		
		Workbook hssfWB = null; 
		
		try {
			hssfWB = excelRdnmadZipService.loadWorkbook(strTmpPath, new XSSFWorkbook());
		} catch (Exception e) {
			throw new Exception(egovMessageSource.getPantheonExceptionMessage("comc.message.1"));
		}
				
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();

		String[] arrStrKcd = {
				"DISS_CODE",
				"ENG_NM",
				"KOREAN_NM"
		};

		if (hssfWB.getNumberOfSheets() == 1) {
			list = Util.getListForExcelSheet(hssfWB.getSheetAt(0), arrStrKcd, 1);
		}
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("DISS_CODE", 200);
		map.put("ENG_NM", 200);
		map.put("KOREAN_NM", 200);
		
		Map<String, Object> mapByteCheck = Util.getListForByteCheck(list, map);
		Map<String, Object> mapNullCheck = Util.getListForNullCheck((List<Map<String, String>>) mapByteCheck.get("list"), arrStrKcd);
		
		List<Map<String, String>> resultList = (List<Map<String, String>>) mapNullCheck.get("list");
		
		for(Map<String, String> iMap : resultList) {
			iMap.put("CURD", "C");
		}
		
		count += (Integer) mapByteCheck.get("count");
		count += (Integer) mapNullCheck.get("count");

		result.put("list", resultList);
		result.put("count", count);

		comz02Service.deleteFile(strTmpPath);
		
		return result;
	}

	@Override
	public void insertEdcCrKcdByExcelList(List<Map<String, Object>> list) throws Exception {
		
		//테스트 환경시 Exception
		come01Service.selectCmSysEnvrnByEnvrnSe();
		
		String strDicaryVer = "";
		
		for(Map<String, Object> iMap : list) {
			if("M".equals(iMap.get("CURD"))) {
				strDicaryVer = EgovStringUtil.isNullToString(iMap.get("DICARY_VER"));
			}
		}
		
		int count = 0;
		for(Map<String, Object> iMap : list) {
			if("C".equals(iMap.get("CURD"))) {
				
				iMap.put("USER_ID", Util.getUserMap().get("USER_ID"));
				iMap.put("DICARY_VER", strDicaryVer);
				
				if(count == 0) {
					comc03DAO.insertEdcCrMic(iMap);
					count++;
				}
				
				iMap.put("KCD_SN", edcCrKcdSeq.getNextStringId());
				comc03DAO.insertEdcCrKcd(iMap);
			}
		}
	}

	@Override
	public List<Map<String, Object>> selectEdcCrMdicByDicarySeCode(Map<String, String> map) throws Exception {
		return comc03DAO.selectEdcCrMdicByDicarySeCode(map);
	}

	@Override
	public List<Map<String, Object>> selectEdcCrKcdByKcdSn(Map<String, String> map) throws Exception {
		return comc03DAO.selectEdcCrKcdByKcdSn(map);
	}

	@Override
	public int selectEdcCrKcdCountByKcdSn(Map<String, String> map) throws Exception {
		return comc03DAO.selectEdcCrKcdCountByKcdSn(map);
	}
}
