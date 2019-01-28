package com.me.EMR.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.me.EMR.dao.AppointmentDAO;
import com.me.EMR.dao.RecipeDAO;
import com.me.EMR.dao.UserDAO;
import com.me.EMR.pojo.Appointment;
import com.me.EMR.pojo.Doctor;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.Prescription;
import com.me.EMR.pojo.Recipe;

@Controller
public class PatientManageController {

	@RequestMapping(value="/patientManage/detail.htm", method = RequestMethod.GET)
	public String handlePatientList(HttpServletRequest request, AppointmentDAO appointmentDao,ModelMap map,UserDAO userDao) {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		Doctor currentUser = (Doctor)session.getAttribute("user");
		if(action.equals("view")) {
			int receiverid = currentUser.getAccountid();
			List<Appointment> appointmentList = appointmentDao.getByReceiverId(receiverid);
			map.addAttribute("appointmentList", appointmentList);
			map.addAttribute("doctorName",currentUser.getName());
			return "allPatients-list";
		}else if(action.equals("recipe")) {
			String appointmentid = request.getParameter("appointmentid");
			Appointment appointment = appointmentDao.getById(appointmentid);
			if(appointment.getSender() instanceof Doctor) {
				map.addAttribute("patientName",((Patient)appointment.getReceiver()).getName());
			}else {
				map.addAttribute("patientName",((Patient)appointment.getSender()).getName());
			}
			map.addAttribute("appointmentid",appointmentid);
			map.addAttribute("doctorName",currentUser.getName());
			return "recipe-edit";
		}else if(action.equals("history")) {
			return "recipe-history";
		}else if(action.equals("addPrescription")) {
			System.out.println("inter controller");
			return "recipe-edit";
		}
		return null;
	}
	
	@RequestMapping(value="/patientManage/detail.htm", method = RequestMethod.POST)
	public String handlePatientOperation(HttpServletRequest request, AppointmentDAO appointmentDao,ModelMap map,UserDAO userdao, RecipeDAO recipeDao) throws Exception {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		String appointmentid = request.getParameter("appointmentid");
		Appointment appointment = appointmentDao.getById(appointmentid);
		String patientName = request.getParameter("patientName");
		Doctor currentUser = (Doctor)session.getAttribute("user");
		Patient patient = userdao.getByName(patientName);
		if(action.equals("recipe")) {
			String testName = request.getParameter("testName");
			String testResult = request.getParameter("testResult");
			
			String[] medicineNameList = request.getParameterValues("medicineName");
			String[] quantityList = request.getParameterValues("quantity");
			String[] instructionList = request.getParameterValues("instructions");
			List<Prescription> prescriptionList = new ArrayList<Prescription>();
			Recipe recipe = new Recipe();
			recipe.setDoctor(currentUser);
			recipe.setPatient(patient);
			recipe.setTestName(testName);
			recipe.setTestResult(testResult);
			recipeDao.create(recipe);
			
			for(int i = 0;i<medicineNameList.length;i++) {
				Prescription prescription = new Prescription();
				prescription.setMedicineName(medicineNameList[i]);
				prescription.setQuantity(quantityList[i]);
				prescription.setInstructions(instructionList[i]);
				prescription.setDoctor(currentUser);
				prescription.setDate(new Date());
				
				if (prescription.getRecipe() == null) {
					prescription.setRecipe(recipe);
				}
				recipeDao.createPrescription(prescription);
				prescriptionList.add(prescription);
			}
			
			recipe.setPrescriptionList(prescriptionList);
			recipeDao.update(recipe);
			appointmentDao.finishRecipe(appointmentid, "finishRecipe");
			
			String text = "You have successfully finished " + patient.getName() + "'s recipe";
			map.addAttribute("content", text);
			return "success";
		}else if(action.equals("history")) {
			return "recipe-history";
		}
		return null;
		
	}
}
