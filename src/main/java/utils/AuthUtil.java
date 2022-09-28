package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthUtil {
	public static boolean CheckLogin(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") == null) {
			return false;
		}
		return true;
	}
	
	public static boolean CheckLoginAdmin(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("userAdmin") == null) {
			return false;
		}
		return true;
	}
}
