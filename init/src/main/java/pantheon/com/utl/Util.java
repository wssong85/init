package pantheon.com.utl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.CharacterRun;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Section;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * Pantheon 유틸리티
 * 
 * @author 송원석
 * @since 2016.02.24
 * @version 1.0
 * @see 수정일 수정자 수정내용
 *      ------- -------- ---------------------------
 *      2016.02.24 송원석 최초 생성
 * 
 */
public class Util {

	private static final Logger LOGGER = LoggerFactory.getLogger(Util.class);

	/**
	 * 사용자 세션을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static HttpSession getHttpSession() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request.getSession();
	}

	/**
	 * 요청정보를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static HttpServletRequest getHttpServletRequest() throws Exception {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	}

	/**
	 * response정보를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static HttpServletResponse getHttpServletResponse() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletWebRequest servletWebRequest = new ServletWebRequest(request);
		return servletWebRequest.getResponse();
	}

	/**
	 * 풀 url을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getFullUrl() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	}

	/**
	 * 사용자정보를 가져온다.
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getUserMap() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMap") != null) {
			Map<String, String> mRet = (Map<String, String>) session.getAttribute("loginMap");
			return mRet;
		} else {
			return null;
		}
	}

	/**
	 * 프로그램 정보를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getProgrmMap() throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("progrmMap") != null) {
			Map<String, String> mRet = (Map<String, String>) session.getAttribute("progrmMap");
			return mRet;
		} else {
			return null;
		}
	}

	/**
	 * 현재 접속 유저가 설정한 언어를 가져온다.
	 * 한국어: kr
	 * 영어: en
	 * 일본어: jp
	 * 중국어1: ch_1
	 * 중국어2: ch_2
	 * 
	 * @return
	 */
	public static String getStrLocale() throws Exception {
		String strLocale = null;

		try {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			HttpSession session = request.getSession();

			Object locale = session.getAttribute("org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE");

			strLocale = EgovStringUtil.isNullToString(locale);

			if ("".equals(strLocale)) {
				strLocale = "kr";
			}
		} catch (Exception e) {
			LOGGER.error("util.class getStrLocale ERROR :" + e.getLocalizedMessage());
			throw e;
		}

		return strLocale;
	}

