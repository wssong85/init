package realtime.shopping.place.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import realtime.shopping.place.service.PlaceService;

@Controller
public class PlaceController {
	
	@Resource(name = "PlaceService")
	private PlaceService placeService;
	
	/**
	 * 지하철 검색
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/shopping/zone/apiSelectTbTrail.do")
	@ResponseBody 
	public Map<String , Object> apiSelectTbTrail(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();

		System.out.println(map);
		
		//map.put("TRAIL_NAME", "%" + map.get("TRAIL_NAME") + "%");
		
		try {
			
			List<Map<String, Object>> list = placeService.apiSelectTbTrail(map);
			
			result.put("success", true);
			result.put("result", list);
			
		} catch (Exception e) {
			
//			System.out.println(e.getLocalizedMessage());
			
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());
		}
		
		return result;
	}
	
	/**
	 * 장소 검색
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/shopping/zone/apiSelectNaverPlace.do")
	@ResponseBody
	public Map<String, Object> apiSelectNaverPlace(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
        String clientId = "Y2zRrfIDJgzcfMQSM2zN";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "Tww_1SdVAG";//애플리케이션 클라이언트 시크릿값";
        
        try {
            String addr = URLEncoder.encode(EgovStringUtil.isNullToString(map.get("TRAIL_NAME")), "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; //json
//            search/**
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            
			result.put("success", true);
			result.put("result", response.toString());
            
        } catch (Exception e) {
//            System.out.println(e);
			result.put("success", false);
			result.put("message", e.getLocalizedMessage());

        }
        
        return result;
		
	}
	
}
