package realtime.shopping.hashtag.service;

import java.util.List;
import java.util.Map;

public interface HashtagService {

	Map<String, Object> apiSelectTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	void apiInsertTbIfHashtagInterest(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> apiSelecBuyTbProductList(Map<String, Object> map) throws Exception;
	
	String apiRequestReverseGeocoding(String query) throws Exception;
}
