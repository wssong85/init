package realtime.com.login.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("LoginMapper")
public interface LoginMapper {

	Map<String, Object> selectTbUsersByPk(Map<String, Object> map) throws Exception;
	
}
