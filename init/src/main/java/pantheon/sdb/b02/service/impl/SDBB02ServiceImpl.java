package pantheon.sdb.b02.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pantheon.com.z06.dao.COMZ06DAO;
import pantheon.com.z06.service.COMZ06Service;
import pantheon.sdb.b02.dao.SDBB02DAO;
import pantheon.sdb.b02.service.SDBB02Service;
import org.codehaus.jettison.json.JSONArray;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("SDBB02Service")
public class SDBB02ServiceImpl implements SDBB02Service{
	
	@Resource(name = "SDBB02DAO")
	private SDBB02DAO sdbb02DAO;
	
	@Resource(name = "COMZ06DAO")
	private COMZ06DAO comz06DAO;	
	
	@Resource(name = "COMZ06Service")
	private COMZ06Service comz06Service;
	
	@Resource(name = "SDM_FILE_MASTR")
	private EgovIdGnrService dmFileMastrSeq;
	
	@Resource(name = "SDM_FILE_DETAIL")
	private EgovIdGnrService dmFileDetailSeq;
	
	@Resource(name = "SDB_DELNGLN_SEQ")
	private EgovIdGnrService sdbDelnglnSeq;	
	
	
	@Resource(name = "ATRAIL_SDB_IM_DELNGLN_CHARGER_MANAGE")
	protected EgovPropertyService atraildelngln_charger_manage;
	
	
	
	
	
