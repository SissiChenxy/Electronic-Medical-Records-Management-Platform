package com.me.EMR.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.me.EMR.dao.AppointmentDAO;
import com.me.EMR.dao.UserDAO;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.User;

@Controller
public class AjaxController {

	@RequestMapping(value = "/checkUserExistence.htm", method = RequestMethod.POST)
	@ResponseBody
	public String checkUserNameExisted(HttpServletRequest request, UserDAO userDao) {
		String username = request.getParameter("username");
		User existUser = userDao.get(username);
		if (existUser == null) {
			return "You can use this username!";
		} else {
			return "UserName Has Already Been Used!";
		}
	}

	@RequestMapping(value = "/patientManage/list.htm", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String handlePatientList(HttpServletRequest request, AppointmentDAO appointmentDao)
			throws JsonGenerationException, JsonMappingException, IOException {

		HttpSession session = request.getSession();
		System.out.println("here");
		User currentUser = (User) session.getAttribute("user");
		int receiverid = currentUser.getAccountid();
		List<Patient> patientList = appointmentDao.getPatients(receiverid);
		ObjectMapper mapper = new ObjectMapper();
		String jsonPatientList = mapper.writeValueAsString(patientList);
		return jsonPatientList;
	}

	ArrayList<String> medicineList;
	public AjaxController() {
		medicineList = new ArrayList<String>();
		medicineList.add("naproxen 500 MG tablet");
		medicineList.add("budesonide 32 mcg/actuation nasal spray");
		medicineList.add("flunisolide 25 mcg (0.025 %) Spry");
		medicineList.add("Cloud computing");
		medicineList.add("Data Science");
	}

	@RequestMapping(value = "/prescription/medicineAdd.htm", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxService(HttpServletRequest request) {
		String queryString = request.getParameter("medicineName");
		String result = "";
		for (int i = 0; i < medicineList.size(); i++) {
			if (medicineList.get(i).toLowerCase().contains(queryString.toLowerCase())) {
				result += medicineList.get(i) + ",";
			}
		}
		return result;
	}
}
