package com.kook.spjpj.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kook.spjpj.command.BContentCommand;
import com.kook.spjpj.command.BDeleteCommand;
import com.kook.spjpj.command.BListCommand;
import com.kook.spjpj.command.BPageListCommand;
import com.kook.spjpj.command.BModifyCommand;
import com.kook.spjpj.command.BWriteCommand;
import com.kook.spjpj.command.ICommand;
import com.kook.spjpj.command.JoinCommand;
import com.kook.spjpj.command.RecordCommand;
import com.kook.spjpj.command.WageBillCommand;
import com.kook.spjpj.dao.Dao;
import com.kook.spjpj.naver.NaverLoginBO;
import com.kook.spjpj.util.Constant;


@Controller
public class SPJController {

//	bean ???????? Constant?? ????
	private Dao dao;

	@Autowired
	public void setDao(Dao dao) {
		this.dao = dao;
		Constant.dao = dao;
	}

	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
		Constant.passwordEncoder = passwordEncoder;
	}
	
	
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	private ICommand com; // command?? ?????????? ?????? ???????? ???????? ???? ???? ?????? ?????? ???? ????

	
	
	
	// NaverLoginBO
	private NaverLoginBO naverLoginBO;
	@Autowired 
	private void setNaverLoginBO (NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	

// ===== ???????? ?????? ?????? ?????? command?? ?????? ???? 
	@RequestMapping(value = "/join", produces = "application/text; charset=UTF8")
	@ResponseBody // jsp?? ???? ?????????? ?????? ?????? ?????? ????, ????: https://memostack.tistory.com/243
	public String join(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("join"); // console?? ?????? ???????? ?????? ????

		com = new JoinCommand(); // join?????? ???? command???????? MiniCommand?????????? ???? ??????
		com.execute(model, request);
		String result = (String) request.getAttribute("result"); // JoinCommand???? ?????? ???????? String result?? ????
		System.out.println(result); // console?? ?????? ???????? ?????? ????
		if (result.equals("success"))
			return "join-success";
		else
			return "join-failed";
	}

	
//	===== ?????? ???? =====
	@RequestMapping("/spj_login")
	public String spj_login(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {
		System.out.println("login");
		//social login url?????? ?????? ????
		socialUrl(model, session);
		return "spj_login";
	}

	@RequestMapping(value = "/processLogin", method = RequestMethod.GET)
	public ModelAndView processLogin(
			@RequestParam(value = "log", required = false) String log,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			HttpSession session, Model pmodel
			) {
		System.out.println("processLogin");
		ModelAndView model = new ModelAndView();	
		
		if(log != null && log !="")  { // security form?? ???? ??(a href="processLogin?log=1)???? ?????? ?? ??????
		model.addObject("log", "before login!");
		}
		if (error != null && error != "") { //???????? ???????????? security???? ????(???? 1)
			model.addObject("error", "Invalid username or password!");
		} 
		if (logout != null && logout != "") { //???????? ?????? security???? ????(???? 1)
			model.addObject("logout", "You've been logged out successfully.");
		}
		socialUrl(pmodel, session);
		model.setViewName("spj_login");	
		return model;
	}
	
	@RequestMapping("/Login")
	public String Login(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session){
		System.out.println("Login");
		socialUrl(model, session);
		return "spj_login";
	}	
	
	//https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=sonmit002&logNo=221344583488
		@RequestMapping(value="/redirect",produces = "application/text; charset=UTF8")
		//???????? ???????? ????
		public String googleCallback(Model model,@RequestParam String code,
				HttpServletResponse response) throws IOException {
			System.out.println("?????? googleCallback");
			OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
			AccessGrant accessGrant =   //access token????????
			oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
			String accessToken = accessGrant.getAccessToken();
			getGoogleUserInfo(accessToken,response);
			return "spj_socialLogin";
		}
		
		@RequestMapping(value="/kredirect",produces = "application/json; charset=UTF8")
		public String kredirect(@RequestParam String code, HttpServletResponse response, 
				Model model) throws Exception {
			System.out.println("#########" + code);
			String access_Token = getKakaoAccessToken(code,response);
			System.out.println("###access_Token#### : " + access_Token);
			//?? access_Token?? ???????? kakao?? ?????? ?????? ??????
			HashMap<String, Object> userInfo = getKakaoUserInfo(access_Token);
			return "spj_socialLogin";
		}
		
		@RequestMapping("/nredirect")
		public ModelAndView callback(@RequestParam String code, @RequestParam String state,
				HttpSession session) throws Exception {
			System.out.println("state: " +state);
			OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
			String apiResult = naverLoginBO.getUserProfile(oauthToken);
			System.out.println(apiResult);
			// String ?????? apiResult?? json ?????? ????
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			JSONObject response_obj = (JSONObject)jsonObj.get("response");
			System.out.println("naver user ????:"  + response_obj);
			// response?? nickname?? ????
			String name = (String)response_obj.get("name");
			System.out.println("name:" +name);
			return new ModelAndView("spj_socialLogin", "result", apiResult);
			// addObject?? setViewName?? ?????? ???????? ???????? ?????? ???? ?????? ?????????? view jsp ????,
			// ???????? ??????, ???????? ??????
		}
		
		//social??????
		public void socialUrl(Model model, HttpSession session) {
			/* ????code ???? */
			OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
			//OAuth2?? ?????????? ????
			String url = 
			oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
			//GrantType?? Oauth2???? ???? AUTHORIZATION_CODE?? ?????????? ????,googleOAuth2Parameters??
			//???? ?????? scope?? redirect?????? ???? ????
			System.out.println("????:" + url);
			//model?? ???????? ???? login_view.jsp?? ???????? ??
			model.addAttribute("google_url", url);	
			
			
			/*kakao code  kakao developer???????? ???? ????*/
			//kakao https://tyrannocoding.tistory.com/61
			String kakao_url  = 
					"https://kauth.kakao.com/oauth/authorize"
					+ "?client_id=9f317d9f39587377b26054a0d805ba58"
					+ "&redirect_uri=https://localhost:8443/spjpj/kredirect"
					+ "&response_type=code";
			model.addAttribute("kakao_url", kakao_url );
			
			// naver social login ????
			// ?????????????? ???? URL?? ???????? ?????? NaverLoginBO???????? getAuthorizationUrl?????? ????
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			System.out.println("??????" +naverAuthUrl);
			model.addAttribute("naver_url", naverAuthUrl);	
		}
		
		//?????????????? ???? ??????
		public void getGoogleUserInfo(String access_Token,HttpServletResponse response) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8"); 
			HashMap<String,Object> googleUserInfo = new HashMap<String,Object>();
			//1.7???????? ?????????? ???? ?????? change ???? Facet???? java 1.7?? ????
			//???? ?????????? ?????? ????
			String reqURL = "https://www.googleapis.com/userinfo/v2/me?access_token="+access_Token;
			try {
				URL url = new URL(reqURL); 
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestProperty("Authorization", "Bearer " + access_Token);
				int responseCode = conn.getResponseCode(); 
				System.out.println("responseCode : "+responseCode);
				if(responseCode == 200) { //200?? ???? ????
					BufferedReader br = 
						new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8")); 
					String line = ""; 
					String result = "";
					while ((line = br.readLine()) != null) {
						result += line;
					}
					JSONParser parser = new JSONParser(); //???????? json?????????? ????
					Object obj = parser.parse(result);
					JSONObject jsonObj = (JSONObject) obj;
					String name_obj = (String)jsonObj.get("name");
					String email_obj = (String)jsonObj.get("email");
					String id_obj = "GOOGLE_" + (String)jsonObj.get("id");
					
					googleUserInfo.put("name", name_obj); 
					googleUserInfo.put("email", email_obj); 
					googleUserInfo.put("id", id_obj);
					
					System.out.println("googleUserInfo : " + googleUserInfo);	
					
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		//kakao access-token ??????
		public String getKakaoAccessToken (String authorize_code,HttpServletResponse response) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8"); 
			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";
			try {
				URL url = new URL(reqURL);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				// URL?????? ???????? ???? ?? ?? ????, POST ???? PUT ?????? ?????? setDoOutput?? true?? ??????????.
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);
				//kakao?? ?????????? ??
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				sb.append("grant_type=authorization_code");
				sb.append("&client_id=9f317d9f39587377b26054a0d805ba58");  //?????? ???????? key
				sb.append("&redirect_uri=https://localhost:8443/spjpj/kredirect");
				// ?????? ?????? ???? ????
				sb.append("&code=" + authorize_code);
				bw.write(sb.toString());
				bw.flush();
				//???? ?????? 200?????? ????
				int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);
	            // ?????? ???? ???? JSON?????? Response ?????? ????????
	            BufferedReader br = 
	            	new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8")); 
	            String line = "";
	            String result = "";
	            while ((line = br.readLine()) != null) {
	            	result += line;
	            }
	            System.out.println("response body : " + result);
	            JSONParser parser = new JSONParser();
	            Object obj = parser.parse(result); //parse???????? Object????
	            JSONObject jsonObj = (JSONObject) obj;
	            access_Token = (String)jsonObj.get("access_token");
				refresh_Token = (String)jsonObj.get("refresh_token");
				System.out.println("access_token : " + access_Token);
		        System.out.println("refresh_token : " + refresh_Token);
		        //io?????? close
		        br.close();
	            bw.close();
			}
			catch(Exception e) {
				e.getMessage();
			}
			return access_Token;
		}
		
		//kakao access-token ???? ?????? ???? ????
		public HashMap<String,Object> getKakaoUserInfo (String access_Token) {
			HashMap<String, Object> userInfo = new HashMap<String, Object>();
			String reqURL = "https://kapi.kakao.com/v2/user/me";
			try {
				URL url = new URL(reqURL);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				//?????? ?????? Header?? ?????? ????
				conn.setRequestProperty("Authorization", "Bearer " + access_Token);
				int responseCode = conn.getResponseCode(); //200???? ????
				System.out.println("responseCode : " + responseCode);
				BufferedReader br = 
						new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
				String line = "";
		        String result = "";
		        while ((line = br.readLine()) != null) {
	                result += line;
	            }
		        System.out.println("response body : " + result);
		        
		        JSONParser parser = new JSONParser();
		        Object obj = parser.parse(result);
		        JSONObject jsonObj = (JSONObject) obj;	       
		        JSONObject properties = (JSONObject) jsonObj.get("properties");
		        JSONObject kakao_account = (JSONObject) jsonObj.get("kakao_account"); //???????? ????
		       
		        String accessToken = (String)properties.get("access_token");
		        String nickname = (String)properties.get("nickname");
		        String email = (String)kakao_account.get("email"); //???????? ????
		        userInfo.put("accessToken", access_Token);
	            userInfo.put("nickname", nickname);
	            userInfo.put("email", email);
	            System.out.println("=============");
	            System.out.println("nickname  " + nickname);
	            System.out.println("email  " + email);
	            System.out.println("=============");
			}
			catch(Exception e) {
				e.getMessage();
			}
			return userInfo;
		}
		
	@RequestMapping("/main") 
	public String main(HttpServletRequest request,HttpServletResponse response,
			Model model,Authentication authentication) {
		System.out.println("main");
		
		// ?????? ?????? ???????????? id?? role?????? ???????? ????
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		Constant.username = userDetails.getUsername();
		System.out.println(userDetails.getUsername());//hsk5410@naver.com (???????? ??????)
		Collection<? extends GrantedAuthority>  authorities = authentication.getAuthorities();
		String auth = authorities.toString(); //role?? ?????? ???????? ????
		System.out.println(auth); //[ROLE_USER]????
		return "spj_main";
	}
	
//	======= ?????????? ???? ======	
	@RequestMapping("/spj_boardList")
	public String spj_boardList(HttpServletRequest request,HttpServletResponse response,Model model) {
		System.out.println("/spj_boardList");	
		com = new BListCommand();
		com.execute(model, request);
		return "spj_boardList";
	}
	
	@RequestMapping("/spj_boardWrite")  //ajax?? ?????? @ResponseBody?????? jsp????
	public String spj_boardWrite(Model model) {
		System.out.println("spj_boardWrite()");
		model.addAttribute("user",Constant.username);	
		return "spj_boardWrite";
	}
	
	@RequestMapping("/write")
	public String write(HttpServletRequest request,HttpServletResponse response,Model model) {
		System.out.println("write");
		com = new BWriteCommand();
		com.execute(model, request);
		return "redirect:spj_boardList";
	}
	
	//?????? ????
	@RequestMapping("/spj_boardView")
	public String content_view(HttpServletRequest request, HttpServletResponse response, Model model) {
		com = new BContentCommand();
		com.execute(model, request);
		model.addAttribute("user",Constant.username);
		if(model.containsAttribute("content_view")) {
			String result = "success";
			System.out.println(result);
		}
		return "spj_boardView"; 
	}
	
	//?????? ????
	@RequestMapping("/spj_boardModify")
	public String modify_view(HttpServletRequest request, HttpServletResponse response, Model model) {
		com = new BContentCommand();
		com.execute(model, request);
		model.addAttribute("user",Constant.username);
		if(model.containsAttribute("content_view")) {
			String result = "success";
			System.out.println(result);
		}
		return "spj_boardModify"; 
	}
	
	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("modify()");
		com = new BModifyCommand();
		com.execute(model,request);
		return "redirect:spj_boardList";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request,HttpServletResponse response,Model model) {
		System.out.println("delete()");
		com = new BDeleteCommand();
		com.execute(model, request);
		
		return "redirect:spj_boardList";
	}
	
	@RequestMapping("/plist")
	public String plist(HttpServletRequest request,HttpServletResponse response,Model model) {
		System.out.println("plist");
		System.out.println(request.getParameter("pageNo"));
		com = new BPageListCommand();
		com.execute(model, request);
		return "plist";
	}
	
