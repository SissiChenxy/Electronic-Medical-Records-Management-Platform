package com.me.EMR.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.me.EMR.dao.UserDAO;
import com.me.EMR.pojo.Doctor;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.User;

@Controller
public class AccountController {

	@RequestMapping(value="/AccountInfo/detail.htm", method = RequestMethod.GET)
	public String showAccountInfo(HttpServletRequest request, ModelMap map) {
		HttpSession session = request.getSession();
		User currentUser = (User)session.getAttribute("user");
		// prepare for showing different info in jsp page
		if(currentUser instanceof Patient) {
			Patient patient = (Patient) currentUser;
			map.addAttribute("patient", patient);
		}
		else if(currentUser instanceof Doctor) {
			Doctor doctor = (Doctor) currentUser;
			map.addAttribute("doctor", doctor);
		}
		
		return "accountInfo";
	}
	
	@RequestMapping(value="/AccountInfo/detail.htm", method = RequestMethod.POST)
	public String SaveAccountChange(HttpServletRequest request, UserDAO userDao, ModelMap map) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User)session.getAttribute("user");
		String action = request.getParameter("action");
		int accountid = currentUser.getAccountid();
		
		if(action == "modify-basic") {
			// modify basic info
			String name = request.getParameter("name");
			String age = request.getParameter("age");
			String phone = request.getParameter("phone");
			
			if(currentUser instanceof Patient) {
				String streetAddress = request.getParameter("streetAddress");
				String city = request.getParameter("city");
				String state = request.getParameter("state");
				String zipCode = request.getParameter("zipCode");
				userDao.updatePatient(accountid+"", name, age, phone, streetAddress, city, state, zipCode);
			}
			else if(currentUser instanceof Doctor) {
				String department = request.getParameter("department");
				userDao.updateDoctor(accountid+"", name, age, phone, department);
			}
			// tell jsp page to display basic info changing successfully.
			map.addAttribute("status", "changeBasic");
		}
		
		else if(action=="modify-password") {
			// modify password
			String oldPw = request.getParameter("oldPw");
			String newPw = request.getParameter("newPw");
			if(currentUser.getPassword().equals(oldPw)) {
				userDao.updateUserPw(accountid+"", newPw);
				map.addAttribute("status", "changePwSuccess");
			}
			else
				map.addAttribute("status", "changePwFail");
		}
		return "accountInfo-result";
	}
}
