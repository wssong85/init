package realtime.shopping.place.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import realtime.shopping.place.service.PlaceService;
import realtime.shopping.user.service.UserService;

@Controller
public class PlaceController {
	
	@Resource(name = "PlaceService")
	private PlaceService placeService;

	
}
