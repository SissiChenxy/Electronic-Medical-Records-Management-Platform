package com.me.EMR.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;

import com.me.EMR.pojo.Doctor;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.User;

//@Repository("userDao")
public class UserDAO extends DAO{
	public User get(String username){
        try {
            begin();
            Query q = getSession().createQuery("from User where username = :username");
            q.setString("username", username);
            User user = (User) q.uniqueResult();
            close();
            return user;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            return null;   
    }
	
	public Patient getByName(String name){
        try {
            begin();
            Query q = getSession().createQuery("from Patient where name = :name");
            q.setString("name", name);
            Patient patient = (Patient) q.uniqueResult();
            close();
            return patient;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            return null;   
    }
	
	public User get(int accountid){
        try {
            begin();
            Query q = getSession().createQuery("from User where accountid = :accountid");
            q.setInteger("accountid", accountid);
            User user = (User) q.uniqueResult();
            close();
            return user;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            return null;   
    }
	
	public User get(String username,String password){
        try {
            begin();
            Query q = getSession().createQuery("from User where username = :username and password = :password");
            q.setString("username", username);
            q.setString("password", password);
            User user = (User) q.uniqueResult();
            close();
            return user;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            return null;
    }
	
	public User register(User u) throws Exception {
        try {
            begin();
            System.out.println("inside DAO");
            getSession().save(u);
            commit();
            return u;

        } catch (HibernateException e) {
            rollback();
            throw new Exception("Exception while creating user: " + e.getMessage());
        }
    }
	
	public boolean updateUser(String username) throws Exception {
        try {
            begin();
            System.out.println("inside DAO");
            Query q = getSession().createQuery("from User where username = :username");
            q.setString("username", username);
            User user = (User) q.uniqueResult();
            if(user!=null){
                user.setStatus(1);
                getSession().update(user);
                commit();
                return true;
            }else{
                return false;
            }

        } catch (HibernateException e) {
            rollback();
            throw new Exception("Exception while creating user: " + e.getMessage());
        }
    
    }
	
	public boolean updatePatient(String accountid, String name, String age, String phone, 
			String streetAddress, String city, String state, String zipCode) throws Exception {
        try {
            begin();
            System.out.println("inside DAO");
            Query q = getSession().createQuery("from Patient where accountid = :accountid");
            q.setString("accountid", accountid);
            Patient patient = (Patient) q.uniqueResult();
            if(patient!=null){
                patient.setName(name);
                patient.setAge(Integer.parseInt(age));
                patient.setPhone(phone);
                patient.setStreetAddress(streetAddress);
                patient.setCity(city);
                patient.setState(state);
                patient.setZipCode(zipCode);
                getSession().update(patient);
                commit();
                close();
                return true;
            }else{
                return false;
            }

        } catch (HibernateException e) {
            rollback();
            throw new Exception("Exception while creating user: " + e.getMessage());
        }
    }
	
	public boolean updateDoctor(String accountid, String name, String age, String phone, String department) throws Exception {
        try {
            begin();
            System.out.println("inside DAO");
            Query q = getSession().createQuery("from Doctor where accountid = :accountid");
            q.setString("accountid", accountid);
            Doctor doctor = (Doctor) q.uniqueResult();
            if(doctor!=null){
            	doctor.setName(name);
            	doctor.setAge(Integer.parseInt(age));
            	doctor.setPhone(phone);
            	doctor.setDepartment(department);
                getSession().update(doctor);
                commit();
                close();
                return true;
            }else{
                return false;
            }

        } catch (HibernateException e) {
            rollback();
            throw new Exception("Exception while creating user: " + e.getMessage());
        }
    
    }
	
	public boolean updateUserPw(String accountid, String password) throws Exception {
        try {
            begin();
            System.out.println("inside DAO");
            Query q = getSession().createQuery("from User where accountid = :accountid");
            q.setString("accountid", accountid);
            User user = (User) q.uniqueResult();
            if(user!=null){
                user.setPassword(password);
                getSession().update(user);
                commit();
                return true;
            }else{
                return false;
            }

        } catch (HibernateException e) {
            rollback();
            throw new Exception("Exception while creating user: " + e.getMessage());
        }
    
    }

}