	/**
	 * 파일 라인별로 읽기
	 * 
	 * @param path
	 * @return
	 */
	public static String getStrFile(String path, String url) throws Exception {

		if (!"".equals(EgovStringUtil.isNullToString(path)) && !"".equals(EgovStringUtil.isNullToString(url))) {
			return null;
		}

		BufferedReader rd;
		String line;
		String result = "";
		InputStreamReader isr;

		try {

			if (url != null) {
				URL connect = new URL(url);
				isr = new InputStreamReader(connect.openStream());
				rd = new BufferedReader(isr);
			} else {
				rd = new BufferedReader(new FileReader(path));
			}

			while ((line = rd.readLine()) != null) {
				result += line;
			}
			rd.close();
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	/**
	 * 지정한 key로 map생성
	 * 
	 * @param map
	 * @param arr
	 * @return
	 */
	public static Map<String, String> getMapForTrail(Map<String, String> map, String[] arr) throws Exception {
		Map<String, String> retMap = new HashMap<String, String>();

		for (String mapkey : map.keySet()) {
			for (String iStr : arr) {
				if (iStr.equals(mapkey) && map.get(mapkey) != null) {
					retMap.put(mapkey, map.get(mapkey));
				}
			}
		}

		return retMap;
	}

	/**
	 * 지정한 key로 map생성
	 * 
	 * @param map
	 * @param arr
	 * @return
	 */
	public static Map<String, String> getMapForTrailByObject(Map<String, Object> map, String[] arr) throws Exception {
		Map<String, String> retMap = new HashMap<String, String>();

		for (String mapkey : map.keySet()) {
			for (String iStr : arr) {
				if (iStr.equals(mapkey) && map.get(mapkey) != null) {
					retMap.put(mapkey, String.valueOf(map.get(mapkey)));
				}
			}
		}

		return retMap;
	}

	/**
	 * audit trail update argument 변환
	 * 
	 * @param map
	 * @param arr
	 * @param arr2
	 * @return
	 * @throws Exception
	 */
	public static String[] getMapForTrailByArrString(Map<String, String> map, String[] arr, String[] arr2) throws Exception {
		List<String> list = new ArrayList<String>();

		for (String mapkey : map.keySet()) {
			for (int i = 0; i < arr.length; i++) {
				if (arr[i].equals(mapkey) && map.get(mapkey) != null) {
					list.add(arr2[i]);
				}
			}
		}

		String[] retArrStr = new String[list.size()];

		for (int i = 0; i < list.size(); i++) {
			retArrStr[i] = list.get(i);
		}

		return retArrStr;
	}

	/**
	 * audit trail update argument 변환
	 * 
	 * @param map
	 * @param arr
	 * @param arr2
	 * @return
	 * @throws Exception
	 */
	public static String[] getMapForTrailByArrObject(Map<String, Object> map, String[] arr, String[] arr2) throws Exception {
		List<String> list = new ArrayList<String>();

		for (String mapkey : map.keySet()) {
			for (int i = 0; i < arr.length; i++) {
				if (arr[i].equals(mapkey) && map.get(mapkey) != null) {
					list.add(arr2[i]);
				}
			}
		}

		String[] retArrStr = new String[list.size()];

		for (int i = 0; i < list.size(); i++) {
			retArrStr[i] = list.get(i);
		}

		return retArrStr;
	}

	/**
	 * 배열을 받아서 "_" 지정자 있는 String 생성
	 * 
	 * @param arr
	 * @return
	 */
	public static String getStrForTrail(String[] arr) throws Exception {
		String retStr = "";

		for (String str : arr) {
			retStr += str + ",";
		}

		return retStr.substring(0, retStr.length() - 1);
	}

	/**
	 * ,구분자로 권한을 String으로 돌려준다.
	 * 
	 * @return
	 */
	public static String getAuthorities() throws Exception {
		String retStr = "";

		for (int i = 0; i < EgovUserDetailsHelper.getAuthorities().size(); i++) {
			String string = EgovUserDetailsHelper.getAuthorities().get(i);
			retStr += string + ",";
		}

		return retStr.substring(0, retStr.length() - 1);
	}

	/**
	 * 각 값 trim처리
	 * 
	 * @param list
	 * @return
	 */
	public static List<Map<String, Object>> setTrimByListObject(List<Map<String, Object>> list) throws Exception {

		for (Map<String, Object> iMap : list) {
			for (String mapkey : iMap.keySet()) {
				if (iMap.get(mapkey) != null) {
					iMap.put(mapkey, iMap.get(mapkey).toString().trim());
				} else {
					iMap.put(mapkey, "");
				}
			}
		}

		return list;
	}

	/**
	 * 각 값 trim처리
	 * 
	 * @param list
	 * @return
	 */
	public static List<Map<String, String>> setTrimByListString(List<Map<String, String>> list) throws Exception {

		for (Map<String, String> iMap : list) {
			for (String mapkey : iMap.keySet()) {
				if (iMap.get(mapkey) != null) {
					iMap.put(mapkey, iMap.get(mapkey).toString().trim());
				} else {
					iMap.put(mapkey, "");
				}
			}
		}

		return list;
	}

	/*
	 * 1) 숫자만(number) : ^[0-9]*$
	 * 2) 영문자만(english) : ^[a-zA-Z]*$
	 * 3) 한글만(korean) : ^[가-힣]*$
	 * 4) 영어 & 숫자만(eng&number) : ^[a-zA-Z0-9]*$
	 * 5) E-Mail(email) : ^[a-zA-Z0-9]+@[a-zA-Z0-9]+$
	 * 6) 휴대폰(phone) : ^01(?:0|1|[6-9]) - (?:\d{3}|\d{4}) - \d{4}$
	 * 7) 일반전화(telno) : ^\d{2.3} - \d{3,4} - \d{4}$
	 * 8) 주민등록번호(ihidnum): \d{6} \- [1-4]\d{6}
	 * 9) IP 주소(ip) : ([0-9]{1,3}) \. ([0-9]{1,3}) \. ([0-9]{1,3}) \. ([0-9]{1,3})
	 * 10) 휴대폰(phone11(11자리)) : \\d{11}$
	 */
	/**
	 * 문자 검증(정규식)
	 * 
	 * @param str1
	 * @param str2
	 * @return
	 * @throws Exception
	 */
	public static boolean isRegexStr(String str1, String str2) throws Exception {
		boolean flag = false;

		if ("number".equals(str2) && str1.trim().matches("^[0-9]*$")) {
			flag = true;
		} else if ("english".equals(str2) && str1.trim().matches("^[a-zA-Z]*$")) {
			flag = true;
		} else if ("korean".equals(str2) && str1.trim().matches("^[가-힣]*$")) {
			flag = true;
		} else if ("eng&number".equals(str2) && str1.trim().matches("^[a-zA-Z0-9]*$")) {
			flag = true;
		} else if ("email".equals(str2) && str1.matches("^[a-zA-Z0-9]+@[a-zA-Z0-9]+$")) {
			flag = true;
		} else if ("phone".equals(str2) && str1.matches("^01(?:0|1|[6-9]) - (?:\\d{3}|\\d{4}) - \\d{4}$")) {
			flag = true;
		} else if ("telno".equals(str2) && str1.matches("^\\d{2.3} - \\d{3,4} - \\d{4}$")) {
			flag = true;
		} else if ("ihidnum".equals(str2) && str1.matches("\\d{6} \\- [1-4]\\d{6}")) {
			flag = true;
		} else if ("ip".equals(str2) && str1.matches("([0-9]{1,3}) \\. ([0-9]{1,3}) \\. ([0-9]{1,3}) \\. ([0-9]{1,3})")) {
			flag = true;
		} else if ("phone11".equals(str2) && str1.matches("\\d{11}$")) {
			flag = true;
		}

		return flag;
	}

	/**
	 * xml 특정 엘리먼트를 List<Map> 으로 반환
	 * 
	 * @param url
	 * @param file
	 * @param arr
	 * @param tagetElement
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, String>> getListByXml(String url, String file, String[] arr, String tagetElement) throws Exception {

		if (!"".equals(EgovStringUtil.isNullToString(url)) && !"".equals(EgovStringUtil.isNullToString(file))) {
			throw new Exception("");
		}

		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = null;

		if (!"".equals(EgovStringUtil.isNullToString(url))) {
			doc = dBuilder.parse(url);
		} else {
			doc = dBuilder.parse(new File(file));
		}

		doc.getDocumentElement().normalize();

		NodeList items = doc.getElementsByTagName(tagetElement);

		List<Map<String, String>> pubList = new ArrayList<Map<String, String>>();

		for (int i = 0; i < items.getLength(); i++) {

			Node n = items.item(i);
			if (n.getNodeType() != Node.ELEMENT_NODE)
				continue;

			String[] fieldNames = arr;

			Element e = (Element) n;
			Map<String, String> pub = new HashMap<String, String>();
			for (String name : fieldNames) {
				NodeList titleList = e.getElementsByTagName(name);
				Element titleElem = (Element) titleList.item(0);
				Node titleNode = titleElem.getChildNodes().item(0);
				pub.put(name, titleNode.getNodeValue());
			}
			pubList.add(pub);

		}

		return pubList;
	}

	/**
	 * List<Map<String, String>> 을 Json 형태의 String으로 반환한다.
	 * 
	 * @param list
	 * @return
	 */
	public static String geStrJsonByString(List<Map<String, String>> list) throws Exception {

		StringBuffer sb = new StringBuffer();
		int listSize = list.size();
		int mapSize = 0;

		sb.append("[");
		for (Map<String, String> iMap : list) {
			sb.append("{");

			mapSize = iMap.size();

			for (String mapkey : iMap.keySet()) {
				sb.append("\"" + mapkey + "\"");
				sb.append(":");
				String strTmp = iMap.get(mapkey);
				strTmp = strTmp.replace("\"", "'");
				strTmp = strTmp.trim();

				if (strTmp.indexOf("\n") > 0) {
					strTmp = strTmp.replace("\n", "");
				}

				sb.append("\"" + strTmp + "\"");

				if (--mapSize != 0) {
					sb.append(",");
				}
			}

			sb.append("}");
			if (--listSize != 0) {
				sb.append(",");
			}
		}
		sb.append("]");

		return sb.toString();
	}

	/**
	 * List<Map<String, Object>> 을 Json 형태의 String으로 반환한다.
	 * 
	 * @param list
	 * @return
	 */
	public static String geStrJsonByObject(List<Map<String, Object>> list) throws Exception {

		StringBuffer sb = new StringBuffer();
		int listSize = list.size();
		int mapSize = 0;

		sb.append("[");
		for (Map<String, Object> iMap : list) {
			sb.append("{");

			mapSize = iMap.size();

			for (String mapkey : iMap.keySet()) {
				sb.append("\"" + mapkey + "\"");
				sb.append(":");

				String strTmp = String.valueOf(iMap.get(mapkey));

				strTmp = strTmp.replace("\"", "'");
				strTmp = strTmp.trim();

				if (strTmp.indexOf("\n") > 0) {
					strTmp = strTmp.replace("\n", "");
				}

				sb.append("\"" + strTmp + "\"");

				if (--mapSize != 0) {
					sb.append(",");
				}
			}

			sb.append("}");
			if (--listSize != 0) {
				sb.append(",");
			}
		}
		sb.append("]");

		return sb.toString();
	}

	/**
	 * 랜덤문자 20자 반환
	 * 
	 * @return
	 */
	public static String getStrRnd() throws Exception {
		Random rnd = new Random();

		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < 20; i++) {
			if (rnd.nextBoolean()) {
				buf.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		return buf.toString();
	}

	/**
	 * 랜덤문자 패스워드 생성
	 * 
	 * @return
	 */
	public static String getStrPasswordRnd() throws Exception {
		Random rnd = new Random();

		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < 10; i++) {
			if (rnd.nextBoolean()) {
				buf.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		return buf.toString() + "!@12";
	}

	/**
	 * List<Map<String, String>> 으로 반환 (null 체크는 안한다.)
	 * 
	 * @param sheet
	 * @param arrStr
	 * @return
	 */
	public static List<Map<String, String>> getListForExcelSheet(Sheet sheet, String[] arrStr, int iRow) throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Row row = null;
		Map<String, String> map = null;
		Cell cell = null;
		int cnt = sheet.getPhysicalNumberOfRows();

		for (int i = iRow; i < cnt; i++) {
			map = new HashMap<String, String>();
			row = sheet.getRow(i);

			for (int j = 0; j < arrStr.length; j++) {
				cell = row.getCell(j);
				if (cell != null) {
					try {
						map.put(arrStr[j], String.valueOf(cell.getStringCellValue()));
					} catch (IllegalStateException e) {
						map.put(arrStr[j], String.valueOf((int) cell.getNumericCellValue()));
					}
				} else {
					map.put(arrStr[j], "");
				}
			}
			map.put("EXCEL_ROW", String.valueOf(i));
			list.add(map);
		}

		return list;
	}

	/**
	 * 리스트의 각 특정 값 byte 체크
	 * 
	 * @param list
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getListForByteCheck(List<Map<String, String>> list, Map<String, Integer> map) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int count = 0;

		for (Map<String, String> iMap : list) {
			for (String iMapKey : map.keySet()) {
				for (String jMapKey : iMap.keySet()) {

					if (iMapKey.equals(jMapKey) && !"".equals(EgovStringUtil.isNullToString(iMap.get(iMapKey))) && iMap.get(iMapKey).getBytes("UTF-8").length > (int) map.get(jMapKey)) {
						iMap.put(iMapKey, "fail");
						iMap.put("VALIDATION", "fail");
						count++;
					}

				}
			}
		}

		result.put("list", list);
		result.put("count", count);
		return result;
	}

	/**
	 * 리스트의 특정 값 null 체크
	 * 
	 * @param list
	 * @param arr
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getListForNullCheck(List<Map<String, String>> list, String[] arr) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int count = 0;

		for (Map<String, String> iMap : list) {
			for (String iMapKey : iMap.keySet()) {
				for (String iStr : arr) {
					if (iStr.equals(iMap.get(iMapKey)) && "".equals(EgovStringUtil.isNullToString(iMap.get(iMapKey)))) {
						iMap.put(iMapKey, "fail");
						iMap.put("VALIDATION", "fail");
						count++;
					}
				}
			}
		}

		result.put("list", list);
		result.put("count", count);
		return result;
	}

	/**
	 * word 파일 PDF로 변환
	 * 
	 * @param uploadPath
	 * @param uploadFileNm
	 * @param textList
	 * @return String
	 * @throws Exception
	 */
	public static String wordConverter(String uploadPath, String uploadFileNm, List<Map<String, String>> textList) throws Exception {
		
		String msg = null;
		SocketOpenOfficeConnection connection = null;
		File inputFile = null;
		
		try {
			POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(uploadPath + uploadFileNm));
			HWPFDocument doc = new HWPFDocument(fs);

			if(textList != null && textList.size() > 0) {
				
				Range r = doc.getRange();
				for (int i = 0; i < r.numSections(); ++i) {
					Section s = r.getSection(i);
					for (int j = 0; j < s.numParagraphs(); j++) {
						Paragraph p = s.getParagraph(j);
						for (int k = 0; k < p.numCharacterRuns(); k++) {
							CharacterRun run = p.getCharacterRun(k);
							String text = run.text();
							
							for (Map<String, String> t : textList) {
								if (text.contains("${" + t.get("CODE") + "}")) {
									run.replaceText("${" + t.get("CODE") + "}", t.get("VALUE"));
								}
							}
						}
					}
				}
				
			}

			FileOutputStream out = new FileOutputStream(new File(uploadPath + uploadFileNm + "_temp.doc"));
			doc.write(out);
			out.close();

			inputFile = new File(uploadPath + uploadFileNm + "_temp.doc");
			File outputFile = new File(uploadPath + uploadFileNm + "_pdf.pdf");

			connection = new SocketOpenOfficeConnection(8100);
			connection.connect();

			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(inputFile, outputFile);

			File renameFile = new File(uploadPath + uploadFileNm + "_pdf");
			outputFile.renameTo(renameFile);
			
		} catch (Exception e) {
//			e.printStackTrace();
			msg = e.getLocalizedMessage();
		} finally {
			try {
				if (inputFile.exists()) {
					inputFile.delete();
				}
			} catch (Exception e2) {
			}
			try {
				if (connection.isConnected()) {
					connection.disconnect();
				}
			} catch (Exception e2) {
				throw e2;
			}
		}
		
		if (msg != null) {
			throw new Exception(msg);
		}
		
		return uploadPath + uploadFileNm + "_pdf";
	}

	/**
	 * rd파라미터 String 맵핑
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static String getStrForRdByString(Map<String, String> map) throws Exception {
		StringBuffer sb = new StringBuffer();
		int mapSize = map.size();

		for (String iStr : map.keySet()) {
			sb.append(iStr);
			sb.append("[");
			sb.append(EgovStringUtil.isNullToString(map.get(iStr)));
			sb.append("]");
			if (--mapSize != 0) {
				sb.append(" ");
			}
		}
		return sb.toString();
	}

	/**
	 * rd파라미터 Object 맵핑
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static String getStrForRdByObject(Map<String, String> map) throws Exception {
		StringBuffer sb = new StringBuffer();
		int mapSize = map.size();

		for (String iStr : map.keySet()) {
			sb.append(iStr);
			sb.append("[");
			sb.append(EgovStringUtil.isNullToString(map.get(iStr)));
			sb.append("]");
			if (--mapSize != 0) {
				sb.append(" ");
			}
		}
		return sb.toString();
	}

	/**
	 * Map 2개를 합친다.
	 * 
	 * @param fMap
	 * @param sMap
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getMapForCombine(Map<String, Object> fMap, Map<String, Object> sMap) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		for (String iStr : fMap.keySet()) {
			result.put(iStr, fMap.get(iStr));
		}

		for (String iStr : sMap.keySet()) {
			result.put(iStr, sMap.get(iStr));
		}

		return result;
	}

	/**
	 * jsonObject 를 map 으로 변환
	 * 
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> makeMap(JSONObject jsonObject) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator<String> iterator = jsonObject.keys();
		while (iterator.hasNext()) {
			String key = iterator.next();
			Object value = null;
			try {
				value = jsonObject.get(key);
				if (value.equals(null)) {
					value = null;
				}
			} catch (JSONException e) {
				throw e;
			}
			map.put(key, value);
		}
		return map;
	}

	/**
	 * 디아모 암호화 값인지 확인(테이블 컬럼 확인) - ATRAIL 자동입력 시 확용, ATRAIL 조회 시 활용
	 * 
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public static boolean isDamo(Object object) throws Exception {

		if ("ADRES_A".equals(object) 
				|| "ADRES_B".equals(object) 
				|| "ADRES_C".equals(object) 
				|| "ADRES_D".equals(object) 
				|| "CELL_PHONE".equals(object) 
				|| "BSNM_REGIST_NO".equals(object) 
				|| "REPORTR_TLPHON".equals(object) 
				|| "REPORTR_EMAIL".equals(object) 
				|| "INFO_OFFER_TLPHON".equals(object) 
				|| "INFO_OFFER_ADRES".equals(object) 
				|| "INFO_OFFER_EMAIL".equals(object) 
				|| "DETAILADDR".equals(object) 
				|| "ACNUT_NO".equals(object) 
				|| "OFFM".equals(object) 
				|| "EMAIL".equals(object) 
				|| "TELNO".equals(object) 
				|| "ADRES".equals(object) 
				|| "ADDRONE".equals(object) 
				|| "ADDRTWO".equals(object) 
				|| "STRAS".equals(object) 
				|| "STCD1".equals(object) 
				|| "STCD2".equals(object) 
				|| "STCD3".equals(object) 
				|| "TELF1".equals(object) 
				|| "PHONE_NO".equals(object) 
				|| "ENG_ADRES".equals(object) 
				|| "CTTPC".equals(object)) 
		{
			
			return true;

		}

		return false;

	}

	/**
	 * 시간대 컬럼인지 확인한다 (시간대 AOP 시 활용)
	 * 
	 * @param mapkey
	 * @return
	 * @throws Exception
	 */
	public static boolean isTimeConvert(String mapkey) throws Exception {
		
		if(mapkey.length() < 6) {
			return false;
		}
		
		if ("_DE".equals(mapkey.substring(mapkey.length() - 3, mapkey.length())) 
				|| "EATHDE".equals(mapkey.substring(mapkey.length()-6, mapkey.length())) 
				|| "MRPSDE".equals(mapkey.substring(mapkey.length()-6, mapkey.length()))
				|| "_DT".equals(mapkey.substring(mapkey.length() - 3, mapkey.length())) 
				|| "_PD".equals(mapkey.substring(mapkey.length() - 3, mapkey.length())) 
				|| "_DTE".equals(mapkey.substring(mapkey.length() - 4, mapkey.length())) 
				|| "DATE".equals(mapkey.substring(mapkey.length() - 4, mapkey.length())) 
				|| "_END".equals(mapkey.substring(mapkey.length() - 4, mapkey.length())) 
				|| "_UPDDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_CREDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_BNGDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_ENDDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "IRTHDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "RRNCDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length()))
				|| "_BEGIN".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_BGNDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_ENDDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "FYEAMD".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "PPLCDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "ALIDPD".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "USNGDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "QESTDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "HOPEDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "QESTDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "OMPTDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length())) 
				|| "_CNCDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length()))
				|| "LASTDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length()))
				|| "PRTNDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length()))
				|| "NCTNDE".equals(mapkey.substring(mapkey.length() - 6, mapkey.length()))) 
		{

			return true;

		}

		return false;

	}

