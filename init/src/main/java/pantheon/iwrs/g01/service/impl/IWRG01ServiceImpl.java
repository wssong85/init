package pantheon.iwrs.g01.service.impl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.springframework.stereotype.Service;

import pantheon.com.utl.Util;
import pantheon.iwrs.g01.BlockInfo;
import pantheon.iwrs.g01.BlockSizeInfo;
import pantheon.iwrs.g01.dao.IWRG01DAO;
import pantheon.iwrs.g01.service.IWRG01Service;

@Service("IWRG01Service")
public class IWRG01ServiceImpl implements IWRG01Service {
	@Resource(name = "IWRG01DAO")
	private IWRG01DAO iwrg01Dao;
	
	@Override
	public List<Map<String, String>> selectTaskList(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectTaskList(param); 
	}
	
	@Override
	public List<Map<String, String>> selectIwrsDesignList(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectIwrsDesignList(param);
	}
	
	@Override
	public String selectIwrsDesignerInfo(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectIwrsDesignerInfo(param);
	}
	
	@Override
	public void insertIwrsDesignerInfo(Map<String, String> param) throws Exception{
		iwrg01Dao.insertIwrsDesignerInfo(param);
	}
	
	@Override
	public List<Map<String, String>> selectRandomizationList(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectRandomizationList(param);
	}
	
	@Override
	public List<Map<String, String>> selectVisitInfo(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectVisitInfo(param);
	}
	
	@Override
	public String selectEdcVersion(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectEdcVersion(param);
	}
	
	@Override
	public List<Map<String, String>> selectArmRaioInfo(Map<String, String> param) throws Exception{
		return iwrg01Dao.selectArmRaioInfo(param);
	}
	
	@Override
	public String insertCodeCreat(Map<String, String> param) throws Exception{
		String creat_code = "";
		while(true){
			creat_code = iwrg01Dao.selectGenerateCreateCode(param);
			Map<String, String> map = new HashMap<String, String>();
			map.put("CREAT_CODE", creat_code);
			int cnt = iwrg01Dao.selectCreateCode(map);
			if(cnt == 0){
				param.put("CREAT_CODE", creat_code);
				break;
			}
		}
		
		iwrg01Dao.insertCodeCreat(param);
		iwrg01Dao.insertVisitSchdul(param);
		return creat_code; 
	}
	
