package com.me.EMR.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.captcha.botdetect.web.servlet.Captcha;
import com.me.EMR.dao.UserDAO;
import com.me.EMR.pojo.User;
import com.me.EMR.pojo.Doctor;
import com.me.EMR.pojo.Patient;

/**
 * Handles requests for the application home page.
 */
@Controller
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/user/login.htm", method = RequestMethod.GET)
	public String showLoginForm() {

		return "user-login";
	}

	@RequestMapping(value = "/user/login.htm", method = RequestMethod.POST)
	public String handleLoginForm(HttpServletRequest request, UserDAO userDao, ModelMap map) {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			User u = userDao.get(username, password);

			if (u != null && u.getStatus() == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("user", u);
				session.setMaxInactiveInterval(120*60);
				 

				if (u instanceof Patient) {
					return "redirect:/patient/dashboard.htm";
				} else if (u instanceof Doctor) {
					return "redirect:/doctor/dashboard.htm";
				}
			} else if (u != null && u.getStatus() == 0) {
				map.addAttribute("errorMessage", "Please activate your account to login!");
				return "error";
			} else {
				map.addAttribute("errorMessage", "Invalid username/password!");
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/patient/dashboard.htm", method = RequestMethod.GET)
	public String handlePatientDashboard(HttpServletRequest request, UserDAO userDao, ModelMap map) {
		return "patient-dashboard";

	}

	@RequestMapping(value = "/doctor/dashboard.htm", method = RequestMethod.GET)
	public String handleDoctorDashboard(HttpServletRequest request, UserDAO userDao, ModelMap map) {
		return "doctor-dashboard";
	}

	@RequestMapping(value = "/user/register.htm", method = RequestMethod.GET)
	public String showCreateForm() {

		return "user-register-form";
	}

	@RequestMapping(value = "/user/register.htm", method = RequestMethod.POST)
	public String handleCreateForm(HttpServletRequest request, UserDAO userDao, ModelMap map) throws Exception {
		Captcha captcha = Captcha.load(request, "CaptchaObject");
		String captchaCode = request.getParameter("captchaCode");
		if (captcha.validate(captchaCode)) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			HttpSession session = request.getSession();

			String role = request.getParameter("role");
			User user = new User();
			if (role.equals("patient")) {
				user = new Patient();
			} else if (role.equals("doctor")) {
				user = new Doctor();
			}
			user.setUsername(username);
			user.setPassword(password);
			user.setStatus(1);

			try {
				User u = userDao.register(user);
				Random rand = new Random();
				int randomNum1 = rand.nextInt(5000000);
				int randomNum2 = rand.nextInt(5000000);

				try {
					String str = "http://localhost:8080/EMR/user/validateemail.htm?username=" + username + "&key1="
							+ randomNum1 + "&key2=" + randomNum2;
					session.setAttribute("key1", randomNum1);
					session.setAttribute("key2", randomNum2);
					sendEmail(username, "Click on this link to activate your account : " + str);
				} catch (Exception e) {
					System.out.println("Email cannot be sent");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			map.addAttribute("errorMessage", "Invalid Captcha!");
			return "user-create-form";
		}
		return "user-created";
	}

	public void sendEmail(String useremail, String message) {
		try {
			Email email = new SimpleEmail();
			email.setHostName("smtp.googlemail.com");
			email.setSmtpPort(465);
			email.setAuthenticator(new DefaultAuthenticator("contactapplication2018@gmail.com", "springmvc"));
			email.setSSLOnConnect(true);
			email.setFrom("no-reply@msis.neu.edu"); // This user email does not
													// exist
			email.setSubject("Web tools lab ");
			email.setMsg(message); // Retrieve email from the DAO and send this
			email.addTo(useremail);
			email.send();
		} catch (EmailException e) {
			System.out.println("Email cannot be sent");
		}
	}

	@RequestMapping(value = "user/validateemail.htm", method = RequestMethod.GET)
	public String validateEmail(HttpServletRequest request, UserDAO userDao, ModelMap map) {

		// The user will be sent the following link when the use registers
		// This is the format of the email
		// http://hostname:8080/lab10/user/validateemail.htm?email=useremail&key1=<random_number>&key2=<body
		// of the email that when user registers>
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		int key1 = Integer.parseInt(request.getParameter("key1"));
		int key2 = Integer.parseInt(request.getParameter("key2"));
		System.out.println(session.getAttribute("key1"));
		System.out.println(session.getAttribute("key2"));

		if ((Integer) (session.getAttribute("key1")) == key1 && ((Integer) session.getAttribute("key2")) == key2) {
			try {
				System.out.println("HI________");
				boolean updateStatus = userDao.updateUser(username);
				if (updateStatus) {
					return "user-login";
				} else {

					return "error";
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			map.addAttribute("errorMessage", "Link expired , generate new link");
			map.addAttribute("resendLink", true);
			return "error";
		}

		return "user-login";

	}

	@RequestMapping(value = "/user/forgotpassword.htm", method = RequestMethod.POST)
	public String handleForgotPasswordForm(HttpServletRequest request, UserDAO userDao) {

		String username = request.getParameter("username");
		Captcha captcha = Captcha.load(request, "CaptchaObject");
		String captchaCode = request.getParameter("captchaCode");

		if (captcha.validate(captchaCode)) {
			User user = userDao.get(username);
			sendEmail(username, "Your password is : " + user.getPassword());
			return "forgot-password-success";
		} else {
			request.setAttribute("captchamsg", "Captcha not valid");
			return "forgot-password";
		}
	}

	@RequestMapping(value = "/user/forgotpassword.htm", method = RequestMethod.GET)
	public String getForgotPasswordForm(HttpServletRequest request) {

		return "forgot-password";
	}
}
