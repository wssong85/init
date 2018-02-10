package realtime.shopping.place.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.shopping.place.mapper.PlaceMapper;
import realtime.shopping.place.service.PlaceService;

@Service("PlaceService")
public class PlaceServiceImpl implements PlaceService{
	
	@Resource(name = "PlaceMapper")
	private PlaceMapper placeMapper;

	@Override
	public List<Map<String, Object>> selectTbTrail(Map<String, Object> map) {
		return placeMapper.selectTbTrail(map);
	}

	
}
