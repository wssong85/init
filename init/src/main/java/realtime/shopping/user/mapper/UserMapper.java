package realtime.shopping.user.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserMapper")
public interface UserMapper {
	int selectTbUserCountForCheck(Map<String, Object> map);
	int selectTbUserCountForCheck2(Map<String, Object> map);
	Map<String, Object> selectTbUserByPK(Map<String, Object> map);
}
