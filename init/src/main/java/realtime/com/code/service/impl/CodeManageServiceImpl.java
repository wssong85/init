package realtime.com.code.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.code.mapper.CodeManageMapper;
import realtime.com.code.service.CodeManageService;

@Service("CodeManageService")
public class CodeManageServiceImpl implements CodeManageService{

	@Resource(name = "CodeManageMapper")
	private CodeManageMapper codeManageMapper;
	
	@Override
	public List<Map<String, Object>> selectTbGroupCodeList(Map<String, Object> map) throws Exception{
		return codeManageMapper.selectTbGroupCodeList(map);
	}

	@Override
	public void multiTbGroupCode(List<Map<String, Object>> list) throws Exception{
		
		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.insertTbGroupCode(iMap);
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.updateTbGroupCode(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.deleteTbGroupCode(iMap);
				
			}
			
		}
		
	}

	@Override
	public List<Map<String, Object>> selectTbDetailCodeList( Map<String, Object> map) throws Exception {
		return codeManageMapper.selectTbDetailCodeList(map);
	}

	@Override
	public void multiTbDetailCode(List<Map<String, Object>> list) throws Exception {

		for(Map<String, Object> iMap : list) {
			
			if("C".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.insertTbDetailCode(iMap);;
				
			} else if("U".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.updateTbDetailCode(iMap);
				
			} else if("D".equals(iMap.get("CRUD"))) {
				
				codeManageMapper.deleteTbDetailCode(iMap);
				
			}
			
		}
		
	}
	
}

