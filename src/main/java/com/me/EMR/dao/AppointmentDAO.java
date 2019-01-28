package com.me.EMR.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import com.me.EMR.pojo.Appointment;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.User;

public class AppointmentDAO extends DAO {
	public Appointment getById(String appointmentid) {
		try {
			begin();
			Query q = getSession().createQuery("from Appointment where appointmentid = :appointmentid");
			q.setString("appointmentid", appointmentid);
			Appointment appointment = (Appointment) q.uniqueResult();
			close();
			return appointment;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public List<Appointment> getByReceiverId(int receiverid) {
		try {
			begin();
			Query q = getSession().createQuery("from Appointment where receiver = :receiver");
			q.setInteger("receiver", receiverid);
			List<Appointment> appointments = q.list();
			close();
			return appointments;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public List<Patient> getPatients(int receiverid){
		try {
			begin();
			Query q1 = getSession().createQuery("from Appointment where receiver = :receiver and status = :status ");
			q1.setInteger("receiver", receiverid);
			q1.setString("status", "confirmed");
			List<Appointment> appointments = q1.list();
			List<Patient> patients = new ArrayList<Patient>();
			for(Appointment a : appointments) {
				User patient = a.getSender();
				int patientid = patient.getAccountid();
				Query q2 = getSession().createQuery("from Patient where accountid = :accountid");
				q2.setInteger("accountid", patientid);
				Patient p = (Patient)q2.uniqueResult();
				patients.add(p);
			}
			close();
			return patients;
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;	
	}
	
	public Patient getPatientById(int patientid){
		try {
			begin();
			Query q = getSession().createQuery("from Patient where accountid = :patientid");
			q.setInteger("patientid", patientid);
			Patient patient = (Patient) q.uniqueResult();
			close();
			return patient;
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;	
	}
	
	public Appointment create(Appointment appointment) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(appointment);
			commit();
			return appointment;
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while creating appointment: " + e.getMessage());
		}
	}
	
	public boolean cancel(String appointmentid) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Appointment where appointmentid = :appointmentid");
			q.setString("appointmentid", appointmentid);
			Appointment appointment = (Appointment)q.uniqueResult();
			if(appointment != null) {
				appointment.setStatus("cancel");
				getSession().update(appointment);
				commit();
				return true;
			}else {
				return false;
			}
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while editing appointment :" + e.getMessage());
		}
	}
	
	public boolean confirmTime(String appointmentid,String confirmedTimes,String status) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Appointment where appointmentid = :id");
			q.setString("id", appointmentid);
			Appointment appointment = (Appointment)q.uniqueResult();
			if(appointment != null) {
				appointment.setConfirmedTimes(confirmedTimes);
				appointment.setStatus(status);
				getSession().update(appointment);
				commit();
				return true;
			}else {
				return false;
			}
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while editing appointment :" + e.getMessage());
		}
	}
	
	public boolean finishRecipe(String appointmentid,String status) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Appointment where appointmentid = :id");
			q.setString("id", appointmentid);
			Appointment appointment = (Appointment)q.uniqueResult();
			if(appointment != null) {
				appointment.setStatus(status);
				getSession().update(appointment);
				commit();
				return true;
			}else {
				return false;
			}
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while editing appointment :" + e.getMessage());
		}
	}
	
}
