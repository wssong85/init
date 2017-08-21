package pantheon.edc.l01.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import pantheon.edc.l01.dao.EDCL01DAO;
import pantheon.edc.l01.service.EDCL01Service;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * Data import 목록을 처리하는 비지니스 구현 클래스
 * @author 오동근
 * @since 2016.03.17
 * @version 1.0
 * @see
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.03.17  오동근          최초 생성
 *  
 */
@Service("EDCL01Service")
public class EDCL01ServiceImpl implements EDCL01Service {
	
	@Resource(name = "EDCL01DAO")
	EDCL01DAO edcl01DAO;
	
	@Resource(name = "EDC_CF_CDISC_SEQ")
	private EgovIdGnrService cdiscSeq;
	
	@Resource(name = "EDC_CF_CDISCDOMN_SEQ")
	private EgovIdGnrService cdiscDomnSeq;
	
	@Resource(name = "EDC_CF_CDISCVRIABL_SEQ")
	private EgovIdGnrService cdiscVriablSeq;
	
	@Resource(name = "EDC_CF_CDISCCODE_SEQ")
	private EgovIdGnrService cdiscCodeSeq;
	
	@Resource(name = "EDC_CF_VALUE_SEQ")
	private EgovIdGnrService cdiscValueSeq;
	
	
	Map<String,Object> xmlHomeMap = new HashMap<String, Object>();
	List<Map<String,Object>> xmlSubList = new ArrayList<Map<String,Object>>();
	List<Map<String,Object>> xmlSubChildList = new ArrayList<Map<String,Object>>();

	/**
	 * Data import 목록
	 */
	@Override
	public List<Map<String, Object>> selectCdiscList(Map<String, Object> param)	throws Exception {
		return edcl01DAO.selectCdiscList(param);
	}
	
	/**
	 * data Import List Count
	 */
	public String selectCdiscListCount(Map<String, Object> param) throws Exception {
		return edcl01DAO.selectCdiscListCount(param); 
	}

	/**
	 * 엑셀 파싱 및 유효성 체크에 대한 비즈니스 로직
	 */
	public String excelValidationChk(String filePath, String cfcdiscDomnSn) throws Exception {
		try {
			Map<String,Object> excelMap = new HashMap<String, Object>();
			List<Map<String,Object>> excelList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> dbList = new ArrayList<Map<String,Object>>();
			
			Workbook wb = WorkbookFactory.create(new File(filePath));
			Sheet sheet = wb.getSheetAt(0); //wb.getSheet("시트명"); 으로 대체가능
			
			int rows = sheet.getPhysicalNumberOfRows(); // 행 갯수 가져오기
			String value = null;
			String itemOid = "";
			DataFormatter formatter = new DataFormatter();
			
			// 담아놓은 VRIABL 테이블에서 변수명과 매칭시킬 OID를 가져온다.
			dbList = edcl01DAO.selectCdiscVriablList(cfcdiscDomnSn);
			
			int cells = sheet.getRow(0).getPhysicalNumberOfCells();
			
			// DB 에서 select 한 VRIABL_NM과 헤더값이 일치해야 한다.
			Row headerRow = sheet.getRow(0);
			for(int c = 0; c < cells; c++){
				itemOid = (String) dbList.get(c).get("VRIABL_NM");
				Cell cell = headerRow.getCell(c); //cell 가져오기
				
				if(itemOid.equals(formatter.formatCellValue(cell))){
					System.out.println(formatter.formatCellValue(cell) + " 값 정상!");
				}else{
					System.out.println(" @@@@@값 비정상!");
				}
			}
			
			itemOid = "";
			
			for(int j = 1; j < rows; j++){
				Row row = sheet.getRow(j);
				if(row != null){
					for(int c = 0; c < cells; c++){
						itemOid = (String) dbList.get(c).get("VRIABL_OID_NM");
						Cell cell = row.getCell(c); //cell 가져오기
						value = formatter.formatCellValue(cell);  //cell.getStringCellValue();
						excelMap.put(c + "val", value);
						excelMap.put("vriablValue", value);
						excelMap.put("itemOid", itemOid);
						excelMap.put("rowOrdr", j); // 행순서
						excelMap.put("lblOrdr", c+1); // 라벨순서
						
						excelList.add(excelMap);
						excelMap = new HashMap<String, Object>();
					}
				}
			}
			
			// EDC_CF_VALUE에 Insert
            for(Map<String, Object> map : excelList){
           	 map.put("edcCfValueSn", cdiscValueSeq.getNextStringId());
           	 map.put("cfcdiscDomnSn", cfcdiscDomnSn);
           	 edcl01DAO.insertCdiscValue(map);
            }
			
			 
		} catch (Exception e) {
			System.out.println("@@@@Service Error : " + e.getLocalizedMessage());
		}
		
		return null;
	}