	@Override
	public int insertArmRatioInfo(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("data"));
		int ratioSum = 0;
		Map<String, String> map = new HashMap<String, String>();
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DATA").length(); i++){
			map.put("CREAT_CODE", array.getJSONObject(0).getString("CREAT_CODE"));
			map.put("EDC_VER", array.getJSONObject(0).getString("EDC_VER"));
			map.put("TA_CODE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("TA_CODE"));
			map.put("TA_LBL", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("TA_LBL"));
			map.put("TA_RATE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("TA_RATE"));
			map.put("USE_AT", array.getJSONObject(0).getString("USE_AT"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			ratioSum += Integer.parseInt(array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("TA_RATE"));
			iwrg01Dao.insertArmRatioInfo(map);
		}
		return ratioSum;
	}
	
	@Override
	public void insertCodeConf(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("data"));
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DATA").length(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("CREAT_CODE", array.getJSONObject(0).getString("CREAT_CODE"));
			int confSn = iwrg01Dao.selectConfSn(map);
			map.put("CONF_SN", String.valueOf(confSn));
			map.put("CONF_TY", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("CONF_TY"));
			map.put("CONF_SIZE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("CONF_SIZE"));
			map.put("USE_AT", array.getJSONObject(0).getString("USE_AT"));
			int confValueSn = iwrg01Dao.selectConfValueSn(map);
			map.put("VALUE_SN", String.valueOf(confValueSn));
			map.put("CONF_VALUE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("CONF_VALUE"));
			map.put("USER_ID", Util.getUserMap().get("USER_ID"));
			iwrg01Dao.insertCodeConf(map);
			iwrg01Dao.insertCodeConfValue(map);
		}
	}
	
	@Override
	public void insertRandomSeed(Map<String, String> param) throws Exception{
		JSONArray array = new JSONArray(param.get("data"));
		Map<String, String> map = new HashMap<String, String>();
		map.put("CREAT_CODE", array.getJSONObject(0).getString("CREAT_CODE"));
		map.put("OPER_TY", array.getJSONObject(0).getString("OPER_TY"));
		map.put("SEED_CO", array.getJSONObject(0).getString("SEED_CO"));
		map.put("BLCK_SEED_CO", array.getJSONObject(0).getString("BLCK_SEED_CO"));
		map.put("USE_AT", array.getJSONObject(0).getString("USE_AT"));
		map.put("USER_ID", Util.getUserMap().get("USER_ID"));
		iwrg01Dao.insertRandomSeed(map);
		for(int i = 0; i < array.getJSONObject(0).getJSONArray("DATA").length(); i++){
			int blckSn = iwrg01Dao.selectBlckSn(map);
			map.put("BLCK_SN", String.valueOf(blckSn));
			map.put("BLCK_SIZE", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("BLCK_SIZE"));
			map.put("BLCK_CO", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("BLCK_CO"));
			map.put("CREAT_CO", array.getJSONObject(0).getJSONArray("DATA").getJSONObject(i).getString("CREAT_CO"));
			map.put("ADIT_AT", array.getJSONObject(0).getString("ADIT_AT"));
			iwrg01Dao.insertBlock(map);
		}
	}
	
	@Override
	public void insertRandomizationInfo(Map<String, String> param) throws Exception{
		List<Map<String, String>> armRatioList = iwrg01Dao.selectArmRatioInfoForGeneration(param);
		List<Map<String, String>> randomSeedList = iwrg01Dao.selectRandomSeedInfoForGeneration(param);
		List<Map<String, String>> blockSizeList = iwrg01Dao.selectBlockSizeInfoForGeneration(param);
		List<Map<String, String>> codeConfigurationList = iwrg01Dao.selectCodeConfForGeneration(param);
		List<String> codeList = new ArrayList<String>();
		List<String[]> data = new ArrayList<String[]>();
		String[] blockSizeArray = new String[blockSizeList.size()];
		int[] blockCountArray = new int[blockSizeList.size()];
		int[] countArray = new int[blockSizeList.size()]; 
		int sizeCount = 0;
		int createCodeCount = 0;
		for(Map<String, String> blockSize : blockSizeList){
			int cnt = 0;
			int count = 0;
			String[] str = new String[Integer.parseInt(String.valueOf(blockSize.get("BLCK_SIZE")))];
			for(Map<String, String> armRatio : armRatioList){
				cnt += Integer.parseInt(String.valueOf(armRatio.get("TA_RATE")));
			}
			for(Map<String, String> armRatio : armRatioList){
				for(int i = 0; i < Integer.parseInt(String.valueOf(armRatio.get("TA_RATE"))) * Integer.parseInt(String.valueOf(blockSize.get("BLCK_SIZE"))) / cnt; i++, count++){
					str[count] = String.valueOf(armRatio.get("TA_CODE"));
				}
			}
			data.add(str);
			blockSizeArray[sizeCount] = String.valueOf(blockSize.get("BLCK_SIZE"));
			blockCountArray[sizeCount] = Integer.parseInt(String.valueOf(blockSize.get("BLCK_CO")));
			countArray[sizeCount] = 0;
			createCodeCount += Integer.parseInt(String.valueOf(blockSize.get("BLCK_SIZE"))) * Integer.parseInt(String.valueOf(blockSize.get("BLCK_CO")));
			sizeCount++;
		}
		
		List<List<BlockInfo>> blockInfo = getBlockSort(data, Integer.parseInt(String.valueOf(randomSeedList.get(0).get("SEED_CO"))));
		List<BlockSizeInfo> blockSizeInfo = getBlockSizeSort(blockSizeArray, blockCountArray, Integer.parseInt(String.valueOf(randomSeedList.get(0).get("BLCK_SEED_CO"))));
		for(int i = 0; i < createCodeCount; i++){
			String code = "";
			for(Map<String, String> codeConf : codeConfigurationList){
				if("03".equals(codeConf.get("CONF_TY"))){
					String zeroSize = "";
					for(int j = 0; j < Integer.parseInt(String.valueOf(codeConf.get("CONF_SIZE"))); j++){
						zeroSize += "0";
					}
					int confValue = Integer.parseInt(String.valueOf(codeConf.get("CONF_VALUE"))) + i;
					String tempCode = zeroSize + String.valueOf(confValue);
					code += tempCode.substring(tempCode.length() - 3, tempCode.length());
				}else{
					code += codeConf.get("CONF_VALUE");
				}
			}
			codeList.add(code);
		}
		int codeCount = 0;
		for(BlockSizeInfo blockSize : blockSizeInfo){
			BlockInfo block = blockInfo.get(blockSize.getIndex()).get(countArray[blockSize.getIndex()]);
			for(int i = 0; i < block.getBlock().length(); i++){
				Map<String, String> map = new HashMap<String, String>();
				map.put("EDC_VER", param.get("EDC_VER"));
				map.put("CREAT_CODE", param.get("CREAT_CODE"));
				map.put("OPER_TY", param.get("OPER_TY"));
				map.put("ADIT_AT", param.get("ADIT_AT"));
				map.put("RANDOM_CODE", codeList.get(codeCount));
				map.put("TA_CODE", block.getBlock().substring(i, i + 1));
				map.put("USE_AT", param.get("USE_AT"));
				map.put("USER_ID", Util.getUserMap().get("USER_ID"));
				iwrg01Dao.insertRandomizationCode(map);
				codeCount++;
			}
			countArray[blockSize.getIndex()]++;
		}
	}
	
	public void test() throws Exception{
		List<List<String>> result = new ArrayList<List<String>>();
		List<String[]> data = new ArrayList<String[]>();
		
		String data1[] = {"A", "B", "C", "D"};
//		result.add(combine(data1));
		String data2[] = {"A", "A", "B", "B", "C", "C", "D", "D"};
//		result.add(combine(data2));
		String data3[] = {"A", "A", "A", "B", "B", "B", "C", "C", "C", "D", "D", "D"};
//		result.add(combine(data3));
		data.add(data1);
		data.add(data2);
		data.add(data3);
		getBlockSort(data, 1000);
		
//		String data4[] = {"A", "A", "A", "A", "B", "B", "B", "B"};
//		combine(result, data4);
//		System.err.println(result.size()); 
		String blockSize[] = {"4", "8", "12"};
		int blockCount[] = {10, 5, 5};
		getBlockSizeSort(blockSize, blockCount, 10000);
	}
	
	private List<String> combine(String[] data, int seed){
		List<String> result = new ArrayList<String>();
		int num = factorial(data);
		int cnt = 0;
		Random rand = new Random();
		rand.setSeed(seed);
		for(int i = 0; i < num;){
			int[] arr = new int[data.length];
			for(int j = 0; j < data.length; j++){
				arr[j] = -1;
			}
			String con = "";
			for(int j = 0; j < data.length; j++){
				int randNum = rand.nextInt(data.length);
				while(true){
					//System.err.println(randNum);
					boolean flag = true;
					for(int k = 0; k < arr.length; k++){
						if(arr[k] == randNum){
							flag = false;
							break;
						}
					}
					if(flag){
						arr[j] = randNum;
						break;
					}else{
						randNum = rand.nextInt(data.length);
					}
				}
			}

			for(int k = 0; k < arr.length; k++){
				con += data[arr[k]];
			}
			if(!result.contains(con)){
				result.add(con);
				i++;
			}
		}
		 
		return result;
	}
	
	private int factorial(String[] data){
		int num = 0;
		BigInteger fac = BigInteger.ONE;
		
		for(int i = 1; i <= data.length; i++){
			fac = fac.multiply(BigInteger.valueOf(i));
		}
		
		List<String> str = new ArrayList<String>();
		
		for(int i = 0; i < data.length; i++){
			if(!str.contains(data[i])){
				str.add(data[i]);
			}
		}
		
		BigInteger fac2 = BigInteger.ONE;
		for(int i = 0; i < str.size(); i++){
			int cnt = 0;
			BigInteger fac3 = BigInteger.ONE;
			for(int j = 0; j < data.length; j++){
				if(data[j].equals(str.get(i))){
					cnt++;
					fac3 = fac3.multiply(BigInteger.valueOf(cnt));
				}
			}
			fac2 = fac2.multiply(fac3);
		}
		
		fac = fac.divide(fac2);
		
		if(fac.compareTo(BigInteger.valueOf(10000)) >= 0){
			num = 10000;
		}else{
			num = fac.intValue();
		}
	
		
		return num;
	}
	
	private List<BlockSizeInfo> getBlockSizeSort(String[] blockSize, int[] blockCount,int seed){
		List<String> blockSizeList = new ArrayList<String>();
		List<BlockSizeInfo> blockSizeInfo = new ArrayList<BlockSizeInfo>();
		
		for(int i = 0; i < blockSize.length; i++){
			for(int j = 0; j < blockCount[i]; j++){
				blockSizeList.add(blockSize[i]);
			}
		}
		
		Random rand = new Random();
		rand.setSeed(seed);
		for(int i = 0; i < blockSizeList.size(); i++){
			double a = rand.nextDouble();
			blockSizeInfo.add(new BlockSizeInfo(i, a, null, -1));
		}
		
		Collections.sort(blockSizeInfo, BlockSizeInfo.randNumComparator);
		for(int i = 0; i < blockSizeList.size(); i++){
			blockSizeInfo.get(i).setBlock(blockSizeList.get(i));

			int index = -1;
			for(int j = 0; j < blockSize.length; j++){
				System.err.println(blockSizeInfo.get(i).getBlock());
				if(blockSize[j].equals(blockSizeInfo.get(i).getBlock())){
					index = j;
					break;
				}
			}
			blockSizeInfo.get(i).setIndex(index);
		}
		Collections.sort(blockSizeInfo, BlockSizeInfo.noComparator);
		 
		return blockSizeInfo;
	}
	
	private List<List<BlockInfo>> getBlockSort(List<String[]> list, int seed){
		List<List<BlockInfo>> blockInfo = new ArrayList<List<BlockInfo>>();
		List<List<String>> blockList = new ArrayList<List<String>>();
		
		for(String[] str : list){
			blockList.add(combine(str, seed));
		}
		
		Random rand = new Random();
		for(List<String> strList : blockList){
			List<BlockInfo> block = new ArrayList<BlockInfo>();
			rand.setSeed(seed);
			for(int i = 0; i < strList.size(); i++){
				double d = rand.nextDouble();
				block.add(new BlockInfo(i, d, -1, null));
			}
			blockInfo.add(block);
		}

		for(int i = 0; i < blockInfo.size(); i++){
			Collections.sort(blockInfo.get(i), BlockInfo.randNumComparator);
			for(int j = 0; j < blockInfo.get(i).size(); j++){
				blockInfo.get(i).get(j).setBlockNo(j);
				blockInfo.get(i).get(j).setBlock(blockList.get(i).get(j));
			}
			Collections.sort(blockInfo.get(i), BlockInfo.noComparator);
		}
		
		return blockInfo;
	}
}
