package realtime.com.file.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("FileManageMapper")
public interface FileManageMapper {

	void insertTbFileMaster(Map<String, String> map);
	
	void insertTbFileDetail(Map<String, String> map);

	void deleteTbFileDetail(Map<String, String> iMap);
	
	int selectTbFileMasterCount(Map<String, String> map);
	
	void deleteTbFileMaster(Map<String, String> map);

	Map<String, String> selectTbFileDetail(Map<String, String> map);
	
}
