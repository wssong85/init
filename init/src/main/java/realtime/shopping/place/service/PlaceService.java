package realtime.shopping.place.service;

import java.util.List;
import java.util.Map;

public interface PlaceService {

	List<Map<String, Object>> selectTbTrail(Map<String, Object> map) throws Exception;

}