package realtime.shopping.place.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("PlaceMapper")
public interface PlaceMapper {

	List<Map<String, Object>> selectTbTrail(Map<String, Object> map);

}