	/**
	 * 기관 등록/수정/삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public String insertOrgan(Map<String, String> param) throws Exception {
		JSONArray array = new JSONArray(param.get("data"));
		
		Map<String, String> DelngnlData = new HashMap<String, String>();		
		String mode = array.getJSONObject(0).getString("CURD");
		System.out.println("============");
		
		System.out.println("========111111====");
		if (!mode.equals("D")){
			DelngnlData.put("DELNGLN_SE", array.getJSONObject(0).getString("DELNGLN_SE"));
			DelngnlData.put("DELNGLN_NM", array.getJSONObject(0).getString("DELNGLN_NM"));
			DelngnlData.put("DMSTC_SE", array.getJSONObject(0).getString("DMSTC_SE"));
			DelngnlData.put("CNTRCT_FILE_ID", array.getJSONObject(0).getString("CNTRCT_FILE_ID"));
			DelngnlData.put("CNTRCT_PD", array.getJSONObject(0).getString("CNTRCT_PD"));
			DelngnlData.put("CNTRCT_PD_END", array.getJSONObject(0).getString("CNTRCT_PD_END"));
			DelngnlData.put("EFECT_OCCRRNCDE", array.getJSONObject(0).getString("EFECT_OCCRRNCDE"));
			DelngnlData.put("PRMISNDE", array.getJSONObject(0).getString("PRMISNDE"));
			DelngnlData.put("CMTDE", array.getJSONObject(0).getString("CMTDE"));
			DelngnlData.put("UPDATE_ID", array.getJSONObject(0).getString("UPDATE_ID"));
		}
		System.out.println(DelngnlData);		
		// TODO Auto-generated method stub
		String DelnglnSeq ="";
		if(mode.equals("C"))		
		{	
			int iDelnglnSeq = Integer.parseInt(sdbDelnglnSeq.getNextStringId());
			String txt_code = String.format("%04d", iDelnglnSeq);
		    Calendar c = Calendar.getInstance();
		    String txtYear = new String();
		    txtYear = String.valueOf(c.get(Calendar.YEAR));
			String Category ="OD"; // 거래선			
			String txtTg_code = Category+""+txtYear+""+txt_code;
			DelnglnSeq = txtTg_code; 
			DelngnlData.put("DELNGLN_CODE", txtTg_code);			
			sdbb02DAO.insertOrgan(DelngnlData);
			
		}else if(mode.equals("U")){
			DelnglnSeq = array.getJSONObject(0).getString("DELNGLN_CODE");
			DelngnlData.put("DELNGLN_CODE", DelnglnSeq);
			sdbb02DAO.updateOrgan(DelngnlData);
		}else if(mode.equals("D")){
			DelnglnSeq = array.getJSONObject(0).getString("DELNGLN_CODE");
			DelngnlData.put("DELNGLN_CODE", DelnglnSeq);
			sdbb02DAO.deleteOrgan(DelngnlData);
		}
		
		if (!mode.equals("D")){
			for(int i = 0; i < array.getJSONObject(0).getJSONArray("chagerGrid").length(); i++){
				Map<String, String> chagerGrid = new HashMap<String, String>();
				
				chagerGrid.put("CURD", 			array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CURD"));
				chagerGrid.put("CHARGER_NM", 	array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CHARGER_NM"));
				chagerGrid.put("CLSF", 			array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CLSF"));
				chagerGrid.put("CTTPC", 		array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CTTPC"));
				chagerGrid.put("EMAIL", 		array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("EMAIL"));			
				chagerGrid.put("UPDATE_ID", 	array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("UPDATE_ID"));
				chagerGrid.put("CHARGER_SN", 	array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CHARGER_SN"));
				chagerGrid.put("DELNGLN_CODE", 	array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("DELNGLN_CODE"));
				
				if(chagerGrid.get("CURD").equals("C")) {
					chagerGrid.put("DELNGLN_CODE", DelnglnSeq);
					sdbb02DAO.insertCharger(chagerGrid);
					comz06Service.createCmDtaAtrailForInsertByString(chagerGrid, atraildelngln_charger_manage, null, null);
				} else if(chagerGrid.get("CURD").equals("U")) {
					//chagerGrid.put("DELNGLN_CODE",  array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("DELNGLN_CODE"));
					comz06Service.createCmDtaAtrailForUpdateByString(chagerGrid, atraildelngln_charger_manage, null, null);
					sdbb02DAO.updateCharger(chagerGrid);
					
				} else if(chagerGrid.get("CURD").equals("D")){
					chagerGrid.put("CHARGER_SN",  array.getJSONObject(0).getJSONArray("chagerGrid").getJSONObject(i).getString("CHARGER_SN"));
					sdbb02DAO.deleteCharger(chagerGrid);
				}
			}
		}
		return DelnglnSeq; 
	}
	
	@Override
	public  Map<String, Object> selectOrganInfo(Map<String, Object> param) throws Exception{
		Map<String, Object> result = sdbb02DAO.selectOrganInfo(param);		
		System.err.println(result);
		return result;
	}
	
	
	
	
	
	/**
	 * 기관 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectOrganList(Map<String, String> map) throws Exception {
		return sdbb02DAO.selectOrganList(map);
	}
	
	
	@Override
	public  Map<String, Object> selectDelnglnInfo(Map<String, Object> param){
		Map<String, Object> result = sdbb02DAO.selectDelnglnInfo(param);		
		System.err.println(result);
		return result;
	}
	

	/**
	 * 계약서 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectCntrctInfo(Map<String, String> map) throws Exception {
		return sdbb02DAO.selectCntrctInfo(map);
	}
	
	/**
	 * 담당자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	@Override
	public List<Map<String, Object>> selectChagerListInfo(Map<String, String> map) throws Exception {		
		return sdbb02DAO.selectChagerListInfo(map);
	}
	
	@Override
	public  Map<String, Object> selectChagerInfo(Map<String, Object> param){
		Map<String, Object> result = sdbb02DAO.selectChagerInfo(param);		
		System.err.println(result);
		return result;
	}
	
	
	@Override
	public void insertProduct(Map<String, String> iMap) throws Exception {
		// TODO Auto-generated method stub
		if(iMap.get("CURD").equals("C"))
		{
			sdbb02DAO.insertProduct(iMap);
		}else if(iMap.get("CURD").equals("U")){
			//sdbb02DAO.updateOrganList(iMap);
		}else if(iMap.get("CURD").equals("D")){
			//sdbb02DAO.deleteOrganList(iMap);		
		}
	}
	
	
	@Override
	public void insertProductDel(Map<String, String> param) throws Exception {
		// TODO Auto-generated method stub
		sdbb02DAO.deleteProduct(param);	
	}

	@Override
	public List<Map<String, Object>> selectProductInfo(Map<String, String> map) throws Exception {
		return sdbb02DAO.selectProductInfo(map);
	}
	

	
	@Override
	public boolean delOrgan(Map<String, String> param, String mode) throws Exception {
		
		// TODO Auto-generated method stub
		sdbb02DAO.delOrgan(param);		
		
		return true;
	}
	
	
	@Override
	public void delCtFile(List<Map<String, Object>> list) throws Exception {
		
		for(Map<String, Object> iMap : list) {
			sdbb02DAO.delCtFile(iMap);		
		}
	}
	
	@Override
	public List<Map<String, Object>> selectProductList(Map<String, String> map) throws Exception{
		System.out.println("@@@Service Impl sdb!!!!!");
		return sdbb02DAO.selectProductList(map);
	}
	
	@Override
	public String selectProductListCount(Map<String, String> map) throws Exception{
		return sdbb02DAO.selectProductListCount(map);
		
	}
	
	@Override
	public List<Map<String, Object>> selectProductListReg(Map<String, String> map) throws Exception{
		System.out.println(map);
		return sdbb02DAO.selectProductListReg(map);
	}
	
}
