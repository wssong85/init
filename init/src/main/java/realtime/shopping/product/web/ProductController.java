package realtime.shopping.product.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {
	
	@RequestMapping("/product/selectDetail.do")
	public Map<String, Object> selectDetail(@RequestParam Map<String, Object> param) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		return map;
	}

}