	/**
	 * 본인인증에 쓰이는 유틸
	 * 
	 * @param paramValue
	 * @param gubun
	 * @return
	 */
	public static String requestReplace(String paramValue, String gubun) {
		String result = "";

		if (paramValue != null) {

			paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

			paramValue = paramValue.replaceAll("\\*", "");
			paramValue = paramValue.replaceAll("\\?", "");
			paramValue = paramValue.replaceAll("\\[", "");
			paramValue = paramValue.replaceAll("\\{", "");
			paramValue = paramValue.replaceAll("\\(", "");
			paramValue = paramValue.replaceAll("\\)", "");
			paramValue = paramValue.replaceAll("\\^", "");
			paramValue = paramValue.replaceAll("\\$", "");
			paramValue = paramValue.replaceAll("'", "");
			paramValue = paramValue.replaceAll("@", "");
			paramValue = paramValue.replaceAll("%", "");
			paramValue = paramValue.replaceAll(";", "");
			paramValue = paramValue.replaceAll(":", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll("#", "");
			paramValue = paramValue.replaceAll("--", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll(",", "");

			if (gubun != "encodeData") {
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
	}
	
	/**
	 * 배열 2개를 map으로 변환(atrail)
	 * @param iArr
	 * @param jArr
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> getLabelMap(String[] iArr, String[] jArr) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		 
		if(iArr.length != jArr.length) {
			throw new Exception("Property`s right do not count! [ labelNm.length != columnNm.length ]");
		}
		
		for(int i = 0; i < iArr.length; i++) {
			result.put(iArr[i], jArr[i]);
		}
		
		return result;
	}
	
	
	/**
	 * 워드 파싱을 위해서 CODE, VALUE 로 list 반환 
	 * @param arr
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, String>> getListByWordParsing(Map<String, String> map) throws Exception {
		
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> innerMap = null;
		
		for(String mapkey : map.keySet()) {
			innerMap = new HashMap<String, String>();
			innerMap.put("CODE", mapkey);
			innerMap.put("VALUE", EgovStringUtil.isNullToString(map.get(mapkey)));
			list.add(innerMap);
		}
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String strDate = sdf.format(d);
		
		innerMap = new HashMap<String, String>();
		innerMap.put("CODE", "Y");
		innerMap.put("VALUE", strDate.substring(0, 4));
		list.add(innerMap);
		innerMap = new HashMap<String, String>();
		innerMap.put("CODE", "M");
		innerMap.put("VALUE", strDate.substring(4, 6));
		list.add(innerMap);
		innerMap = new HashMap<String, String>();
		innerMap.put("CODE", "D");
		innerMap.put("VALUE", strDate.substring(6, 8));
		list.add(innerMap);

		return list;
	}
	
	
	/**
	 * word 파일 PDF로 변환(임시파일 위치)
	 * 
	 * @param uploadPath
	 * @param uploadFileNm
	 * @param textList
	 * @return String
	 * @throws Exception
	 */
	public static String wordConverter2(String strFullPath, String strTmpPath, List<Map<String, String>> textList) throws Exception {
		
		String msg = null;
		SocketOpenOfficeConnection connection = null;
		File inputFile = null;
		
		try {
			POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(strFullPath));
			HWPFDocument doc = new HWPFDocument(fs);

			if(textList != null && textList.size() > 0) {
				
				Range r = doc.getRange();
				for (int i = 0; i < r.numSections(); ++i) {
					Section s = r.getSection(i);
					for (int j = 0; j < s.numParagraphs(); j++) {
						Paragraph p = s.getParagraph(j);
						for (int k = 0; k < p.numCharacterRuns(); k++) {
							CharacterRun run = p.getCharacterRun(k);
							String text = run.text();
							for (Map<String, String> t : textList) {
								if (text.contains("${" + t.get("CODE") + "}")) {
									run.replaceText("${" + t.get("CODE") + "}", t.get("VALUE"));
								}
							}
						}
					}
				}
				
			}

			FileOutputStream out = new FileOutputStream(new File(strTmpPath + "_temp.doc"));
			doc.write(out);
			out.close();

			inputFile = new File(strTmpPath + "_temp.doc");
			File outputFile = new File(strTmpPath + "_pdf.pdf");

			connection = new SocketOpenOfficeConnection(8100);
			connection.connect();

			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(inputFile, outputFile);
			
		} catch (Exception e) {
			msg = e.getLocalizedMessage();
		} finally {
			try {
				if (inputFile.exists()) {
					inputFile.delete();
				}
			} catch (Exception e2) {
			}
			try {
				if (connection.isConnected()) {
					connection.disconnect();
				}
			} catch (Exception e2) {
				throw e2;
			}
		}
		
		if (msg != null) {
			throw new Exception(msg);
		}
		
		return strTmpPath + "_pdf.pdf";
	}
	
	/**
	 * map 복사(String)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> getMapForShallowCopyByString(Map<String, String> map) throws Exception {
		Map<String, String> mapShallowCopy = new HashMap<String, String>();
		
		for(String mapkey : map.keySet()) {
			mapShallowCopy.put(mapkey, map.get(mapkey));
		}
		
		return mapShallowCopy;
	}
	
	/**
	 * map 복사(Object)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getMapForShallowCopyByObject(Map<String, Object> map) throws Exception {
		Map<String, Object> mapShallowCopy = new HashMap<String, Object>();
		
		for(String mapkey : map.keySet()) {
			mapShallowCopy.put(mapkey, map.get(mapkey));
		}
		
		return mapShallowCopy;
	}
	
	/**
	 * list 복사(String)
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, String>> getListForShaalowCopyByString(List<Map<String, String>> list) throws Exception {
		List<Map<String, String>> listShallowCopy = new ArrayList<Map<String, String>>();
		Map<String, String> mapShallowCopy = null;
		
		for(Map<String, String> iMap: list) {
			mapShallowCopy = new HashMap<String, String>();
			
			for(String mapkey : iMap.keySet()) {
				mapShallowCopy.put(mapkey, iMap.get(mapkey));
			}
			
			listShallowCopy.add(mapShallowCopy);
		}
		
		return listShallowCopy;
	}
	
	/**
	 * list 복사(Object)
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, Object>> getListForShaalowCopyByObject(List<Map<String, Object>> list) throws Exception {
		List<Map<String, Object>> listShallowCopy = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapShallowCopy = null;
		
		for(Map<String, Object> iMap: list) {
			mapShallowCopy = new HashMap<String, Object>();
			
			for(String mapkey : iMap.keySet()) {
				mapShallowCopy.put(mapkey, iMap.get(mapkey));
			}
			
			listShallowCopy.add(mapShallowCopy);
		}
		
		return listShallowCopy;
	}
	
	/**
	 * Pantheon 에러 메시지 
	 * @param str
	 * @throws Exception
	 */
	public static String getPantheonErrorMessage(Exception e, Object obj) throws Exception {
		
		
		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(Util.getHttpServletRequest().getServletContext());
		EgovMessageSource egovMessageSource = (EgovMessageSource) act.getBean("egovMessageSource");
		Class<? extends Object> clz = obj.getClass();
		
		//비지니스로직 에러 메시지
		if(e.getLocalizedMessage().startsWith(Globals.PANTHEON_BIZ_MESSAGE)) {
			
			int f= Globals.PANTHEON_BIZ_MESSAGE.length();
			int s = e.getLocalizedMessage().length();
			
			return e.getLocalizedMessage().substring(f, s);
			
		}
		//읽기, 쓰기 에러 메시지
		else if(e.getLocalizedMessage().startsWith(Globals.PANTHEON_READ_WRITE_MESSAGE)) {
			
			int f= Globals.PANTHEON_READ_WRITE_MESSAGE.length();
			int s = e.getLocalizedMessage().length();
			
			return e.getLocalizedMessage().substring(f, s);
		}
		
		LOGGER.error(clz.getName(), e);
		
		//SQL 에러
		if(e instanceof DataAccessException) {
			return egovMessageSource.getPantheonMessageByOriginal("global.error.2");
		}
		//서버 에러
		else {
			return egovMessageSource.getPantheonMessageByOriginal("global.error.1");
		}
	}

	/**
	 * CURD 체크 필요가 없는 메소드인지 확인한다 (AOP 활용)
	 * @param strMethodName
	 * @return
	 * @throws Exception
	 */
	public static boolean isCURDCheck(String strMethodName) throws Exception {
		
		if("selectCmMenuDistinctForLeftMenu".equals(strMethodName)
			||"selectCmMenuForLeftMenu".equals(strMethodName) 
			||"selectDistinctTaskByLeftMenu".equals(strMethodName) 
			||"selectTaskByLeftMenu".equals(strMethodName) 
			||"selectTaskList".equals(strMethodName)
			||"selectCtmsDmcTaskRoleForDupCheck".equals(strMethodName)
			||"selectCmProgrmForHeaderTaskModule".equals(strMethodName)
			||"selectQueryDataList".equals(strMethodName)
			||"selectQueryData".equals(strMethodName)
			||"selectCmMenuForModuleCode".equals(strMethodName)
			||"selectUserByEducationList".equals(strMethodName)
			||"selectCmCmmnCodeListByPk".equals(strMethodName)
			||"selectCmMenuByModuleCode".equals(strMethodName)
			||"selectCmProgrmForHomeMenu".equals(strMethodName)
			||"selectTaskList".equals(strMethodName)
			)
		{
			return true;
		}
		
		return false;
	}
	
	/**
	 * exception 과 동시에 로그를 남긴다.
	 * @param obj
	 * @param e
	 * @throws Exception
	 */
	public static void recordThrow(Object obj, Exception e) throws Exception {
		Class<? extends Object> clz = obj.getClass();
		LOGGER.error(clz.getName(), e);
		throw e;
	}
}