	/**
	 * xml중 Define.xml을 제외한 파싱 및 유효성 체크에 대한 비즈니스 로직
	 */
	public String xmlValidationChk(String filePath, String cfcdiscDomnSn) throws Exception {
		try {
			Map<String,Object> xmlMap = new HashMap<String, Object>();
			List<Map<String,Object>> xmlList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> dbList = new ArrayList<Map<String,Object>>();
			
			String vriablNm = "";
			String domnOrdr = "";
			int cnt = 0;
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = (Document) builder.parse(filePath);
			
			// 담아놓은 VRIABL 테이블에서 변수명과 매칭시킬 OID를 가져온다.
			dbList = edcl01DAO.selectCdiscVriablList(cfcdiscDomnSn);
			
			// 루트 엘리먼트 접근
			 Element root = doc.getDocumentElement();
            
             // ItemGroupData 노드
             NodeList mstNodeList = root.getElementsByTagName("ItemGroupData");
             for(int i=0; i<mstNodeList.getLength(); i++){
            	 Node mstNode =  mstNodeList.item(i);
            	 Element mstElement = (Element)mstNode;
            	 
            	  cnt = mstElement.getElementsByTagName("ItemData").getLength();
            	// cnt = dbList.size();
            	 // DB에 담아놓은 ItemRef의 ItemOID와 파싱한 xml데이터의 ItemOID를 매칭시켜 맞으면 값을 넣고 틀리면 빈값을 넣는다.
            	 for(int j=0; j<cnt; j++){
            		 xmlMap.put("vriablValue", mstElement.getElementsByTagName("ItemData").item(j).getAttributes().getNamedItem("Value").getNodeValue());
            		 xmlMap.put("itemOid", mstElement.getElementsByTagName("ItemData").item(j).getAttributes().getNamedItem("ItemOID").getNodeValue());
            		 xmlMap.put("rowOrdr", i+1); //행순서
            		 xmlMap.put("lblOrdr", j+1); //라벨순서
            		 xmlList.add(i, xmlMap);
                	 xmlMap = new HashMap<String, Object>();
                	 
            		 
            		/* if(dbList.get(j).get("VRIABL_OID_NM").equals(mstElement.getElementsByTagName("ItemData").item(j).getAttributes().getNamedItem("ItemOID").getNodeValue())){
            			 xmlMap.put("vriablValue", mstElement.getElementsByTagName("ItemData").item(j).getAttributes().getNamedItem("Value").getNodeValue());
                		 xmlMap.put("rowOrdr", i+1); //행순서
                		 xmlMap.put("lblOrdr", j+1); //라벨순서
            		 }else{
            			 xmlMap.put("vriablValue", "");
                		 xmlMap.put("rowOrdr", i+1); //행순서
                		 xmlMap.put("lblOrdr", j+1); //라벨순서
            		 }
            		 
            		 xmlList.add(i, xmlMap);
                	 xmlMap = new HashMap<String, Object>();*/
            	 }
             }
             
             // EDC_CF_VALUE에 Insert
             for(Map<String, Object> map : xmlList){
            	 map.put("edcCfValueSn", cdiscValueSeq.getNextStringId());
            	 map.put("cfcdiscDomnSn", cfcdiscDomnSn);
            	 edcl01DAO.insertCdiscValue(map);
             }
             
		} catch (Exception e) {
			System.out.println("@@@@EDC_CF_VALUE Error : " + e.getLocalizedMessage());
		}
		
		
		return null;
	}

	/**
	 * xml중 Define.xml 파싱 및 유효성 체크에 대한 비즈니스 로직
	 */
	public String defineXmlValidationChk(String filePath, String fileNo, String cdiscSeCode, String imprtNm) throws Exception {
		try {
			Map<String,Object> xmlAttMap = new HashMap<String, Object>();
			List<Map<String,Object>> xmlAttList = new ArrayList<Map<String,Object>>();
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = (Document) builder.parse(filePath);
			
			// 루트 엘리먼트 접근
			 Element root = doc.getDocumentElement();
             
			 // 키값을 미리 생성해서 map에 적재한다.
             String cfcdiscSn = cdiscSeq.getNextStringId();
             xmlHomeMap.put("cfcdiscSn", cfcdiscSn); 
             
             // 마스터 데이터를 가져온다.
             xmlAttList = defineXmlMst(root, xmlAttList, xmlAttMap, cfcdiscSn);
             // 마스터 데이터로 연결된 키값으로 Keys 값을 가져온다.
             xmlAttList = defineXmlKeys(root, xmlAttList);
             // 마스터 데이터로 연결된 키값으로 Documentation 값을 가져온다.
             xmlAttList = defineXmlDoc(root, xmlAttList);
             xmlHomeMap.put("cdiscFileSn", fileNo);
             xmlHomeMap.put("cdiscSeCode", cdiscSeCode);
             xmlHomeMap.put("imprtNm", imprtNm);
             
             //EDC_CF_CDISC에 한건 Insert
             edcl01DAO.insertCdisc(xmlHomeMap);
             
             // EDC_CF_CDISCDOMN에 Insert
             for(Map<String, Object> mstMap : xmlAttList){
            	 edcl01DAO.insertCdiscDomn(mstMap);
             }
             // EDC_CF_CDISCVRIABL에 Insert
             for(Map<String, Object> subMap : xmlSubList){
            	 edcl01DAO.insertCdiscVriabl(subMap);
             }
         	 // EDC_CF_CDISCCODE에 Insert
             for(Map<String, Object> subChildMap : xmlSubChildList){
            	 subChildMap.put("cfcdiscSn", cfcdiscSn);
            	 subChildMap.put("cdiscCodeSn", cdiscCodeSeq.getNextStringId());
            	 edcl01DAO.insertCdiscCode(subChildMap);
             }
             
             xmlHomeMap = new HashMap<String, Object>();
             xmlSubList = new ArrayList<Map<String,Object>>();
             xmlSubChildList = new ArrayList<Map<String,Object>>();
 			
		} catch (Exception e) {
			System.out.println("@@@@DefineXmlValidationChk Service Error : " + e.getLocalizedMessage());
		}
		
		return null;
	}
	
