package pantheon.edc.b01.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/edc/b01")
public class EDCB01Controller {
	
	@RequestMapping("/EDCB0101.do")
	public String EDCB0101(ModelMap model, HttpServletRequest request, Map<String, Object> searchMap) throws Exception {
		return "/pantheon/edc/b01/EDCB0101";
	}

}
