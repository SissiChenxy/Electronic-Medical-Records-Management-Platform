package com.me.EMR.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Prescription {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="prescriptionid")
	private String prescriptionid;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="recipe")
	private Recipe recipe;
	
	@Column(name="medicineName")
	private String medicineName;
	
	@Column(name="instructions")
	private String instructions;
	
	@OneToOne
	@JoinColumn(name="approvedBy")
	private User doctor;
	
	@Column(name="date")
	private Date date;
	
	@Column(name="quantity")
	private String quantity;

	public Prescription() {
		super();
	}

	public String getPrescriptionid() {
		return prescriptionid;
	}

	public void setPrescriptionid(String prescriptionid) {
		this.prescriptionid = prescriptionid;
	}

	public String getMedicineName() {
		return medicineName;
	}

	public void setMedicineName(String medicineName) {
		this.medicineName = medicineName;
	}

	public String getInstructions() {
		return instructions;
	}

	public Recipe getRecipe() {
		return recipe;
	}

	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
	}

	public User getDoctor() {
		return doctor;
	}

	public void setDoctor(User doctor) {
		this.doctor = doctor;
	}

	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

}
