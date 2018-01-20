package realtime.shopping.place.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.shopping.place.mapper.PlaceMapper;
import realtime.shopping.place.service.PlaceService;

@Service("PlaceService")
public class PlaceServiceImpl implements PlaceService{
	
	@Resource(name = "PlaceMapper")
	private PlaceMapper placeMapper;

	
}