	/**
	 * Define.xml 중 ItemGroupDef(Master)값을 가져오기 위한 메서드.
	 * @param root
	 * @param xmlAttList
	 * @return
	 * @throws Exception
	 */
	private List<Map<String,Object>> defineXmlMst(Element root, List<Map<String,Object>> xmlAttList, Map<String,Object> xmlAttMap, String cfcdiscSn) throws Exception {
		Map<String,Object> xmlSubMap = new HashMap<String, Object>();
	//	Map<String,Object> xmlHomeMap = new HashMap<String, Object>();
	//	List<Map<String,Object>> xmlSubList = new ArrayList<Map<String,Object>>();
		
		 // ItemGroupDef 노드(마스터 노드)
        NodeList n1 = root.getElementsByTagName("ItemGroupDef");
		 // GlobalVariables 노드      
        NodeList n2 = root.getElementsByTagName("GlobalVariables");
        
        Node homeNode = n2.item(0);
        Element homeElement = (Element) homeNode;
        
        xmlHomeMap.put("ruleNm",  homeElement.getElementsByTagName("StudyName").item(0).getTextContent());
        xmlHomeMap.put("ruleDc",  homeElement.getElementsByTagName("StudyDescription").item(0).getTextContent());
        xmlHomeMap.put("taskNo",  homeElement.getElementsByTagName("ProtocolName").item(0).getTextContent());
        
		int cnt = 0;
		int cnt2 = 0;
		int cnt3 = 0;
		String tempItemOID = "";
		String lblOrdr = "";
		String tempSubItemOID = "";
		String leafId = "";
		String tempLv2KeySeq = "";
		String tempLv2MethodOID = "";
		String cfcdiscDomnSn = "";
		
	/*	try{*/
         
         // ItemGroupDef 노드의 값 만큼 for문 시작
         for(int i=0; i<n1.getLength(); i++){
        	 
        	 Node node = n1.item(i);
             Element mstElement = (Element)node;
             
           // 키값을 미리 만들어 Map에 적재한다.
             cfcdiscDomnSn = cdiscDomnSeq.getNextStringId();
        	 xmlAttMap.put("cfcdiscDomnSn", cfcdiscDomnSn);
        	 xmlAttMap.put("cfcdiscSn", cfcdiscSn); //상위키값
        	 xmlAttMap.put("domnOrdr", i+1); //DOMN_ORDR
             
             // ItemGroupDef의 속성 갯수
             cnt =  mstElement.getAttributes().getLength();
             // ItemRef의 노드 갯수
             cnt2 = mstElement.getElementsByTagName("ItemRef").getLength();
             // Description
             xmlAttMap.put("description", mstElement.getElementsByTagName("TranslatedText").item(0).getTextContent());
             // Location 값을 가져갈때 비교할 값
             leafId = mstElement.getElementsByTagName("def:leaf").item(0).getAttributes().getNamedItem("ID").getNodeValue();
             // ItemRef의 수만큼 for문
             for(int k = 0; k < cnt2; k++){
            	 // 각 ItemRef의 속성 갯수
            	 cnt3 = mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getLength();
            	 // Itemref노드의 속성중 ItemOID의 속성값
            	 tempItemOID = mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("ItemOID").getNodeValue();
            	 lblOrdr = mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("OrderNumber").getNodeValue(); // LBL_ORDR
            	 // ItemRef의 속성수만큼 for문
            	 for(int l=0; l<cnt3; l++){
            		 
            		 // 속성값 mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("KeySequence").getNodeValue()
            		 if(mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().item(l).getNodeName().equals("KeySequence")){
            			 tempLv2KeySeq = mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("KeySequence").getNodeValue();
            			 
            			 if(tempSubItemOID.equals("")){
	            				tempSubItemOID = tempItemOID;
            			 }else if(!tempSubItemOID.equals("") && !tempSubItemOID.equals(null)){
            				tempSubItemOID = tempSubItemOID + "," + tempItemOID;
            			 }
            		 }
            		 
            		 if(mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().item(l).getNodeName().equals("MethodOID")){
            			 tempLv2MethodOID = mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("MethodOID").getNodeValue();
            		 }
            		 
            		 if(l == cnt3-1){
            			 // 마스터의 ItemOID의 속성값으로 하위 레벨 데이터를 정제한다.
            			 
            			 xmlSubMap = defineXmlLv2(root, tempItemOID, tempLv2KeySeq, tempLv2MethodOID, cfcdiscDomnSn);
            			 xmlSubMap.put("lblOrdr", lblOrdr);
            			 xmlSubList.add(k, xmlSubMap);
            			 tempLv2KeySeq = "";
            			 tempLv2MethodOID = "";
            			 
            			 xmlSubMap = new HashMap<String, Object>();
            		 }
            	 }
            	 
            	 if(k == cnt2-1){
        			 xmlAttMap.put("keys", tempSubItemOID);
        			 tempItemOID = "";
        			 tempSubItemOID = "";
        		 }
             }
             
             // ItemGroupDef의 노드 속성값만큼 for문
             for(int j = 0; j < cnt; j++){
            	 
            	 // mstElement.getAttributes().item(j).getNodeName()); // 속성명 가져오기
            	 // mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName())); // 속성값 가져오기
            	 // mstElement.getElementsByTagName("ItemRef").item(k).getAttributes().getNamedItem("ItemOID").getNodeValue(); //하위노드의 속성값 가져오기
            	 // mstElement.getElementsByTagName("TranslatedText").item(0).getTextContent() //노드의 값 가져오기
            	 
            	 // Dataset
                 if(mstElement.getAttributes().item(j).getNodeName().equals("SASDatasetName")){
                	 xmlAttMap.put("dataset", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                 }
                 // Documentation을 찾기 위한 값
                 if(mstElement.getAttributes().item(j).getNodeName().equals("def:CommentOID")){
                	 xmlAttMap.put("documentation", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                 }
                 // Location을 찾기 위한 값
                 if(mstElement.getAttributes().item(j).getNodeName().equals("def:ArchiveLocationID")){
                	 // 속성 def:ArchiveLocationID의 값과 위에서 미리 받은 def:leaf의 ID속성값을 매칭해서 맞으면 def:title 노드value값을 저장한다.
                	 if(mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()).equals(leafId)){
                		 xmlAttMap.put("location", mstElement.getElementsByTagName("def:title").item(0).getTextContent());
                	 }
                 }
                 // Class
                 if(mstElement.getAttributes().item(j).getNodeName().equals("def:Class")){
                	 xmlAttMap.put("class", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                 }
                 // Structure
                 if(mstElement.getAttributes().item(j).getNodeName().equals("def:Structure")){
                	 xmlAttMap.put("structure", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                 }
                 // Purpose
                 if(mstElement.getAttributes().item(j).getNodeName().equals("Purpose")){
                	 xmlAttMap.put("purpose", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                 }
                 
                 if(j == cnt-1){
                	 xmlAttList.add(i, xmlAttMap);
                	 xmlAttMap = new HashMap<String, Object>();
                 }
             }
             
             mstElement.getElementsByTagName("def:title").item(0).getTextContent();
             cfcdiscDomnSn = "";
         }
		/*// 트라이 캐치 고민..
		}catch(Exception e){
			throw new Exception();
		}*/
		return xmlAttList;
	}
	
	/**
	 * Define.xml 중 Keys값을 가져오기 위한 메서드.
	 * @param root
	 * @param xmlAttList
	 * @return
	 * @throws Exception
	 */
	private List<Map<String,Object>> defineXmlKeys(Element root, List<Map<String,Object>> xmlAttList ) throws Exception {
		NodeList n2 = root.getElementsByTagName("ItemDef");
		
        String oidKey = "";
        String tempItemOID = "";
		String tempSubItemOID = "";
        
        // 마스터의 리스트 갯수만큼 for문 시작
        for(int k=0; k<xmlAttList.size(); k++){
        	oidKey = (String) xmlAttList.get(k).get("keys");
        	String[] oid = oidKey.split(",");
        	
	        // ItemDef 노드의 값 만큼 for문 시작
	        for(int p=0; p<n2.getLength(); p++){
	       	 	
	       	 	Node node = n2.item(p);
	            Element subElement = (Element)node;
	            
            	tempItemOID = subElement.getAttribute("Name");
            	// 마스터의 리스트 중 keys값은 복수이며 숫자만큼 ItemDef 속성중 OID값과 같은걸 찾아 매칭한다.
            	for(int i=0; i<oid.length; i++){
            		if(subElement.getAttribute("OID").equals(oid[i])){
            			if(tempSubItemOID.equals("")){
            				tempSubItemOID = tempItemOID;
            			}else if(!tempSubItemOID.equals("") && !tempSubItemOID.equals(null)){
            				tempSubItemOID = tempSubItemOID + "," + tempItemOID;
            			}
 	               }
            	}
	        }
	        
	        xmlAttList.get(k).put("keys", tempSubItemOID);
			tempItemOID = "";
			tempSubItemOID = "";
        }
        
		return xmlAttList;
	}
	
	/**
	 * Define.xml 중 Documentation값을 가져오기 위한 메서드.
	 * @param root
	 * @param xmlAttList
	 * @return
	 * @throws Exception
	 */
	private List<Map<String,Object>> defineXmlDoc(Element root, List<Map<String,Object>> xmlAttList ) throws Exception {
		NodeList n2 = root.getElementsByTagName("def:CommentDef");
		NodeList n3 = root.getElementsByTagName("def:leaf");
		
        String oidKey = "";
        String defLeaf = "";
		String tempSubItemOID = "";
        
        // 마스터의 리스트 갯수만큼 for문 시작
        for(int k=0; k<xmlAttList.size(); k++){
        	oidKey = (String) xmlAttList.get(k).get("documentation");
        	
	        // CommentDef 노드의 값 만큼 for문 시작
	        for(int p=0; p<n2.getLength(); p++){
	       	 	
	       	 	Node node = n2.item(p);
	            Element element = (Element)node;
	            
        		if(element.getAttribute("OID").equals(oidKey)){
        			
        			tempSubItemOID = element.getElementsByTagName("TranslatedText").item(0).getTextContent();
        			
        			defLeaf = element.getElementsByTagName("def:DocumentRef").item(0).getAttributes().getNamedItem("leafID").getNodeValue();
        			for(int i=0; i<n3.getLength(); i++){
        				Node subNode = n3.item(i);
        	            Element subElement = (Element)subNode;
                		if(subElement.getAttribute("ID").equals(defLeaf)){
                			if(tempSubItemOID.equals("")){
	            				tempSubItemOID = subElement.getElementsByTagName("def:title").item(0).getTextContent();
	            			}else if(!tempSubItemOID.equals("") && !tempSubItemOID.equals(null)){
	            				tempSubItemOID = tempSubItemOID + "," + subElement.getElementsByTagName("def:title").item(0).getTextContent();
	            			}
                		}
        			}
               }
	        }
	        
	        xmlAttList.get(k).put("documentation", tempSubItemOID);
	        defLeaf = "";
			tempSubItemOID = "";
	        
        }
        
		return xmlAttList;
	}
	
	/**
	 * Define.xml 중 ItemDef(Master 하위레벨)값을 가져오기 위한 메서드.
	 * @param root
	 * @param oid
	 * @return
	 * @throws Exception
	 */
	private Map<String,Object> defineXmlLv2(Element root, String oid, String keySeq, String methodOID, String cfcdiscDomnSn) throws Exception {
		Map<String,Object> xmlSubMap = new HashMap<String, Object>();
		
		NodeList n = root.getElementsByTagName("ItemDef");
		
		int cnt = 0;
        String dvComment = "";
        String codeOID = "";
        String cfcdiscVriablSn = "";
        
		// ItemDef 노드의 값 만큼 for문 시작
        for(int i=0; i<n.getLength(); i++){
        	
       	 	Node node = n.item(i);
            Element mstElement = (Element)node;
            
            if(mstElement.getAttribute("OID").equals(oid)){
            	// 키값을 미리 만들어 Map에 적재한다. (받아온 상위순번도 Map에 적재한다.)
            	cfcdiscVriablSn = cdiscVriablSeq.getNextStringId();
                xmlSubMap.put("cfcdiscVriablSn", cfcdiscVriablSn);
                xmlSubMap.put("cfcdiscDomnSn", cfcdiscDomnSn); //상위순번
                xmlSubMap.put("vriablOidNm", oid); // ItemRef의 itemOID
            	
        		// ItemDef의 속성 갯수
                cnt =  mstElement.getAttributes().getLength();
                // Label
                xmlSubMap.put("label", mstElement.getElementsByTagName("TranslatedText").item(0).getTextContent());
                // Key
                xmlSubMap.put("key", keySeq);
                
                // 자식 노드가 있는지 없는지 체크해서 있으면 값을 담는다. (def:Origin)
                for(Node SubNode = n.item(i).getFirstChild(); SubNode!=null; SubNode=SubNode.getNextSibling()){ //첫번째 자식을 시작으로 마지막까지 다음 형제를 실행
                    if(SubNode.getNodeName().equals("def:Origin")){
                    	// Origin
                        xmlSubMap.put("origin", mstElement.getElementsByTagName("def:Origin").item(0).getAttributes().getNamedItem("Type").getNodeValue());
                    }else if(SubNode.getNodeName().equals("CodeListRef")){
                    	codeOID = mstElement.getElementsByTagName("CodeListRef").item(0).getAttributes().getNamedItem("CodeListOID").getNodeValue();
                    	// ctFormat
                    	xmlSubMap.put("ctFormat", defineXmlLv2CtFormat(root, codeOID));
                    	xmlSubMap.put("cdiscSubmitvalue", defineXmlLv2SubmitValue(root, codeOID));
                    	// CodeList 테이블에 insert
                    	defineXmlLv2CodeList(root, codeOID);
                    }
                }
                
                // Derivation/Comment
                dvComment = defineXmlLv2DvComment(root, methodOID);
                
                
                // ItemDef의 노드 속성 값 만큼 for문
                for(int j = 0; j < cnt; j++){
        		
                	// Variable
                    if(mstElement.getAttributes().item(j).getNodeName().equals("SASFieldName")){
                   	 xmlSubMap.put("variable", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                    }
                    // Type
                    if(mstElement.getAttributes().item(j).getNodeName().equals("DataType")){
                   	 xmlSubMap.put("type", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                    }
                    // Length
                    if(mstElement.getAttributes().item(j).getNodeName().equals("Length")){
                   	 xmlSubMap.put("length", mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                    }
                    // Derivation/Comment 추가값
                    if(mstElement.getAttributes().item(j).getNodeName().equals("def:CommentOID")){
                    	if(dvComment == ""){
                    		dvComment = defineXmlLv2DvCommentSub(root, mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                    	}else if(dvComment !="" && !dvComment.equals(null)){
                    		dvComment = dvComment + "," + defineXmlLv2DvCommentSub(root, mstElement.getAttribute(mstElement.getAttributes().item(j).getNodeName()));
                    	}
                    	
                    }
                }
                // Derivation/Comment
                xmlSubMap.put("dvComment", dvComment);
                
        	}
		}
		return xmlSubMap;
	}
	
	/**
	 * Define.xml 중 ItemDef(Master 하위레벨)의 Derivation/Comment 값을 가져오기 위한 메서드.
	 * @param root
	 * @param methodOID
	 * @return
	 * @throws Exception
	 */
	private String defineXmlLv2DvComment(Element root, String methodOID ) throws Exception {
		NodeList n = root.getElementsByTagName("MethodDef");
		NodeList n2 = root.getElementsByTagName("def:leaf");
        String tempStr = "";
        String tempAttr = "";
        
        if(methodOID != ""){
        	// MethodDef 노드의 값 만큼 for문 시작
            for(int p=0; p<n.getLength(); p++){
           	 	Node node = n.item(p);
                Element subElement = (Element)node;
            	
        		if(subElement.getAttribute("OID").equals(methodOID)){
        			tempStr = subElement.getElementsByTagName("TranslatedText").item(0).getTextContent();
        			
        			// 자식 노드가 있는지 없는지 체크해서 있으면 값을 담는다. (def:DocumentRef)
                    for(Node SubNode = n.item(p).getFirstChild(); SubNode!=null; SubNode=SubNode.getNextSibling()){ //첫번째 자식을 시작으로 마지막까지 다음 형제를 실행
                        if(SubNode.getNodeName().equals("def:DocumentRef")){
                        	tempAttr = SubNode.getAttributes().getNamedItem("leafID").getNodeValue();
                        	
                        	for(int i=0; i<n2.getLength(); i++){
                				Node subChildNode = n2.item(i);
                	            Element subChildElement = (Element)subChildNode;
                        		if(subChildElement.getAttribute("ID").equals(tempAttr)){
                        			if(tempStr.equals("")){
                        				tempStr = subChildElement.getElementsByTagName("def:title").item(0).getTextContent() 
                        						+ "(" + subChildElement.getAttribute("xlink:href") + ")";
        	            			}else if(!tempStr.equals("") && !tempStr.equals(null)){
        	            				tempStr = tempStr + "," + subChildElement.getElementsByTagName("def:title").item(0).getTextContent() 
        										+ "(" + subChildElement.getAttribute("xlink:href") + ")";
        	            			}
                        		}
                			}
                        }
                    }
               }
            }
        }
		return tempStr;
	}
	
	/**
	 * Define.xml 중 ItemDef(Master 하위레벨)의 Derivation/Comment 값중 추가(Comment)로 가져오기 위한 메서드.
	 * @param root
	 * @param commentOID
	 * @return
	 * @throws Exception
	 */
	private String defineXmlLv2DvCommentSub(Element root, String commentOID ) throws Exception {
		NodeList n = root.getElementsByTagName("def:CommentDef");
		NodeList n2 = root.getElementsByTagName("def:leaf");
        String tempStr = "";
        String tempAttr = "";
        
        if(commentOID != ""){
        	// def:CommentDef 노드의 값 만큼 for문 시작
            for(int p=0; p<n.getLength(); p++){
           	 	Node node = n.item(p);
                Element subElement = (Element)node;
            	
        		if(subElement.getAttribute("OID").equals(commentOID)){
        			tempStr = subElement.getElementsByTagName("TranslatedText").item(0).getTextContent();
        			
        			// 자식 노드가 있는지 없는지 체크해서 있으면 값을 담는다. (def:DocumentRef)
                    for(Node SubNode = n.item(p).getFirstChild(); SubNode!=null; SubNode=SubNode.getNextSibling()){ //첫번째 자식을 시작으로 마지막까지 다음 형제를 실행
                        if(SubNode.getNodeName().equals("def:DocumentRef")){
                        	tempAttr = SubNode.getAttributes().getNamedItem("leafID").getNodeValue();
                        	
                        	for(int i=0; i<n2.getLength(); i++){
                				Node subChildNode = n2.item(i);
                	            Element subChildElement = (Element)subChildNode;
                        		if(subChildElement.getAttribute("ID").equals(tempAttr)){
                        			if(tempStr.equals("")){
                        				tempStr = subChildElement.getElementsByTagName("def:title").item(0).getTextContent(); 
                        					//	+ "(" + subChildElement.getAttribute("xlink:href") + ")";
        	            			}else if(!tempStr.equals("") && !tempStr.equals(null)){
        	            				tempStr = tempStr + "," + subChildElement.getElementsByTagName("def:title").item(0).getTextContent(); 
        									//	+ "(" + subChildElement.getAttribute("xlink:href") + ")";
        	            			}
                        		}
                			}
                        }
                    }
               }
            }
        }
		return tempStr;
	}
	
	/**
	 * Define.xml 중 ItemDef(Master 하위레벨)의 Controlled Terms or Format 값을 가져오기 위한 메서드.
	 * @param root
	 * @param commentOID
	 * @return
	 * @throws Exception
	 */
	private String defineXmlLv2CtFormat(Element root, String commentOID ) throws Exception {
		NodeList n = root.getElementsByTagName("CodeList");
        String tempNameStr = "";
        String tempStr = "";
        int cnt = 0;
        int cnt2 = 0;
        
        if(commentOID != ""){
        	// CodeList 노드의 값 만큼 for문 시작
            for(int p=0; p<n.getLength(); p++){
           	 	Node node = n.item(p);
                Element subElement = (Element)node;
            	
        		if(subElement.getAttribute("OID").equals(commentOID)){
        			tempNameStr = subElement.getAttribute("Name"); 
	        		// 각 ItemRef의 노드 갯수
	        		cnt = subElement.getElementsByTagName("CodeListItem").getLength();
	               	cnt2 = subElement.getElementsByTagName("EnumeratedItem").getLength();
	               	
	                // CodeListItem의 수만큼 for문
	               	// 각 CodeListItem의 속성중 CodedValue의 속성값을 가져온다. CodeListItem갯수가 하나일때와 두개 이상일때에 따라 다르게 담는다.
	                for(int k = 0; k < cnt; k++){
		                if(cnt == 1){
		                	tempStr = "[\"" + subElement.getElementsByTagName("CodeListItem").item(k).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"=\""
			                				+ subElement.getElementsByTagName("TranslatedText").item(k).getTextContent() + "\"]" + System.getProperty("line.separator") + "<" + tempNameStr + ">";
		                }else if(cnt != 1){
		                	if(k < cnt-1){
		                		if(tempStr.equals("")){
				                	tempStr = "[\"" + subElement.getElementsByTagName("CodeListItem").item(k).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"=\""
					                				+ subElement.getElementsByTagName("TranslatedText").item(k).getTextContent() + "\",";
		            			}else{
		            				tempStr = tempStr + "\"" + subElement.getElementsByTagName("CodeListItem").item(k).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"=\""
			                				+ subElement.getElementsByTagName("TranslatedText").item(k).getTextContent() + "\",";
		            			}
			                }else if(k == cnt-1){
			                	tempStr = tempStr + "\"" + subElement.getElementsByTagName("CodeListItem").item(k).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"=\""
		                				+ subElement.getElementsByTagName("TranslatedText").item(k).getTextContent() + "\"]" + System.getProperty("line.separator") + "<" + tempNameStr + ">";
			                }
		                } 
	                }
	                // EnumeratedItem의 수만큼 for문
	               	// 각 EnumeratedItem의 속성중 CodedValue의 속성값을 가져온다. CodeListItem갯수가 하나일때와 두개 이상일때에 따라 다르게 담는다.	                
	                for(int i = 0; i < cnt2; i++){
	                	if(cnt == 1){
		                	tempStr = "[\"" + subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"]" 
		                			+ System.getProperty("line.separator") + "<" + tempNameStr + ">";
		                }else if(cnt != 1){
			                if(i < cnt-1){
				                if(tempStr.equals("")){
				                	tempStr = "[\"" + subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\",";
		            			}else{
		            				tempStr = tempStr + "\"" + subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\",";
		            			}
			                }else if(i == cnt2-1){
			                	tempStr = tempStr + "\"" + subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue() + "\"]" 
			                			+ System.getProperty("line.separator") + "<" + tempNameStr + ">";
			                }
		                }
	                }
               }
            }
        }
		return tempStr;
	}
	
	/**
	 * Define.xml 중 ItemDef(Master 하위레벨)의 CDISC_SUBMIT_VALUE 값을 가져오기 위한 메서드.
	 * @param root
	 * @param commentOID
	 * @return
	 * @throws Exception
	 */
	private String defineXmlLv2SubmitValue(Element root, String commentOID ) throws Exception {
		NodeList n = root.getElementsByTagName("CodeList");
        String tempNameStr = "";
        
        if(commentOID != ""){
        	// CodeList 노드의 값 만큼 for문 시작
            for(int p=0; p<n.getLength(); p++){
           	 	Node node = n.item(p);
                Element subElement = (Element)node;
            	
        		if(subElement.getAttribute("OID").equals(commentOID)){
        			tempNameStr = subElement.getAttribute("Name"); 
               }
            }
        }
		return tempNameStr;
	}
	
	/**
	 * Define.xml 중 CodeList 테이블에 insert할 값 파싱 및 적재하기위한 메서드
	 * @param root
	 * @param commentOID
	 * @throws Exception
	 */
	private void defineXmlLv2CodeList(Element root, String commentOID) throws Exception {
		try {
			Map<String,Object> xmlSubChildMap = new HashMap<String, Object>();
			
			String tempNameStr = "";
	        String tempOidStr = "";
	        String tempUpperAlias = "";
	        int cnt = 0;
	        int cnt2 = 0;
			
			// 루트 엘리먼트 접근
            NodeList n = root.getElementsByTagName("CodeList");
     		
     		for(int p=0; p<n.getLength(); p++){
           	 	Node node = n.item(p);
                Element subElement = (Element)node;
                tempNameStr = subElement.getAttribute("Name"); 
    			tempOidStr = subElement.getAttribute("OID"); 
            	
        		if(subElement.getAttribute("OID").equals(commentOID)){
        			// 각 하위의 노드 갯수
	        		cnt = subElement.getElementsByTagName("CodeListItem").getLength();
	               	cnt2 = subElement.getElementsByTagName("EnumeratedItem").getLength();
	               	
        			NodeList nChild = n.item(p).getChildNodes();
        			//  Alias노드가 있을 때 상위코드를 넣어준다.
        			for(int j=0; j<nChild.getLength(); j++){
        				if(nChild.item(j).getNodeName().equals("Alias")){
        					tempUpperAlias = nChild.item(j).getAttributes().getNamedItem("Name").getNodeValue(); //상위코드
        					xmlSubChildMap.put("cfcdiscUpperCode", tempUpperAlias); //상위코드 한건
        					xmlSubChildMap.put("cdiscSubmitValue", tempOidStr); //제출용값 한건
        					xmlSubChildMap.put("cdiscSynonm", tempNameStr); // 동의어 한건
        					xmlSubChildMap.put("cfcdiscCode", "");
        					xmlSubChildList.add(xmlSubChildMap); //상위코드 쌓기.
        					xmlSubChildMap = new HashMap<String, Object>();
        				}
        			}
        			
	               	// EnumeratedItem 일때
	               	for(int i = 0; i < cnt2; i++){
	                	// 자식 노드가 있는지 없는지 체크해서 있으면 값을 담는다. (Alias)
	                	if(!tempUpperAlias.equals("")){
	                		xmlSubChildMap.put("cfcdiscUpperCode", tempUpperAlias); // 상위코드
	                		xmlSubChildMap.put("cfcdiscCode", subElement.getElementsByTagName("Alias").item(i).getAttributes().getNamedItem("Name").getNodeValue()) ; // 하위코드
	                		xmlSubChildMap.put("cdiscSubmitValue", subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue()); // 제출용값
	                		xmlSubChildMap.put("cdiscSynonm", "");
	                	}else{
	                		xmlSubChildMap.put("cdiscSubmitValue", subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue()); // 제출용값
	                		xmlSubChildMap.put("cfcdiscUpperCode", "");
	                		xmlSubChildMap.put("cfcdiscCode", "");
	                		xmlSubChildMap.put("cdiscSynonm", "");
	                	}
	                	
	                	xmlSubChildList.add(xmlSubChildMap);
	                	xmlSubChildMap = new HashMap<String, Object>();
	                }
	               	// CodeListItem 일때
	               	for(int i = 0; i < cnt; i++){
		                	// 자식 노드가 있는지 없는지 체크해서 있으면 값을 담는다. (Alias)
		                	if(!tempUpperAlias.equals("")){
		                		xmlSubChildMap.put("cfcdiscUpperCode", tempUpperAlias); // 상위코드
		                		xmlSubChildMap.put("cfcdiscCode", subElement.getElementsByTagName("Alias").item(i).getAttributes().getNamedItem("Name").getNodeValue()) ; // 하위코드
		                		xmlSubChildMap.put("cdiscSubmitValue", subElement.getElementsByTagName("CodeListItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue()); // 제출용값
		                		xmlSubChildMap.put("cdiscSynonm", subElement.getElementsByTagName("TranslatedText").item(i).getTextContent());
		                	}else{
		                		xmlSubChildMap.put("cfcdiscUpperCode", "");
		                		xmlSubChildMap.put("cfcdiscCode", "");
		                		xmlSubChildMap.put("cdiscSubmitValue", subElement.getElementsByTagName("EnumeratedItem").item(i).getAttributes().getNamedItem("CodedValue").getNodeValue()); // 제출용값
		                		xmlSubChildMap.put("cdiscSynonm", subElement.getElementsByTagName("TranslatedText").item(i).getTextContent());
		                	}
		                	
		                	xmlSubChildList.add(xmlSubChildMap);
		                	xmlSubChildMap = new HashMap<String, Object>();
		                }
        		}
     		}
     		
		} catch (Exception e) {
			System.out.println("@@@@Service Error : " + e.getLocalizedMessage());
		}
		
	}
	
	/**
	 * 도메인 명 콤보박스 List
	 */
	public List<Map<String, Object>> selectCdiscDomainList(	String cfcdiscSn) throws Exception {
		return edcl01DAO.selectCdiscDomainList(cfcdiscSn);
	}

	/**
	 * 도메인에 해당하는 변수 명 List
	 */
	public List<Map<String, Object>> selectCdiscVriablList(String cfcdiscDomnSn) throws Exception {
		return edcl01DAO.selectCdiscVriablList(cfcdiscDomnSn);
	}

	/**
	 * Data Import view 그리드 동적 생성 Value값  List 
	 */
	public List<Map<String, Object>> selectCdiscVariablValueList(Map<String, Object> param) throws Exception {
		return edcl01DAO.selectCdiscVariablValueList(param);
	}

	
}
