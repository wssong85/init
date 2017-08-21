package realtime.com.file.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import realtime.com.file.service.FileManageService;

@Controller
public class FileManageController {
	
	@Resource(name ="FileManageService")
	private FileManageService fileManageService;
	
}