//	======== record ===========
	@RequestMapping("/record")
	public String record(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("record");
		com = new RecordCommand();
		com.execute(model, request);
		String user = request.getParameter("ruser");
		model.addAttribute("user", user);
		return "redirect:spj_wageBill"; 
	}
	
	@RequestMapping("/spj_wageBill")
	public String spj_wageBill(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("spj_wageBill");
		model.addAttribute("user", Constant.username);
		com = new WageBillCommand();
		com.execute(model, request);
		return "spj_wageBill";
	}
	
	@RequestMapping("/myWageBill")
	public String myWageBill(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("myWageBill");
		model.addAttribute("user", Constant.username);
		com = new WageBillCommand();
		com.execute(model, request);

		String id = request.getParameter("rid");			
		return "redirect:spj_wageBill"; 
	}
	
	
//	========== menu ================
//	===== main ???? =====
	@RequestMapping("/spj_main")
	public String spj_main() {
		return "spj_main";
	}	
	
//	===== about ???? =====
	@RequestMapping("/spj_about")
	public String spj_about() {
		return "spj_about";
	}	
		
//  ========= ???? ???? ???? ========
	@RequestMapping("/spj_record")
	public String spj_record(Model model) {
		System.out.println("spj_record()");
		model.addAttribute("user", Constant.username);
		return "spj_record";
	}

	// ===== ???????? ???? =====
	@RequestMapping("/spj_join")
	public String spj_join() {
		return "spj_join";
	}
}
