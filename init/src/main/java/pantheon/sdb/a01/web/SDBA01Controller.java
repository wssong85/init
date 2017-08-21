package pantheon.sdb.a01.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SDBA01Controller {		
	
	@RequestMapping(value="/sdb/a01/SDBA0101.do")
	public String sdba0101(HttpServletRequest request, HttpServletResponse response) {
		return "/pantheon/sdb/a01/SDBA0101";	 	
	} 
}
 