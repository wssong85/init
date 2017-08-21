package realtime.com.file.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import realtime.com.file.mapper.FileManageMapper;
import realtime.com.file.service.FileManageService;

@Service("FileManageService")
public class FileManageServiceImpl implements FileManageService{

	@Resource(name = "FileManageMapper")
	private FileManageMapper fileManageMapper;
	
}
