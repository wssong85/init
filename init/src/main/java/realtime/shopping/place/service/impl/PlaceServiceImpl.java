package realtime.shopping.place.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import realtime.shopping.place.mapper.PlaceMapper;
import realtime.shopping.place.service.PlaceService;

@Service("PlaceService")
public class PlaceServiceImpl implements PlaceService{
	
	@Resource(name = "PlaceMapper")
	private PlaceMapper placeMapper;

	@Override
	public List<Map<String, Object>> selectTbTrail(Map<String, Object> map) {
		List<Map<String, Object>> list = placeMapper.selectTbTrail(map);
		
		String strTmp = "";
		String[] arrTmp = null;
		Map<String, Object> mapTmp = null;
		
		for(Map<String, Object> iMap : list) {
			
			strTmp = EgovStringUtil.isNullToString(iMap.get("TRAIL_COORDINATE"));
			arrTmp = strTmp.split(",");
			
			mapTmp = new HashMap<String, Object>();
			
			mapTmp.put("x", arrTmp[1]);
			mapTmp.put("y", arrTmp[0]);
			
			iMap.put("point", mapTmp);
			
		}
		
		return list;
	}

	
}
