package com.me.EMR.pojo;



import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Recipe implements Serializable{
	 
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="recipeid")
	private int recipeid;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="patient")
	private Patient patient;
	
	@OneToOne
	@JoinColumn(name="doctor")
	private Doctor doctor;
	
	@JsonIgnore
	@OneToMany(mappedBy="recipe",fetch=FetchType.LAZY)
	private List<Prescription> prescriptionList;
	
	@Column(name="testName")
	private String testName;
	
	@Column(name="testResult")
	private String testResult;

	public Recipe() {
		super();
	}

	public int getRecipeid() {
		return recipeid;
	}

	public void setRecipeid(int recipeid) {
		this.recipeid = recipeid;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public List<Prescription> getPrescriptionList() {
		return prescriptionList;
	}

	public void setPrescriptionList(List<Prescription> prescriptionList) {
		this.prescriptionList = prescriptionList;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public String getTestResult() {
		return testResult;
	}

	public void setTestResult(String testResult) {
		this.testResult = testResult;
	}
	
}
