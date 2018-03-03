package realtime.com.file.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("FileManageMapper")
public interface FileManageMapper {

	void insertTbFileMaster(Map<String, String> map);
	
	void insertTbFileDetail(Map<String, String> map);
	
}
