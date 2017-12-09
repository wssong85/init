package realtime.shopping.user.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserMapper")
public interface UserMapper {
	int selectTbUserCountForCheck(Map<String, Object> map);
}
