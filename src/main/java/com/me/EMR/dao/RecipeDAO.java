package com.me.EMR.dao;

import org.hibernate.HibernateException;

import com.me.EMR.pojo.Prescription;
import com.me.EMR.pojo.Recipe;


public class RecipeDAO extends DAO{

	public Recipe create(Recipe recipe) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			System.out.println(recipe.getPatient() + "--------");
			getSession().save(recipe);
			commit();
			return recipe;
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while creating recipe: " + e.getMessage());
		}
	}
	
	public Recipe update(Recipe recipe) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			getSession().update(recipe);
			commit();
			return recipe;
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while creating recipe: " + e.getMessage());
		}
	}
	
	public Prescription createPrescription(Prescription prescription) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(prescription);
		
			commit();
			return prescription;
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while creating recipe: " + e.getMessage());
		}
	}
}
